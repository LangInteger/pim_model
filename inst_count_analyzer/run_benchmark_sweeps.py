#!/usr/bin/env python3
"""Run static instruction counting for settings declared in summary.csv."""
from __future__ import annotations

import argparse
import csv
import hashlib
import json
import subprocess
import sys
from collections import defaultdict
from pathlib import Path
from typing import Any

from upmem_icount.benchmark_settings import (
    BENCHMARK_CONFIGS,
    DpuPhase,
    load_summary_phases,
    loop_backedge_uppers,
    normalize_benchmark,
    setting_id,
)


ANALYZER_ROOT = Path(__file__).resolve().parent
REPO_ROOT = ANALYZER_ROOT.parent


def parse_args(argv: list[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Analyze every setting present in draw_figs/results/<benchmark>/summary.csv. "
            "Each summary row supplies both the experiment configuration and exact "
            "per-DPU/execution input arguments."
        )
    )
    parser.add_argument(
        "benchmarks",
        nargs="*",
        help="benchmarks to analyze (default: every supported benchmark with a summary)",
    )
    parser.add_argument(
        "--benchmark-root",
        type=Path,
        default=REPO_ROOT / "uPIMulator" / "golang" / "uPIMulator" / "benchmark",
    )
    parser.add_argument("--sdk-root", type=Path, required=True)
    parser.add_argument(
        "--summary-root", type=Path, default=REPO_ROOT / "draw_figs" / "results"
    )
    parser.add_argument(
        "--results-root", type=Path, default=ANALYZER_ROOT / "results"
    )
    parser.add_argument(
        "--work-root", type=Path, default=ANALYZER_ROOT / ".work" / "runs"
    )
    parser.add_argument("--force", action="store_true")
    parser.add_argument("--debug", action="store_true")
    parser.add_argument("--fail-fast", action="store_true")
    return parser.parse_args(argv)


def discover_benchmarks(summary_root: Path) -> list[str]:
    return sorted(
        normalize_benchmark(path.parent.name)
        for path in summary_root.glob("*/summary.csv")
        if path.parent.name.upper() in BENCHMARK_CONFIGS
    )


def load_experiment_settings(summary_path: Path) -> list[dict[str, Any]]:
    with summary_path.open(newline="", encoding="utf-8") as input_file:
        rows = list(csv.DictReader(input_file))
    settings: list[dict[str, Any]] = []
    for row in rows:
        setting = {
            "experiment": row["experiment"],
            "benchmark": normalize_benchmark(row["benchmark"]),
            "num_dpus": int(row["num_dpus"]),
            "num_tasklets": int(row["num_tasklets"]),
            "data_prep_params": int(row["data_prep_params"]),
            "dpu_build_options": json.loads(row["dpu_build_options_json"]),
            "dpu_execution_inputs": json.loads(row["dpu_execution_inputs_json"]),
        }
        settings.append(setting)
    return settings


def analysis_params(benchmark: str, phase: DpuPhase) -> dict[str, int]:
    """Remove values that cannot affect control flow or loop trip counts."""
    ignored = BENCHMARK_CONFIGS[benchmark].non_control_params
    return {name: value for name, value in phase.params.items() if name not in ignored}


def make_args_for_setting(benchmark: str, setting: dict[str, Any]) -> list[str]:
    options = setting["dpu_build_options"]
    if not isinstance(options, dict) or any(
        not isinstance(name, str)
        or not name
        or isinstance(value, (dict, list, bool))
        or not isinstance(value, (str, int, float))
        for name, value in options.items()
    ):
        raise ValueError(f"invalid dpu_build_options for {benchmark}: {options!r}")
    return [
        *(f"{name}={value}" for name, value in sorted(options.items())),
    ]


