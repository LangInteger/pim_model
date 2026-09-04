#!/usr/bin/env python3
"""Compare static and simulated dynamic instruction counts."""

from __future__ import annotations

import argparse
import csv
from pathlib import Path
from typing import Any

from aggregate_simulator_results import aggregate_setting


SUPPORTED_BENCHMARKS = ("va",)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Plot static instruction bounds against uPIMulator counts. "
            "Without BENCHMARK, generate every supported benchmark."
        )
    )
    parser.add_argument(
        "benchmark",
        nargs="?",
        help=f"benchmark to generate; supported: {', '.join(SUPPORTED_BENCHMARKS)}",
    )
    parser.add_argument(
        "--static-summary",
        type=Path,
        help="override the static instruction-count summary path",
    )
    parser.add_argument(
        "--simulator-summary",
        type=Path,
        help="override the aggregated simulator summary path",
    )
    parser.add_argument(
        "--raw-simulator-results",
        type=Path,
        help="Used to recover settings such as T=11 excluded from summary.csv",
    )
    parser.add_argument(
        "--output-dir",
        type=Path,
        help="override the output directory",
    )
    return parser.parse_args()


def load_static_rows(
    path: Path, benchmark: str
) -> dict[int, dict[str, Any]]:
    rows: dict[int, dict[str, Any]] = {}
    with path.open(newline="", encoding="utf-8") as input_file:
        for row in csv.DictReader(input_file):
            if row["benchmark"].lower() != benchmark:
                continue
            tasklets = int(row["tasklets"])
            lower = float(row["instructions_lower"])
            upper = float(row["instructions_upper"])
            rows[tasklets] = {
                "lower": lower,
                "upper": upper,
                "midpoint": (lower + upper) / 2,
                "unexpanded_callees": row.get("unexpanded_callees", ""),
            }
    if not rows:
        raise ValueError(f"no {benchmark.upper()} instruction results found in {path}")
    return rows


def load_simulator_rows(
    summary_path: Path, raw_results: Path, benchmark: str
) -> dict[int, dict[str, Any]]:
    rows: dict[int, dict[str, Any]] = {}
    with summary_path.open(newline="", encoding="utf-8") as input_file:
        for row in csv.DictReader(input_file):
            if row["benchmark"].lower() != benchmark:
                continue
            if row["experiment"] != "tasklet_sweep":
                continue
            tasklets = int(row["num_tasklets"])
            rows[tasklets] = {
                "instructions": float(row["instructions_mean"]),
                "source": "aggregated_summary",
            }

    # The main aggregation intentionally excludes T=11. Read any missing
    # tasklet setting through the same per-setting aggregation function.
    for metadata_path in sorted(raw_results.rglob("metadata.txt")):
        setting = aggregate_setting(metadata_path.parent)
        if not setting:
            continue
        if setting["benchmark"].lower() != benchmark:
            continue
        if setting["experiment"] != "tasklet_sweep":
            continue
        tasklets = int(setting["num_tasklets"])
        rows.setdefault(
            tasklets,
            {
                "instructions": float(setting["instructions_mean"]),
                "source": "raw_simulator_log",
            },
        )
    return rows


def comparison_rows(
    static_rows: dict[int, dict[str, Any]],
    simulator_rows: dict[int, dict[str, Any]],
) -> list[dict[str, Any]]:
    missing = sorted(set(static_rows) - set(simulator_rows))
    if missing:
        raise ValueError(f"missing simulator instruction counts for tasklets {missing}")

    rows = []
    for tasklets in sorted(static_rows):
        static = static_rows[tasklets]
        simulated = simulator_rows[tasklets]
        measured = float(simulated["instructions"])
        midpoint = float(static["midpoint"])
        rows.append(
            {
                "num_tasklets": tasklets,
                "static_instructions_lower": static["lower"],
                "static_instructions_midpoint": midpoint,
                "static_instructions_upper": static["upper"],
                "simulator_instructions": measured,
                "static_midpoint_minus_simulator": midpoint - measured,
                "static_midpoint_error_percent": 100 * (midpoint - measured) / measured,
                "simulator_within_static_interval": (
                    static["lower"] <= measured <= static["upper"]
                ),
                "unexpanded_callees": static["unexpanded_callees"],
                "simulator_source": simulated["source"],
            }
        )
    return rows


