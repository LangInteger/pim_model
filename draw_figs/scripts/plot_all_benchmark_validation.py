#!/usr/bin/env python3
"""Plot compact instruction and cycle validation matrices for all benchmarks."""

from __future__ import annotations

import argparse
import csv
import math
import sys
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
    ("tasklet_sweep", 1, "T1"),
    ("tasklet_sweep", 2, "T2"),
    ("tasklet_sweep", 4, "T4"),
    ("tasklet_sweep", 8, "T8"),
    ("tasklet_sweep", 16, "T16"),
    ("dpu_sweep", 1, "P1"),
    ("dpu_sweep", 4, "P4"),
    ("dpu_sweep", 16, "P16"),
    ("dpu_sweep", 64, "P64"),
)


def parse_args() -> argparse.Namespace:
    script_dir = Path(__file__).resolve().parent
    results_root = script_dir.parent / "results"
    parser = argparse.ArgumentParser(
        description=(
            "Create a compact all-benchmark validation matrix. Each cell's "
            "left and right halves encode the lower and upper normalized bounds."
        )
    )
    parser.add_argument("--results-root", type=Path, default=results_root)
    parser.add_argument(
        "--output",
        type=Path,
        default=results_root / "all_benchmark_validation.pdf",
    )
    return parser.parse_args()


def read_csv(path: Path) -> list[dict[str, str]]:
    with path.open(newline="", encoding="utf-8") as input_file:
        rows = list(csv.DictReader(input_file))
    if not rows:
        raise ValueError(f"no rows found in {path}")
    return rows


def setting_id(row: dict[str, str]) -> tuple[str, int]:
    experiment = row["experiment"]
    if experiment == "tasklet_sweep":
        return experiment, int(row["num_tasklets"])
    if experiment == "dpu_sweep":
        return experiment, int(row["num_dpus"])
    raise ValueError(f"unsupported experiment: {experiment}")


def normalized_interval(
    row: dict[str, str], metric: str
) -> tuple[float, float]:
    if metric == "instruction":
        observed = float(row["simulator_instructions"])
        lower = float(row["static_instructions_lower"])
        upper = float(row["static_instructions_upper"])
    elif metric == "cycle":
        observed = float(row["actual_cycles"])
        lower = float(row["composed_cycles_lower"])
        upper = float(row["composed_cycles_upper"])
    else:
        raise ValueError(f"unsupported metric: {metric}")
    if observed <= 0 or lower <= 0 or upper <= 0:
        raise ValueError(f"non-positive {metric} value in row: {row}")
    return lower / observed, upper / observed


def load_all_results(
    results_root: Path,
) -> tuple[
    list[str],
    dict[str, dict[str, dict[tuple[str, int], tuple[float, float]]]],
    dict[str, set[str]],
]:
    benchmarks: list[str] = []
    data: dict[
        str, dict[str, dict[tuple[str, int], tuple[float, float]]]
    ] = {"instruction": {}, "cycle": {}}
    unresolved: dict[str, set[str]] = {}

    for benchmark in BENCHMARK_ORDER:
        benchmark_dir = results_root / benchmark
        instruction_path = (
            benchmark_dir / f"{benchmark}_instruction_count_comparison.csv"
        )
        cycle_path = benchmark_dir / f"{benchmark}_cost_estimates.csv"
        if not instruction_path.exists() or not cycle_path.exists():
            continue

        instruction_rows = read_csv(instruction_path)
        cycle_rows = read_csv(cycle_path)
        data["instruction"][benchmark] = {
            setting_id(row): normalized_interval(row, "instruction")
            for row in instruction_rows
        }
        data["cycle"][benchmark] = {
            setting_id(row): normalized_interval(row, "cycle")
            for row in cycle_rows
        }
        unresolved_names: set[str] = set()
        for row in instruction_rows:
            unresolved_names.update(
                name
                for name in row.get("unexpanded_callees", "").split(";")
                if name
            )
        if unresolved_names:
            unresolved[benchmark] = unresolved_names
        benchmarks.append(benchmark)

    if not benchmarks:
        raise ValueError(f"no benchmark validation CSVs found below {results_root}")
    return benchmarks, data, unresolved


