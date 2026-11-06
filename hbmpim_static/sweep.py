#!/usr/bin/env python3
"""Validate PIMSA HBM-PIM static estimates against Samsung PIMSimulator.

For each configuration: run the simulator (timed region identical to the
vendor PIMBenchFixture) and the static analysis, then record cycles and the
per-channel DRAM command counts on both sides.

    ../.venv/bin/python sweep.py --ir IR.json \
        --sim ../hbmpim_sim/build/pimsim/sim --out results/sweep.json
"""
from __future__ import annotations

import argparse
import csv
import json
import os
import subprocess
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

import pimsa_hbm as P

# Simulator stall-attribution names (hbmpim_sim/instrument.py) -> controller.py names.
SIM_NAME = {"tRCDRD": "tRCD_RD", "tRCDWR": "tRCD_WR", "tCCDL": "tCCD_L", "tCCDS": "tCCD_S",
            "tRRDL": "tRRD_L", "tRRDS": "tRRD_S", "slot": "tCMD", "other": "order"}

GEMV = [(m, n, b, c)
        for (m, n) in [(1024, 1024), (1024, 4096), (4096, 1024), (2048, 2048),
                       (4096, 4096), (8192, 2048)]
        for b in (1, 4)
        for c in (16, 64)]
ELTWISE = [(k, l, c)
           for k in ("ADD", "MUL", "RELU")
           for l in (1 << 18, 1 << 20, 1 << 22)
           for c in (16, 64)]


def configs():
    for m, n, b, c in GEMV:
        yield {"kernel": "GEMV", "M": m, "N": n, "B": b, "C": c}
    for k, l, c in ELTWISE:
        yield {"kernel": k, "L": l, "B": 1, "C": c}


def simulate(sim: Path, cfg: dict) -> dict:
    env = dict(os.environ, PIMSA_KERNEL=cfg["kernel"], PIMSA_BATCH=str(cfg["B"]),
               PIMSA_CHANS=str(cfg["C"]))
    if cfg["kernel"] == "GEMV":
        env.update(PIMSA_OUT=str(cfg["M"]), PIMSA_IN=str(cfg["N"]))
    else:
        env.update(PIMSA_OUT=str(cfg["L"]), PIMSA_IN=str(cfg["L"]))
    out = subprocess.run([str(sim), "--gtest_filter=PIMSASweep.run"], cwd=sim.parent,
                         env=env, capture_output=True, text=True, check=True).stdout
    line = next(l for l in out.splitlines() if l.startswith("PIMSA_RESULT "))
    return json.loads(line[len("PIMSA_RESULT "):])


def static(ir: Path, arch: dict, cfg: dict) -> dict:
    vals = {P.C: cfg["C"], P.BT: cfg["B"]}
    if cfg["kernel"] == "GEMV":
        vals.update({P.M: cfg["M"], P.N: cfg["N"]})
    else:
        vals[P.L] = cfg["L"]
    return P.analyze(ir, arch, cfg["kernel"], vals)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--ir", type=Path, required=True)
    ap.add_argument("--sim", type=Path, required=True)
    ap.add_argument("--arch", type=Path, default=P.HERE / "arch" / "hbm2_pim.json")
    ap.add_argument("--out", type=Path, default=P.HERE / "results" / "sweep.json")
    ap.add_argument("-j", type=int, default=os.cpu_count())
    a = ap.parse_args()
    arch = json.loads(a.arch.read_text())
    cfgs = list(configs())

    with ThreadPoolExecutor(a.j) as pool:
        sims = list(pool.map(lambda c: simulate(a.sim.resolve(), c), cfgs))

    rows = []
    for cfg, sim in zip(cfgs, sims):
        st = static(a.ir, arch, cfg)
        m = st["metrics"]
        ch0 = sim["ch0"]
        sim_by = {SIM_NAME.get(k, k): v[0] for k, v in sim.get("gap", {}).items()}
        est_by = st["estimate"]["by_constraint"]
        keys = sorted(set(sim_by) | set(est_by))
        row = {
            **cfg,
            "sim_cycles": sim["cycles"],
            "est_cycles": round(st["estimate"]["total"]),
            "worst_cycles": round(st["worst_case"]["total"]),
            "est_ratio": st["estimate"]["total"] / sim["cycles"],
            "worst_ratio": st["worst_case"]["total"] / sim["cycles"],
            "sim_rd": ch0["rd"], "static_rd": m["rd"],
            "sim_wr": ch0["wr"], "static_wr": m["wr"],
            "sim_act": ch0["act"], "static_act": m["act"],
            "sim_ref": ch0["ref"], "static_ref": st["estimate"]["commands"]["REF"],
            # largest per-constraint disagreement, in cycles
            "max_constraint_diff": max(abs(sim_by.get(k, 0) - est_by.get(k, 0)) for k in keys),
            **{f"est_{t}": v for t, v in st["estimate"]["by_term"].items()},
            **{k: v for k, v in st["metric_vector"].items()},
            "by_constraint": {k: [sim_by.get(k, 0), est_by.get(k, 0)] for k in keys},
            "by_term": {t: [s, st["estimate"]["by_term"][t]] for t, s in
                        P.cost_terms(sim_by, sim["cycles"]).items()},
            "symbolic": st["symbolic"],
        }
        rows.append(row)
        print(f"{cfg['kernel']:5s} {str({k: v for k, v in cfg.items() if k != 'kernel'}):45s} "
              f"sim={sim['cycles']:>8d} est={row['est_cycles']:>8d} ({row['est_ratio']:.3f}x) "
              f"worst={row['worst_ratio']:.2f}x rd {m['rd']}/{ch0['rd']} wr {m['wr']}/{ch0['wr']} "
              f"act {m['act']}/{ch0['act']} maxΔconstraint {row['max_constraint_diff']}")

    a.out.parent.mkdir(parents=True, exist_ok=True)
    a.out.write_text(json.dumps(rows, indent=2))
    with a.out.with_suffix(".csv").open("w", newline="") as f:
        skip = ("symbolic", "by_constraint", "by_term")
        cols = list(dict.fromkeys(k for r in rows for k in r if k not in skip))
        w = csv.DictWriter(f, cols, lineterminator="\n")
        w.writeheader()
        for r in rows:
            w.writerow({k: v for k, v in r.items() if k not in skip})

    exact = sum(r["sim_rd"] == r["static_rd"] and r["sim_wr"] == r["static_wr"] for r in rows)
    ratios = [r["est_ratio"] for r in rows]
    print(f"\ncolumn-command counts exact: {exact}/{len(rows)}")
    print(f"estimate/sim: min {min(ratios):.3f} max {max(ratios):.3f} "
          f"mean |err| {sum(abs(x - 1) for x in ratios) / len(ratios):.3%}")
    exact_cyc = sum(r["sim_cycles"] == r["est_cycles"] for r in rows)
    print(f"cycle count exact: {exact_cyc}/{len(rows)}")
    print(f"worst-case/sim: min {min(r['worst_ratio'] for r in rows):.2f} "
          f"max {max(r['worst_ratio'] for r in rows):.2f}")


if __name__ == "__main__":
    main()
