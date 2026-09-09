#!/usr/bin/env python3
"""Compare static and simulated dynamic instruction counts."""

from __future__ import annotations

import argparse
import csv
from pathlib import Path
from typing import Any

from aggregate_simulator_results import aggregate_setting


SUPPORTED_BENCHMARKS = (
    "bs",
    "gemv",
    "hst-l",
    "hst-s",
    "mlp",
    "red",
    "scan-rss",
    "scan-ssa",
    "sel",
    "trns",
    "ts",
    "uni",
    "va",
)

SUPPORTED_EXPERIMENTS = ("tasklet_sweep", "dpu_sweep")


def sweep_value(row: dict[str, Any], experiment: str) -> int:
    if experiment == "tasklet_sweep":
        return int(row["num_tasklets"])
    if experiment == "dpu_sweep":
        return int(row["num_dpus"])
    raise ValueError(f"unsupported experiment: {experiment}")


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
) -> dict[str, dict[int, dict[str, Any]]]:
    rows: dict[str, dict[int, dict[str, Any]]] = {
        experiment: {} for experiment in SUPPORTED_EXPERIMENTS
    }
    with path.open(newline="", encoding="utf-8") as input_file:
        for row in csv.DictReader(input_file):
            if row["benchmark"].lower() != benchmark:
                continue
            experiment = row.get("experiment", "")
            if experiment not in SUPPORTED_EXPERIMENTS:
                continue
            value = sweep_value(row, experiment)
            lower = float(row["instructions_lower"])
            upper = float(row["instructions_upper"])
            rows[experiment][value] = {
                "num_dpus": int(row["num_dpus"]),
                "num_tasklets": int(row["num_tasklets"]),
                "lower": lower,
                "upper": upper,
                "midpoint": (lower + upper) / 2,
                "unexpanded_callees": row.get("unexpanded_callees", ""),
            }
    if not any(rows.values()):
        raise ValueError(f"no {benchmark.upper()} instruction results found in {path}")
    return rows


def load_simulator_rows(
    summary_path: Path, raw_results: Path, benchmark: str
) -> dict[str, dict[int, dict[str, Any]]]:
    rows: dict[str, dict[int, dict[str, Any]]] = {
        experiment: {} for experiment in SUPPORTED_EXPERIMENTS
    }
    with summary_path.open(newline="", encoding="utf-8") as input_file:
        for row in csv.DictReader(input_file):
            if row["benchmark"].lower() != benchmark:
                continue
            experiment = row["experiment"]
            if experiment not in SUPPORTED_EXPERIMENTS:
                continue
            value = sweep_value(row, experiment)
            rows[experiment][value] = {
                "num_dpus": int(row["num_dpus"]),
                "num_tasklets": int(row["num_tasklets"]),
                "instructions": float(row["instructions_mean"]),
                "source": "aggregated_summary",
            }

    # The main aggregation intentionally excludes T=11. Read any missing
    # tasklet setting through the same per-setting aggregation function.
    for metadata_path in sorted(raw_results.rglob("metadata.txt")):
        if not (metadata_path.parent / "log.txt").is_file():
            continue
        setting = aggregate_setting(metadata_path.parent)
        if not setting:
            continue
        if setting["benchmark"].lower() != benchmark:
            continue
        experiment = str(setting["experiment"])
        if experiment not in SUPPORTED_EXPERIMENTS:
            continue
        value = sweep_value(setting, experiment)
        rows[experiment].setdefault(
            value,
            {
                "num_dpus": int(setting["num_dpus"]),
                "num_tasklets": int(setting["num_tasklets"]),
                "instructions": float(setting["instructions_mean"]),
                "source": "raw_simulator_log",
            },
        )
    return rows