def write_csv(path: Path, rows: list[dict[str, Any]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="", encoding="utf-8") as output_file:
        writer = csv.DictWriter(
            output_file, fieldnames=list(rows[0]), lineterminator="\n"
        )
        writer.writeheader()
        writer.writerows(rows)


def write_plot(
    path: Path, rows: list[dict[str, Any]], benchmark: str
) -> None:
    import matplotlib

    matplotlib.use("Agg")
    import matplotlib.pyplot as plt
    from matplotlib.ticker import ScalarFormatter

    tasklets = [int(row["num_tasklets"]) for row in rows]
    lower = [float(row["static_instructions_lower"]) for row in rows]
    midpoint = [float(row["static_instructions_midpoint"]) for row in rows]
    upper = [float(row["static_instructions_upper"]) for row in rows]
    measured = [float(row["simulator_instructions"]) for row in rows]
    errors = [float(row["static_midpoint_error_percent"]) for row in rows]

    figure, (count_axis, error_axis) = plt.subplots(
        2,
        1,
        figsize=(9.2, 7.0),
        sharex=True,
        layout="constrained",
        gridspec_kw={"height_ratios": [3.2, 1.2], "hspace": 0.08},
    )

    count_axis.fill_between(
        tasklets,
        lower,
        upper,
        color="#93c5fd",
        alpha=0.45,
        label="Static lower–upper interval",
        zorder=1,
    )
    count_axis.plot(
        tasklets,
        midpoint,
        color="#2563eb",
        marker="s",
        linestyle="--",
        linewidth=2.1,
        markersize=7,
        label="Static midpoint",
        zorder=3,
    )
    count_axis.plot(
        tasklets,
        measured,
        color="#111827",
        marker="o",
        linewidth=2.4,
        markersize=7,
        label="uPIMulator",
        zorder=4,
    )
    count_axis.set_ylabel("Dynamic instructions per DPU")
    count_axis.set_title(
        f"{benchmark.upper()} instruction count: static analysis vs uPIMulator"
    )
    count_axis.grid(axis="y", linestyle="--", alpha=0.3)
    count_axis.legend(frameon=False, loc="upper left")
    formatter = ScalarFormatter(useMathText=True)
    formatter.set_powerlimits((0, 0))
    count_axis.yaxis.set_major_formatter(formatter)

    error_axis.axhline(0, color="#64748b", linewidth=1.1)
    error_axis.plot(
        tasklets,
        errors,
        color="#ea580c",
        marker="D",
        linewidth=2.0,
        markersize=6.5,
    )
    for index, (tasklet, error) in enumerate(zip(tasklets, errors)):
        if index == 0:
            x_offset, alignment = -4, "right"
        elif index == 1:
            x_offset, alignment = 4, "left"
        elif index == len(tasklets) - 1:
            x_offset, alignment = -4, "right"
        else:
            x_offset, alignment = 0, "center"
        error_axis.annotate(
            f"{error:.3f}%",
            (tasklet, error),
            xytext=(x_offset, 9),
            textcoords="offset points",
            ha=alignment,
            va="bottom",
            fontsize=8.5,
        )
    error_axis.set_xlabel("Number of tasklets")
    error_axis.set_ylabel("Static midpoint\nerror (%)")
    error_axis.set_xticks(tasklets)
    error_axis.grid(axis="y", linestyle="--", alpha=0.3)

    all_counts = lower + upper + measured
    count_range = max(all_counts) - min(all_counts)
    padding = max(300.0, 0.10 * count_range)
    count_axis.set_ylim(min(all_counts) - padding, max(all_counts) + padding)
    error_padding = max(0.01, 0.12 * (max(errors) - min(errors)))
    error_axis.set_ylim(min(errors) - error_padding, error_padding)
    error_axis.set_xlim(min(tasklets) - 0.5, max(tasklets) + 0.5)

    path.parent.mkdir(parents=True, exist_ok=True)
    figure.savefig(path, dpi=220, bbox_inches="tight")
    plt.close(figure)


def run_benchmark(args: argparse.Namespace, benchmark: str) -> None:
    project_root = Path(__file__).resolve().parents[2]
    benchmark_upper = benchmark.upper()
    static_summary = args.static_summary or (
        project_root
        / "inst_count_analyzer"
        / "results"
        / f"{benchmark_upper}_tasklet_sweep"
        / "instruction_counts.csv"
    )
    simulator_summary = args.simulator_summary or (
        project_root / "draw_figs" / "results" / benchmark / "summary.csv"
    )
    raw_simulator_results = args.raw_simulator_results or (
        project_root / "draw_figs" / "simulator_results" / benchmark
    )
    output_dir = args.output_dir or (
        project_root / "draw_figs" / "results" / benchmark
    )

    static_rows = load_static_rows(static_summary, benchmark)
    simulator_rows = load_simulator_rows(
        simulator_summary, raw_simulator_results, benchmark
    )
    rows = comparison_rows(static_rows, simulator_rows)
    csv_path = output_dir / f"{benchmark}_instruction_count_comparison.csv"
    plot_path = output_dir / f"{benchmark}_instruction_count_comparison.png"
    write_csv(csv_path, rows)
    write_plot(plot_path, rows, benchmark)
    print(f"Wrote {csv_path}")
    print(f"Wrote {plot_path}")


def main() -> int:
    args = parse_args()
    if args.benchmark:
        benchmark = args.benchmark.lower()
        if benchmark not in SUPPORTED_BENCHMARKS:
            supported = ", ".join(SUPPORTED_BENCHMARKS)
            raise SystemExit(
                f"unsupported benchmark {args.benchmark!r}; supported: {supported}"
            )
        benchmarks = [benchmark]
    else:
        overrides = {
            "--static-summary": args.static_summary,
            "--simulator-summary": args.simulator_summary,
            "--raw-simulator-results": args.raw_simulator_results,
            "--output-dir": args.output_dir,
        }
        incompatible = [name for name, value in overrides.items() if value]
        if incompatible:
            raise SystemExit(
                "path overrides require an explicit benchmark: "
                + ", ".join(incompatible)
            )
        benchmarks = list(SUPPORTED_BENCHMARKS)

    for benchmark in benchmarks:
        run_benchmark(args, benchmark)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
