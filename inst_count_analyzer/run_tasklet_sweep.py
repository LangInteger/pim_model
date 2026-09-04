#!/usr/bin/env python3
from __future__ import annotations

import argparse
import csv
import json
import subprocess
import sys
from pathlib import Path


ANALYZER_ROOT = Path(__file__).resolve().parent
DEFAULT_TASKLETS = (1, 2, 4, 8, 11, 16)


def parse_args(argv: list[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Run static instruction counting for a tasklet sweep."
    )
    parser.add_argument("--root", required=True, help="benchmark-suite root")
    parser.add_argument("--benchmark", required=True)
    parser.add_argument("--sdk-root", required=True)
    parser.add_argument("--function", default="main_kernel1")
    parser.add_argument(
        "--tasklets",
        type=int,
        nargs="+",
        default=list(DEFAULT_TASKLETS),
        help="tasklet counts (default: 1 2 4 8 11 16)",
    )
    parser.add_argument("--param", action="append", default=[])
    parser.add_argument("--make-arg", action="append", default=[])
    parser.add_argument("--num-dpus", type=int, default=1)
    parser.add_argument("--data-prep-param")
    parser.add_argument(
        "--outdir",
        help="final sweep directory (default: results/<benchmark>_tasklet_sweep)",
    )
    parser.add_argument(
        "--workdir",
        help="work directory (default: .work/runs/<benchmark>_tasklet_sweep)",
    )
    parser.add_argument("--debug", action="store_true")
    parser.add_argument(
        "--force", action="store_true", help="rerun settings with an existing result"
    )
    return parser.parse_args(argv)


def write_summary(sweep_dir: Path, tasklets: list[int]) -> Path:
    rows = []
    for tasklet_count in tasklets:
        result_path = sweep_dir / f"T{tasklet_count}" / "result.json"
        if not result_path.is_file():
            continue
        result = json.loads(result_path.read_text())
        bound = result["dynamic_instruction_bound"]
        lower = bound.get("lower")
        upper = bound.get("upper")
        midpoint = None
        if lower is not None and upper is not None:
            midpoint = (lower + upper) / 2
        rows.append(
            {
                "benchmark": result["benchmark"],
                "tasklets": result["tasklets"],
                "instructions_lower": lower,
                "instructions_upper": upper,
                "instructions_midpoint": midpoint,
                "exact": bound.get("exact", False),
                "unexpanded_callees": ";".join(
                    result.get("unexpanded_callees", [])
                ),
                "result_path": str(result_path),
            }
        )

    summary_path = sweep_dir / "instruction_counts.csv"
    fieldnames = [
        "benchmark",
        "tasklets",
        "instructions_lower",
        "instructions_upper",
        "instructions_midpoint",
        "exact",
        "unexpanded_callees",
        "result_path",
    ]
    with summary_path.open("w", newline="") as output:
        writer = csv.DictWriter(output, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)
    return summary_path


def main(argv: list[str] | None = None) -> int:
    args = parse_args(argv)
    tasklets = list(dict.fromkeys(args.tasklets))
    if any(value < 1 or value > 24 for value in tasklets):
        raise SystemExit("tasklet counts must be between 1 and 24")

    benchmark_root = Path(args.root).resolve()
    sdk_root = Path(args.sdk_root).resolve()
    benchmark_name = args.benchmark.upper()
    sweep_name = f"{benchmark_name}_tasklet_sweep"
    sweep_dir = (
        Path(args.outdir).resolve()
        if args.outdir
        else ANALYZER_ROOT / "results" / sweep_name
    )
    work_root = (
        Path(args.workdir).resolve()
        if args.workdir
        else ANALYZER_ROOT / ".work" / "runs" / sweep_name
    )
    sweep_dir.mkdir(parents=True, exist_ok=True)

    failed = []
    for tasklet_count in tasklets:
        result_dir = sweep_dir / f"T{tasklet_count}"
        result_path = result_dir / "result.json"
        setting_work_dir = work_root / f"T{tasklet_count}"
        log_path = setting_work_dir / "console.log"
        if result_path.is_file() and not args.force:
            print(f"SKIP T={tasklet_count}: {result_path}")
            continue

        setting_work_dir.mkdir(parents=True, exist_ok=True)
        command = [
            sys.executable,
            str(ANALYZER_ROOT / "count_instructions.py"),
            "--root",
            str(benchmark_root),
            "--benchmark",
            args.benchmark,
            "--tasklets",
            str(tasklet_count),
            "--sdk-root",
            str(sdk_root),
            "--function",
            args.function,
            "--experiment",
            "tasklet_sweep",
            "--num-dpus",
            str(args.num_dpus),
            "--outdir",
            str(result_dir),
            "--workdir",
            str(setting_work_dir),
        ]
        for parameter in args.param:
            command.extend(["--param", parameter])
        for make_argument in args.make_arg:
            command.extend(["--make-arg", make_argument])
        if args.data_prep_param is not None:
            command.extend(["--data-prep-param", args.data_prep_param])
        if args.debug:
            command.append("--debug")

        print(f"RUN T={tasklet_count}")
        completed = subprocess.run(
            command,
            cwd=ANALYZER_ROOT,
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
        )
        log_path.write_text(completed.stdout)
        if completed.returncode != 0:
            failed.append(tasklet_count)
            print(f"FAILED T={tasklet_count}: see {log_path}")
        else:
            print(f"DONE T={tasklet_count}: {result_path}")

    summary_path = write_summary(sweep_dir, tasklets)
    print(f"Summary: {summary_path}")
    if failed:
        print(f"Failed tasklet settings: {failed}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