def phase_cache_key(
    benchmark: str, phase: DpuPhase, make_args: list[str]
) -> str:
    payload = json.dumps(
        {
            "function": phase.function,
            "params": analysis_params(benchmark, phase),
            "loop_backedge_uppers": loop_backedge_uppers(benchmark, phase.params),
            "make_args": make_args,
        },
        sort_keys=True,
        separators=(",", ":"),
    ).encode()
    return hashlib.sha256(payload).hexdigest()[:16]


def cached_build_matches(cached: dict[str, Any], make_args: list[str]) -> bool:
    return (
        cached.get("provenance", {}).get("make_args") == make_args
        and cached.get("machine_cfg_validation_status")
        in {"match", "match_with_warnings"}
    )


def add_bounds(bounds: list[dict[str, Any]]) -> dict[str, Any]:
    lower = 0.0
    upper = 0.0
    exact = True
    for bound in bounds:
        if bound.get("lower") is None or bound.get("upper") is None:
            raise ValueError("cannot compose an unresolved instruction bound")
        lower += float(bound["lower"])
        upper += float(bound["upper"])
        exact = exact and bool(bound.get("exact"))
    return {"lower": lower, "upper": upper, "exact": exact and lower == upper}


def clean_number(value: float) -> int | float:
    return int(value) if float(value).is_integer() else value


