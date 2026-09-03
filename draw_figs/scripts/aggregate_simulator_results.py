#!/usr/bin/env python3
"""Aggregate uPIMulator results needed by the cost model."""

from __future__ import annotations

import argparse
import csv
import re
import sys
from collections import defaultdict
from pathlib import Path
from typing import Any


LOG_LINE_RE = re.compile(
    r"^[^[]+\[(?P<channel>\d+)_(?P<rank>\d+)_(?P<dpu>\d+)\]"
    r"_(?P<metric>[^:]+):\s*(?P<value>-?\d+(?:\.\d+)?)\s*$"
)

EXCLUDED_TASKLET_COUNTS = frozenset({11})

IDENTITY_FIELDS = [
    "experiment",
    "benchmark",
    "num_dpus_configured",
    "num_dpus_observed",
    "num_tasklets",
    "data_prep_params",
]

SUMMED_METRICS = [
    "breakdown_run",
    "breakdown_dma",
    "breakdown_etc",
    "backpressure",
    "num_reads",
    "num_writes",
    "read_bytes",
    "write_bytes",
]

SUMMARY_FIELDS = IDENTITY_FIELDS + [
    "instructions_mean",
    "cycles_max",
    "breakdown_run_sum",
    "breakdown_dma_sum",
    "breakdown_etc_sum",
    "backpressure_sum",
    "num_reads_sum",
    "num_writes_sum",
    "read_bytes_sum",
    "write_bytes_sum",
]


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Aggregate uPIMulator logs into analysis-ready CSV files."
    )
    parser.add_argument(
        "benchmark",
        nargs="?",
        help=(
            "Benchmark directory below simulator_results, such as va or bfs. "
            "If omitted, aggregate every benchmark into its own output directory."
        ),
    )
    parser.add_argument(
        "--input",
        type=Path,
        help="Override the result directory to scan",
    )
    parser.add_argument(
        "--output-dir",
        type=Path,
        help="Override the output directory",
    )
    return parser.parse_args()


def parse_key_values(path: Path, separator: str) -> dict[str, str]:
    values: dict[str, str] = {}
    if not path.is_file():
        return values
    for raw_line in path.read_text(encoding="utf-8").splitlines():
        if separator not in raw_line:
            continue
        key, value = raw_line.split(separator, 1)
        values[key.strip()] = value.strip()
    return values


def parse_number(value: str) -> int | float:
    number = float(value)
    return int(number) if number.is_integer() else number


def parse_log(path: Path) -> dict[tuple[int, int, int], dict[str, int | float]]:
    dpus: dict[tuple[int, int, int], dict[str, int | float]] = defaultdict(dict)
    for line_number, raw_line in enumerate(
        path.read_text(encoding="utf-8").splitlines(), start=1
    ):
        match = LOG_LINE_RE.match(raw_line)
        if not match:
            if raw_line.strip():
                print(
                    f"warning: ignored unrecognized line {path}:{line_number}",
                    file=sys.stderr,
                )
            continue
        dpu_key = tuple(
            int(match.group(name)) for name in ("channel", "rank", "dpu")
        )
        dpus[dpu_key][match.group("metric")] = parse_number(match.group("value"))
    return dpus


def numeric(value: str | None) -> int | float | str:
    if value is None or value == "":
        return ""
    try:
        return parse_number(value)
    except ValueError:
        return value


def make_identity(
    metadata: dict[str, str], observed_dpus: int
) -> dict[str, int | float | str]:
    return {
        "experiment": metadata.get("experiment", ""),
        "benchmark": metadata.get("benchmark", ""),
        "num_dpus_configured": numeric(metadata.get("num_dpus")),
        "num_dpus_observed": observed_dpus,
        "num_tasklets": numeric(metadata.get("num_tasklets")),
        "data_prep_params": numeric(metadata.get("data_prep_params")),
    }


