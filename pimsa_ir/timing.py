"""Wall-clock cost of the HBM-PIM analysis vs. PIMSimulator, per configuration.

  one-time    closed_form.derive per kernel: critical cycles from tiny
              instances lowered from PIMSA-IR (done once per kernel and
              architecture, independent of problem size)
  per config  closed_form.estimate: evaluate the closed form and the refresh
              rule at the configuration
  simulator   one run of the PIMSimulator sweep driver (same timed region as
              the vendor benchmark), sequential, wall clock of the process

The simulator is the uninstrumented build with the timing driver
(VANILLA=1 hbmpim_sim/build.sh ... ; PIMSATime.cpp). Its process wall time is
recorded, and also the time of the timed region alone (kernel issue + run).

Usage: ../.venv/bin/python timing.py --sim PATH/TO/vanilla/sim --out ../hbmpim_static/results/timing.csv
"""
from __future__ import annotations

import argparse
import csv
import json
import statistics
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path[:0] = [str(HERE), str(HERE.parent / "hbmpim_static")]

import analyze as AN  # noqa: E402
import closed_form  # noqa: E402
import pimsa_hbm as P  # noqa: E402
import os  # noqa: E402
import subprocess  # noqa: E402

import sweep  # noqa: E402


def simulate(sim: Path, cfg: dict):
    """(cycles, kernel seconds, process wall seconds) from PIMSATime.run."""
    env = dict(os.environ, PIMSA_KERNEL=cfg["kernel"], PIMSA_BATCH=str(cfg["B"]),
               PIMSA_CHANS=str(cfg["C"]))
    if cfg["kernel"] == "GEMV":
        env.update(PIMSA_OUT=str(cfg["M"]), PIMSA_IN=str(cfg["N"]))
    else:
        env.update(PIMSA_OUT=str(cfg["L"]), PIMSA_IN=str(cfg["L"]))
    t0 = time.perf_counter()
    out = subprocess.run([str(sim), "--gtest_filter=PIMSATime.run"], cwd=sim.parent, env=env,
                         capture_output=True, text=True, check=True).stdout
    wall = time.perf_counter() - t0
    _, cyc, t_kernel, _ = next(l for l in out.splitlines() if l.startswith("PIMSA_TIME ")).split()
    return int(cyc), float(t_kernel), wall


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--sim", type=Path, required=True)
    ap.add_argument("--out", type=Path, required=True)
    ap.add_argument("--repeat", type=int, default=5, help="repetitions of the per-config evaluation")
    a = ap.parse_args()
    arch = json.loads(AN.HBM_ARCH.read_text())
    stream = AN.Stream(arch)

    one_time = {}
    for k in ("GEMV", "ADD", "MUL", "RELU"):
        t0 = time.perf_counter()
        closed_form.derive(stream, arch, k)
        one_time[k] = time.perf_counter() - t0

    rows = []
    for cfg in sweep.configs():
        vals = {P.C: cfg["C"], P.BT: cfg["B"]}
        if cfg["kernel"] == "GEMV":
            vals.update({P.M: cfg["M"], P.N: cfg["N"]})
        else:
            vals[P.L] = cfg["L"]
        times = []
        for _ in range(a.repeat):
            t0 = time.perf_counter()
            est = closed_form.estimate(stream, arch, cfg["kernel"], vals)
            times.append(time.perf_counter() - t0)
        cyc, t_kernel, t_sim = simulate(a.sim.resolve(), cfg)
        t_cf = statistics.median(times)
        rows.append({**cfg, "sim_cycles": cyc, "closed_cycles": est["total"],
                     "sim_seconds": round(t_sim, 4), "sim_kernel_seconds": round(t_kernel, 4),
                     "closed_seconds": round(t_cf, 6), "speedup": round(t_sim / t_cf, 1)})
        print(f"{cfg} sim {t_sim:.3f}s closed {t_cf * 1e3:.2f}ms ({t_sim / t_cf:.0f}x)", flush=True)

    a.out.parent.mkdir(parents=True, exist_ok=True)
    with a.out.open("w", newline="") as f:
        fields = ["kernel", "M", "N", "L", "B", "C"] + [k for k in rows[0] if k not in
                                                       ("kernel", "M", "N", "L", "B", "C")]
        w = csv.DictWriter(f, fieldnames=fields, lineterminator="\n")
        w.writeheader()
        w.writerows(rows)
    sp = [r["speedup"] for r in rows]
    sim_total = sum(r["sim_seconds"] for r in rows)
    cf_total = sum(r["closed_seconds"] for r in rows) + sum(one_time.values())
    summary = {"one_time_seconds": {k: round(v, 3) for k, v in one_time.items()},
               "sim_seconds": [min(r["sim_seconds"] for r in rows), max(r["sim_seconds"] for r in rows)],
               "closed_seconds": [min(r["closed_seconds"] for r in rows), max(r["closed_seconds"] for r in rows)],
               "speedup_per_config": {"min": min(sp), "median": statistics.median(sp), "max": max(sp),
                                      "geomean": round(statistics.geometric_mean(sp), 1)},
               "sweep_total_seconds": {"simulator": round(sim_total, 2),
                                       "pimsa_including_one_time": round(cf_total, 2),
                                       "speedup": round(sim_total / cf_total, 1)}}
    a.out.with_suffix(".json").write_text(json.dumps(summary, indent=2) + "\n")
    print(json.dumps(summary, indent=2))


if __name__ == "__main__":
    main()
