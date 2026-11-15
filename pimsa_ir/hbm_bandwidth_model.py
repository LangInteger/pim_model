"""HBM-PIM under the bandwidth-based cost model, against the DRAM-timing-based one.

The paper estimates HBM-PIM with the DRAM-timing-based cost model (closed
form from the controller specification). This script applies the
bandwidth-based cost model instead, to the same PIMSA-IR metrics, and
compares both with Samsung PIMSimulator on the 42 sweep configurations.

Bandwidth-based estimate, per PU (pseudo-channel), with the memory term of
the paper's Sec. 4.2.1:
    T = V_mem / BW_mem + N_mem * t_mem * rho_row + V_host / BW_host
  V_mem   bytes between the banks and the P PIM blocks (inside the die)
  V_host  bytes between the host and the PIM registers (over the channel bus,
          including the launch protocol's register writes)
  BW_mem  P blocks x 32 B per column command, one command per tCCD_L
  BW_host 32 B per column command, one command per tCCD_S
  N_mem   column commands between the banks and the PIM blocks
  t_mem   latency of a row miss: tRP + tRCD_RD for a read, tRP + tRCD_WR
          for a write (split by direction, as t_read / t_write on UPMEM)
  rho_row fraction of the column commands that pay it, three ways:
            bw      rho_row = 0         volume over bandwidth only
            bw_row  rho_row = X / N     one row miss per transfer (statement
                                        execution, which stays in one row),
                                        from the IR metrics X_mem
            bw_act  rho_row = ACT / N   the exact number of row activations
                                        (static_act in sweep.csv, the
                                        controller's count, equal to the
                                        simulator's), each charged
                                        tRP + tRCD_RD
            bw_max  rho_row = 1         the model's worst-case default
There is no compute term (every PIM step is triggered by a column command,
so its time is that command's) and no overlap to bound, so the estimate is a
single value. Commands without payload (mode switches) and barriers cost
nothing in this model. Cycles are DRAM clock cycles (tCK = 1 ns in
PIMSimulator's HBM2 ini), so B/cycle equals GB/s.

Inputs: the IR metrics (metrics.hbm_counts), the architecture instance, and
sim_cycles / closed_cycles recorded in ../hbmpim_static/results/sweep.csv.
Output: results/hbm/bandwidth_vs_dram_timing.csv and a per-kernel summary.

Usage: ../.venv/bin/python hbm_bandwidth_model.py
"""
from __future__ import annotations

import csv
import json
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path[:0] = [str(HERE), str(HERE.parent / "hbmpim_static")]

import sympy as sp  # noqa: E402

import analyze as AN  # noqa: E402
import archinfo as A  # noqa: E402
import kernels as K  # noqa: E402
import metrics as MX  # noqa: E402

SWEEP = HERE.parent / "hbmpim_static/results/sweep.csv"
OUT = HERE / "results/hbm/bandwidth_vs_dram_timing.csv"
MICRO_FIT = HERE / "results/hbm/microbench_fit.json"


def bandwidths(arch):
    """(BW_mem, BW_host) in bytes per cycle, from the architecture instance."""
    col = arch["M"]["bytes_per_column_access"]["value"]
    p = A.pus_per_region(arch)
    t = arch["timing_cycles"]
    return p * col / t["tCCD_L"]["value"], col / t["tCCD_S"]["value"]


def estimate(kname, arch, values, n_act):
    """Bandwidth-based cycles and the volumes it uses, at one configuration."""
    m = {k: int(sp.sympify(v).subs(values)) for k, v in MX.hbm_counts(K.KERNELS[kname](), arch).items()}
    col = arch["M"]["bytes_per_column_access"]["value"]
    p = A.pus_per_region(arch)
    v_mem = p * col * (m["bank2pu"] + m["pu2bank"])
    v_host = col * (m["host2pu"] + m["pu2host"])
    bw_mem, bw_host = bandwidths(arch)
    t = {k: v["value"] for k, v in arch["timing_cycles"].items()}
    t_read, t_write = t["tRP"] + t["tRCD_RD"], t["tRP"] + t["tRCD_WR"]
    c = MX.extract(K.KERNELS[kname](), arch, values)  # transfers X per direction
    base = v_mem / bw_mem + v_host / bw_host
    row = c["X_mem2reg"] * t_read + c["X_reg2mem"] * t_write
    worst = m["bank2pu"] * t_read + m["pu2bank"] * t_write
    act = n_act * t_read
    # Measured variant: alpha + beta * bytes per transfer, both fitted by the
    # PIMSAMicro microbenchmark (hbm_microbench.py), as PrIM does for UPMEM.
    mb = json.loads(MICRO_FIT.read_text())["fit"]
    v = {"MEM_RD": p * col * m["bank2pu"], "MEM_WR": p * col * m["pu2bank"],
         "BUS_WR": col * m["host2pu"], "BUS_RD": col * m["pu2host"]}
    x = {"MEM_RD": c["X_mem2reg"], "MEM_WR": c["X_reg2mem"],
         "BUS_WR": c["X_host2reg"], "BUS_RD": c.get("X_reg2host", 0)}
    meas_vol = sum(v[k] * mb[k]["beta_cycles_per_byte"] for k in v)
    meas = meas_vol + sum(x[k] * mb[k]["alpha_cycles"] for k in x)
    return {"V_mem_bytes": v_mem, "V_host_bytes": v_host,
            "X_mem": c["X_mem2reg"] + c["X_reg2mem"], "N_mem": m["bank2pu"] + m["pu2bank"],
            "bw_cycles": round(base), "bw_row_cycles": round(base + row),
            "bw_act_cycles": round(base + act),
            "bw_max_cycles": round(base + worst),
            "meas_vol_cycles": round(meas_vol), "meas_cycles": round(meas)}


