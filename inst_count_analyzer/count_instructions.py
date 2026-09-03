#!/usr/bin/env python3
"""Generic UPMEM static dynamic-instruction counter (Q1)."""
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

def _parse_scalar(text: str):
    # Keep strings if they are not clean integers/floats; DPU params are usually ints.
    try:
        return int(text, 0)
    except Exception:
        try:
            return float(text)
        except Exception:
            return text


ANALYZER_ROOT = Path(__file__).resolve().parent


def default_work_dir(result_dir: Path) -> Path:
    """Return analyzer-owned, gitignored storage for one result directory."""
    return ANALYZER_ROOT / ".work" / "runs" / result_dir.name


def collect_unexpanded_callees(result: dict) -> list[str]:
    callees: set[str] = set()

    def visit(value, inside_unexpanded: bool = False) -> None:
        if isinstance(value, dict):
            callee = value.get("callee")
            if inside_unexpanded and isinstance(callee, str):
                callees.add(callee)
            for key, child in value.items():
                visit(
                    child,
                    inside_unexpanded
                    or key in {"unexpanded_calls", "callee_unexpanded_calls"},
                )
        elif isinstance(value, list):
            for child in value:
                visit(child, inside_unexpanded)

    visit(result.get("per_tasklet", []))
    return sorted(callees)


def _compact_bound(bound: dict) -> dict:
    def clean_number(value):
        if isinstance(value, float) and value.is_integer():
            return int(value)
        return value

    return {
        "lower": clean_number(bound.get("lower")),
        "upper": clean_number(bound.get("upper")),
        "exact": bool(bound.get("exact")),
    }


def compact_result(result: dict) -> dict:
    return {
        "benchmark": result["benchmark"],
        "tasklets": result["tasklets"],
        "params": result.get("params", {}),
        "dynamic_instruction_bound": _compact_bound(
            result.get("dynamic_instruction_bound", {})
        ),
        "unexpanded_callees": collect_unexpanded_callees(result),
    }


def main(argv: list[str] | None = None) -> int:
    p = argparse.ArgumentParser(
        description=(
            "Statically estimate/bound dynamic UPMEM DPU machine-instruction count. "
            "This tool answers Q1 only; it does not model cycles or stalls."
        )
    )
    p.add_argument("--root", required=True, help="PrIM/benchmark-suite root")
    p.add_argument("--benchmark", required=True)
    p.add_argument("--tasklets", type=int, required=True)
    p.add_argument("--sdk-root", required=True, help="UPMEM SDK root")
    p.add_argument("--function", default="main_kernel1")
    p.add_argument("--params", help="JSON object containing concrete DPU_INPUT_ARGUMENTS values")
    p.add_argument("--param", action="append", default=[], help="NAME=VALUE; repeat as needed")
    p.add_argument("--make-arg", action="append", default=[], help="extra Make assignment, e.g. BL=10")
    p.add_argument(
        "--outdir",
        required=True,
        help="final result directory; intermediate files are never written here",
    )
    p.add_argument(
        "--workdir",
        help=(
            "intermediate artifact directory (default: "
            "inst_count_analyzer/.work/runs/<outdir-name>)"
        ),
    )
    p.add_argument(
        "--debug",
        action="store_true",
        help="also write the full analysis details to <outdir>/debug.json",
    )
    p.add_argument(
        "-o",
        "--output",
        help="override the final result path (default: <outdir>/result.json)",
    )

    # Optional metadata used only to align this result with simulator summary.csv.
    p.add_argument("--experiment")
    p.add_argument("--num-dpus", type=int)
    p.add_argument("--data-prep-param")
    p.add_argument("--setting-id")
    a = p.parse_args(argv)

    params = {}
    if a.params:
        obj = json.loads(Path(a.params).read_text())
        if isinstance(obj, dict) and "dpu_input_arguments" in obj:
            obj = obj["dpu_input_arguments"]
        if not isinstance(obj, dict):
            raise SystemExit("--params JSON must be an object")
        params = {k: v for k, v in obj.items() if v is not None}
    for kv in a.param:
        if "=" not in kv:
            raise SystemExit(f"bad --param {kv!r}; expected NAME=VALUE")
        k, v = kv.split("=", 1)
        params[k] = _parse_scalar(v)

    result_dir = Path(a.outdir).resolve()
    result_dir.mkdir(parents=True, exist_ok=True)
    work_dir = (
        Path(a.workdir).resolve()
        if a.workdir
        else default_work_dir(result_dir).resolve()
    )

    try:
        # Import lazily so artifact-management helpers and their tests do not
        # require the LLVM-analysis dependencies to be installed.
        from upmem_icount.generic_count import generic_dynamic_instruction_count

        result = generic_dynamic_instruction_count(
            Path(a.root) / a.benchmark,
            a.tasklets,
            params,
            work_dir,
            a.sdk_root,
            a.function,
            a.make_arg,
        )
    except Exception as e:
        print(f"error: {e}", file=sys.stderr)
        return 2

    setting = {
        "experiment": a.experiment,
        "num_dpus_configured": a.num_dpus,
        "data_prep_params": _parse_scalar(a.data_prep_param) if a.data_prep_param is not None else None,
        "setting_id": a.setting_id,
    }
    setting = {k: v for k, v in setting.items() if v is not None}
    if setting:
        result["simulator_match"] = setting

    result_path = Path(a.output).resolve() if a.output else result_dir / "result.json"
    result_path.parent.mkdir(parents=True, exist_ok=True)
    result_path.write_text(json.dumps(compact_result(result), indent=2) + "\n")
    if a.debug:
        (result_dir / "debug.json").write_text(json.dumps(result, indent=2) + "\n")

    print(f"Wrote result: {result_path}")
    print(f"Intermediate artifacts: {work_dir}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
