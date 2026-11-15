"""Measure the HBM-PIM transfer cost on PIMSimulator, PrIM-style.

The bandwidth-based baseline needs a bandwidth and a fixed cost per transfer.
On UPMEM these come from the PrIM microbenchmark on real hardware
(mram_read of s bytes costs alpha + beta * s). This script measures the same
two numbers for the simulated HBM-PIM instance, independently of the four
evaluated kernels: it runs the PIMSAMicro driver (../hbmpim_sim/PIMSAMicro.cpp)
for N blocking transfers of K column commands each, K = 1..32 (one DRAM row),
and fits the cycles per transfer as alpha + beta * bytes by least squares.

Modes (one pseudo-channel):
  MEM_RD / MEM_WR  all-bank mode, P x 32 B per command, banks <-> PIM blocks
  BUS_RD / BUS_WR  single-bank mode, 32 B per command over the channel bus

Output: results/hbm/microbench.csv (raw runs) and results/hbm/microbench_fit.json.

Usage: ../.venv/bin/python hbm_microbench.py [--sim ../hbmpim_sim/build/pimsim/sim]
"""
from __future__ import annotations

import argparse
import csv
import json
import os
import subprocess
from pathlib import Path

HERE = Path(__file__).resolve().parent
OUT_CSV = HERE / "results/hbm/microbench.csv"
OUT_FIT = HERE / "results/hbm/microbench_fit.json"
P, COL = 8, 32
BYTES = {"MEM_RD": P * COL, "MEM_WR": P * COL, "BUS_RD": COL, "BUS_WR": COL}
N_TRANSFERS = 256


def run(sim: Path, mode: str, k: int, n: int) -> dict:
    env = dict(os.environ, PIMSA_MB_MODE=mode, PIMSA_MB_K=str(k), PIMSA_MB_N=str(n), PIMSA_MB_BAR="1")
    out = subprocess.run([str(sim), "--gtest_filter=PIMSAMicro.run"], cwd=sim.parent, env=env,
                         capture_output=True, text=True, check=True).stdout
    line = next(l for l in out.splitlines() if l.startswith("PIMSA_MICRO "))
    return json.loads(line[len("PIMSA_MICRO "):])


def fit(xs, ys):
    n = len(xs)
    mx, my = sum(xs) / n, sum(ys) / n
    b = sum((x - mx) * (y - my) for x, y in zip(xs, ys)) / sum((x - mx) ** 2 for x in xs)
    return my - b * mx, b


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--sim", type=Path, default=HERE.parent / "hbmpim_sim/build/pimsim/sim")
    sim = ap.parse_args().sim.resolve()
    rows, res = [], {}
    for mode in BYTES:
        xs, ys = [], []
        for k in range(1, 33):
            r = run(sim, mode, k, N_TRANSFERS)
            per = r["cycles"] / r["n"]
            rows.append({"mode": mode, "k": k, "n": r["n"], "bytes": k * BYTES[mode],
                         "cycles": r["cycles"], "cycles_per_transfer": round(per, 3),
                         **{f"ch0_{c}": v for c, v in r["ch0"].items()}})
            xs.append(k * BYTES[mode])
            ys.append(per)
        alpha, beta = fit(xs, ys)
        res[mode] = {"alpha_cycles": round(alpha, 3), "beta_cycles_per_byte": round(beta, 6),
                     "bandwidth_bytes_per_cycle": round(1 / beta, 3),
                     "max_rel_residual": round(max(abs(alpha + beta * x - y) / y for x, y in zip(xs, ys)), 4)}
        print(f"{mode}: alpha = {alpha:.1f} cycles, beta = {beta:.5f} cycles/B "
              f"(1/beta = {1 / beta:.1f} B/cycle), max residual {res[mode]['max_rel_residual']:.1%}")
    OUT_CSV.parent.mkdir(parents=True, exist_ok=True)
    with OUT_CSV.open("w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0]), lineterminator="\n")
        w.writeheader()
        w.writerows(rows)
    OUT_FIT.write_text(json.dumps({"n_transfers": N_TRANSFERS, "k_range": [1, 32], "fit": res}, indent=2) + "\n")
    print(f"wrote {OUT_CSV.relative_to(HERE)}, {OUT_FIT.relative_to(HERE)}")


if __name__ == "__main__":
    main()
