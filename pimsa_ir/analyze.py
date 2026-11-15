"""HBM-PIM analysis run entirely on PIMSA-IR.

  metrics      metrics.hbm_counts: symbolic, from the IR and the arch instance
  cycles       lower_cmd.lower -> controller.schedule (constraint evaluation)
  closed form  closed_form.estimate with the PIMSA-IR lowering as its stream
               source: per-period critical cycles, refresh by the sourced rule

The vendor frontend IR is not read here; it is only used by the tests, as the
reference the lowered streams are compared against.

Usage: ../.venv/bin/python analyze.py ADD L=1048576 B=1 C=64
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path[:0] = [str(HERE), str(HERE.parent / "hbmpim_static")]

import sympy as sp  # noqa: E402

import closed_form  # noqa: E402
import kernels as K  # noqa: E402
import lower_cmd as LC  # noqa: E402
import metrics as MX  # noqa: E402
import pimsa_hbm as P  # noqa: E402

HBM_ARCH = HERE.parent / "hbmpim_static/arch/hbm2_pim.json"
_TO_K = {P.M: K.M, P.N: K.N, P.L: K.L, P.BT: K.B, P.C: K.C}


class Stream:
    """(kernel, values keyed by hbmpim_static symbols) -> lowered command stream."""

    def __init__(self, arch):
        self.arch = arch

    def __call__(self, kernel, vals):
        return LC.lower(K.KERNELS[kernel](), self.arch, {_TO_K[k]: int(v) for k, v in vals.items()})

    def trips(self, kernel):
        """Loop trip counts of the PIMSA-IR program (metrics.loop_trips), in
        program order, in the hbmpim_static symbols."""
        to_p = {v: k for k, v in _TO_K.items()}
        return [(v, sp.sympify(n).subs(to_p, simultaneous=True))
                for v, n in MX.loop_trips(K.KERNELS[kernel](), self.arch)]

    def __str__(self):
        return "pimsa-ir"


def analyze(kname: str, arch: dict, values: dict) -> dict:
    """values keyed by kernels symbols (K.L, K.B, K.C, ...)."""
    kern = K.KERNELS[kname]()
    sym = MX.hbm_counts(kern, arch)
    m = {k: int(sp.sympify(v).subs(values)) for k, v in sym.items()}
    cmds = LC.lower(kern, arch, values)
    if (m["rd"], m["wr"]) != (sum(not c.write for c in cmds), sum(c.write for c in cmds)):
        raise AssertionError("symbolic counts disagree with the lowered stream")
    est = P.estimate(arch, cmds)
    est["by_term"] = P.cost_terms(est["by_constraint"], est["total"])
    to_p = {v: k for k, v in _TO_K.items()}
    return {
        "kernel": kname,
        "values": {str(k): int(v) for k, v in values.items()},
        "symbolic": {k: str(v) for k, v in sym.items()},
        "metrics": m,
        "metric_vector": P.metric_vector(arch, m, est["commands"]["ACT"]),
        "estimate": est,
        "closed_form": closed_form.estimate(Stream(arch), arch, kname,
                                            {to_p[k]: v for k, v in values.items()}),
    }


def main(argv):
    kname, *kv = argv
    names = {"L": K.L, "M": K.M, "N": K.N, "B": K.B, "C": K.C}
    values = {names[a]: int(b) for a, b in (x.split("=") for x in kv)}
    arch = json.loads(HBM_ARCH.read_text())
    r = analyze(kname, arch, values)
    print(json.dumps({k: r[k] for k in ("kernel", "values", "symbolic", "metric_vector")}, indent=2))
    print("cycles (constraint evaluation):", r["estimate"]["total"])
    cf = r["closed_form"]
    print("cycles (closed form):", cf["total"], "=", cf["formula"], f"+ {cf['refreshes']}*tRFC")


if __name__ == "__main__":
    main(sys.argv[1:])
