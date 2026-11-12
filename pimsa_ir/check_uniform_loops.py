"""Check that every loop of the PrIM programs has alike iterations.

The analysis counts a loop as its first iteration times its trip count
(metrics.times). This script re-runs every PrIM setting at both extremes of
its data-dependent values and, for every loop entry, compares the counts of
the first iteration with those of iterations 1, n//2 and n-1, and of every
iteration when n <= 1000. Average loops (For(average=True)) have no
iterations to compare. Prints OK, or the loops that differ.

Usage: ../.venv/bin/python check_uniform_loops.py
"""
from __future__ import annotations

import collections
import csv
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))

import metrics as MX  # noqa: E402
import prim  # noqa: E402
import upmem_cost as U  # noqa: E402

FIG = HERE.parent / "draw_figs/results"


def main():
    bad = collections.Counter()
    checked = collections.Counter()
    times = MX.times

    def checking(n, run):
        if n == int(n) and n > 1:
            n = int(n)
            first = run(0)
            qs = range(1, n) if n <= 1000 else (1, n // 2, n - 1)
            checked[current] += 1
            if any(run(q) != first for q in qs):
                bad[current] += 1
        return times(n, run)

    MX.times = checking
    try:
        for name in prim.NAMES:
            mod = prim.load(name)
            current = mod.BENCH
            for r in csv.DictReader(open(FIG / mod.BENCH.lower() / "summary.csv")):
                U.setting_bounds(mod, U.setting_id(r, mod.BENCH), r)
    finally:
        MX.times = times
    print(f"loop entries checked: {sum(checked.values())} ({dict(checked)})")
    if bad:
        print("loops whose iterations differ:", dict(bad))
        sys.exit(1)
    print("OK")


if __name__ == "__main__":
    main()
