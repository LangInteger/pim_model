#!/usr/bin/env python3
"""Plot VA instruction and composed-cycle validation across all settings."""

from __future__ import annotations

import argparse
import csv
from pathlib import Path
from typing import Any


EXPERIMENTS = (
    ("tasklet_sweep", "num_tasklets", "Number of tasklets", "Tasklet sweep"),
    ("dpu_sweep", "num_dpus", "Number of DPUs", "DPU sweep (16 tasklets)"),
)


def parse_args() -> argparse.Namespace:
    script_dir = Path(__file__).resolve().parent
    default_results = script_dir.parent / "results" / "va"
    parser = argparse.ArgumentParser(
        description=(
            "Create the full-width VA cross-setting validation figure used in "
            "Section 5.5."
        )
    )
    parser.add_argument(
        "--instruction-csv",
        type=Path,
        default=default_results / "va_instruction_count_comparison.csv",
    )
    parser.add_argument(
        "--cost-csv",
        type=Path,
        default=default_results / "va_cost_estimates.csv",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=default_results / "va_cross_setting_validation.pdf",
    )
    return parser.parse_args()


def read_rows(path: Path) -> list[dict[str, str]]:
    with path.open(newline="", encoding="utf-8") as input_file:
        rows = list(csv.DictReader(input_file))
    if not rows:
        raise ValueError(f"no rows found in {path}")
    return rows


def selected_rows(
    rows: list[dict[str, str]], experiment: str, x_field: str
) -> list[dict[str, str]]:
    selected = [row for row in rows if row["experiment"] == experiment]
    if not selected:
        raise ValueError(f"no {experiment} rows found")
    return sorted(selected, key=lambda row: int(row[x_field]))


def normalized_instruction_data(
    rows: list[dict[str, str]], experiment: str, x_field: str
) -> dict[str, Any]:
    selected = selected_rows(rows, experiment, x_field)
    measured = [float(row["simulator_instructions"]) for row in selected]
    lower = [
        float(row["static_instructions_lower"]) / observed
        for row, observed in zip(selected, measured)
    ]
    upper = [
        float(row["static_instructions_upper"]) / observed
        for row, observed in zip(selected, measured)
    ]
    return {
        "tick_labels": [int(row[x_field]) for row in selected],
        "lower": lower,
        "upper": upper,
        "covered": sum(low <= 1.0 <= high for low, high in zip(lower, upper)),
    }


def normalized_cycle_data(
    rows: list[dict[str, str]], experiment: str, x_field: str
) -> dict[str, Any]:
    selected = selected_rows(rows, experiment, x_field)
    measured = [float(row["actual_cycles"]) for row in selected]
    # These are the two structural overlap endpoints implemented by
    # estimate_cost.py: fully hidden memory and fully serialized memory.
    lower = [
        float(row["ideal_compute_hidden_memory_cycles"]) / observed
        for row, observed in zip(selected, measured)
    ]
    upper = [
        float(row["ideal_compute_no_hidden_memory_cycles"]) / observed
        for row, observed in zip(selected, measured)
    ]
    return {
        "tick_labels": [int(row[x_field]) for row in selected],
        "lower": lower,
        "upper": upper,
        "covered": sum(low <= 1.0 <= high for low, high in zip(lower, upper)),
    }


def padded_limits(values: list[float], minimum_span: float) -> tuple[float, float]:
    low = min(values + [1.0])
    high = max(values + [1.0])
    span = max(high - low, minimum_span)
    padding = 0.10 * span
    return low - padding, high + padding


def plot_interval(
    axis: Any,
    x_positions: list[int],
    lower: list[float],
    upper: list[float],
    color: str,
) -> None:
    """Draw compact lower--upper ranges without implying error bars."""
    cap_half_width = 0.10
    axis.vlines(
        x_positions,
        lower,
        upper,
        color=color,
        linewidth=2.0,
        alpha=0.90,
        zorder=2,
    )
    for x_value, low, high in zip(x_positions, lower, upper):
        axis.hlines(
            (low, high),
            x_value - cap_half_width,
            x_value + cap_half_width,
            color=color,
            linewidth=1.35,
            zorder=2,
        )
