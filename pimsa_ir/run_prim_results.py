"""Regenerate the UPMEM (PrIM) results of the paper from PIMSA-IR.

For every setting in draw_figs/results/<bench>/summary.csv, this runs the IR
analysis (upmem_cost.setting_bounds) and writes, under results/prim/:

  <bench>/<bench>_cost_estimates.csv  intervals per setting, in the column names
                                      that draw_figs' plotting scripts read
  wall_time_comparison.csv            analysis time vs uPIMulator wall time

Analysis time per setting = the toolchain run for that setting (compilation of
the DPU source and machine-code analysis, `analysis_wall_seconds` in
inst_count_analyzer/results/<bench>/instruction_counts.csv) + the IR analysis
measured here. Charging every setting a full toolchain run is conservative:
settings of one build (same BL, TYPE, NR_TASKLETS) could share it.

Run it on the machine that timed the toolchain and uPIMulator, after
draw_figs/scripts/summarize_upimulator_wall_time.py has written
draw_figs/.work/upimulator_wall_times.csv.

Usage: ../.venv/bin/python run_prim_results.py [--repeat N]
"""
from __future__ import annotations

import argparse
import csv
import statistics
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))

import prim  # noqa: E402
import upmem_cost as U  # noqa: E402

ROOT = HERE.parent
FIG = ROOT / "draw_figs/results"
TOOL = ROOT / "inst_count_analyzer/results"
SIM_TIMES = ROOT / "draw_figs/.work/upimulator_wall_times.csv"
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
          "actual_within_composed_bounds", "ir_analysis_seconds", "toolchain_seconds",
          "pimsa_wall_seconds")


def rows(path):
    with open(path) as f:
        return list(csv.DictReader(f))


def key(r):
    return (r["benchmark"].upper(), r["experiment"], int(r["num_dpus"]), int(r["num_tasklets"]),
            int(r["data_prep_params"]))


def run(repeat):
    sim_times = {key(r): float(r["wall_seconds"]) for r in rows(SIM_TIMES)}
    all_rows, cmp_rows = [], []
    for name in prim.NAMES:
        mod = prim.load(name)
        b = mod.BENCH.lower()
        tool = {key(r): float(r["analysis_wall_seconds"]) for r in rows(TOOL / b / "instruction_counts.csv")}
        old = {(r["experiment"], r["num_dpus"], r["num_tasklets"]): r
               for r in rows(FIG / b / f"{b}_cost_estimates.csv")}
        out = []
        for r in rows(FIG / b / "summary.csv"):
            sid = U.setting_id(r, mod.BENCH)
            times = []
            for _ in range(repeat):
                t0 = time.perf_counter()
                res = U.setting_bounds(mod, sid, r)
                times.append(time.perf_counter() - t0)
            ir_s = statistics.median(times)
            k = key({**r, "benchmark": mod.BENCH})
            tool_s = tool[k]
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
                   "actual_within_composed_bounds": cyc[0] <= actual <= cyc[1],
                   "ir_analysis_seconds": ir_s, "toolchain_seconds": tool_s,
                   "pimsa_wall_seconds": tool_s + ir_s}
            out.append(rec)
            if k in sim_times:
                cmp_rows.append({"benchmark": mod.BENCH, "experiment": r["experiment"],
                                 "num_dpus": r["num_dpus"], "num_tasklets": r["num_tasklets"],
                                 "data_prep_params": r["data_prep_params"],
                                 "pimsa_wall_seconds": tool_s + ir_s, "ir_analysis_seconds": ir_s,
                                 "toolchain_seconds": tool_s, "upimulator_wall_seconds": sim_times[k],
                                 "upimulator_over_pimsa": sim_times[k] / (tool_s + ir_s)})
        (OUT / b).mkdir(parents=True, exist_ok=True)
        with open(OUT / b / f"{b}_cost_estimates.csv", "w", newline="") as f:
            w = csv.DictWriter(f, fieldnames=FIELDS, lineterminator="\n")
            w.writeheader()
            w.writerows(out)
        all_rows += out
        cov = sum(x["actual_within_composed_bounds"] for x in out)
        print(f"{mod.BENCH:9s} {len(out):3d} settings, {cov:3d} covered")
    with open(OUT / "wall_time_comparison.csv", "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(cmp_rows[0]), lineterminator="\n")
        w.writeheader()
        w.writerows(cmp_rows)
    return all_rows, cmp_rows


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--repeat", type=int, default=3, help="IR analysis runs per setting (median)")
    a = ap.parse_args()
    run(a.repeat)
