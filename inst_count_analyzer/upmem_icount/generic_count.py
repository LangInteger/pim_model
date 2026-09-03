from __future__ import annotations

import re
import subprocess
from pathlib import Path

from .generic_cfg import (
    Bound,
    add_bounds,
    parse_ir_cfg,
    parse_mir,
    resolve_callsite_integer_args,
    run_late_mir,
    run_opt_analysis,
    solve_ir_block_bounds,
    solve_machine_total,
)
from .llvm_ir import emit_llvm_ir
from .toolchain import discover_toolchain


def _run(cmd, cwd=None):
    p = subprocess.run(cmd, cwd=cwd, text=True, capture_output=True)
    if p.returncode != 0:
        raise RuntimeError(
            f"command failed: {' '.join(map(str, cmd))}\n{p.stdout}\n{p.stderr}"
        )
    return p


def _named_ir(opt: str, ir: Path, out: Path):
    _run([opt, "-S", "-instnamer", str(ir), "-o", str(out)])


def _scale_bounds(a: Bound, b: Bound) -> Bound:
    """Multiply two non-negative count bounds."""
    lo = None if a.lower is None or b.lower is None else a.lower * b.lower
    hi = None if a.upper is None or b.upper is None else a.upper * b.upper
    return Bound(lo, hi)


def _ctx_slug(function: str, args: dict[int, int]) -> str:
    tail = "_".join(f"a{k}_{v}" for k, v in sorted(args.items())) or "generic"
    return re.sub(r"[^A-Za-z0-9_.-]+", "_", f"{function}__{tail}")


