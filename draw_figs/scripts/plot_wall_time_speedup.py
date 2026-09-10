#!/usr/bin/env python3
"""Plot PIMSA wall-clock speedup over uPIMulator for all benchmarks."""

from __future__ import annotations

import argparse
import csv
import math
import statistics
from pathlib import Path
from typing import Any


BENCHMARK_ORDER = (
    "VA",
    "GEMV",
    "MLP",
    "HST-S",
    "HST-L",
    "BS",
    "TS",
    "SEL",
    "UNI",
    "RED",
    "SCAN-SSA",
    "SCAN-RSS",
    "TRNS",
)

EXPERIMENTS = (
    (
        "tasklet_sweep",
        (1, 2, 4, 8, 16),
        "(a) Tasklet sweep (1 DPU)",
        "Tasklets",
    ),
    (
        "dpu_sweep",
        (1, 4, 16, 64),
        "(b) DPU sweep (16 tasklets)",
        "DPUs",
    ),
)

COLORS = ("#0072B2", "#56B4E9", "#009E73", "#E69F00", "#D55E00")
MARKERS = ("o", "s", "D", "^", "v")


def parse_args() -> argparse.Namespace:
    script_dir = Path(__file__).resolve().parent
    results_root = script_dir.parent / "results"
    parser = argparse.ArgumentParser(
        description=(
            "Plot uPIMulator/PIMSA wall-clock ratios for every benchmark and "
            "configuration in the tasklet and DPU sweeps."
        )
    )
    parser.add_argument(
        "--input",
        type=Path,
        default=script_dir.parent / ".work" / "wall_time_comparison.csv",
        help="CSV produced by summarize_wall_time_comparison.py",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=results_root / "all_benchmark_wall_time_speedup.pdf",
        help="PDF output path; a PNG with the same stem is also written",
    )
    return parser.parse_args()


def load_ratios(path: Path) -> dict[str, dict[tuple[str, int], float]]:
    results: dict[str, dict[tuple[str, int], float]] = {
        benchmark: {} for benchmark in BENCHMARK_ORDER
    }
    with path.open(newline="", encoding="utf-8") as input_file:
        rows = list(csv.DictReader(input_file))
    if not rows:
        raise ValueError(f"no timing comparisons found in {path}")

    for row in rows:
        benchmark = row["benchmark"].upper()
        if benchmark not in results:
            continue
        experiment = row["experiment"]
        if experiment == "tasklet_sweep":
            setting = int(row["num_tasklets"])
        elif experiment == "dpu_sweep":
            setting = int(row["num_dpus"])
        else:
            raise ValueError(f"unsupported experiment {experiment!r} in {path}")
        ratio = float(row["upimulator_over_pimsa"])
        if ratio <= 0:
            raise ValueError(f"non-positive wall-clock ratio in {path}: {row}")
        key = (experiment, setting)
        if key in results[benchmark]:
            raise ValueError(f"duplicate {benchmark} configuration {key} in {path}")
        results[benchmark][key] = ratio

    return {benchmark: values for benchmark, values in results.items() if values}


def geometric_mean(values: list[float]) -> float:
    return math.exp(statistics.mean(math.log(value) for value in values))


