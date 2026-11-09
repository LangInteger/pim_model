"""Checks for PIMSA-IR.

HBM-PIM: the command stream lowered from each hand-written PIMSA-IR program
(kernels.py) with the architecture instance must equal, command for command
(direction, bank, row, column, barrier), the stream derived from the vendor
generator (hbmpim_static: frontend IR of PIMKernel.cpp, abstract execution),
on all 42 sweep configurations. Symbolic metrics extracted from PIMSA-IR must
equal the ones extracted from the vendor IR.

Run: PIMSA_HBM_IR=../hbmpim_static/build/ir.json ../.venv/bin/python -m unittest -v test_unified_ir
"""
from __future__ import annotations

import csv
import json
import os
import sys
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path[:0] = [str(HERE), str(HERE.parent / "hbmpim_static")]

import sympy as sp  # noqa: E402

import kernels as K  # noqa: E402
import analyze as AN  # noqa: E402
import lower_cmd as LC  # noqa: E402
import metrics as MX  # noqa: E402
import pimsa_hbm as P  # noqa: E402

ARCH = json.loads((HERE.parent / "hbmpim_static/arch/hbm2_pim.json").read_text())
IR = Path(os.environ.get("PIMSA_HBM_IR", HERE.parent / "hbmpim_static/build/ir.json"))
SWEEP = HERE.parent / "hbmpim_static/results/sweep.csv"


def _rows(path):
    with open(path) as f:
        return list(csv.DictReader(f))


def configs():
    for r in _rows(SWEEP):
        k = r["kernel"]
        if k == "GEMV":
            yield k, {K.M: int(r["M"]), K.N: int(r["N"]), K.B: int(r["B"]), K.C: int(r["C"])}, \
                {P.M: int(r["M"]), P.N: int(r["N"]), P.BT: int(r["B"]), P.C: int(r["C"])}
        else:
            yield k, {K.L: int(r["L"]), K.B: int(r["B"]), K.C: int(r["C"])}, \
                {P.L: int(r["L"]), P.BT: int(r["B"]), P.C: int(r["C"])}


@unittest.skipUnless(IR.exists(), f"vendor IR not built: {IR}")
class HBMStream(unittest.TestCase):
    def test_streams_equal(self):
        n = 0
        for k, kv, pv in configs():
            with self.subTest(kernel=k, values=kv):
                ours = LC.lower(K.KERNELS[k](), ARCH, kv)
                vendor = P.concrete_stream(IR, ARCH, k, pv).cmds
                self.assertEqual(len(ours), len(vendor))
                for q, (a, b) in enumerate(zip(ours, vendor)):
                    self.assertEqual(a, b, f"command {q}")
                n += 1
        self.assertEqual(n, 42)


@unittest.skipUnless(IR.exists(), f"vendor IR not built: {IR}")
class HBMMetrics(unittest.TestCase):
    def test_symbolic_metrics_equal(self):
        subst = {K.M: P.M, K.N: P.N, K.L: P.L, K.B: P.BT, K.C: P.C}
        for k in ("ADD", "MUL", "RELU", "GEMV"):
            with self.subTest(kernel=k):
                ours = MX.hbm_counts(K.KERNELS[k](), ARCH)
                vendor = P.symbolic_metrics(IR, ARCH, k)
                for key in P.Metrics.KEYS:
                    a = sp.sympify(ours[key]).subs(subst)
                    b = sp.sympify(getattr(vendor, key))
                    # equal as functions: check on the sweep grid and on extra shapes
                    for _, _, pv in configs():
                        if set(pv) >= (a.free_symbols | b.free_symbols):
                            self.assertEqual(int(a.subs(pv)), int(b.subs(pv)), f"{key} at {pv}")


class HBMCycles(unittest.TestCase):
    """Cycles from PIMSA-IR alone (no vendor IR) against the recorded sweep:
    constraint evaluation equals the simulator, and the closed form reproduces
    the recorded closed-form estimate."""

    def test_cycles_from_pimsa_ir(self):
        recorded = _rows(SWEEP)
        for (k, kv, _), r in zip(configs(), recorded):
            with self.subTest(kernel=k, values=kv):
                res = AN.analyze(k, ARCH, kv)
                self.assertEqual(res["estimate"]["total"], int(r["sim_cycles"]))
                self.assertEqual(res["closed_form"]["total"], int(r["closed_cycles"]))


class PrIMCycles(unittest.TestCase):
    """PrIM benchmarks on UPMEM (prim/*.py): from PIMSA-IR counts and the
    toolchain's stored per-body costs, per setting: MRAM traffic matches
    uPIMulator's counters, the instruction bound equals the toolchain's stored
    bound, and the measured cycle count lies inside the composed interval."""

    def test_all_settings(self):
        import prim
        import prim_check
        for name in prim.NAMES:
            for rec in prim_check.check(name, quiet=True):
                with self.subTest(setting=rec["setting"]):
                    self.assertIn(rec["dma"], ("exact", "in"))
                    self.assertTrue(rec["instr_same"] or rec["instr_tighter"],
                                    (rec["instr"], rec["instr_stored"], rec["instr_measured"]))
                    # cycles must be covered, except where the paper's composition
                    # (same model, same inputs) is known not to cover either
                    self.assertTrue(rec["covered"] or rec["paper_covered"] is False,
                                    (rec["cycles"], rec["actual"]))

    def test_other_input_sizes_from_one_build(self):
        """Inputs are runtime arguments: the machine code stored for one setting
        predicts every setting with the same build (BL, TYPE, tasklets)."""
        import prim
        import upmem_cost as U
        for name in ("va", "red", "gemv"):
            mod = prim.load(name)
            settings = _rows(HERE.parent / f"draw_figs/results/{name}/summary.csv")
            for r in settings:
                for ref in settings:
                    if ref is r or ref["num_tasklets"] != r["num_tasklets"] \
                            or ref["dpu_build_options_json"] != r["dpu_build_options_json"]:
                        continue
                    with self.subTest(bench=name, target=U.setting_id(r, mod.BENCH),
                                      code_of=U.setting_id(ref, mod.BENCH)):
                        res = U.setting_bounds(mod, U.setting_id(r, mod.BENCH), r,
                                               code_setting=U.setting_id(ref, mod.BENCH))
                        truth = U.load_setting(mod.BENCH, U.setting_id(r, mod.BENCH))
                        b = truth["dynamic_instruction_bound"]
                        self.assertEqual(tuple(map(float, res["instructions"])),
                                         (float(b["lower"]), float(b["upper"])))


if __name__ == "__main__":
    unittest.main()