def main():
    arch = json.loads(AN.HBM_ARCH.read_text())
    rows = []
    for r in csv.DictReader(SWEEP.open()):
        vals = {K.C: int(r["C"]), K.B: int(r["B"])}
        if r["kernel"] == "GEMV":
            vals.update({K.M: int(r["M"]), K.N: int(r["N"])})
        else:
            vals[K.L] = int(r["L"])
        e = estimate(r["kernel"], arch, vals, int(r["static_act"]))
        sim, closed = int(r["sim_cycles"]), int(r["closed_cycles"])
        rows.append({"kernel": r["kernel"], "M": r["M"], "N": r["N"], "L": r["L"], "B": r["B"],
                     "C": r["C"], "sim_cycles": sim, **e,
                     **{f"{k}_ratio": round(e[f"{k}_cycles"] / sim, 4)
                        for k in ("bw", "bw_row", "bw_act", "bw_max", "meas_vol", "meas")},
                     "closed_cycles": closed, "closed_ratio": round(closed / sim, 4)})
    OUT.parent.mkdir(parents=True, exist_ok=True)
    with OUT.open("w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0]), lineterminator="\n")
        w.writeheader()
        w.writerows(rows)

    bw_mem, bw_host = bandwidths(arch)
    print(f"BW_mem = {bw_mem:g} B/cycle, BW_host = {bw_host:g} B/cycle")
    print("estimate / sim: range (MAPE)")
    print(f"{'kernel':6}" + "".join(f"{h:>26}" for h in ("bw (rho=0)", "bw_row (rho=X/N)",
                                                        "bw_act (rho=ACT/N)", "bw_max (rho=1)",
                                                        "DRAM-timing")))
    for k in ("GEMV", "ADD", "MUL", "RELU", None):
        sel = [x for x in rows if k is None or x["kernel"] == k]
        cell = lambda key: (f"{min(x[key] for x in sel):.2f}-{max(x[key] for x in sel):.2f}"
                            f" ({100 * sum(abs(x[key] - 1) for x in sel) / len(sel):.1f}%)")
        print(f"{k or 'all':6}" + "".join(f"{cell(c):>26}" for c in
                                         ("bw_ratio", "bw_row_ratio", "bw_act_ratio", "bw_max_ratio",
                                          "closed_ratio")))
    print("measured (microbenchmark alpha, beta): volume only | alpha per transfer + beta per byte")
    for k in ("GEMV", "ADD", "MUL", "RELU", None):
        sel = [x for x in rows if k is None or x["kernel"] == k]
        cell = lambda key: (f"{min(x[key] for x in sel):.2f}-{max(x[key] for x in sel):.2f}"
                            f" ({100 * sum(abs(x[key] - 1) for x in sel) / len(sel):.1f}%)")
        print(f"{k or 'all':6}{cell('meas_vol_ratio'):>26}{cell('meas_ratio'):>26}")
    # Why: the schedule's attribution of the simulated cycles (sweep.csv est_*,
    # which partition the cycles by the constraint each command waited on)
    t_row = arch["timing_cycles"]["tRP"]["value"] + arch["timing_cycles"]["tRCD_RD"]["value"]
    print("schedule attribution: row time / (ACT x (tRP+tRCD_RD)), and share of the cycles in"
          " terms the model lacks (turnaround + refresh + issue + drain)")
    sw = list(csv.DictReader(SWEEP.open()))
    for k in ("GEMV", "ADD", "MUL", "RELU"):
        sel = [r for r in sw if r["kernel"] == k]
        exp = [float(r["est_row"]) / (int(r["static_act"]) * t_row) for r in sel]
        miss = [sum(float(r[c]) for c in ("est_turnaround", "est_refresh", "est_issue", "est_drain"))
                / float(r["sim_cycles"]) for r in sel]
        print(f"{k:6} exposed row time {min(exp):.2f}-{max(exp):.2f}"
              f"   missing terms {100 * min(miss):.0f}-{100 * max(miss):.0f}%")
    print(f"wrote {OUT.relative_to(HERE)}")


if __name__ == "__main__":
    main()
