"""Regenerate the UPMEM (PrIM) results of the paper from PIMSA-IR.

For every setting in draw_figs/results/<bench>/summary.csv, this runs the IR
analysis (upmem_cost.setting_bounds) and writes, under results/prim/:

  <bench>/<bench>_cost_estimates.csv  intervals per setting, in the column names
                                      that draw_figs' plotting scripts read

It records results only, no timing: the analysis-time numbers of the paper come
from draw_figs (the toolchain's analysis_wall_seconds).

Usage: ../.venv/bin/python run_prim_results.py
"""
from __future__ import annotations

import csv
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))

import prim  # noqa: E402
import upmem_cost as U  # noqa: E402

ROOT = HERE.parent
FIG = ROOT / "draw_figs/results"
OUT = HERE / "results/prim"

FIELDS = ("benchmark", "experiment", "num_dpus", "num_tasklets", "data_prep_params", "setting_id",
          "memory_read_bytes_lower_per_dpu", "memory_read_bytes_upper_per_dpu",
          "memory_write_bytes_lower_per_dpu", "memory_write_bytes_upper_per_dpu",
          "observed_read_bytes", "observed_write_bytes",
          "static_instructions_lower_per_dpu", "static_instructions_upper_per_dpu",
          "toolchain_instructions_lower_per_dpu", "toolchain_instructions_upper_per_dpu",
          "measured_instructions_per_dpu",
          "memory_model_lower_cycles", "memory_model_upper_cycles",
          "composed_cycles_lower", "composed_cycles_upper", "actual_cycles",
          "actual_within_composed_bounds")


def rows(path):
    with open(path) as f:
        return list(csv.DictReader(f))


def run():
    all_rows = []
    for name in prim.NAMES:
        mod = prim.load(name)
        b = mod.BENCH.lower()
        old = {(r["experiment"], r["num_dpus"], r["num_tasklets"]): r
               for r in rows(FIG / b / f"{b}_cost_estimates.csv")}
        out = []
        for r in rows(FIG / b / "summary.csv"):
            sid = U.setting_id(r, mod.BENCH)
            res = U.setting_bounds(mod, sid, r)
            d, ins, st, cyc, mem = (res["dma_total"], res["instructions"], res["stored_instructions"],
                                   res["cycles"], res["memory_cycles"])
            actual = float(r["cycles_max"])
            e = old.get((r["experiment"], r["num_dpus"], r["num_tasklets"]))
            meas = e.get("measured_instructions_per_dpu", "") if e else ""
            n = int(r["num_dpus"])
            rec = {"benchmark": mod.BENCH, "experiment": r["experiment"], "num_dpus": r["num_dpus"],
                   "num_tasklets": r["num_tasklets"], "data_prep_params": r["data_prep_params"],
                   "setting_id": sid,
                   "memory_read_bytes_lower_per_dpu": d["read_bytes_lower"] / n,
                   "memory_read_bytes_upper_per_dpu": d["read_bytes_upper"] / n,
                   "memory_write_bytes_lower_per_dpu": d["write_bytes_lower"] / n,
                   "memory_write_bytes_upper_per_dpu": d["write_bytes_upper"] / n,
                   "observed_read_bytes": r["read_bytes_sum"], "observed_write_bytes": r["write_bytes_sum"],
                   "static_instructions_lower_per_dpu": ins[0], "static_instructions_upper_per_dpu": ins[1],
                   "toolchain_instructions_lower_per_dpu": st[0], "toolchain_instructions_upper_per_dpu": st[1],
                   "measured_instructions_per_dpu": meas,
                   "memory_model_lower_cycles": mem[0], "memory_model_upper_cycles": mem[1],
                   "composed_cycles_lower": cyc[0], "composed_cycles_upper": cyc[1], "actual_cycles": actual,
                   "actual_within_composed_bounds": cyc[0] <= actual <= cyc[1]}
            out.append(rec)
        (OUT / b).mkdir(parents=True, exist_ok=True)
        with open(OUT / b / f"{b}_cost_estimates.csv", "w", newline="") as f:
            w = csv.DictWriter(f, fieldnames=FIELDS, lineterminator="\n")
            w.writeheader()
            w.writerows(out)
        all_rows += out
        cov = sum(x["actual_within_composed_bounds"] for x in out)
        print(f"{mod.BENCH:9s} {len(out):3d} settings, {cov:3d} covered")
    return all_rows


if __name__ == "__main__":
    run()