def log_ratio(value: float) -> float:
    return math.log2(value)


def draw_matrix(
    axis: Any,
    matrix: dict[str, dict[tuple[str, int], tuple[float, float]]],
    benchmarks: list[str],
    cmap: Any,
    norm: Any,
    title: str,
    show_ylabels: bool,
) -> tuple[int, int]:
    from matplotlib.patches import Rectangle

    covered = 0
    present = 0
    for row_index, benchmark in enumerate(benchmarks):
        benchmark_values = matrix[benchmark]
        for column_index, (experiment, value, _label) in enumerate(SETTINGS):
            interval = benchmark_values.get((experiment, value))
            if interval is None:
                axis.add_patch(
                    Rectangle(
                        (column_index - 0.5, row_index - 0.5),
                        1.0,
                        1.0,
                        facecolor="#E5E7EB",
                        edgecolor="#FFFFFF",
                        linewidth=0.7,
                        hatch="////",
                    )
                )
                continue

            lower, upper = interval
            present += 1
            is_covered = lower <= 1.0 <= upper
            covered += int(is_covered)
            for offset, endpoint in ((-0.5, lower), (0.0, upper)):
                axis.add_patch(
                    Rectangle(
                        (column_index + offset, row_index - 0.5),
                        0.5,
                        1.0,
                        facecolor=cmap(norm(log_ratio(endpoint))),
                        edgecolor="none",
                    )
                )
            axis.add_patch(
                Rectangle(
                    (column_index - 0.5, row_index - 0.5),
                    1.0,
                    1.0,
                    facecolor="none",
                    edgecolor="#FFFFFF",
                    linewidth=0.7,
                )
            )
            if not is_covered:
                axis.plot(
                    column_index,
                    row_index,
                    marker="x",
                    markersize=3.1,
                    markeredgewidth=0.75,
                    color="#202124",
                    zorder=3,
                )

    axis.set_xlim(-0.5, len(SETTINGS) - 0.5)
    axis.set_ylim(len(benchmarks) - 0.5, -0.5)
    axis.set_xticks(range(len(SETTINGS)), [setting[2] for setting in SETTINGS])
    axis.set_yticks(
        range(len(benchmarks)),
        [benchmark.upper() for benchmark in benchmarks] if show_ylabels else [],
    )
    axis.tick_params(axis="both", length=0, pad=2)
    axis.axvline(4.5, color="#3F3F46", linewidth=0.7)
    axis.set_title(title, loc="left", pad=4, fontweight="bold")
    for spine in axis.spines.values():
        spine.set_color("#3F3F46")
        spine.set_linewidth(0.7)
    return covered, present


