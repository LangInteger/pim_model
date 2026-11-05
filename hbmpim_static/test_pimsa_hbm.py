"""Tests for the PIMSA HBM-PIM analyzer.

The synthetic-IR tests need nothing but sympy. The closed-form tests run on
real PIMSA-IR of Samsung PIMSimulator's PIMKernel when PIMSA_HBM_IR points to
it (produced by run_frontend.sh); otherwise they are skipped.

    PIMSA_HBM_IR=build/ir.json ../.venv/bin/python -m unittest -v test_pimsa_hbm
"""
import json
import os
import unittest
from pathlib import Path

import sympy as sp

import pimsa_hbm as P

ARCH = json.loads((P.HERE / "arch" / "hbm2_pim.json").read_text())


def c(v):
    return {"c": v}


def s(name):
    return {"s": name}


def addr(row, col, bank=c(0)):
    return {"fn": "addrGenSafe", "obj": s("pim_addr_mgr_"),
            "args": [s("ch"), c(0), c(0), bank, row, col]}


def rd(row=c(0), col=c(0), bank=c(0)):
    return [{"k": "let", "var": "a", "val": addr(row, col, bank)},
            {"k": "event", "op": "addTransaction", "args": [c(0), s("a")]}]


def wr(row=c(0), col=c(0)):
    return [{"k": "let", "var": "a", "val": addr(row, col)},
            {"k": "event", "op": "addTransaction", "args": [c(1), s("a")]}]


def bar():
    return [{"k": "event", "op": "addBarrier", "args": [s("ch")]}]


def loop(var, hi, body, step=1, lo=0, op="<"):
    return {"k": "for", "init": [{"k": "let", "var": var, "val": c(lo)}],
            "cond": {"op": op, "a": s(var), "b": hi},
            "inc": [{"k": "assign", "var": var, "op": "+=", "val": c(step)}],
            "body": body}


def chans(body):
    return {"k": "forrange", "var": "ch", "range": s("pim_chans_"), "body": body}


def run(body, bind=None, concrete=False, chans_val=None):
    it = P.Interp(ARCH, bind or {}, chans_val if chans_val is not None else P.C, concrete)
    return it, it.run(body, {})


class SymbolicRules(unittest.TestCase):
    def test_loop_scales_and_pu_loop_does_not(self):
        n = sp.Symbol("n", integer=True, positive=True)
        body = [loop("i", s("n"), [chans(rd() + bar())])]
        _, m = run(body, {"n": n})
        self.assertEqual(sp.simplify(m.rd - n), 0)  # per PU: not multiplied by C
        self.assertEqual(sp.simplify(m.bar - n), 0)

    def test_strided_loops_cover_even_and_odd_iterations(self):
        n = sp.Symbol("n", integer=True, positive=True)
        body = [loop("i", s("n"), [chans(rd())], step=2),
                loop("i", s("n"), [chans(wr())], step=2, lo=1)]
        _, m = run(body, {"n": n})
        for k in range(1, 12):
            self.assertEqual(int((m.rd + m.wr).subs(n, k)), k)

    def test_decidable_branch_is_resolved_and_undecidable_takes_max(self):
        body = [{"k": "if", "cond": s("flag"), "then": [chans(rd() + rd())], "else": [chans(rd())]}]
        _, m = run(body, {"flag": 0})
        self.assertEqual(m.rd, 1)
        x = sp.Symbol("x")
        _, m = run(body, {"flag": sp.Gt(x, 0)})
        self.assertEqual(m.rd, 2)
        self.assertTrue(any("component-wise max" in n for n in m.notes))

    def test_call_binds_actual_arguments(self):
        n = sp.Symbol("n", integer=True, positive=True)
        callee = {"k": "call", "fn": "f", "params": ["k"], "args": [{"op": "*", "a": c(2), "b": s("n")}],
                  "body": [loop("i", s("k"), [chans(wr())])]}
        _, m = run([callee], {"n": n})
        self.assertEqual(sp.simplify(m.wr - 2 * n), 0)

    def test_leading_break_guard_gives_exact_trip(self):
        guard = {"k": "if", "cond": {"op": ">=", "a": {"op": "*", "a": s("i"), "b": c(8)}, "b": c(6)},
                 "then": [{"k": "break"}], "else": []}
        _, m = run([loop("i", c(4), [guard, chans(wr())])])
        self.assertEqual(m.wr, 1)

    def test_concrete_pass_agrees_and_normalizes_columns(self):
        # 40 consecutive columns from col 0: crosses one row (32 columns/row).
        body = [chans([{"k": "let", "var": "r", "val": c(5)}, {"k": "let", "var": "col", "val": c(0)},
                       loop("i", c(40), rd(s("r"), s("col")) +
                            [{"k": "assign", "var": "col", "op": "+=", "val": c(1)}])])]
        it, _ = run(body, concrete=True, chans_val=sp.Integer(4))
        self.assertEqual(it.counts["rd"], 40)
        rows = [r for g in it.groups for _, r in g]
        self.assertEqual(rows[31], 5)
        self.assertEqual(rows[32], 6)


