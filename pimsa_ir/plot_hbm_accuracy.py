#!/usr/bin/env python3
"""HBM-PIM accuracy figure, in the style of the UPMEM midpoint figure
(draw_figs/scripts/plot_all_benchmark_cycle_midpoint.py).

Each marker is one of the 42 sweep configurations: its estimated cycles divided
by PIMSimulator's, under (a) the DRAM-timing-based closed form and (b) the
bandwidth-based cost model (bytes / bandwidth plus one row miss per transfer).
Kernels are grouped on the x axis. GEMV is split by batch size and by matrix
shape (square or rectangular), so that every group holds three problem sizes,
like the element-wise kernels. Within a group the configurations are ordered by
problem size, and the color gives the number of pseudo-channels.

Input:  results/hbm/bandwidth_vs_dram_timing.csv (hbm_bandwidth_model.py)
Output: results/hbm/hbm_accuracy.pdf
"""
from __future__ import annotations

import argparse
import csv
import statistics
from pathlib import Path

HERE = Path(__file__).resolve().parent
# x-axis groups: (label, kernel, batch or None, shape or None); GEMV shape is
# "sq" (M == N) or "rect" (M != N)
GROUPS = (("GEMV-B1 sq.", "GEMV", 1, "sq"), ("GEMV-B1 rect.", "GEMV", 1, "rect"),
          ("GEMV-B4 sq.", "GEMV", 4, "sq"), ("GEMV-B4 rect.", "GEMV", 4, "rect"),
          ("ADD", "ADD", None, None), ("MUL", "MUL", None, None), ("RELU", "RELU", None, None))


def shape(r):
    return "sq" if r["M"] == r["N"] else "rect"
CHANNELS = (16, 64)
COLORS = ("#0072B2", "#E69F00")          # same palette as the UPMEM figure
MARKERS = ("o", "^")
# (column, title, zoom): the DRAM-timing errors are below 0.5%, so panel (a)
# uses a linear axis around 1; panel (b) keeps the log2 axis of the UPMEM figure.
PANELS = (("closed_ratio", "(a) DRAM-timing-based", True),
          ("bw_row_ratio", "(b) Bandwidth-based", False))


def load(path: Path):
    rows = list(csv.DictReader(path.open(newline="")))
    if len(rows) != 42:
        raise ValueError(f"expected 42 configurations in {path}, found {len(rows)}")
    return rows


def size_key(r):
    if r["kernel"] == "GEMV":
        return (int(r["M"]) * int(r["N"]), int(r["B"]))
    return (int(r["L"]), int(r["B"]))


def draw(axis, rows, column, title, legend, zoom):
    import numpy as np

    for ci, (chans, color, marker) in enumerate(zip(CHANNELS, COLORS, MARKERS)):
        xs, ys = [], []
        for ki, (_label, kernel, batch, shp) in enumerate(GROUPS):
            group = sorted((r for r in rows if r["kernel"] == kernel and int(r["C"]) == chans
                            and (batch is None or int(r["B"]) == batch)
                            and (shp is None or shape(r) == shp)), key=size_key)
            offsets = np.linspace(-0.32, 0.32, 2 * len(group)) if group else []
            for gi, r in enumerate(group):
                # interleave the two channel counts of the same problem size
                xs.append(ki + offsets[2 * gi + ci])
                ys.append(float(r[column]))
        axis.scatter(xs, ys, s=11.5, marker=marker, facecolor=color, edgecolor="white",
                     linewidth=0.28, label=str(chans), zorder=3)

    axis.axhline(1.0, color="#202124", linestyle=(0, (3.0, 2.2)), linewidth=0.85, zorder=1)
    if zoom:
        axis.set_ylim(0.994, 1.006)
        axis.set_yticks((0.995, 1.0, 1.005), ("0.995", "1", "1.005"))
    else:
        axis.set_yscale("log", base=2)
        axis.set_ylim(0.5, 2.0)
        axis.set_yticks((0.5, 0.71, 1.0, 1.41, 2.0), ("1/2", "", "1", "", "2"))
    axis.set_xlim(-0.55, len(GROUPS) - 0.45)
    axis.set_xticks(range(len(GROUPS)), [g[0] for g in GROUPS])
    axis.tick_params(axis="x", rotation=48, length=0, pad=1.5)
    axis.tick_params(axis="y", length=2.2, width=0.6, pad=1.8)
    axis.grid(axis="y", which="major", color="#D1D5DB", linewidth=0.45)
    axis.set_title(title, loc="left", pad=17 if legend else 4, fontweight="bold")
    if legend:
        axis.legend(title="Pseudo-channels", loc="lower right", bbox_to_anchor=(1.0, 1.005),
                    ncol=len(CHANNELS), frameon=False, borderaxespad=0, handletextpad=0.25,
                    columnspacing=0.75, markerscale=0.92)
    for spine in axis.spines.values():
        spine.set_color("#4B5563")
        spine.set_linewidth(0.6)


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--input", type=Path, default=HERE / "results/hbm/bandwidth_vs_dram_timing.csv")
    ap.add_argument("--output", type=Path, default=HERE / "results/hbm/hbm_accuracy.pdf")
    a = ap.parse_args()
    rows = load(a.input)

    import matplotlib
    matplotlib.use("Agg")
    import matplotlib.pyplot as plt

    plt.rcParams.update({"font.family": "serif", "font.size": 6.7, "axes.titlesize": 7.7,
                         "axes.labelsize": 7.2, "xtick.labelsize": 5.9, "ytick.labelsize": 6.2,
                         "legend.fontsize": 6.0, "legend.title_fontsize": 6.0,
                         "pdf.fonttype": 42, "ps.fonttype": 42})
    figure, axes = plt.subplots(2, 1, figsize=(3.35, 3.45), sharex=True)
    figure.subplots_adjust(left=0.155, right=0.985, bottom=0.13, top=0.88, hspace=0.42)
    for i, (axis, (column, title, zoom)) in enumerate(zip(axes, PANELS)):
        draw(axis, rows, column, title, legend=(i == 0), zoom=zoom)
    axes[0].tick_params(axis="x", bottom=False, labelbottom=False)
    figure.text(0.018, 0.49, "Estimated cycles / PIMSimulator", rotation=90,
                ha="center", va="center", fontsize=7.0)
    a.output.parent.mkdir(parents=True, exist_ok=True)
    figure.savefig(a.output, bbox_inches="tight", facecolor="white")
    plt.close(figure)

    for column, title, _zoom in PANELS:
        errs = [abs(float(r[column]) - 1) for r in rows]
        print(f"{title}: mean error {100 * statistics.mean(errs):.2f}%, max {100 * max(errs):.2f}%")
    print(f"wrote {a.output}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
