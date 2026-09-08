from __future__ import annotations

import json
import re
import subprocess
from pathlib import Path

from .generic_cfg import (
    Bound,
    add_bounds,
    compare_machine_cfgs,
    merge_machine_cfgs,
    parse_annotated_assembly,
    parse_ir_cfg,
    parse_lowered_callsites,
    parse_mir,
    resolve_callsite_integer_args,
    run_annotated_assembly,
    run_late_mir,
    run_opt_analysis,
    solve_ir_block_bounds,
    solve_machine_total,
)
from .llvm_ir import emit_llvm_ir
from .runtime import (
    AnalysisModule,
    DEFAULT_RUNTIME_FUNCTIONS,
    build_function_index,
    prepare_runtime_modules,
)
from .runtime_semantics import (
    is_collective_runtime_primitive,
    runtime_function_instruction_bound,
)
from .source_loop_semantics import (
    source_loop_backedge_bounds,
    source_loop_total_backedge_bounds,
)
from .toolchain import discover_toolchain
from .version import ANALYSIS_SCHEMA_VERSION


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


def _descendant_unexpanded_calls(summary: dict) -> list[dict]:
    """Flatten unresolved costs below a recursively summarized callee."""
    unresolved = list(summary.get("unexpanded_calls", []))
    for call in summary.get("expanded_calls", []):
        unresolved.extend(call.get("callee_unexpanded_calls", []))
    deduplicated: list[dict] = []
    seen: set[str] = set()
    for item in unresolved:
        signature = json.dumps(item, sort_keys=True)
        if signature not in seen:
            seen.add(signature)
            deduplicated.append(item)
    return deduplicated


def _prepare_benchmark_module(
    benchmark_dir: Path,
    tasklets: int,
    work_dir: Path,
    opt: str,
    llc: str,
    extra_make: list[str] | None,
) -> AnalysisModule:
    llvm_ir = work_dir / "kernel.ll"
    emit_info = emit_llvm_ir(benchmark_dir, tasklets, llvm_ir, extra_make)
    named_ir = work_dir / "kernel.named.ll"
    _named_ir(opt, llvm_ir, named_ir)
    cfg = parse_ir_cfg(named_ir.read_text())

    late_mir = work_dir / "kernel.late.mir"
    run_late_mir(llc, named_ir, late_mir)
    ir_names = {function: set(blocks) for function, blocks in cfg.items()}
    annotated_assembly = work_dir / "kernel.annotated.s"
    run_annotated_assembly(llc, named_ir, annotated_assembly)
    mir_machine = parse_mir(late_mir.read_text(), ir_names)
    assembly_machine = parse_annotated_assembly(
        annotated_assembly.read_text(), ir_names
    )
    machine_cfg_validation = compare_machine_cfgs(
        mir_machine, assembly_machine
    )
    machine = (
        assembly_machine
        if machine_cfg_validation["status"] == "error"
        else merge_machine_cfgs(
            mir_machine, assembly_machine, machine_cfg_validation
        )
    )

    return AnalysisModule(
        name="benchmark",
        kind="benchmark",
        source_dir=benchmark_dir,
        source_path=None,
        llvm_ir=llvm_ir,
        named_ir=named_ir,
        late_mir=late_mir,
        annotated_assembly=annotated_assembly,
        cfg=cfg,
        machine=machine,
        machine_cfg_validation=machine_cfg_validation,
        emit_info=emit_info,
    )


