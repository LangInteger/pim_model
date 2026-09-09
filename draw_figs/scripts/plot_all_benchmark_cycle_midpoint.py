#!/usr/bin/env python3
"""Compare composed-cycle interval midpoints with uPIMulator for all benchmarks."""

from __future__ import annotations

import argparse
import csv
import statistics
from dataclasses import dataclass
from pathlib import Path
from typing import Any


# Keep related PrIM application domains adjacent so that cross-benchmark
# patterns remain visible without adding another visual encoding.
BENCHMARK_ORDER = (
    "va",
    "gemv",
    "mlp",
    "hst-s",
    "hst-l",
    "bs",
    "ts",
    "sel",
    "uni",
    "red",
    "scan-ssa",
    "scan-rss",
    "trns",
)

EXPERIMENTS = (
    (
        "tasklet_sweep",
        "num_tasklets",
        (1, 2, 4, 8, 16),
        "(a) Tasklet sweep (1 DPU)",
        "Tasklets",
    ),
    (
        "dpu_sweep",
        "num_dpus",
        (1, 4, 16, 64),
        "(b) DPU sweep (16 tasklets)",
        "DPUs",
    ),
)

COLORS = ("#0072B2", "#56B4E9", "#009E73", "#E69F00", "#D55E00")
MARKERS = ("o", "s", "D", "^", "v")


@dataclass(frozen=True)
class NormalizedInterval:
    lower: float
    midpoint: float
    upper: float


def parse_args() -> argparse.Namespace:
    script_dir = Path(__file__).resolve().parent
    results_root = script_dir.parent / "results"
    parser = argparse.ArgumentParser(
        description=(
            "Plot normalized composed-cycle interval midpoints and widths for "
            "all benchmarks in the tasklet and DPU sweeps."
        )
    )
    parser.add_argument("--results-root", type=Path, default=results_root)
    parser.add_argument(
        "--output",
        type=Path,
        default=results_root / "all_benchmark_cycle_midpoint.pdf",
    )
    return parser.parse_args()


def load_results(
    results_root: Path,
) -> dict[str, dict[tuple[str, int], NormalizedInterval]]:
    results: dict[str, dict[tuple[str, int], NormalizedInterval]] = {}
    for benchmark in BENCHMARK_ORDER:
        path = results_root / benchmark / f"{benchmark}_cost_estimates.csv"
        if not path.is_file():
            continue
        with path.open(newline="", encoding="utf-8") as input_file:
            rows = list(csv.DictReader(input_file))
        if not rows:
            raise ValueError(f"no cost estimates found in {path}")

        intervals: dict[tuple[str, int], NormalizedInterval] = {}
        for row in rows:
            observed = float(row["actual_cycles"])
            lower = float(row["composed_cycles_lower"])
            upper = float(row["composed_cycles_upper"])
            if observed <= 0 or lower <= 0 or upper < lower:
                raise ValueError(f"invalid composed-cycle interval in {path}: {row}")
            experiment = row["experiment"]
            if experiment == "tasklet_sweep":
                value = int(row["num_tasklets"])
            elif experiment == "dpu_sweep":
                value = int(row["num_dpus"])
            else:
                raise ValueError(f"unsupported experiment {experiment!r} in {path}")
            intervals[(experiment, value)] = NormalizedInterval(
                lower=lower / observed,
                midpoint=(lower + upper) / (2.0 * observed),
                upper=upper / observed,
            )
        results[benchmark] = intervals

    if not results:
        raise ValueError(f"no benchmark cost estimates found below {results_root}")
    return results


