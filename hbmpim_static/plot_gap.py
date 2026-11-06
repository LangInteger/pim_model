#!/usr/bin/env python3
"""Figure: static estimate / PIMSimulator cycles per kernel (results/sweep.json).

The previous additive model is read from commit 5347031 of pim_model. Needs matplotlib.
    python plot_gap.py results/fig/static_vs_sim_gap.png   (run in hbmpim_static/)
"""
import json, subprocess, sys
import matplotlib; matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.ticker import FixedLocator, NullLocator

cur = json.load(open("results/sweep.json"))
old = json.loads(subprocess.check_output(
    ["git", "show", "5347031:hbmpim_static/results/sweep.json"]))
key = lambda r: (r["kernel"], r.get("M"), r.get("N"), r.get("L"), r["B"], r["C"])
oldm = {key(r): r for r in old if r["kernel"] != "GEMV" or True}
arch = json.load(open("arch/hbm2_pim.json"))["timing_cycles"]
col = max(arch["tCCD_S"]["value"], arch["BL"]["value"] // 2)

SER = [  # name, color (palette slots 1-4), marker
    ("Worst case (additive, unproven)", "#1baf7a", "^"),
    ("Previous additive model", "#eb6834", "s"),
    ("Controller-constraint model", "#2a78d6", "o"),
    (f"Trivial lower bound: {col}·(RD+WR)", "#eda100", "v"),
]
ink, ink2, grid = "#0b0b0b", "#52514e", "#e4e3df"
plt.rcParams.update({"font.size": 9, "axes.edgecolor": ink2, "axes.labelcolor": ink2,
                     "xtick.color": ink2, "ytick.color": ink2})
fig, axs = plt.subplots(1, 4, figsize=(12, 3.6), sharey=True)
for ax, k in zip(axs, ["GEMV", "ADD", "MUL", "RELU"]):
    rows = sorted([r for r in cur if r["kernel"] == k], key=lambda r: r["sim_cycles"])
    x = [r["sim_cycles"] for r in rows]
    ys = [
        [r["worst_cycles"] / r["sim_cycles"] for r in rows],
        [oldm[key(r)]["est_ratio"] for r in rows],
        [r["est_cycles"] / r["sim_cycles"] for r in rows],
        [col * (r["static_rd"] + r["static_wr"]) / r["sim_cycles"] for r in rows],
    ]
    ax.axhline(1, color=ink2, lw=1, ls=(0, (3, 3)), zorder=1)
    for (name, c, m), y in zip(SER, ys):
        ax.plot(x, y, m, color=c, ms=8, mec="white", mew=1.5, label=name, zorder=3)
    ax.set_xscale("log"); ax.set_yscale("log")
    ax.set_title(f"{k}  ({len(rows)} configs)", color=ink, fontsize=10, loc="left")
    ax.grid(True, which="major", color=grid, lw=0.8); ax.set_axisbelow(True)
    for s in ("top", "right"): ax.spines[s].set_visible(False)
    ax.set_xlabel("Simulated cycles (PIMSimulator)")
axs[0].set_ylabel("Static estimate / simulated cycles")
axs[0].yaxis.set_major_locator(FixedLocator([0.1, 0.2, 0.5, 1, 2, 5, 10, 20]))
axs[0].yaxis.set_minor_locator(NullLocator())
axs[0].set_yticklabels(["0.1", "0.2", "0.5", "1", "2", "5", "10", "20"])
axs[0].set_ylim(0.08, 25)
h, l = axs[0].get_legend_handles_labels()
fig.legend(h, l, loc="upper center", ncol=4, frameon=False, fontsize=9, labelcolor=ink, markerscale=1.2)
fig.tight_layout(rect=(0, 0, 1, 0.9))
fig.savefig(sys.argv[1], dpi=200, facecolor="#fcfcfb")
for k in ["GEMV", "ADD", "MUL", "RELU"]:
    rows = [r for r in cur if r["kernel"] == k]
    o = [oldm[key(r)]["est_ratio"] for r in rows]
    lb = [col * (r["static_rd"] + r["static_wr"]) / r["sim_cycles"] for r in rows]
    print(k, "old", round(min(o),3), round(max(o),3), "lb", round(min(lb),3), round(max(lb),3),
          "exact", sum(r["est_cycles"] == r["sim_cycles"] for r in rows), len(rows))