def aggregate_setting(setting_dir: Path) -> dict[str, Any] | None:
    """Reduce one setting's DPU log to the fields consumed by the cost model."""
    metadata = parse_key_values(setting_dir / "metadata.txt", "=")
    dpu_metrics = parse_log(setting_dir / "log.txt")
    if not dpu_metrics:
        return None

    metrics_by_dpu = list(dpu_metrics.values())
    instructions = [
        float(metrics.get("num_instructions", 0)) for metrics in metrics_by_dpu
    ]
    cycles = [float(metrics.get("logic_cycle", 0)) for metrics in metrics_by_dpu]

    summary: dict[str, Any] = {
        **make_identity(metadata, len(dpu_metrics)),
        "instructions_mean": sum(instructions) / len(instructions),
        "cycles_max": max(cycles),
        **{
            f"{metric}_sum": sum(
                float(metrics.get(metric, 0) or 0)
                for metrics in metrics_by_dpu
            )
            for metric in SUMMED_METRICS
        },
    }
    return summary


def sort_key(row: dict[str, Any]) -> tuple[Any, ...]:
    return (
        row.get("benchmark", ""),
        row.get("experiment", ""),
        row.get("num_dpus_configured", 0),
        row.get("num_tasklets", 0),
        row.get("data_prep_params", ""),
    )


def write_csv(path: Path, fields: list[str], rows: list[dict[str, Any]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8", newline="") as output_file:
        writer = csv.DictWriter(
            output_file,
            fieldnames=fields,
            extrasaction="ignore",
            lineterminator="\n",
        )
        writer.writeheader()
        writer.writerows(rows)


def aggregate_results(input_root: Path, output_dir: Path) -> int:
    """Aggregate one benchmark directory and return its setting count."""
    if not input_root.is_dir():
        raise ValueError(f"input directory does not exist: {input_root}")

    summaries: list[dict[str, Any]] = []
    for metadata_path in sorted(input_root.rglob("metadata.txt")):
        setting_dir = metadata_path.parent
        metadata = parse_key_values(metadata_path, "=")
        try:
            tasklet_count = int(metadata.get("num_tasklets", ""))
        except ValueError:
            tasklet_count = -1
        if tasklet_count in EXCLUDED_TASKLET_COUNTS:
            print(f"Skipped excluded {tasklet_count}-tasklet setting: {setting_dir}")
            continue
        if not (setting_dir / "log.txt").is_file():
            print(f"warning: skipped result without log.txt: {setting_dir}", file=sys.stderr)
            continue
        summary = aggregate_setting(setting_dir)
        if summary is None:
            print(f"warning: skipped empty log: {setting_dir / 'log.txt'}", file=sys.stderr)
            continue
        summaries.append(summary)

    summaries.sort(key=sort_key)
    write_csv(output_dir / "summary.csv", SUMMARY_FIELDS, summaries)
    print(f"Wrote {len(summaries)} settings to {output_dir}")
    return len(summaries)


def main() -> int:
    args = parse_args()
    draw_figs_dir = Path(__file__).resolve().parent.parent

    if args.benchmark:
        benchmark_dir = args.benchmark.lower()

        input_root = (
            args.input or draw_figs_dir / "simulator_results" / benchmark_dir
        ).resolve()

        output_dir = (
            args.output_dir
            or draw_figs_dir / "results" / benchmark_dir
        ).resolve()

        try:
            aggregate_results(input_root, output_dir)
        except ValueError as error:
            print(f"error: {error}", file=sys.stderr)
            return 2
        return 0

    # Batch mode: each immediate child containing metadata is one benchmark.
    # Keep outputs outside the scanned benchmark directories so generated files
    # can never be rediscovered as raw simulator inputs.
    input_root = (args.input or draw_figs_dir / "simulator_results").resolve()
    output_root = args.output_dir or draw_figs_dir / "results"
    if not input_root.is_dir():
        print(f"error: input directory does not exist: {input_root}", file=sys.stderr)
        return 2

    resolved_output_root = output_root.resolve()
    benchmark_inputs = [
        child
        for child in sorted(input_root.iterdir())
        if child.is_dir()
        and child.resolve() != resolved_output_root
        and any(child.rglob("metadata.txt"))
    ]
    if not benchmark_inputs:
        print(
            f"error: no benchmark result directories found below {input_root}",
            file=sys.stderr,
        )
        return 2

    total_settings = 0
    for benchmark_input in benchmark_inputs:
        print(f"Aggregating {benchmark_input.name}...")
        settings = aggregate_results(
            benchmark_input,
            output_root / benchmark_input.name.lower(),
        )
        total_settings += settings

    print(
        f"Aggregated {len(benchmark_inputs)} benchmarks: {total_settings} settings"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