def analyze_setting(
    args: argparse.Namespace,
    setting: dict[str, Any],
) -> dict[str, Any]:
    benchmark = setting["benchmark"]
    sid = setting_id(
        setting["experiment"],
        benchmark,
        setting["num_dpus"],
        setting["num_tasklets"],
        setting["data_prep_params"],
    )
    output_dir = args.results_root / benchmark / sid
    output_path = output_dir / "result.json"
    make_args = make_args_for_setting(benchmark, setting)
    if output_path.is_file() and not args.force:
        cached = json.loads(output_path.read_text(encoding="utf-8"))
        if cached_build_matches(cached, make_args):
            print(f"SKIP {sid}")
            cached["experiment_setting"] = {
                "experiment": setting["experiment"],
                "benchmark": benchmark,
                "num_dpus": setting["num_dpus"],
                "num_tasklets": setting["num_tasklets"],
                "data_prep_params": setting["data_prep_params"],
                "dpu_build_options": setting["dpu_build_options"],
                "setting_id": sid,
            }
            return cached
        print(f"RERUN {sid}: cached build options do not match summary")

    phases = load_summary_phases(setting["dpu_execution_inputs"])
    phase_dpus = {phase.dpu for phase in phases}
    expected_dpus = set(range(setting["num_dpus"]))
    if phase_dpus != expected_dpus:
        raise ValueError(
            f"{sid} argument DPU IDs do not match num_dpus: "
            f"expected {sorted(expected_dpus)}, observed {sorted(phase_dpus)}"
        )
    output_dir.mkdir(parents=True, exist_ok=True)
    work_dir = args.work_root / benchmark / sid

    result_cache: dict[str, dict[str, Any]] = {}
    dpu_phases: dict[int, list[dict[str, Any]]] = defaultdict(list)
    print(f"RUN {sid}: {len(phases)} DPU/execution argument records")
    for phase in phases:
        cache_key = phase_cache_key(benchmark, phase, make_args)
        phase_output_dir = output_dir / "phases" / cache_key
        phase_result_path = phase_output_dir / "result.json"
        phase_work_dir = work_dir / "phases" / cache_key
        if cache_key not in result_cache:
            command = [
                sys.executable,
                str(ANALYZER_ROOT / "count_instructions.py"),
                "--root",
                str(args.benchmark_root),
                "--benchmark",
                benchmark,
                "--tasklets",
                str(setting["num_tasklets"]),
                "--sdk-root",
                str(args.sdk_root),
                "--function",
                phase.function,
                "--experiment",
                setting["experiment"],
                "--num-dpus",
                str(setting["num_dpus"]),
                "--data-prep-param",
                str(setting["data_prep_params"]),
                "--setting-id",
                sid,
                "--outdir",
                str(phase_output_dir),
                "--workdir",
                str(phase_work_dir),
            ]
            for name, value in sorted(analysis_params(benchmark, phase).items()):
                command.extend(["--param", f"{name}={value}"])
            for make_arg in make_args:
                command.extend(["--make-arg", make_arg])
            for function, bound in sorted(
                loop_backedge_uppers(benchmark, phase.params).items()
            ):
                command.extend(["--unknown-loop-bound", f"{function}={bound}"])
            if args.debug:
                command.append("--debug")

            phase_work_dir.mkdir(parents=True, exist_ok=True)
            completed = subprocess.run(
                command,
                cwd=ANALYZER_ROOT,
                text=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
            )
            (phase_work_dir / "console.log").write_text(
                completed.stdout, encoding="utf-8"
            )
            if completed.returncode != 0:
                validation_path = phase_output_dir / "machine_cfg_validation.json"
                validation_note = (
                    f"; Machine CFG diagnostics: {validation_path}"
                    if validation_path.is_file()
                    else ""
                )
                raise RuntimeError(
                    f"instruction analysis failed for {sid}, {phase.function}; "
                    f"see {phase_work_dir / 'console.log'}{validation_note}"
                )
            result_cache[cache_key] = json.loads(
                phase_result_path.read_text(encoding="utf-8")
            )

        phase_result = result_cache[cache_key]
        dpu_phases[phase.dpu].append(
            {
                "execution": phase.execution,
                "function": phase.function,
                "params": phase.params,
                "unknown_loop_backedge_uppers": loop_backedge_uppers(
                    benchmark, phase.params
                ),
                "bound": phase_result["dynamic_instruction_bound"],
                "unexpanded_callees": phase_result.get("unexpanded_callees", []),
                "machine_cfg_validation_status": phase_result.get(
                    "machine_cfg_validation_status", "not_checked"
                ),
                "arguments_source": phase.arguments_source,
                "result_path": str(phase_result_path.relative_to(output_dir)),
            }
        )

    per_dpu: list[dict[str, Any]] = []
    all_unexpanded: set[str] = set()
    for dpu in range(setting["num_dpus"]):
        phase_rows = sorted(dpu_phases.get(dpu, []), key=lambda row: row["execution"])
        if not phase_rows:
            raise ValueError(f"{sid} has no argument record for DPU {dpu}")
        bound = add_bounds([row["bound"] for row in phase_rows])
        for row in phase_rows:
            all_unexpanded.update(row["unexpanded_callees"])
        per_dpu.append({"dpu": dpu, "bound": bound, "phases": phase_rows})
    if not per_dpu:
        raise ValueError(f"{sid} has no active DPU phases")

    lower = max(float(row["bound"]["lower"]) for row in per_dpu)
    upper = max(float(row["bound"]["upper"]) for row in per_dpu)
    cfg_statuses = {
        phase["machine_cfg_validation_status"]
        for row in per_dpu
        for phase in row["phases"]
    }
    cfg_status = (
        "match_with_warnings"
        if "match_with_warnings" in cfg_statuses
        else "match"
    )
    result = {
        "benchmark": benchmark,
        "tasklets": setting["num_tasklets"],
        "experiment_setting": {
            "experiment": setting["experiment"],
            "benchmark": benchmark,
            "num_dpus": setting["num_dpus"],
            "num_tasklets": setting["num_tasklets"],
            "data_prep_params": setting["data_prep_params"],
            "dpu_build_options": setting["dpu_build_options"],
            "setting_id": sid,
        },
        "instruction_scope": "maximum_per_dpu_sum_of_sequential_executions",
        "machine_cfg_validation_status": cfg_status,
        "provenance": {
            "argument_source": "summary_csv_semantic_execution_inputs",
            "benchmark_source_dir": str((args.benchmark_root / benchmark).resolve()),
            "make_args": make_args,
        },
        "dynamic_instruction_bound": {
            "lower": clean_number(lower),
            "upper": clean_number(upper),
            "exact": all(row["bound"]["exact"] for row in per_dpu)
            and lower == upper,
        },
        "unexpanded_callees": sorted(all_unexpanded),
        "per_dpu": per_dpu,
    }
    output_path.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(f"DONE {sid}: {clean_number(lower)}..{clean_number(upper)}")
    unexpected = all_unexpanded - {"barrier_wait"}
    if unexpected:
        print(
            f"WARNING {sid}: unresolved non-collective callees: "
            + ", ".join(sorted(unexpected)),
            file=sys.stderr,
        )
    return result