def write_plot(
    output: Path,
    instruction_rows: list[dict[str, str]],
    cost_rows: list[dict[str, str]],
) -> None:
    import matplotlib

    matplotlib.use("Agg")
    import matplotlib.pyplot as plt
    from matplotlib.lines import Line2D

    plt.rcParams.update(
        {
            "font.family": "serif",
            "font.size": 7.3,
            "axes.titlesize": 7.8,
            "axes.labelsize": 7.8,
            "xtick.labelsize": 7.0,
            "ytick.labelsize": 7.0,
            "legend.fontsize": 7.0,
            "pdf.fonttype": 42,
            "ps.fonttype": 42,
        }
    )

    figure, axes = plt.subplots(1, 4, figsize=(7.0, 1.75))
    figure.subplots_adjust(
        left=0.078,
        right=0.995,
        bottom=0.170,
        top=0.770,
        wspace=0.30,
    )
    instruction_color = "#0072B2"
    cycle_color = "#D55E00"
    measured_color = "#30343B"
    all_instruction_values: list[float] = []
    all_cycle_values: list[float] = []

    for sweep_index, (experiment, x_field, _x_label, title) in enumerate(EXPERIMENTS):
        instruction = normalized_instruction_data(
            instruction_rows, experiment, x_field
        )
        cycles = normalized_cycle_data(cost_rows, experiment, x_field)
        x_positions = list(range(len(instruction["tick_labels"])))
        if instruction["tick_labels"] != cycles["tick_labels"]:
            raise ValueError(f"instruction/cycle settings differ for {experiment}")

        instruction_axis = axes[sweep_index]
        plot_interval(
            instruction_axis,
            x_positions,
            instruction["lower"],
            instruction["upper"],
            instruction_color,
        )
        instruction_axis.set_title(
            f"({'ab'[sweep_index]}) "
            + ("Tasklets" if experiment == "tasklet_sweep" else "DPUs"),
            loc="left",
            pad=3,
            fontweight="bold",
        )
        all_instruction_values.extend(instruction["lower"])
        all_instruction_values.extend(instruction["upper"])

        cycle_axis = axes[sweep_index + 2]
        plot_interval(
            cycle_axis,
            x_positions,
            cycles["lower"],
            cycles["upper"],
            cycle_color,
        )
        cycle_axis.set_title(
            f"({'cd'[sweep_index]}) "
            + ("Tasklets" if experiment == "tasklet_sweep" else "DPUs"),
            loc="left",
            pad=3,
            fontweight="bold",
        )
        all_cycle_values.extend(cycles["lower"])
        all_cycle_values.extend(cycles["upper"])

        for axis in (instruction_axis, cycle_axis):
            axis.axhline(
                1.0,
                color=measured_color,
                linewidth=1.0,
                linestyle=(0, (2, 1.6)),
                zorder=4,
            )
            axis.set_xticks(x_positions, instruction["tick_labels"])
            axis.grid(axis="y", linestyle="-", linewidth=0.45, alpha=0.18)
            axis.tick_params(axis="both", length=2.5, pad=2)
            axis.spines[["top", "right"]].set_visible(False)

    instruction_limits = padded_limits(all_instruction_values, 0.045)
    cycle_limits = padded_limits(all_cycle_values, 0.80)
    for axis in axes[:2]:
        axis.set_ylim(*instruction_limits)
        axis.set_yticks((0.98, 1.00, 1.02))
    for axis in axes[2:]:
        axis.set_ylim(*cycle_limits)
        axis.set_yticks((0.8, 1.0, 1.2, 1.4, 1.6))
    axes[1].tick_params(labelleft=False)
    axes[3].tick_params(labelleft=False)
    figure.text(
        0.018,
        0.470,
        "PIMSA / uPIMulator",
        ha="center",
        va="center",
        rotation="vertical",
        fontsize=7.8,
    )

    legend_handles = [
        Line2D(
            [0],
            [0],
            color=instruction_color,
            linewidth=2.0,
            label="PIMSA instruction-count interval",
        ),
        Line2D(
            [0],
            [0],
            color=cycle_color,
            linewidth=2.0,
            label="PIMSA composed-cycle envelope",
        ),
        Line2D(
            [0],
            [0],
            color=measured_color,
            linestyle=(0, (2, 1.6)),
            linewidth=1.0,
            label="uPIMulator measurement (normalized to 1)",
        ),
    ]
    figure.legend(
        handles=legend_handles,
        loc="upper center",
        bbox_to_anchor=(0.53, 0.985),
        ncol=3,
        frameon=False,
        columnspacing=1.25,
        handlelength=1.9,
        borderaxespad=0,
    )
    output.parent.mkdir(parents=True, exist_ok=True)
    figure.savefig(output)
    plt.close(figure)


def main() -> int:
    args = parse_args()
    write_plot(
        args.output,
        read_rows(args.instruction_csv),
        read_rows(args.cost_csv),
    )
    print(f"Wrote VA cross-setting validation figure to {args.output}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