def generic_dynamic_instruction_count(
    benchmark_dir: Path,
    tasklets: int,
    params: dict[str, object],
    work_dir: Path,
    sdk_root: str | None = None,
    function: str = "main_kernel1",
    extra_make: list[str] | None = None,
) -> dict:
    """Statically estimate/bound dynamic DPU instructions.

    Direct calls to functions defined in the same DPU translation unit are
    recursively expanded. Integer scalar call arguments that SCEV proves
    constant are propagated into callee analysis, so callee loop counts can be
    specialized without changing the original machine-code shape.

    Calls to runtime/SDK functions that are not present in the compiled
    translation unit remain explicitly unexpanded.
    """
    # All disposable LLVM/SCEV/MIR artifacts live under work_dir. emit_llvm_ir
    # runs clang with benchmark_dir as its working directory, so resolve both
    # paths first to keep their meaning stable across subprocess cwd changes.
    benchmark_dir = benchmark_dir.resolve()
    work_dir = work_dir.resolve()
    work_dir.mkdir(parents=True, exist_ok=True)
    tc = discover_toolchain(sdk_root)
    if not tc.dpu_clang or not tc.opt or not tc.sdk_root:
        raise RuntimeError("UPMEM SDK with clang/opt is required")
    llc = str(Path(tc.sdk_root) / "bin" / "llc")
    if not Path(llc).exists():
        raise RuntimeError(f"llc not found: {llc}")

    # Emit the exact optimized target IR corresponding to the benchmark build.
    ir = work_dir / "kernel.ll"
    emit_info = emit_llvm_ir(benchmark_dir, tasklets, ir, extra_make)
    named = work_dir / "kernel.named.ll"
    _named_ir(tc.opt, ir, named)
    named_text = named.read_text()
    original_cfg = parse_ir_cfg(named_text)
    if function not in original_cfg:
        raise RuntimeError(
            f"function {function!r} not found; available: {sorted(original_cfg)}"
        )

    # Generate one unspecialized late MIR. It defines the real machine-code
    # shape/cost; all parameter specialization below is analysis-only.
    mir = work_dir / "kernel.late.mir"
    run_late_mir(llc, named, mir)
    ir_names = {fn: set(bs) for fn, bs in original_cfg.items()}
    machine = parse_mir(mir.read_text(), ir_names)
    if function not in machine:
        raise RuntimeError(
            f"machine function {function!r} not found; available: {sorted(machine)}"
        )

    total_direct = Bound(0.0, 0.0)
    total_expanded = Bound(0.0, 0.0)
    per_tid = []

    for tid in range(tasklets):
        tid_dir = work_dir / "analysis" / f"tid{tid}"
        cache: dict[tuple[str, tuple[tuple[int, int], ...]], dict] = {}
        active: set[tuple[str, tuple[tuple[int, int], ...]]] = set()

        def summarize(fn: str, fn_args: dict[int, int]) -> dict:
            key = (fn, tuple(sorted(fn_args.items())))
            if key in cache:
                return cache[key]
            if key in active:
                # Recursion is not expected in the PrIM kernels. Be explicit
                # rather than silently under/over-counting it.
                return {
                    "function": fn,
                    "function_args": fn_args,
                    "direct": Bound(None, None),
                    "expanded": Bound(None, None),
                    "expanded_calls": [],
                    "unexpanded_calls": [
                        {"callee": fn, "reason": "recursive call cycle"}
                    ],
                }
            if fn not in original_cfg or fn not in machine:
                return {
                    "function": fn,
                    "function_args": fn_args,
                    "direct": Bound(None, None),
                    "expanded": Bound(None, None),
                    "expanded_calls": [],
                    "unexpanded_calls": [
                        {"callee": fn, "reason": "not defined in translation unit"}
                    ],
                }

            active.add(key)
            ctx_dir = tid_dir / "contexts" / _ctx_slug(fn, fn_args)
            ana = run_opt_analysis(
                tc.opt,
                named,
                benchmark_dir,
                tid,
                params,
                ctx_dir,
                function=fn if fn_args else None,
                function_args=fn_args or None,
            )
            cfg = ana["cfg"].get(fn)
            loops = ana["loops"].get(fn, [])
            if not cfg:
                active.remove(key)
                raise RuntimeError(
                    f"{fn} disappeared during analysis for tid={tid}, args={fn_args}"
                )

            ir_bounds, ir_meta = solve_ir_block_bounds(cfg, loops)
            direct, machine_bounds, machine_meta = solve_machine_total(
                machine[fn], ir_bounds
            )
            expanded = direct
            expanded_calls = []
            unexpanded_calls = []

            for call_index, call in enumerate(ana["callsites"].get(fn, [])):
                if call.callee.startswith("llvm."):
                    continue
                call_bound = ir_bounds.get(call.block, Bound(None, None))
                if call.callee not in original_cfg or call.callee not in machine:
                    unexpanded_calls.append(
                        {
                            "callee": call.callee,
                            "block": call.block,
                            "call_bound": call_bound.to_dict(),
                            "reason": "runtime/external callee not defined in translation unit",
                        }
                    )
                    continue

                child_args = resolve_callsite_integer_args(
                    call, ana["scalar_constants"]
                )
                child = summarize(call.callee, child_args)
                contribution = _scale_bounds(call_bound, child["expanded"])
                expanded = add_bounds(expanded, contribution)
                expanded_calls.append(
                    {
                        "call_index": call_index,
                        "callee": call.callee,
                        "block": call.block,
                        "call_bound": call_bound.to_dict(),
                        "constant_integer_args": child_args,
                        "callee_direct_bound_per_call": child["direct"].to_dict(),
                        "callee_expanded_bound_per_call": child["expanded"].to_dict(),
                        "contribution": contribution.to_dict(),
                        "callee_unexpanded_calls": child["unexpanded_calls"],
                    }
                )

            result = {
                "function": fn,
                "function_args": fn_args,
                "direct": direct,
                "expanded": expanded,
                "ir_block_bounds": ir_bounds,
                "ir_meta": ir_meta,
                "machine_meta": machine_meta,
                "analysis": ana,
                "expanded_calls": expanded_calls,
                "unexpanded_calls": unexpanded_calls,
            }
            cache[key] = result
            active.remove(key)
            return result

        root = summarize(function, {})
        total_direct = add_bounds(total_direct, root["direct"])
        total_expanded = add_bounds(total_expanded, root["expanded"])

        per_tid.append(
            {
                "tid": tid,
                "instruction_bound_direct_function": root["direct"].to_dict(),
                "instruction_bound_with_internal_callees": root[
                    "expanded"
                ].to_dict(),
                "ir_block_bounds": {
                    k: v.to_dict() for k, v in root["ir_block_bounds"].items()
                },
                "ir_analysis": {
                    "unknown_loops": root["ir_meta"]["unknown_loops"],
                    "loops": [
                        {
                            "header": x.header,
                            "depth": x.depth,
                            "blocks": x.blocks,
                            "backedge_count": x.backedge_count,
                            "trip_count": x.trip_count,
                        }
                        for x in root["analysis"]["loops"].get(function, [])
                    ],
                    "replacements": root["analysis"].get("replacements", {}),
                },
                "expanded_calls": root["expanded_calls"],
                "unexpanded_calls": root["unexpanded_calls"],
                "machine": root["machine_meta"],
            }
        )

    result = {
        "benchmark": benchmark_dir.name,
        "tasklets": tasklets,
        "function": function,
        "params": params,
        "method": (
            "generic interprocedural CFG+SCEV flow constraints + late MIR "
            "machine basic blocks"
        ),
        "scope_note": (
            "Direct calls to functions defined in the same compiled DPU translation unit "
            "are recursively expanded. Scalar integer call arguments proven constant by "
            "SCEV are propagated into callee analysis. Runtime/SDK callees not present in "
            "the translation unit remain explicitly unexpanded."
        ),
        "dynamic_instruction_bound_direct": total_direct.to_dict(),
        "dynamic_instruction_bound": total_expanded.to_dict(),
        "per_tasklet": per_tid,
        "artifacts": {
            "llvm_ir": str(ir),
            "named_ir": str(named),
            "late_mir": str(mir),
            "emit_info": emit_info,
        },
    }
    return result
