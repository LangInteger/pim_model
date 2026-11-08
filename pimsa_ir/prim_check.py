"""Check a PrIM benchmark written in PIMSA-IR against the stored results.

For every setting in draw_figs/results/<bench>/summary.csv:
  dma     MRAM bytes and 8 B units summed over DPUs vs uPIMulator counters
  instr   per-DPU instruction bound from IR counts + stored machine code vs the
          toolchain's stored bound
  cycles  composed cycle interval vs the paper's (<bench>_cost_estimates.csv),
          and whether the measured cycle count lies inside
  loops   IR loop iterations vs the toolchain's loop-header counts

Usage: ../.venv/bin/python prim_check.py red [--code-of SETTING]   (module name: hst_s, scan_ssa, ...)
"""
from __future__ import annotations

import argparse
import csv
import json
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))

import prim  # noqa: E402
import upmem_cost as U  # noqa: E402

FIG = HERE.parent / "draw_figs/results"


def rows(path):
    with open(path) as f:
        return list(csv.DictReader(f))


def check(name, code_of=None, quiet=False):
    mod = prim.load(name)
    b = mod.BENCH.lower()  # draw_figs/results/<bench> (e.g. hst-s for module hst_s)
    est = {(r["experiment"], r["num_dpus"], r["num_tasklets"]): r
           for r in rows(FIG / b / f"{b}_cost_estimates.csv")}
    out = []
    for r in rows(FIG / b / "summary.csv"):
        sid = U.setting_id(r, mod.BENCH)
        res = U.setting_bounds(mod, sid, r, code_setting=code_of)
        e = est.get((r["experiment"], r["num_dpus"], r["num_tasklets"]))
        d = res["dma_total"]
        dma_ok = all(d[f"{k}_lower"] <= float(r[c]) <= d[f"{k}_upper"] for k, c in
                     (("read_bytes", "read_bytes_sum"), ("write_bytes", "write_bytes_sum"),
                      ("reads", "num_reads_sum"), ("writes", "num_writes_sum")))
        dma_exact = all(d[f"{k}_lower"] == float(r[c]) == d[f"{k}_upper"] for k, c in
                        (("read_bytes", "read_bytes_sum"), ("write_bytes", "write_bytes_sum"),
                         ("reads", "num_reads_sum"), ("writes", "num_writes_sum")))
        ins = res["instructions"]
        st = res["stored_instructions"]
        cyc = res["cycles"]
        paper = (float(e["composed_cycles_lower"]), float(e["composed_cycles_upper"])) if e else None
        actual = float(e["actual_cycles"]) if e else float(r["cycles_max"])
        loops_bad = [c for c in res["checks"] if c[3][0] == c[3][1] and c[2] != c[3]]
        measured_ins = float(e["measured_instructions_per_dpu"]) if e and e.get("measured_instructions_per_dpu") else None
        same = tuple(map(float, ins)) == tuple(map(float, st))
        # the IR may know a count the toolchain could only bound: then its bound
        # must lie inside the stored one and still contain the measured count
        tighter = (st[0] <= ins[0] <= ins[1] <= st[1] and measured_ins is not None
                   and ins[0] <= measured_ins <= ins[1])
        rec = {"setting": sid, "dma": "exact" if dma_exact else ("in" if dma_ok else "OUT"),
               "instr": ins, "instr_stored": st, "instr_same": same, "instr_tighter": tighter,
               "instr_measured": measured_ins,
               "paper_covered": (e.get("actual_within_composed_bounds") == "True") if e else None,
               "cycles": cyc, "paper": paper, "actual": actual,
               "covered": cyc[0] <= actual <= cyc[1], "loops_differ": loops_bad[:3]}
        out.append(rec)
        if not quiet:
            print(f"{sid:48s} dma {rec['dma']:5s} instr {'=' if same else ('⊂' if tighter else '≠')} "
                  f"[{ins[0]:.0f}, {ins[1]:.0f}] stored [{st[0]:.0f}, {st[1]:.0f}]  "
                  f"cycles [{cyc[0]:.0f}, {cyc[1]:.0f}] paper "
                  f"{'[%.0f, %.0f]' % paper if paper else '-'} actual {actual:.0f} "
                  f"{'in' if rec['covered'] else 'OUT'}" + (f" loops≠ {loops_bad[:2]}" if loops_bad else ""))
    return out


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("bench")
    ap.add_argument("--code-of")
    a = ap.parse_args()
    check(a.bench, a.code_of)
