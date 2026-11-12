"""Summary numbers of the UPMEM evaluation from results/prim (run_prim_results.py).

Prints coverage, midpoint accuracy per sweep, and interval widths, and
writes them to results/prim/summary.json. No timing.

Usage: ../.venv/bin/python summarize_prim_results.py
"""
from __future__ import annotations

import csv
import json
import statistics
from pathlib import Path

HERE = Path(__file__).resolve().parent
OUT = HERE / "results/prim"


def rows(path):
    with open(path) as f:
        return list(csv.DictReader(f))


def main():
    est = [r for p in sorted(OUT.glob("*/*_cost_estimates.csv")) for r in rows(p)]
    n = len(est)
    cyc_cov = sum(r["actual_within_composed_bounds"] == "True" for r in est)
    ins = [r for r in est if r["measured_instructions_per_dpu"]]
    ins_cov = sum(float(r["static_instructions_lower_per_dpu"]) <= float(r["measured_instructions_per_dpu"])
                  <= float(r["static_instructions_upper_per_dpu"]) for r in ins)
    uncovered = sorted({r["benchmark"] for r in est if r["actual_within_composed_bounds"] != "True"})
    mape, width = {}, {}
    for sweep in ("tasklet_sweep", "dpu_sweep"):
        sel = [r for r in est if r["experiment"] == sweep]
        ape = [abs((float(r["composed_cycles_lower"]) + float(r["composed_cycles_upper"])) / 2
                   - float(r["actual_cycles"])) / float(r["actual_cycles"]) for r in sel]
        mape[sweep] = 100 * statistics.mean(ape)
        width[sweep] = statistics.median((float(r["composed_cycles_upper"]) - float(r["composed_cycles_lower"]))
                                         / float(r["actual_cycles"]) for r in sel)
    out = {
        "settings": n, "cycles_covered": cyc_cov, "cycles_coverage_pct": 100 * cyc_cov / n,
        "instructions_with_measurement": len(ins), "instructions_covered": ins_cov,
        "instructions_coverage_pct": 100 * ins_cov / len(ins), "uncovered_benchmarks": uncovered,
        "midpoint_mape_pct": mape, "median_normalized_width": width,
    }
    (OUT / "summary.json").write_text(json.dumps(out, indent=2) + "\n")
    print(json.dumps(out, indent=2))


if __name__ == "__main__":
    main()
