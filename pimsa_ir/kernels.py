"""PIMSA-IR programs, one per kernel, written against the unified IR.

HBM-PIM kernels follow Samsung PIMSimulator's host-side command generators
(PIMKernel::executeEltwise / computeAddOrMul / computeRelu / executeGemv /
computeGemv, src/tests/PIMKernel.cpp). The UPMEM programs (PrIM) are in
prim/. The programs are written by hand from that source,
statement for statement, and checked mechanically: the HBM-PIM command stream
lowered from each program must equal, command for command, the stream the
vendor generator produces (test_unified_ir.py).

What a program contains: the data layout (array placement, which bank and
offset each slice lives at), the loop structure and the barriers the source
places. What it does not contain: anything about how the target realizes a
statement (DRAM command encoding, broadcast, mode switching, CRF code), which
comes from the architecture instance.

Symbols:
  application  L (elements), M, N (matrix), B (batch)
  deployment   C (PUs: HBM-PIM pseudo-channels)
  architecture P (PIM blocks per PU), NB (banks per block), G (registers per
               GRF file), W (SIMD lanes)
"""
from __future__ import annotations

import sympy as sp

import archinfo as A
from ir import Array, Assign, Barrier, For, Kernel, ParFor, Ref

L, M, N, B, C = sp.symbols("L M N B C", integer=True, positive=True)
P, NB, G, W = sp.symbols("P NB G W", integer=True, positive=True)
i, b, j, bt, i2, c, blk = sp.symbols("i b j bt i2 c blk", integer=True, nonnegative=True)

ROW = 32 * 32  # bytes per DRAM row of one bank (32 bursts of 32 B); used only to place arrays
PIMK = "Samsung_PIMSimulator/src/tests/PIMKernel.cpp"


def arch_values(arch: dict) -> dict:
    """Architecture symbols that programs use, from the architecture instance."""
    if A.issuer(arch) == "controller":  # HBM-PIM: R = 2 register files of G entries
        return {P: A.pus_per_region(arch), NB: A.banks_per_pu(arch), G: arch["P"]["R"]["value"] // 2,
                W: arch["P"]["W"]["value"]}
    return {W: arch["P"]["W"]["value"]}  # UPMEM (prim/): BS and E come from the build


# ----------------------------------------------------------------------------
# HBM-PIM element-wise kernels (executeEltwise). Per PU, n_t tiles; each tile
# is G bursts of W fp16 lanes in each bank of the block's bank pair.
# ----------------------------------------------------------------------------
def _grf(f):  # GRF file f (0 = GRF_A, 1 = GRF_B), all G entries
    return Ref(GRF, 0, G * W, (("file", f),))


GRF = Array("grf", "R", 2)


def _eltwise(name, op):
    A = Array("A", "M", 2, 0 * ROW)
    Bv = Array("Bv", "M", 2, 128 * ROW)
    Cv = Array("Cv", "M", 2, 256 * ROW)
    n_t = sp.floor(B * sp.ceiling(L / W) / (C * P * NB * G))
    tile = lambda arr: Ref(arr, i * G * W, G * W, (("bank", b),))
    body = (Assign(_grf(b), "copy", (tile(A),)), Barrier(),
            Assign(_grf(b), op, (_grf(b), tile(Bv))), Barrier(),
            Assign(tile(Cv), "copy", (_grf(b),)), Barrier())
    return Kernel(name, (L, B), (C,), (A, Bv, Cv, GRF),
                  (ParFor(blk, P, (For(i, n_t, (For(b, NB, body, src=PIMK + ":533"),),
                                       src=PIMK + ":530"),), src=PIMK + ":512"),),
                  src=PIMK + ":499", lets={"n_t": n_t})


def relu():
    A = Array("A", "M", 2, 0 * ROW)
    Cv = Array("Cv", "M", 2, 256 * ROW)
    n_t = sp.floor(B * sp.ceiling(L / W) / (C * P * NB * G))
    tile = lambda arr: Ref(arr, i * G * W, G * W, (("bank", b),))
    body = (Assign(_grf(b), "relu", (tile(A),)), Barrier(),
            Assign(tile(Cv), "copy", (_grf(b),)), Barrier())
    return Kernel("RELU", (L, B), (C,), (A, Cv, GRF),
                  (ParFor(blk, P, (For(i, n_t, (For(b, NB, body),), src=PIMK + ":576"),),
                          src=PIMK + ":512"),),
                  src=PIMK + ":499", lets={"n_t": n_t})


# ----------------------------------------------------------------------------
# HBM-PIM GEMV (executeGemv, non-tree). Output tiles of G*P*C rows; input tiles
# of G*W elements, even tiles in the even bank and odd tiles in the odd bank.
# For each output tile and batch item the block program runs once (one
# parallel region): load the input tile into GRF_A from the host, G MACs over
# G weight bursts each, then write GRF_B back.
# ----------------------------------------------------------------------------
def gemv():
    Wt = Array("Wt", "M", 2, 0)
    Y = Array("Y", "M", 2, 0)
    X = Array("x", "H", 2)
    n_in = sp.ceiling(N / (G * W))
    n_out = sp.ceiling(M / (P * C) / G)
    half = sp.floor(n_in / 2)

    def tiles(parity, count):
        ii = 2 * i2 + parity  # input tile index
        load = Assign(_grf(0), "copy", (Ref(X, (bt * n_in + ii) * G * W, G * W),))
        w_off = (G * G * (i2 + j * half) + c * G) * W
        mac = Assign(_grf(1), "mac", (_grf(1), Ref(Wt, w_off, G * W, (("bank", parity),)), _grf(0)))
        return For(i2, count, (load, Barrier(), For(c, G, (mac, Barrier()), src=PIMK + ":468")),
                   src=PIMK + (":429" if parity == 0 else ":432"))

    y_off = (sp.floor(n_out * n_in / 2) * G * G + (j + bt) * G) * W
    store = Assign(Ref(Y, y_off, G * W, (("bank", 1),)), "copy", (_grf(1),))
    region = ParFor(blk, P, (tiles(0, sp.ceiling(n_in / 2)), tiles(1, half), store, Barrier()),
                    src=PIMK + ":411")
    return Kernel("GEMV", (M, N, B), (C,), (Wt, Y, X, GRF),
                  (For(j, n_out, (For(bt, B, (region,), src=PIMK + ":409"),), src=PIMK + ":407"),),
                  src=PIMK + ":364", lets={"n_in": n_in, "n_out": n_out})


KERNELS = {
    "ADD": lambda: _eltwise("ADD", "add"),
    "MUL": lambda: _eltwise("MUL", "mul"),
    "RELU": relu,
    "GEMV": gemv,
}