def generic_dynamic_instruction_count(
    benchmark_dir: Path,
    tasklets: int,
    params: dict[str, object],
    work_dir: Path,
    sdk_root: str | None = None,
    function: str = "main_kernel1",
    extra_make: list[str] | None = None,
    runtime_functions: frozenset[str] = DEFAULT_RUNTIME_FUNCTIONS,
    unknown_loop_backedge_uppers: dict[str, int] | None = None,
) -> dict:
    """Statically estimate/bound dynamic DPU instructions.

    Direct calls to functions indexed from independently compiled benchmark or
    runtime translation units are recursively expanded. Integer scalar call
    arguments that SCEV proves constant are propagated into callee analysis,
    so callee loop counts can be specialized without changing the original
    machine-code shape.

    Runtime collective primitives and calls without an indexed translation
    unit remain explicitly unexpanded.
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

    # Keep every translation unit independent through optimization and MIR
    # lowering. Cross-module expansion is an analyzer operation, not llvm-link.
    benchmark_module = _prepare_benchmark_module(
        benchmark_dir, tasklets, work_dir, tc.opt, llc, extra_make
    )
    modules = [benchmark_module]
    benchmark_ir = benchmark_module.named_ir.read_text()
    benchmark_lowered_calls = parse_lowered_callsites(benchmark_ir)
    lowered_runtime_references = {
        call.callee
        for calls in benchmark_lowered_calls.values()
        for call in calls
    }
    requested_runtime_functions = frozenset(
        function
        for function in runtime_functions
        if re.search(rf"@{re.escape(function)}\s*\(", benchmark_ir)
        or function in lowered_runtime_references
    )
    if requested_runtime_functions:
        modules.extend(
            prepare_runtime_modules(
                tc, llc, work_dir, requested_runtime_functions
            )
        )
    function_index = build_function_index(modules)
    machine_cfg_validation = {
        "status": (
            "error"
            if any(
                module.machine_cfg_validation["status"] == "error"
                for module in modules
            )
            else "match_with_warnings"
            if any(
                module.machine_cfg_validation["status"] == "match_with_warnings"
                for module in modules
            )
            else "match"
        ),
        "modules": [
            {
                "name": module.name,
                "kind": module.kind,
                "late_mir": str(module.late_mir),
                "annotated_assembly": str(module.annotated_assembly),
                **module.machine_cfg_validation,
            }
            for module in modules
        ],
    }
    if machine_cfg_validation["status"] == "error":
        error = RuntimeError(
            "MIR and annotated-assembly Machine CFGs are inconsistent"
        )
        error.machine_cfg_validation = machine_cfg_validation
        raise error
    if function not in function_index:
        raise RuntimeError(
            f"function {function!r} not found; available: {sorted(function_index)}"
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
            owner = function_index.get(fn)
            if owner is None:
                return {
                    "function": fn,
                    "function_args": fn_args,
                    "direct": Bound(None, None),
                    "expanded": Bound(None, None),
                    "expanded_calls": [],
                    "unexpanded_calls": [
                        {"callee": fn, "reason": "no indexed translation unit"}
                    ],
                }

            active.add(key)
            ctx_dir = (
                tid_dir
                / "contexts"
                / owner.name
                / _ctx_slug(fn, fn_args)
            )
            ana = run_opt_analysis(
                tc.opt,
                owner.named_ir,
                owner.source_dir,
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

            ir_bounds, ir_meta = solve_ir_block_bounds(
                cfg,
                loops,
                unknown_loop_backedge_upper=(unknown_loop_backedge_uppers or {}).get(fn),
                unknown_loop_backedge_bounds=source_loop_backedge_bounds(
                    benchmark_dir.name, fn, loops, params
                ),
                unknown_loop_total_backedge_bounds=source_loop_total_backedge_bounds(
                    benchmark_dir.name, fn, loops, params, tasklets
                ),
            )
            synchronization_blocks = {
                block.number
                for block in owner.machine[fn]
                if "__atomic_acquire_retry" in block.calls
            }
            direct, machine_bounds, machine_meta = solve_machine_total(
                owner.machine[fn],
                ir_bounds,
                bound_block_numbers=synchronization_blocks,
                ir_loops=loops,
            )
            direct, runtime_cost_semantics = runtime_function_instruction_bound(
                fn, owner.source_path, direct
            )
            expanded = direct
            expanded_calls = []
            unexpanded_calls = []

            for block in owner.machine[fn]:
                if "__atomic_acquire_retry" not in block.calls:
                    continue
                block_bound = machine_bounds.get(block.key, Bound(None, None))
                if block_bound.upper is not None and block_bound.upper <= 0:
                    continue
                unexpanded_calls.append(
                    {
                        "callee": "__atomic_acquire_retry",
                        "block": block.key,
                        "call_bound": block_bound.to_dict(),
                        "reason": (
                            "atomic acquire retry count depends on contention and "
                            "cross-tasklet scheduling; the successful acquire is "
                            "counted once but failed retries are excluded"
                        ),
                    }
                )

            for call_index, call in enumerate(ana["callsites"].get(fn, [])):
                if call.callee.startswith("llvm."):
                    continue
                call_bound = ir_bounds.get(call.block, Bound(None, None))
                if call_bound.upper is not None and call_bound.upper <= 0:
                    continue
                if is_collective_runtime_primitive(call.callee):
                    unexpanded_calls.append(
                        {
                            "callee": call.callee,
                            "block": call.block,
                            "call_bound": call_bound.to_dict(),
                            "reason": (
                                "collective runtime primitive requires generation-level "
                                "semantics; ordinary per-tasklet expansion is disabled"
                            ),
                        }
                    )
                    continue
                callee_owner = function_index.get(call.callee)
                if callee_owner is None:
                    unexpanded_calls.append(
                        {
                            "callee": call.callee,
                            "block": call.block,
                            "call_bound": call_bound.to_dict(),
                            "reason": "no indexed translation unit",
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
                        "callee_module": callee_owner.name,
                        "block": call.block,
                        "call_bound": call_bound.to_dict(),
                        "constant_integer_args": child_args,
                        "callee_direct_bound_per_call": child["direct"].to_dict(),
                        "callee_expanded_bound_per_call": child["expanded"].to_dict(),
                        "contribution": contribution.to_dict(),
                        "callee_unexpanded_calls": _descendant_unexpanded_calls(child),
                    }
                )

            # Some target helper calls are introduced only during instruction
            # selection and therefore have no LLVM ``call`` instruction.  Use
            # the originating IR operation's block bound, then recurse through
            # the same cross-TU function index used by ordinary calls.
            lowered_calls = parse_lowered_callsites(owner.named_ir.read_text()).get(
                fn, []
            )
            for call_index, call in enumerate(lowered_calls):
                call_bound = ir_bounds.get(call.block, Bound(None, None))
                if call_bound.upper is not None and call_bound.upper <= 0:
                    continue
                callee_owner = function_index.get(call.callee)
                if callee_owner is None:
                    unexpanded_calls.append(
                        {
                            "callee": call.callee,
                            "block": call.block,
                            "call_bound": call_bound.to_dict(),
                            "origin": "target_lowering",
                            "operation": call.operation,
                            "reason": "no indexed translation unit",
                        }
                    )
                    continue
                child = summarize(call.callee, {})
                contribution = _scale_bounds(call_bound, child["expanded"])
                expanded = add_bounds(expanded, contribution)
                expanded_calls.append(
                    {
                        "call_index": call_index,
                        "callee": call.callee,
                        "callee_module": callee_owner.name,
                        "block": call.block,
                        "call_bound": call_bound.to_dict(),
                        "origin": "target_lowering",
                        "operation": call.operation,
                        "constant_integer_args": {},
                        "callee_direct_bound_per_call": child["direct"].to_dict(),
                        "callee_expanded_bound_per_call": child[
                            "expanded"
                        ].to_dict(),
                        "contribution": contribution.to_dict(),
                        "callee_unexpanded_calls": _descendant_unexpanded_calls(child),
                    }
                )

            result = {
                "function": fn,
                "module": owner.name,
                "function_args": fn_args,
                "direct": direct,
                "expanded": expanded,
                "ir_block_bounds": ir_bounds,
                "ir_meta": ir_meta,
                "machine_meta": machine_meta,
                "runtime_cost_semantics": runtime_cost_semantics,
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
                    "bounded_unknown_loops": root["ir_meta"].get(
                        "bounded_unknown_loops", []
                    ),
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
                "runtime_cost_semantics": root["runtime_cost_semantics"],
            }
        )

    result = {
        "benchmark": benchmark_dir.name,
        "tasklets": tasklets,
        "function": function,
        "params": params,
        "unknown_loop_backedge_uppers": unknown_loop_backedge_uppers or {},
        "method": (
            "cross-translation-unit CFG+SCEV flow constraints + edge-sensitive "
            "post-macro-expansion MCInst machine blocks + target-lowered runtime "
            "helper expansion + proven natural-loop machine-flow facts"
        ),
        "scope_note": (
            "Benchmark and selected SDK runtime translation units are compiled and "
            "lowered independently, then indexed for recursive analysis. Scalar integer "
            "call arguments proven constant by SCEV are propagated into callees. "
            "Target-introduced libcalls and acyclic runtime inline assembly are bounded "
            "from their independently compiled SDK translation units. "
            "Final annotated assembly is used for ordinary functions so DPU backend "
            "macros that emit multiple instructions are charged at their emitted size. "
            "Exact SCEV loop counts are transferred to Machine-CFG entry, backedge, "
            "and exit flows only for verified single-entry natural loops. "
            "TRNS phase 2 uses an amortized per-tasklet partition of its finite, "
            "atomically distributed tile domain to bound total DPU work without "
            "multiplying nested data-dependent loops. Collective runtime primitives "
            "and failed atomic-acquire retries remain explicitly unexpanded."
        ),
        "dynamic_instruction_bound_direct": total_direct.to_dict(),
        "dynamic_instruction_bound": total_expanded.to_dict(),
        "analysis_schema_version": ANALYSIS_SCHEMA_VERSION,
        "per_tasklet": per_tid,
        "artifacts": {
            "modules": [module.artifact_dict() for module in modules],
            "machine_cfg_validation": machine_cfg_validation,
            "function_index": {
                name: owner.name for name, owner in sorted(function_index.items())
            },
        },
    }
    return result
