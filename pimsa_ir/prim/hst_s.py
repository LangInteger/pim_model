"""PrIM HST-S: histogram, one private WRAM histogram per tasklet. Source: PrIM/HST-S/dpu/task.c.

Per tasklet: zero its histogram (bins words), stream BS-byte blocks of the
input and bin them (`histogram`, a noinline callee: its j loop over the block
is the callee's, so here it is one statement over the cached block). After a
barrier, tasklet t sums bin i = t, t+NT, ... over the NT histograms into the
histogram of tasklet 0 (message[0]); after another barrier, tasklet 0 writes
the result to MRAM, in one DMA when bins*4 <= 2048 B, else in 2048 B pieces.

Two statements have no machine loop of their own, and the IR says why:
  - `for i < bins: histo[i] = 0` (line 70) is a unit-stride fill, i.e. the
    slice assignment histo[0:bins] <- 0 (dpu-clang emits it as one memset);
  - the j loop over NR_TASKLETS (line 96) has a compile-time trip count and is
    fully unrolled. With NR_TASKLETS = 1 the whole merge is
    histo_dpu[i] = message[0][i] = histo[i], a copy of the array onto itself,
    and the compiler removes it: the IR guards the merge loop with NT > 1.
"""
import sympy as sp

from prim.common import (NT, SIZE, Array, Assign, Barrier, For, If, Kernel, ParFor, Ref,
                         blocks_loop, build_values, idx, l_size, t)

BENCH = "HST-S"
SRC = "PrIM/HST-S/dpu/task.c"


BINS, TSIZE = sp.symbols("bins transfer_size", integer=True, positive=True)
i, j, off = sp.symbols("i j off", integer=True, nonnegative=True)


def main_kernel1():
    A = Array("A", "M", 4, 0)
    Hm = Array("histo_mram", "M", 4, TSIZE)
    cache = Array("cache_A", "B", 4)
    histo = Array("histo", "B", 4)  # message[t] = histo of tasklet t
    acc = Array("b", "R", 4)
    th = (("tasklet", t),)
    t0 = (("tasklet", 0),)
    n = l_size() / 4
    init = Assign(Ref(histo, 0, BINS, th), "fill", (), src=SRC + ":70")
    blocks = blocks_loop((Assign(Ref(cache, 0, n, th), "copy", (Ref(A, idx / 4, n),), src=SRC + ":81"),
                          Assign(Ref(histo, 0, BINS, th), "histogram", (Ref(cache, 0, n, th),),
                                 src=SRC + ":84")),
                         SRC + ":75")
    merge = For(i, BINS, (
        For(j, NT, (Assign(Ref(acc, 0, 1), "add", (Ref(acc, 0, 1), Ref(histo, i, 1, (("tasklet", j),))),
                           src=SRC + ":97"),), unrolled=True, src=SRC + ":96"),
        Assign(Ref(histo, i, 1, t0), "copy", (Ref(acc, 0, 1),), src=SRC + ":99")),
        lo=t, step=NT, src=SRC + ":94")
    write = If(sp.Eq(t, 0), (
        If(BINS * 4 <= 2048,
           (Assign(Ref(Hm, 0, BINS), "copy", (Ref(histo, 0, BINS, t0),), src=SRC + ":108"),),
           (For(off, sp.floor(BINS * 4 / 2048),
                (Assign(Ref(Hm, off * 512, 512), "copy", (Ref(histo, off * 512, 512, t0),),
                        src=SRC + ":111"),), src=SRC + ":110"),),
           src=SRC + ":107"),), src=SRC + ":106")
    body = (Barrier(),                       # :52
            init, blocks,
            Barrier(),                       # :90
            If(NT > 1, (merge,), static=True, src=SRC + ":94"),
            Barrier(),                       # :103
            write)
    return Kernel("HST-S", (SIZE, BINS, TSIZE), (NT,), (A, Hm, cache, histo, acc),
                  (ParFor(t, NT, body, src=SRC + ":43"),), src=SRC + ":43")


FUNCTIONS = {"main_kernel1": main_kernel1}


def values(params, build, nt):
    return {**build_values(build, nt), SIZE: params["size"], BINS: params["bins"],
            TSIZE: params["transfer_size"]}