def draw_experiment(
    axis: Any,
    results: dict[str, dict[tuple[str, int], NormalizedInterval]],
    experiment: str,
    values: tuple[int, ...],
    title: str,
    legend_title: str,
) -> None:
    import numpy as np

    benchmarks = list(results)
    centers = np.arange(len(benchmarks), dtype=float)
    offsets = np.linspace(-0.24, 0.24, len(values))

    for setting_index, (value, offset) in enumerate(zip(values, offsets)):
        x_values: list[float] = []
        lower: list[float] = []
        midpoint: list[float] = []
        upper: list[float] = []
        for benchmark_index, benchmark in enumerate(benchmarks):
            interval = results[benchmark].get((experiment, value))
            if interval is None:
                continue
            x_values.append(benchmark_index + offset)
            lower.append(interval.lower)
            midpoint.append(interval.midpoint)
            upper.append(interval.upper)

        color = COLORS[setting_index]
        marker = MARKERS[setting_index]
        # These are deterministic interval endpoints, not statistical error
        # bars. Thin lines retain the width information while the marker keeps
        # the midpoint comparison visually dominant.
        axis.vlines(
            x_values,
            lower,
            upper,
            color=color,
            linewidth=0.65,
            alpha=0.42,
            zorder=2,
        )
        axis.scatter(
            x_values,
            midpoint,
            s=11.5,
            marker=marker,
            facecolor=color,
            edgecolor="white",
            linewidth=0.28,
            label=str(value),
            zorder=3,
        )

    axis.axhline(
        1.0,
        color="#202124",
        linestyle=(0, (3.0, 2.2)),
        linewidth=0.85,
        zorder=1,
    )
    axis.set_yscale("log", base=2)
    axis.set_ylim(0.125, 8.0)
    axis.set_yticks(
        (0.125, 0.25, 0.5, 1.0, 2.0, 4.0, 8.0),
        ("1/8", "1/4", "1/2", "1", "2", "4", "8"),
    )
    axis.set_xlim(-0.55, len(benchmarks) - 0.45)
    axis.set_xticks(centers, [benchmark.upper() for benchmark in benchmarks])
    axis.tick_params(axis="x", rotation=48, length=0, pad=1.5)
    axis.tick_params(axis="y", length=2.2, width=0.6, pad=1.8)
    axis.grid(axis="y", which="major", color="#D1D5DB", linewidth=0.45)
    axis.set_title(title, loc="left", pad=17, fontweight="bold")
    axis.legend(
        title=legend_title,
        loc="lower right",
        bbox_to_anchor=(1.0, 1.005),
        ncol=len(values),
        frameon=False,
        borderaxespad=0,
        handletextpad=0.25,
        columnspacing=0.75,
        markerscale=0.92,
    )
    for spine in axis.spines.values():
        spine.set_color("#4B5563")
        spine.set_linewidth(0.6)


def write_plot(
    output: Path,
    results: dict[str, dict[tuple[str, int], NormalizedInterval]],
) -> None:
    import matplotlib

    matplotlib.use("Agg")
    import matplotlib.pyplot as plt
    from matplotlib.lines import Line2D

    plt.rcParams.update(
        {
            "font.family": "serif",
            "font.size": 6.7,
            "axes.titlesize": 7.7,
            "axes.labelsize": 7.2,
            "xtick.labelsize": 5.9,
            "ytick.labelsize": 6.2,
            "legend.fontsize": 6.0,
            "legend.title_fontsize": 6.0,
            "pdf.fonttype": 42,
            "ps.fonttype": 42,
        }
    )

    figure, axes = plt.subplots(1, 2, figsize=(7.0, 2.35), sharey=True)
    figure.subplots_adjust(
        left=0.073,
        right=0.995,
        bottom=0.255,
        top=0.775,
        wspace=0.075,
    )
    for axis, (experiment, _field, values, title, legend_title) in zip(
        axes, EXPERIMENTS
    ):
        draw_experiment(
            axis,
            results,
            experiment,
            values,
            title,
            legend_title,
        )

    axes[1].tick_params(axis="y", left=False, labelleft=False)
    figure.text(
        0.012,
        0.51,
        "PIMSA / uPIMulator",
        rotation=90,
        ha="center",
        va="center",
        fontsize=7.2,
    )
    explanation = [
        Line2D(
            [0],
            [0],
            marker="o",
            color="none",
            markerfacecolor="#4B5563",
            markeredgecolor="white",
            markeredgewidth=0.3,
            markersize=4.3,
            label="interval midpoint",
        ),
        Line2D(
            [0],
            [0],
            color="#4B5563",
            alpha=0.55,
            linewidth=0.8,
            label="lower--upper interval",
        ),
        Line2D(
            [0],
            [0],
            color="#202124",
            linestyle=(0, (3.0, 2.2)),
            linewidth=0.85,
            label="uPIMulator (normalized to 1)",
        ),
    ]
    figure.legend(
        handles=explanation,
        loc="upper center",
        bbox_to_anchor=(0.5, 0.995),
        ncol=3,
        frameon=False,
        handlelength=2.0,
        columnspacing=1.5,
    )

    output.parent.mkdir(parents=True, exist_ok=True)
    figure.savefig(output, bbox_inches="tight", facecolor="white")
    plt.close(figure)


def summarize(
    results: dict[str, dict[tuple[str, int], NormalizedInterval]],
) -> None:
    for experiment, _field, values, _title, _legend_title in EXPERIMENTS:
        intervals = [
            interval
            for benchmark_results in results.values()
            for value in values
            if (interval := benchmark_results.get((experiment, value))) is not None
        ]
        absolute_errors = [abs(interval.midpoint - 1.0) for interval in intervals]
        normalized_widths = [interval.upper - interval.lower for interval in intervals]
        print(
            f"{experiment}: n={len(intervals)}, "
            f"midpoint MAPE={100.0 * statistics.mean(absolute_errors):.1f}%, "
            f"median absolute error={100.0 * statistics.median(absolute_errors):.1f}%, "
            f"median normalized width={statistics.median(normalized_widths):.3f}"
        )


def main() -> int:
    args = parse_args()
    results = load_results(args.results_root)
    write_plot(args.output, results)
    print(f"Wrote {len(results)}-benchmark midpoint figure to {args.output}")
    summarize(results)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