def draw_experiment(
    axis: Any,
    results: dict[str, dict[tuple[str, int], float]],
    experiment: str,
    settings: tuple[int, ...],
    title: str,
    legend_title: str,
) -> list[float]:
    import numpy as np

    centers = np.arange(len(BENCHMARK_ORDER), dtype=float)
    offsets = np.linspace(-0.22, 0.22, len(settings))
    all_ratios: list[float] = []

    for setting_index, (setting, offset) in enumerate(zip(settings, offsets)):
        x_values: list[float] = []
        ratios: list[float] = []
        for benchmark_index, benchmark in enumerate(BENCHMARK_ORDER):
            ratio = results.get(benchmark, {}).get((experiment, setting))
            if ratio is None:
                continue
            x_values.append(benchmark_index + offset)
            ratios.append(ratio)
        all_ratios.extend(ratios)
        axis.scatter(
            x_values,
            ratios,
            s=13.0,
            marker=MARKERS[setting_index],
            facecolor=COLORS[setting_index],
            edgecolor="white",
            linewidth=0.3,
            label=str(setting),
            zorder=3,
        )

    benchmark_means: list[tuple[int, float, float, float]] = []
    for benchmark_index, benchmark in enumerate(BENCHMARK_ORDER):
        values = [
            ratio
            for setting in settings
            if (ratio := results.get(benchmark, {}).get((experiment, setting)))
            is not None
        ]
        if values:
            benchmark_means.append(
                (benchmark_index, min(values), geometric_mean(values), max(values))
            )

    axis.vlines(
        [value[0] for value in benchmark_means],
        [value[1] for value in benchmark_means],
        [value[3] for value in benchmark_means],
        color="#6B7280",
        alpha=0.38,
        linewidth=0.65,
        zorder=1,
    )
    axis.scatter(
        [value[0] for value in benchmark_means],
        [value[2] for value in benchmark_means],
        s=17.0,
        marker="D",
        facecolor="#202124",
        edgecolor="white",
        linewidth=0.35,
        zorder=4,
    )

    axis.axhspan(0.5, 1.0, color="#E5E7EB", alpha=0.42, zorder=0)
    axis.axhline(
        1.0,
        color="#202124",
        linestyle=(0, (3.0, 2.2)),
        linewidth=0.85,
        zorder=2,
    )
    axis.set_yscale("log", base=2)
    axis.set_ylim(0.5, 512)
    y_ticks = (0.5, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512)
    axis.set_yticks(y_ticks, [f"{value:g}$\\times$" for value in y_ticks])
    axis.set_xlim(-0.55, len(BENCHMARK_ORDER) - 0.45)
    axis.set_xticks(centers, BENCHMARK_ORDER)
    axis.tick_params(axis="x", rotation=48, length=0, pad=1.5)
    axis.tick_params(axis="y", length=2.2, width=0.6, pad=1.8)
    axis.grid(axis="y", which="major", color="#D1D5DB", linewidth=0.45)
    axis.set_title(title, loc="left", pad=17, fontweight="bold")
    axis.legend(
        title=legend_title,
        loc="lower right",
        bbox_to_anchor=(1.0, 1.005),
        ncol=len(settings),
        frameon=False,
        borderaxespad=0,
        handletextpad=0.25,
        columnspacing=0.75,
        markerscale=0.95,
    )
    for spine in axis.spines.values():
        spine.set_color("#4B5563")
        spine.set_linewidth(0.6)

    panel_geomean = geometric_mean(all_ratios)
    axis.text(
        0.02,
        0.965,
        f"sweep geomean: {panel_geomean:.1f}$\\times$",
        transform=axis.transAxes,
        ha="left",
        va="top",
        fontsize=6.2,
        color="#374151",
    )
    return all_ratios


def write_plot(
    output: Path,
    results: dict[str, dict[tuple[str, int], float]],
) -> tuple[Path, list[float]]:
    import matplotlib

    matplotlib.use("Agg")
    import matplotlib.pyplot as plt

    plt.rcParams.update(
        {
            "font.family": "serif",
            "font.size": 6.7,
            "axes.titlesize": 7.7,
            "axes.labelsize": 7.2,
            "xtick.labelsize": 5.9,
            "ytick.labelsize": 6.1,
            "legend.fontsize": 6.0,
            "legend.title_fontsize": 6.0,
            "pdf.fonttype": 42,
            "ps.fonttype": 42,
        }
    )

    figure, axes = plt.subplots(
        2,
        1,
        figsize=(3.35, 4.50),
        sharex=True,
        sharey=True,
    )
    figure.subplots_adjust(
        left=0.155,
        right=0.985,
        bottom=0.135,
        top=0.905,
        hspace=0.30,
    )
    all_ratios: list[float] = []
    for axis, (experiment, settings, title, legend_title) in zip(axes, EXPERIMENTS):
        all_ratios.extend(
            draw_experiment(
                axis,
                results,
                experiment,
                settings,
                title,
                legend_title,
            )
        )

    axes[0].tick_params(axis="x", bottom=False, labelbottom=False)
    figure.text(
        0.018,
        0.52,
        "PIMSA analysis speedup over uPIMulator",
        rotation=90,
        ha="center",
        va="center",
        fontsize=7.0,
    )

    output.parent.mkdir(parents=True, exist_ok=True)
    png_output = output.with_suffix(".png")
    figure.savefig(output, bbox_inches="tight", facecolor="white")
    figure.savefig(png_output, dpi=300, bbox_inches="tight", facecolor="white")
    plt.close(figure)
    return png_output, all_ratios


def main() -> int:
    args = parse_args()
    results = load_ratios(args.input)
    png_output, ratios = write_plot(args.output, results)
    faster = sum(ratio > 1.0 for ratio in ratios)
    print(
        f"Wrote {len(ratios)} speedup measurements for {len(results)} benchmarks "
        f"to {args.output} and {png_output}"
    )
    print(
        f"PIMSA faster in {faster}/{len(ratios)} configurations; "
        f"geomean={geometric_mean(ratios):.2f}x, "
        f"median={statistics.median(ratios):.2f}x"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