def comparison_rows(
    static_rows: dict[str, dict[int, dict[str, Any]]],
    simulator_rows: dict[str, dict[int, dict[str, Any]]],
) -> list[dict[str, Any]]:
    rows: list[dict[str, Any]] = []
    for experiment in SUPPORTED_EXPERIMENTS:
        experiment_static = static_rows[experiment]
        experiment_simulator = simulator_rows[experiment]
        missing = sorted(set(experiment_static) - set(experiment_simulator))
        if missing:
            parameter = "tasklets" if experiment == "tasklet_sweep" else "DPUs"
            raise ValueError(
                f"missing simulator instruction counts for {parameter} {missing}"
            )

        for value in sorted(experiment_static):
            static = experiment_static[value]
            simulated = experiment_simulator[value]
            measured = float(simulated["instructions"])
            midpoint = float(static["midpoint"])
            rows.append(
                {
                    "experiment": experiment,
                    "num_dpus": static["num_dpus"],
                    "num_tasklets": static["num_tasklets"],
                    "static_instructions_lower": static["lower"],
                    "static_instructions_midpoint": midpoint,
                    "static_instructions_upper": static["upper"],
                    "simulator_instructions": measured,
                    "static_midpoint_minus_simulator": midpoint - measured,
                    "static_midpoint_error_percent": (
                        100 * (midpoint - measured) / measured
                    ),
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

    figure, axes = plt.subplots(
        2,
        2,
        figsize=(13.2, 7.0),
        sharex="col",
        layout="constrained",
        gridspec_kw={"height_ratios": [3.2, 1.2], "hspace": 0.08},
    )

    experiment_specs = (
        ("tasklet_sweep", "Number of tasklets", "Tasklet sweep"),
        ("dpu_sweep", "Number of DPUs", "DPU sweep"),
    )
    for column, (experiment, x_label, title) in enumerate(experiment_specs):
        experiment_rows = [
            row for row in rows if row["experiment"] == experiment
        ]
        if not experiment_rows:
            axes[0, column].set_visible(False)
            axes[1, column].set_visible(False)
            continue

        x_key = "num_tasklets" if experiment == "tasklet_sweep" else "num_dpus"
        values = [int(row[x_key]) for row in experiment_rows]
        lower = [float(row["static_instructions_lower"]) for row in experiment_rows]
        midpoint = [
            float(row["static_instructions_midpoint"]) for row in experiment_rows
        ]
        upper = [float(row["static_instructions_upper"]) for row in experiment_rows]
        measured = [float(row["simulator_instructions"]) for row in experiment_rows]
        errors = [
            float(row["static_midpoint_error_percent"])
            for row in experiment_rows
        ]
        lower_errors = [
            100 * (static_lower - observed) / observed
            for static_lower, observed in zip(lower, measured)
        ]
        upper_errors = [
            100 * (static_upper - observed) / observed
            for static_upper, observed in zip(upper, measured)
        ]
        count_axis = axes[0, column]
        error_axis = axes[1, column]

        count_axis.fill_between(
            values,
            lower,
            upper,
            color="#93c5fd",
            alpha=0.45,
            label="Static lower–upper interval",
            zorder=1,
        )
        count_axis.errorbar(
            values,
            midpoint,
            yerr=(
                [middle - low for middle, low in zip(midpoint, lower)],
                [high - middle for high, middle in zip(upper, midpoint)],
            ),
            color="#2563eb",
            marker="s",
            linestyle="--",
            linewidth=2.1,
            markersize=7,
            elinewidth=2.0,
            capsize=6,
            capthick=2.0,
            label="Static midpoint and bounds",
            zorder=3,
        )
        count_axis.plot(
            values,
            measured,
            color="#111827",
            marker="o",
            linewidth=2.4,
            markersize=7,
            label="uPIMulator",
            zorder=4,
        )
        count_axis.set_title(title)
        count_axis.grid(axis="y", linestyle="--", alpha=0.3)
        formatter = ScalarFormatter(useMathText=True)
        formatter.set_powerlimits((0, 0))
        count_axis.yaxis.set_major_formatter(formatter)

        error_axis.axhline(0, color="#64748b", linewidth=1.1)
        error_axis.fill_between(
            values,
            lower_errors,
            upper_errors,
            color="#93c5fd",
            alpha=0.55,
            label="Lower–upper error range",
            zorder=1,
        )
        error_axis.plot(
            values,
            lower_errors,
            color="#60a5fa",
            linestyle=":",
            linewidth=1.2,
            zorder=2,
        )
        error_axis.plot(
            values,
            upper_errors,
            color="#60a5fa",
            linestyle=":",
            linewidth=1.2,
            zorder=2,
        )
        error_axis.plot(
            values,
            errors,
            color="#ea580c",
            marker="D",
            linewidth=2.0,
            markersize=6.5,
        )
        for index, (value, error) in enumerate(zip(values, errors)):
            if experiment == "tasklet_sweep" and index == 0:
                x_offset, y_offset, alignment = -2, 14, "center"
            elif experiment == "tasklet_sweep" and index == 1:
                x_offset, y_offset, alignment = 2, -17, "center"
            elif index == 0:
                x_offset, y_offset, alignment = 4, 9, "left"
            elif index == len(values) - 1:
                x_offset, y_offset, alignment = -4, 9, "right"
            else:
                x_offset, y_offset, alignment = 0, 9, "center"
            error_axis.annotate(
                f"{error:.3f}%",
                (value, error),
                xytext=(x_offset, y_offset),
                textcoords="offset points",
                ha=alignment,
                va="bottom",
                fontsize=8.5,
        )
        error_axis.set_xlabel(x_label)
        error_axis.grid(axis="y", linestyle="--", alpha=0.3)

        all_counts = lower + upper + measured
        count_range = max(all_counts) - min(all_counts)
        padding = max(300.0, 0.10 * count_range)
        count_axis.set_ylim(min(all_counts) - padding, max(all_counts) + padding)
        all_errors = lower_errors + errors + upper_errors
        error_range = max(all_errors) - min(all_errors)
        error_padding = max(
            0.01,
            0.12 * error_range,
            0.05 * max(abs(error) for error in all_errors),
        )
        error_axis.set_ylim(
            min(0.0, min(all_errors) - error_padding),
            max(0.0, max(all_errors))
            + max(error_padding, 0.08 * max(abs(error) for error in all_errors)),
        )
        if experiment == "dpu_sweep":
            count_axis.set_xscale("log", base=2)
            error_axis.set_xscale("log", base=2)
        else:
            error_axis.set_xlim(min(values) - 0.5, max(values) + 0.5)
        error_axis.set_xticks(values, labels=[str(value) for value in values])

    axes[0, 0].set_ylabel("Dynamic instructions per DPU")
    axes[1, 0].set_ylabel("Static midpoint\nerror (%)")
    visible_count_axes = [axis for axis in axes[0] if axis.get_visible()]
    if visible_count_axes:
        visible_count_axes[0].legend(frameon=False, loc="upper left")
    figure.suptitle(
        f"{benchmark.upper()} instruction count: static analysis vs uPIMulator"
    )

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
        / benchmark_upper
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