class RowPolicy(unittest.TestCase):
    def test_cold_vs_conflict(self):
        b0, b1 = (0, 0, 0), (0, 0, 1)
        # g1 opens b0:r1; g2 does not reuse b0 -> closed early; g3 b0:r2 is cold.
        r = P.row_misses([[(b0, 1)], [(b1, 7)], [(b0, 2)]])
        self.assertEqual((r["cold"], r["conflict"]), (3, 0))
        # Row change on a bank kept open inside one group -> conflict.
        r = P.row_misses([[(b0, 1), (b0, 2)]])
        self.assertEqual((r["cold"], r["conflict"]), (1, 1))
        # Reuse in the next group keeps the row open -> hit.
        r = P.row_misses([[(b0, 1)], [(b0, 1)]])
        self.assertEqual((r["cold"], r["conflict"]), (1, 0))


class CostModel(unittest.TestCase):
    def test_terms(self):
        t = P.cost(ARCH, rd=10, wr=2, cold=3, conflict=1, r2w=1, w2r=1)
        self.assertEqual(t["T_buf"], 12 * 4)
        self.assertEqual(t["T_row"], 1 * (14 + 14) + 3 * 14)
        # R->W: RL + BL/2 + tRTRS - WL = 15; W->R: WL + BL/2 + tWTR_L = 19; minus tCCD_L.
        self.assertEqual(t["T_turn"], (15 - 4) + (19 - 4))
        self.assertEqual(t["n_ref"], 0)

    def test_refresh_fixed_point(self):
        t = P.cost(ARCH, rd=2000, wr=0, cold=0, conflict=0)
        self.assertEqual(t["n_ref"], 2)  # 8000 -> 8700 cycles, 2 refreshes
        self.assertEqual(t["total"], 8000 + 2 * 350)


IR = os.environ.get("PIMSA_HBM_IR")


@unittest.skipUnless(IR and Path(IR).exists(), "set PIMSA_HBM_IR to PIMKernel PIMSA-IR")
class PIMKernelClosedForms(unittest.TestCase):
    """Closed forms of the per-channel command counts, checked on a grid."""

    def check(self, kernel, expect, grid):
        m = P.symbolic_metrics(Path(IR), ARCH, kernel)
        for vals in grid:
            for k, f in expect.items():
                self.assertEqual(int(getattr(m, k).subs(vals)), f(vals), (kernel, k, vals))

    def test_gemv(self):
        def n_in(v): return -(-v[P.N] // 128)
        def n_out(v): return -(-v[P.M] // (64 * v[P.C]))
        self.check("GEMV", {
            "rd": lambda v: 64 * v[P.BT] * n_in(v) * n_out(v) + 32,
            "wr": lambda v: v[P.BT] * n_out(v) * (8 * n_in(v) + 10) + 7,
            "bar": lambda v: v[P.BT] * n_out(v) * (9 * n_in(v) + 3) + 6,
        }, [{P.M: m, P.N: n, P.BT: b, P.C: ch}
            for m in (512, 1000, 4096) for n in (128, 1000, 4096)
            for b in (1, 3) for ch in (1, 16, 64)])

    def test_eltwise(self):
        def n_t(v): return (v[P.BT] * -(-v[P.L] // 16)) // (128 * v[P.C])
        grid = [{P.L: l, P.BT: b, P.C: ch}
                for l in (1 << 18, 1 << 20, 3 << 20) for b in (1, 2) for ch in (4, 64)]
        for k in ("ADD", "MUL"):
            self.check(k, {"rd": lambda v: 32 * n_t(v) + 32,
                           "wr": lambda v: 16 * n_t(v) + 9,
                           "bar": lambda v: 6 * n_t(v) + 8}, grid)
        self.check("RELU", {"rd": lambda v: 16 * n_t(v) + 32,
                            "wr": lambda v: 16 * n_t(v) + 9,
                            "bar": lambda v: 4 * n_t(v) + 8}, grid)


if __name__ == "__main__":
    unittest.main()
