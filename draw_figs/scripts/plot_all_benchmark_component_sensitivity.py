#!/usr/bin/env python3
"""Plot normalized composed-cycle intervals for every benchmark."""

from __future__ import annotations

import argparse
import csv
from pathlib import Path
from typing import Any


BENCHMARK_ORDER = (
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

SETTINGS = (
    ("tasklet_sweep", 1, "T1", 0.0),
    ("tasklet_sweep", 2, "T2", 1.0),
    ("tasklet_sweep", 4, "T4", 2.0),
    ("tasklet_sweep", 8, "T8", 3.0),
    ("tasklet_sweep", 16, "T16", 4.0),
    ("dpu_sweep", 1, "P1", 5.5),
    ("dpu_sweep", 4, "P4", 6.5),
    ("dpu_sweep", 16, "P16", 7.5),
    ("dpu_sweep", 64, "P64", 8.5),
)


def parse_args() -> argparse.Namespace:
    script_dir = Path(__file__).resolve().parent
    results_root = script_dir.parent / "results"
    parser = argparse.ArgumentParser(
        description="Create an all-benchmark composed-cycle small-multiples plot."
    )
    parser.add_argument("--results-root", type=Path, default=results_root)
    parser.add_argument(
        "--output",
        type=Path,
        default=results_root / "all_benchmark_component_sensitivity.png",
    )
    return parser.parse_args()


def setting_id(row: dict[str, str]) -> tuple[str, int]:
    experiment = row["experiment"]
    if experiment == "tasklet_sweep":
        return experiment, int(row["num_tasklets"])
    if experiment == "dpu_sweep":
        return experiment, int(row["num_dpus"])
    raise ValueError(f"unsupported experiment: {experiment}")


def load_results(
    results_root: Path,
) -> dict[str, dict[tuple[str, int], tuple[float, float]]]:
    results: dict[str, dict[tuple[str, int], tuple[float, float]]] = {}
    for benchmark in BENCHMARK_ORDER:
        path = results_root / benchmark / f"{benchmark}_cost_estimates.csv"
        if not path.is_file():
            continue
        with path.open(newline="", encoding="utf-8") as input_file:
            rows = list(csv.DictReader(input_file))
        if not rows:
            raise ValueError(f"no cost estimates found in {path}")

        intervals: dict[tuple[str, int], tuple[float, float]] = {}
        for row in rows:
            measured = float(row["actual_cycles"])
            if measured <= 0:
                raise ValueError(f"non-positive actual_cycles in {path}")
            lower = float(row["composed_cycles_lower"]) / measured
            upper = float(row["composed_cycles_upper"]) / measured
            if lower <= 0 or upper <= 0 or lower > upper:
                raise ValueError(f"invalid composed-cycle interval in {path}: {row}")
            intervals[setting_id(row)] = (lower, upper)
        results[benchmark] = intervals

    if not results:
        raise ValueError(f"no benchmark cost estimates found below {results_root}")
    return results


def plot_group(
    axis: Any,
    intervals: dict[tuple[str, int], tuple[float, float]],
    experiment: str,
) -> None:
    selected = [
        (position, intervals[(kind, value)])
        for kind, value, _label, position in SETTINGS
        if kind == experiment and (kind, value) in intervals
    ]
    if not selected:
        return
    x_values = [item[0] for item in selected]
    lower = [item[1][0] for item in selected]
    upper = [item[1][1] for item in selected]
    axis.fill_between(
        x_values,
        lower,
        upper,
        color="#9ecae1",
        alpha=0.25,
        linewidth=0,
        zorder=1,
    )
    axis.plot(
        x_values,
        lower,
        color="#2563eb",
        marker="^",
        markersize=3.8,
        markeredgecolor="white",
        markeredgewidth=0.4,
        linestyle="--",
        linewidth=1.15,
        zorder=3,
    )
    axis.plot(
        x_values,
        upper,
        color="#ea580c",
        marker="v",
        markersize=3.8,
        markeredgecolor="white",
        markeredgewidth=0.4,
        linestyle="--",
        linewidth=1.15,
        zorder=3,
    )


def write_plot(
    output: Path,
    results: dict[str, dict[tuple[str, int], tuple[float, float]]],
) -> tuple[int, int]:
    import matplotlib

    matplotlib.use("Agg")
    import matplotlib.pyplot as plt
    from matplotlib.lines import Line2D

    plt.rcParams.update(
        {
            "font.family": "serif",
            "font.size": 7.5,
            "axes.titlesize": 9.2,
            "xtick.labelsize": 6.8,
            "ytick.labelsize": 6.8,
        }
    )

    figure = plt.figure(figsize=(15.0, 7.7))
    grid = figure.add_gridspec(3, 10)
    placements = [
        (0, 0), (0, 2), (0, 4), (0, 6), (0, 8),
        (1, 0), (1, 2), (1, 4), (1, 6), (1, 8),
        (2, 2), (2, 4), (2, 6),
    ]

    total_covered = 0
    total_present = 0
    axes = []
    for benchmark, (row_index, column_index) in zip(results, placements):
        axis = figure.add_subplot(grid[row_index, column_index:column_index + 2])
        axes.append(axis)
        intervals = results[benchmark]
        covered = sum(lower <= 1.0 <= upper for lower, upper in intervals.values())
        present = len(intervals)
        total_covered += covered
        total_present += present

        plot_group(axis, intervals, "tasklet_sweep")
        plot_group(axis, intervals, "dpu_sweep")
        axis.axhline(
            1.0,
            color="#111827",
            linestyle=(0, (2.2, 2.2)),
            linewidth=0.9,
            zorder=2,
        )
        for experiment, value, _label, position in SETTINGS:
            interval = intervals.get((experiment, value))
            if interval is None:
                axis.text(
                    position,
                    0.145,
                    "N/A",
                    color="#6b7280",
                    fontsize=5.8,
                    ha="center",
                    va="bottom",
                )
            elif not interval[0] <= 1.0 <= interval[1]:
                axis.plot(
                    position,
                    1.0,
                    marker="x",
                    color="#b91c1c",
                    markersize=4.8,
                    markeredgewidth=1.05,
                    zorder=5,
                )

        axis.axvline(4.75, color="#9ca3af", linewidth=0.65)
        axis.set_yscale("log", base=2)
        axis.set_ylim(0.12, 8.1)
        axis.set_xlim(-0.35, 8.85)
        axis.set_xticks(
            [setting[3] for setting in SETTINGS],
            [setting[2] for setting in SETTINGS],
        )
        axis.set_yticks(
            [0.125, 0.25, 0.5, 1, 2, 4, 8],
            ["1/8", "1/4", "1/2", "1", "2", "4", "8"],
        )
        if benchmark not in {"bs", "red", "ts"}:
            axis.tick_params(axis="y", labelleft=False)
        axis.tick_params(axis="both", length=2.2, width=0.6, pad=1.5)
        axis.grid(axis="y", color="#d1d5db", linewidth=0.45, alpha=0.65)
        axis.set_title(
            f"{benchmark.upper()}  ·  {covered}/{present}",
            loc="left",
            pad=2.5,
            fontweight="bold",
        )
        for spine in axis.spines.values():
            spine.set_color("#4b5563")
            spine.set_linewidth(0.65)

    legend_handles = [
        Line2D(
            [0], [0], color="#2563eb", marker="^", linestyle="--",
            linewidth=1.3, markersize=4.5, label="PIMSA lower bound",
        ),
        Line2D(
            [0], [0], color="#ea580c", marker="v", linestyle="--",
            linewidth=1.3, markersize=4.5, label="PIMSA upper bound",
        ),
        Line2D(
            [0], [0], color="#111827", linestyle=(0, (2.2, 2.2)),
            linewidth=1.0, label="uPIMulator (normalized to 1)",
        ),
        Line2D(
            [0], [0], color="#b91c1c", marker="x", linestyle="none",
            markersize=5.0, label="measurement outside interval",
        ),
    ]
    figure.legend(
        handles=legend_handles,
        loc="upper center",
        bbox_to_anchor=(0.5, 0.925),
        ncol=4,
        frameon=False,
        fontsize=8.2,
        handlelength=2.4,
        columnspacing=1.8,
    )
    figure.suptitle(
        f"PIMSA composed-cycle bounds across benchmarks  ·  "
        f"{total_covered}/{total_present} covered",
        fontsize=14,
        fontweight="bold",
        y=0.982,
    )
    figure.text(
        0.5,
        0.944,
        "T1–T16: tasklet sweep   ·   P1–P64: DPU sweep at 16 tasklets",
        ha="center",
        va="center",
        fontsize=8.3,
        color="#374151",
    )
    figure.text(
        0.018,
        0.47,
        "PIMSA estimate / uPIMulator",
        rotation=90,
        ha="center",
        va="center",
        fontsize=9.2,
    )
    figure.subplots_adjust(
        left=0.048,
        right=0.992,
        bottom=0.065,
        top=0.86,
        wspace=0.82,
        hspace=0.43,
    )
    output.parent.mkdir(parents=True, exist_ok=True)
    figure.savefig(output, dpi=240, bbox_inches="tight", facecolor="white")
    plt.close(figure)
    return total_covered, total_present


def main() -> int:
    args = parse_args()
    results = load_results(args.results_root)
    covered, present = write_plot(args.output, results)
    print(f"Wrote {len(results)}-benchmark component figure to {args.output}")
    print(f"Coverage: {covered}/{present}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
