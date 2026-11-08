"""PrIM GEMV: y = A x, rows split over tasklets in pairs. Source: PrIM/GEMV/dpu/task.c.

Per tasklet: rows [start_row, start_row + rows_per_tasklet) in steps of two;
for each row (pos), BS-byte blocks of the row and of x are read, multiplied
(gemv) and accumulated; the last partial block is handled by a bounded loop
(j). When the row start is not 8-byte aligned (`offset`), the cached block is
shifted by one element and one 8-byte word is read extra. `offset` is the
program's state carried from the previous row; it is written here as the
expression it equals: the current row starts unaligned and is not the
tasklet's first row. The two result words are written once per row pair."""
import sympy as sp

from prim.common import BS, E, NT, Array, Assign, Barrier, For, If, Kernel, ParFor, Ref, build_values, t

BENCH = "GEMV"
SRC = "PrIM/GEMV/dpu/task.c"

N_SIZE, N_PAD, NR_ROWS, MAX_ROWS = sp.symbols("n_size n_size_pad nr_rows max_rows",
                                              integer=True, positive=True)
i, pos, n, off, j = sp.symbols("i pos n off j", integer=True, nonnegative=True)


def _rows():
    chunks = sp.floor(NR_ROWS / (2 * NT))
    dbl = 2 * chunks
    rest = sp.Mod(NR_ROWS, 2 * NT)
    h = sp.floor(rest / 2)
    rows = dbl + sp.Piecewise((2, 2 * t < rest), (0, True))
    start = sp.Piecewise(
        (t * (dbl + 2), sp.And(rest > 0, 2 * t < rest)),
        ((h + 1) * (dbl + 2) + (t - 1 - h) * dbl, sp.And(rest > 0, sp.Eq(sp.Mod(rest, 2), 1))),
        (h * (dbl + 2) + (t - h) * dbl, rest > 0),
        (t * dbl, True))
    return start, rows


def main():
    A = Array("A", "M", E, 0)
    X = Array("x", "M", E, MAX_ROWS * N_PAD * E)
    Y = Array("y", "M", E, MAX_ROWS * N_PAD * E + N_PAD * E)
    cA, cAux, cB, cC = (Array(nm, "B", E) for nm in ("cache_A", "cache_A_aux", "cache_B", "cache_C"))
    start, rows = _rows()
    blk = BS / E  # elements per block
    row = i + pos
    a0 = row * N_SIZE  # row start, in elements
    offset = sp.And(sp.Ne(row, start), sp.Ne(sp.Mod(a0 * E, 8), 0))
    n_iters = sp.Max(0, sp.ceiling((N_SIZE - blk) / blk))
    n_end = n_iters * blk
    shift = For(off, blk - 1, (Assign(Ref(cA, off, 1), "copy", (Ref(cA, off + 1, 1),)),), src=SRC + ":103")
    shift2 = For(off, blk - 1, (Assign(Ref(cA, off, 1), "copy", (Ref(cA, off + 1, 1),)),), src=SRC + ":126")
    aux = lambda a: Assign(Ref(cAux, 0, 8 / E), "copy", (Ref(A, a + blk, 8 / E),))
    n_body = (Assign(Ref(cA, 0, blk), "copy", (Ref(A, a0 + n, blk),)),
              Assign(Ref(cB, 0, blk), "copy", (Ref(X, n, blk),)),
              If(offset, (shift, aux(a0 + n))),
              Assign(Ref(cC, pos, 1), "mac", (Ref(cC, pos, 1), Ref(cA, 0, blk), Ref(cB, 0, blk)),
                     src=SRC + ":19"))
    tail = (Assign(Ref(cA, 0, blk), "copy", (Ref(A, a0 + n_end, blk),)),
            If(offset, (shift2, aux(a0 + n_end))),
            Assign(Ref(cB, 0, blk), "copy", (Ref(X, n_end, blk),)),
            For(j, sp.Min(blk, sp.Max(0, N_SIZE - n_end)),
                (Assign(Ref(cC, pos, 1), "mac", (Ref(cC, pos, 1), Ref(cA, j, 1), Ref(cB, j, 1))),),
                src=SRC + ":140"))
    pos_loop = For(pos, sp.Min(2, sp.Max(0, NR_ROWS - i)),
                   (For(n, N_SIZE - blk, n_body, step=blk, src=SRC + ":94"),) + tail, src=SRC + ":92")
    i_loop = For(i, start + rows, (pos_loop, Assign(Ref(Y, i, 8 / E), "copy", (Ref(cC, 0, 8 / E),))),
                 lo=start, step=2, src=SRC + ":85")
    return Kernel("GEMV", (N_SIZE, NR_ROWS), (NT,), (A, X, Y, cA, cAux, cB, cC),
                  (ParFor(t, NT, (Barrier(), i_loop), src=SRC + ":29"),), src=SRC + ":29")


FUNCTIONS = {"main": main}


def values(params, build, nt):
    return {**build_values(build, nt), N_SIZE: params["n_size"], N_PAD: params["n_size_pad"],
            NR_ROWS: params["nr_rows"], MAX_ROWS: params["max_rows"]}
