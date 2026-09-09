#!/usr/bin/env python3
"""Plot normalized composed-cycle intervals for every benchmark."""

from __future__ import annotations

import argparse
import csv
import math
from dataclasses import dataclass
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


@dataclass(frozen=True)
class CycleComponents:
    lower_total: float
    upper_total: float
    lower_compute: float
    lower_memory: float
    upper_compute: float
    upper_memory: float
    lower_is_additive: bool


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
) -> dict[str, dict[tuple[str, int], CycleComponents]]:
    results: dict[str, dict[tuple[str, int], CycleComponents]] = {}
    for benchmark in BENCHMARK_ORDER:
        path = results_root / benchmark / f"{benchmark}_cost_estimates.csv"
        if not path.is_file():
            continue
        with path.open(newline="", encoding="utf-8") as input_file:
            rows = list(csv.DictReader(input_file))
        if not rows:
            raise ValueError(f"no cost estimates found in {path}")

        intervals: dict[tuple[str, int], CycleComponents] = {}
        for row in rows:
            measured = float(row["actual_cycles"])
            if measured <= 0:
                raise ValueError(f"non-positive actual_cycles in {path}")
            components = CycleComponents(
                lower_total=float(row["composed_cycles_lower"]) / measured,
                upper_total=float(row["composed_cycles_upper"]) / measured,
                lower_compute=float(row["compute_cycles_lower"]) / measured,
                lower_memory=float(row["memory_model_lower_cycles"]) / measured,
                upper_compute=(
                    float(row["compute_cycles_conservative_upper"]) / measured
                ),
                upper_memory=float(row["memory_model_upper_cycles"]) / measured,
                lower_is_additive=(
                    row["composed_lower_assumption"]
                    == "single_tasklet_no_overlap"
                ),
            )
            if (
                components.lower_total <= 0
                or components.upper_total <= 0
                or components.lower_total > components.upper_total
            ):
                raise ValueError(f"invalid composed-cycle interval in {path}: {row}")
            expected_lower = (
                components.lower_compute + components.lower_memory
                if components.lower_is_additive
                else max(components.lower_compute, components.lower_memory)
            )
            expected_upper = components.upper_compute + components.upper_memory
            if not math.isclose(components.lower_total, expected_lower) or not math.isclose(
                components.upper_total, expected_upper
            ):
                raise ValueError(f"component totals do not compose in {path}: {row}")
            intervals[setting_id(row)] = components
        results[benchmark] = intervals

    if not results:
        raise ValueError(f"no benchmark cost estimates found below {results_root}")
    return results


def plot_group(
    axis: Any,
    intervals: dict[tuple[str, int], CycleComponents],
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
    lower = [item[1].lower_total for item in selected]
    upper = [item[1].upper_total for item in selected]
    bar_width = 0.26
    lower_offset = -0.16
    upper_offset = 0.16
    compute_color = "#4c78a8"
    memory_color = "#f58518"

    for position, components in selected:
        lower_x = position + lower_offset
        upper_x = position + upper_offset
        if components.lower_is_additive:
            axis.bar(
                lower_x,
                components.lower_compute,
                width=bar_width,
                color=compute_color,
                edgecolor="none",
                zorder=2,
            )
            axis.bar(
                lower_x,
                components.lower_memory,
                bottom=components.lower_compute,
                width=bar_width,
                color=memory_color,
                edgecolor="none",
                zorder=2,
            )
        else:
            compute_dominates = (
                components.lower_compute >= components.lower_memory
            )
            dominant = (
                components.lower_compute
                if compute_dominates
                else components.lower_memory
            )
            hidden = (
                components.lower_memory
                if compute_dominates
                else components.lower_compute
            )
            dominant_color = compute_color if compute_dominates else memory_color
            hidden_color = memory_color if compute_dominates else compute_color
            axis.bar(
                lower_x,
                dominant,
                width=bar_width,
                color=dominant_color,
                edgecolor="none",
                zorder=2,
            )
            axis.bar(
                lower_x,
                hidden,
                width=bar_width,
                color=hidden_color,
                alpha=0.48,
                edgecolor="#374151",
                linewidth=0.25,
                hatch="////",
                zorder=3,
            )

        axis.bar(
            upper_x,
            components.upper_compute,
            width=bar_width,
            color=compute_color,
            edgecolor="none",
            zorder=2,
        )
        axis.bar(
            upper_x,
            components.upper_memory,
            bottom=components.upper_compute,
            width=bar_width,
            color=memory_color,
            edgecolor="none",
            zorder=2,
        )

    axis.plot(
        [value + lower_offset for value in x_values],
        lower,
        color="#111827",
        linestyle="-",
        linewidth=0.8,
        zorder=4,
    )
    axis.plot(
        [value + upper_offset for value in x_values],
        upper,
        color="#111827",
        linestyle="--",
        linewidth=0.8,
        zorder=4,
    )


def write_plot(
    output: Path,
    results: dict[str, dict[tuple[str, int], CycleComponents]],
) -> tuple[int, int]:
    import matplotlib

    matplotlib.use("Agg")
    import matplotlib.pyplot as plt
    from matplotlib.patches import Patch
    from matplotlib.lines import Line2D
    from matplotlib.ticker import MaxNLocator

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
        covered = sum(
            item.lower_total <= 1.0 <= item.upper_total
            for item in intervals.values()
        )
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
            elif not interval.lower_total <= 1.0 <= interval.upper_total:
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
        largest_upper = max(item.upper_total for item in intervals.values())
        axis.set_ylim(0.0, max(1.15, largest_upper * 1.08))
        axis.set_xlim(-0.35, 8.85)
        axis.set_xticks(
            [setting[3] for setting in SETTINGS],
            [setting[2] for setting in SETTINGS],
        )
        axis.yaxis.set_major_locator(MaxNLocator(nbins=4, min_n_ticks=3))
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
        Patch(
            facecolor="#4c78a8",
            edgecolor="none",
            label="instruction-count cost",
        ),
        Patch(
            facecolor="#f58518",
            edgecolor="none",
            label="data-movement cost",
        ),
        Patch(
            facecolor="#d1d5db",
            edgecolor="#374151",
            linewidth=0.3,
            hatch="////",
            label="overlapped component in lower bound",
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
        bbox_to_anchor=(0.5, 0.92),
        ncol=5,
        frameon=False,
        fontsize=8.2,
        handlelength=2.4,
        columnspacing=1.8,
    )
    figure.suptitle(
        f"PIMSA composed-cycle intervals across benchmarks  ·  "
        f"{total_covered}/{total_present} covered",
        fontsize=14,
        fontweight="bold",
        y=0.982,
    )
    figure.text(
        0.5,
        0.944,
        "Each setting: lower (left, solid) | upper (right, dashed)   ·   "
        "T: tasklets   ·   P: DPUs at 16 tasklets",
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