def write_summary(results_root: Path, benchmark: str, results: list[dict[str, Any]]) -> Path:
    benchmark_dir = results_root / benchmark
    benchmark_dir.mkdir(parents=True, exist_ok=True)
    path = benchmark_dir / "instruction_counts.csv"
    rows = []
    for result in results:
        match = result["experiment_setting"]
        bound = result["dynamic_instruction_bound"]
        lower = float(bound["lower"])
        upper = float(bound["upper"])
        rows.append(
            {
                "benchmark": benchmark,
                "experiment": match["experiment"],
                "num_dpus": match["num_dpus"],
                "num_tasklets": result["tasklets"],
                "data_prep_params": match["data_prep_params"],
                "dpu_build_options_json": json.dumps(
                    match["dpu_build_options"], separators=(",", ":")
                ),
                "setting_id": match["setting_id"],
                "instructions_lower": clean_number(lower),
                "instructions_upper": clean_number(upper),
                "instructions_midpoint": clean_number((lower + upper) / 2),
                "exact": bound.get("exact", False),
                "instruction_scope": result["instruction_scope"],
                "unexpanded_callees": ";".join(result["unexpanded_callees"]),
                "result_path": f"{match['setting_id']}/result.json",
                "machine_cfg_validation_status": result[
                    "machine_cfg_validation_status"
                ],
            }
        )
    rows.sort(
        key=lambda row: (
            row["experiment"],
            int(row["num_dpus"]),
            int(row["num_tasklets"]),
            int(row["data_prep_params"]),
        )
    )
    fields = list(rows[0]) if rows else [
        "benchmark", "experiment", "num_dpus", "num_tasklets",
        "data_prep_params", "dpu_build_options_json",
        "setting_id", "instructions_lower",
        "instructions_upper", "instructions_midpoint", "exact",
        "instruction_scope", "unexpanded_callees", "result_path",
        "machine_cfg_validation_status",
    ]
    with path.open("w", newline="", encoding="utf-8") as output:
        writer = csv.DictWriter(output, fieldnames=fields, lineterminator="\n")
        writer.writeheader()
        writer.writerows(rows)
    return path


def main(argv: list[str] | None = None) -> int:
    args = parse_args(argv)
    benchmarks = (
        [normalize_benchmark(name) for name in args.benchmarks]
        if args.benchmarks
        else discover_benchmarks(args.summary_root)
    )
    failures: list[tuple[str, str, Exception]] = []
    for benchmark in benchmarks:
        summary_path = args.summary_root / benchmark.lower() / "summary.csv"
        results: list[dict[str, Any]] = []
        try:
            settings = load_experiment_settings(summary_path)
        except Exception as error:
            failures.append((benchmark, "summary", error))
            if args.fail_fast:
                break
            continue
        for setting in settings:
            try:
                results.append(analyze_setting(args, setting))
            except Exception as error:
                sid = setting_id(
                    setting["experiment"], benchmark,
                    setting["num_dpus"], setting["num_tasklets"],
                    setting["data_prep_params"],
                )
                failures.append((benchmark, sid, error))
                print(f"FAILED {sid}: {error}", file=sys.stderr)
                if args.fail_fast:
                    break
        if results:
            print(f"Summary: {write_summary(args.results_root, benchmark, results)}")
        if failures and args.fail_fast:
            break
    if failures:
        print("Static instruction sweep failures:", file=sys.stderr)
        for benchmark, sid, error in failures:
            print(f"  {benchmark} {sid}: {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
