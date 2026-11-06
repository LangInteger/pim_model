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

    def test_boundary_classification_by_row(self):
        pr = ARCH["M"]["pim_rows"]
        cl = lambda w, r: P.classify(ARCH, w, r)
        self.assertEqual(cl(False, 0), "bank2pu")
        self.assertEqual(cl(True, 256), "pu2bank")
        self.assertEqual(cl(True, pr["register_row"]["value"]), "host2pu")
        self.assertEqual(cl(False, pr["register_row"]["value"]), "pu2host")
        self.assertEqual(cl(False, pr["park_row"]["value"]), "mode_rd")
        self.assertEqual(cl(True, pr["abmr_row"]["value"]), "mode_wr")
        self.assertIsNone(cl(False, sp.Symbol("r")))

    def test_cost_terms_partition_the_total(self):
        by = {"tCCD_L": 40, "tRCD_RD": 14, "tRFC": 350, "W2R": 19, "tCMD": 3}
        t = P.cost_terms(by, 450)
        self.assertEqual(t, {"column": 40, "row": 14, "refresh": 350, "turnaround": 19,
                             "issue": 3, "drain": 24})
        with self.assertRaises(AssertionError):
            P.cost_terms({"tFAW": 1}, 1)

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


T = P.timing(ARCH)


def sched(cmds):
    return P.ctl.schedule(cmds, T, 2, 16, 4)


def cmd(w, bank, row, col=0, bar=False):
    return P.ctl.Cmd(w, 0, bank, row, col, bar)


class Controller(unittest.TestCase):
    """Each constraint-table edge, checked on a minimal command stream."""

    def gaps(self, cmds):
        tr = []
        P.ctl.schedule(cmds, T, 2, 16, 4, trace=tr)
        return [(k, w, g) for _, k, _, _, w, g in tr]

    def test_row_open_then_column_stream(self):
        g = self.gaps([cmd(False, 0, 5, c) for c in range(3)])
        self.assertEqual(g[0][:2], ("ACT", "tCMD"))
        self.assertEqual(g[1], ("RD", "tRCD_RD", T["tRCD_RD"]))
        self.assertEqual(g[2], ("RD", "tCCD_L", T["tCCD_L"]))

    def test_same_bank_row_switch_after_read(self):
        # A row read for less than tRAS cannot be closed before ACT + tRAS.
        g = self.gaps([cmd(False, 0, 5, 0, bar=True), cmd(False, 0, 6, 0)])
        self.assertEqual(g[2], ("PRE", "tRAS", T["tRAS"] - T["tRCD_RD"]))
        # Otherwise the second row costs RD->PRE, tRP, tRCD (BAR keeps the order).
        g = self.gaps([cmd(False, 0, 5, c, bar=c == 7) for c in range(8)] + [cmd(False, 0, 6, 0)])
        d = P.ctl.delays(T)
        self.assertEqual([x[1:] for x in g[9:]],
                         [("tRTP", d["READ_TO_PRE"]), ("tRP", T["tRP"]),
                          ("tRCD_RD", T["tRCD_RD"])])

    def test_write_recovery_before_precharge(self):
        g = self.gaps([cmd(True, 0, 5, 0, bar=True), cmd(False, 0, 6, 0)])
        self.assertEqual(g[2][:2], ("PRE", "tWR"))
        self.assertEqual(g[2][2], P.ctl.delays(T)["WRITE_TO_PRE"])

    def test_turnarounds(self):
        d = P.ctl.delays(T)
        g = self.gaps([cmd(False, 0, 5, 0, bar=True), cmd(True, 0, 5, 1, bar=True),
                       cmd(False, 0, 5, 2)])
        self.assertEqual(g[2], ("WR", "R2W", d["READ_TO_WRITE"]))
        self.assertEqual(g[3], ("RD", "W2R", d["WRITE_TO_READ_B_LONG"]))

    def test_completion_and_refresh(self):
        cyc, br, cnt = sched([cmd(False, 0, 5, 0)])
        # ACT at 1, RD at 1 + tRCD, data back tCMD + RL + BL/2 later, +1 for runPIM.
        self.assertEqual(cyc, 1 + T["tRCD_RD"] + T["tCMD"] + T["RL"] + T["BL"] // 2 + 1)
        # Rank 0 is refreshed first at tREFI / NUM_RANKS.
        n = (T["tREFI"] // 2) // T["tCCD_L"] + 10
        cyc, br, cnt = sched([cmd(False, 0, 5, c % 32) for c in range(n)])
        self.assertEqual(cnt["REF"], 1)
        self.assertEqual(br["tRFC"], T["tRFC"])

    def test_all_bank_mode_blocks_high_banks(self):
        enter = [cmd(True, b, P.ctl.ABMR_RA, 0x1F, bar=b == 9) for b in (0, 8, 1, 9)]
        # In all-bank mode ACT to bank >= 2 is refused: a bank-4 access never issues.
        with self.assertRaises(RuntimeError):
            sched(enter + [cmd(False, 4, 3)])
        # Leaving it (PRE of row PIM_SBMR_RA on banks 0 and 1) re-enables bank 4.
        leave = [cmd(True, b, P.ctl.SBMR_RA, 0, bar=True) for b in (0, 1)]
        cyc, br, cnt = sched(enter + leave + [cmd(False, 4, 3)])
        self.assertEqual(cnt["RD"], 1)


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
            # by boundary: MAC reads, GRFB_TO_BANK writes, GRF_A loads + 2 mode
            # words per (tile, batch) + 1 CRF write, 32 park reads, 6 ABMR/SBMR writes
            "bank2pu": lambda v: 64 * v[P.BT] * n_in(v) * n_out(v),
            "pu2bank": lambda v: 8 * v[P.BT] * n_out(v),
            "host2pu": lambda v: v[P.BT] * n_out(v) * (8 * n_in(v) + 2) + 1,
            "pu2host": lambda v: 0,
            "mode_rd": lambda v: 32,
            "mode_wr": lambda v: 6,
        }, [{P.M: m, P.N: n, P.BT: b, P.C: ch}
            for m in (512, 1000, 4096) for n in (128, 1000, 4096)
            for b in (1, 3) for ch in (1, 16, 64)])

    def test_eltwise(self):
        def n_t(v): return (v[P.BT] * -(-v[P.L] // 16)) // (128 * v[P.C])
        grid = [{P.L: l, P.BT: b, P.C: ch}
                for l in (1 << 18, 1 << 20, 3 << 20) for b in (1, 2) for ch in (4, 64)]
        # Operands are preloaded in the banks: host traffic is only the CRF write
        # and the two mode words.
        fixed = {"host2pu": lambda v: 3, "pu2host": lambda v: 0,
                 "mode_rd": lambda v: 32, "mode_wr": lambda v: 6}
        for k in ("ADD", "MUL"):
            self.check(k, {"rd": lambda v: 32 * n_t(v) + 32,
                           "wr": lambda v: 16 * n_t(v) + 9,
                           "bar": lambda v: 6 * n_t(v) + 8,
                           "bank2pu": lambda v: 32 * n_t(v),
                           "pu2bank": lambda v: 16 * n_t(v), **fixed}, grid)
        self.check("RELU", {"rd": lambda v: 16 * n_t(v) + 32,
                            "wr": lambda v: 16 * n_t(v) + 9,
                            "bar": lambda v: 4 * n_t(v) + 8,
                            "bank2pu": lambda v: 16 * n_t(v),
                            "pu2bank": lambda v: 16 * n_t(v), **fixed}, grid)


if __name__ == "__main__":
    unittest.main()