def write_plot(
    output: Path,
    benchmarks: list[str],
    data: dict[str, dict[str, dict[tuple[str, int], tuple[float, float]]]],
) -> tuple[tuple[int, int], tuple[int, int]]:
    import matplotlib

    matplotlib.use("Agg")
    import matplotlib.pyplot as plt
    from matplotlib.colors import TwoSlopeNorm
    from matplotlib.cm import ScalarMappable
    from matplotlib.patches import Rectangle

    plt.rcParams.update(
        {
            "font.family": "serif",
            "font.size": 6.6,
            "axes.titlesize": 7.8,
            "xtick.labelsize": 6.2,
            "ytick.labelsize": 6.4,
            "pdf.fonttype": 42,
            "ps.fonttype": 42,
        }
    )

    figure, axes = plt.subplots(1, 2, figsize=(7.0, 2.72))
    figure.subplots_adjust(
        left=0.095,
        right=0.995,
        bottom=0.305,
        top=0.905,
        wspace=0.075,
    )
    cmap = plt.get_cmap("RdBu_r")
    norm = TwoSlopeNorm(vmin=-4.25, vcenter=0.0, vmax=3.0)

    instruction_coverage = draw_matrix(
        axes[0],
        data["instruction"],
        benchmarks,
        cmap,
        norm,
        "(a) Instruction-count interval",
        show_ylabels=True,
    )
    cycle_coverage = draw_matrix(
        axes[1],
        data["cycle"],
        benchmarks,
        cmap,
        norm,
        "(b) Composed-cycle interval",
        show_ylabels=False,
    )

    color_axis = figure.add_axes((0.285, 0.155, 0.43, 0.028))
    colorbar = figure.colorbar(
        ScalarMappable(norm=norm, cmap=cmap),
        cax=color_axis,
        orientation="horizontal",
    )
    colorbar.set_ticks((-4, -3, -2, -1, 0, 1, 2, 3))
    colorbar.set_ticklabels(
        ("1/16", "1/8", "1/4", "1/2", "1", "2", "4", "8")
    )
    colorbar.ax.tick_params(length=2, pad=1, labelsize=6.0)
    colorbar.outline.set_linewidth(0.6)
    color_axis.set_title(
        "PIMSA bound / uPIMulator",
        fontsize=6.2,
        pad=2.0,
    )

    legend_axis = figure.add_axes((0.16, 0.012, 0.68, 0.075))
    legend_axis.set_xlim(0, 1)
    legend_axis.set_ylim(0, 1)
    legend_axis.axis("off")

    cell_y = 0.27
    cell_width = 0.072
    cell_height = 0.48

    def draw_legend_cell(
        x: float,
        label: str,
        endpoint_values: tuple[float, float] | None,
        *,
        letters: bool = False,
        outside: bool = False,
        missing: bool = False,
    ) -> None:
        if missing:
            legend_axis.add_patch(
                Rectangle(
                    (x, cell_y),
                    cell_width,
                    cell_height,
                    facecolor="#E5E7EB",
                    edgecolor="#FFFFFF",
                    linewidth=0.7,
                    hatch="////",
                )
            )
        elif endpoint_values is not None:
            for half, value in enumerate(endpoint_values):
                legend_axis.add_patch(
                    Rectangle(
                        (x + half * cell_width / 2, cell_y),
                        cell_width / 2,
                        cell_height,
                        facecolor=cmap(norm(value)),
                        edgecolor="none",
                    )
                )
        legend_axis.add_patch(
            Rectangle(
                (x, cell_y),
                cell_width,
                cell_height,
                facecolor="none",
                edgecolor="#6b7280",
                linewidth=0.6,
            )
        )
        if letters:
            for center, letter in ((0.25, "L"), (0.75, "U")):
                legend_axis.text(
                    x + center * cell_width,
                    cell_y + cell_height / 2,
                    letter,
                    ha="center",
                    va="center",
                    fontsize=5.4,
                )
        if outside:
            legend_axis.plot(
                x + cell_width / 2,
                cell_y + cell_height / 2,
                marker="x",
                markersize=4.0,
                markeredgewidth=0.8,
                color="#202124",
            )
        legend_axis.text(
            x + cell_width + 0.014,
            0.5,
            label,
            ha="left",
            va="center",
            fontsize=6.2,
        )

    # The split example makes the lower/upper ordering visible directly.
    draw_legend_cell(0.0, "cell: lower | upper", (-1.0, 1.0), letters=True)
    draw_legend_cell(
        0.38,
        "measurement outside interval",
        (-1.5, -0.5),
        outside=True,
    )
    draw_legend_cell(0.79, "missing data", None, missing=True)
    output.parent.mkdir(parents=True, exist_ok=True)
    figure.savefig(output)
    plt.close(figure)
    return instruction_coverage, cycle_coverage


def main() -> int:
    args = parse_args()
    benchmarks, data, unresolved = load_all_results(args.results_root)
    instruction_coverage, cycle_coverage = write_plot(
        args.output, benchmarks, data
    )
    print(
        f"Wrote {len(benchmarks)}-benchmark validation figure to {args.output}"
    )
    print(
        "Coverage: instruction "
        f"{instruction_coverage[0]}/{instruction_coverage[1]}, cycles "
        f"{cycle_coverage[0]}/{cycle_coverage[1]}"
    )
    if unresolved:
        details = ", ".join(
            f"{benchmark.upper()} ({';'.join(sorted(names))})"
            for benchmark, names in unresolved.items()
        )
        print(
            "WARNING: regenerate instruction results before publication; "
            f"unexpanded callees remain in {details}",
            file=sys.stderr,
        )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
