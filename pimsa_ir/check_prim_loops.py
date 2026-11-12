"""Check the loop counts of the PrIM programs against the compiled code.

For every setting in draw_figs/results/<bench>/summary.csv, every DPU
execution and every tasklet, compare each IR loop's iteration count (lower,
upper) with the bound the toolchain derived for the matching machine loop
header (LLVM scalar evolution and path analysis; BS's search loop uses the
source-derived cap of inst_count_analyzer's benchmark_settings.py). Loops are
matched by order and nesting; upmem_cost raises if the nests differ.

Classes: equal, ir_inside (within the toolchain bound and tighter), ir_wider,
other. The paper states that no check is ir_wider or other.

Usage: ../.venv/bin/python check_prim_loops.py
"""
from __future__ import annotations

import collections
import csv
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))

import prim  # noqa: E402
import upmem_cost as U  # noqa: E402

FIG = HERE.parent / "draw_figs/results"


def classify(ir, tool):
    (lo, hi), (slo, shi) = ir, tool
    if (lo, hi) == (slo, shi):
        return "equal"
    if slo <= lo <= hi <= shi:
        return "ir_inside"
    if lo <= slo <= shi <= hi:
        return "ir_wider"
    return "other"


def main():
    checks = collections.Counter()
    settings = collections.Counter()
    for name in prim.NAMES:
        mod = prim.load(name)
        b = mod.BENCH.lower()
        with open(FIG / b / "summary.csv") as f:
            rows = list(csv.DictReader(f))
        for r in rows:
            res = U.setting_bounds(mod, U.setting_id(r, mod.BENCH), r)
            kinds = {classify(ir, tool) for _, _, ir, tool in res["checks"]}
            for _, _, ir, tool in res["checks"]:
                checks[classify(ir, tool)] += 1
            worst = next(k for k in ("other", "ir_wider", "ir_inside", "equal") if k in kinds)
            settings[(mod.BENCH, worst)] += 1
    print("loop checks:", dict(checks))
    for (bench, k), n in sorted(settings.items()):
        print(f"{bench:9s} {k:10s} {n:3d} settings")
    bad = checks["ir_wider"] + checks["other"]
    print("OK" if bad == 0 else f"{bad} checks outside the toolchain bound")
    return 0 if bad == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
