"""PrIM HST-L: histogram, NR_HISTO shared WRAM histograms updated under a mutex.
Source: PrIM/HST-L/dpu/task.c.

Tasklet t uses histogram h = t mod NR_HISTO, shared with the NT/NR_HISTO
tasklets of its group (l_tasklet_id = t / NR_HISTO). Tasklet 0 resets the heap
and sets up the NR_HISTO group barriers; the first NR_HISTO tasklets allocate
the histograms; each group zeroes its histogram, strided over the group; then
every tasklet streams BS-byte blocks and bins them into its group's histogram
(`histogram`, noinline: each update is mutex_lock / += 1 / mutex_unlock, the
j loop and the lock are the callee's, so here it is one statement). After a
barrier, tasklet t sums bin i = t, t+NT, ... over the NR_HISTO histograms into
histogram 0; after another barrier tasklet 0 writes it to MRAM (one DMA when
bins*4 <= 2048 B, else 2048 B pieces).

Compile-time structure (If(static=True)):
  - the zeroing loop (line 97) has stride nr_l_tasklet = NT / NR_HISTO; with
    stride 1 it is the slice fill histo[0:bins] <- 0 (dpu-clang emits a memset,
    no machine loop), otherwise a strided loop;
  - with NR_HISTO = 1 the merge (line 120) is histo_dpu[i] = message[0][i], a
    copy of histogram 0 onto itself, which the compiler removes;
  - the loops over NR_HISTO (lines 64, 122) have compile-time trip counts and
    are unrolled (verified only for the analyzed NR_HISTO = 1).
Barriers: line 72 and 117/129 wait on all NT tasklets; lines 92 and 101 wait
on the group barrier of histogram h (NT / NR_HISTO tasklets); with NR_HISTO = 1
the group is all tasklets, which is what `Barrier` expresses.
"""
import sympy as sp

from prim.common import (NT, SIZE, Array, Assign, Barrier, For, If, Kernel, ParFor, Ref,
                         blocks_loop, build_values, idx, l_size, t)

BENCH = "HST-L"
SRC = "PrIM/HST-L/dpu/task.c"

NH, BINS, TSIZE = sp.symbols("NR_HISTO bins transfer_size", integer=True, positive=True)
i, j, eb, off = sp.symbols("i j eb off", integer=True, nonnegative=True)


def main_kernel1():
    A = Array("A", "M", 4, 0)
    Hm = Array("histo_mram", "M", 4, TSIZE)
    cache = Array("cache_A", "B", 4)
    histo = Array("histo", "B", 4)  # message[h], h < NR_HISTO
    bar = Array("barriers", "B", 4)
    acc = Array("b", "R", 4)
    th = (("tasklet", t),)
    l_tid, nr_l, h = sp.floor(t / NH), sp.floor(NT / NH), sp.Mod(t, NH)
    mine = (("histo", h),)
    h0 = (("histo", 0),)
    n = l_size() / 4
    setup = If(sp.Eq(t, 0), (
        For(eb, NH, (Assign(Ref(bar, eb, 1), "copy", (), src=SRC + ":65"),), unrolled=True,
            src=SRC + ":64"),), src=SRC + ":61")
    init = If(sp.Eq(nr_l, 1),
              (Assign(Ref(histo, 0, BINS, mine), "fill", (), src=SRC + ":98"),),
              (For(i, BINS, (Assign(Ref(histo, i, 1, mine), "fill", (), src=SRC + ":98"),),
                         lo=l_tid, step=nr_l, src=SRC + ":97"),), static=True, src=SRC + ":97")
    blocks = blocks_loop((Assign(Ref(cache, 0, n, th), "copy", (Ref(A, idx / 4, n),), src=SRC + ":110"),
                          Assign(Ref(histo, 0, BINS, mine), "histogram", (Ref(cache, 0, n, th),),
                                 src=SRC + ":113")),
                         SRC + ":104")
    merge = For(i, BINS, (
        For(j, NH, (Assign(Ref(acc, 0, 1), "add", (Ref(acc, 0, 1), Ref(histo, i, 1, (("histo", j),))),
                           src=SRC + ":123"),), unrolled=True, src=SRC + ":122"),
        Assign(Ref(histo, i, 1, h0), "copy", (Ref(acc, 0, 1),), src=SRC + ":125")),
        lo=t, step=NT, src=SRC + ":120")
    write = If(sp.Eq(t, 0), (
        If(BINS * 4 <= 2048,
           (Assign(Ref(Hm, 0, BINS), "copy", (Ref(histo, 0, BINS, h0),), src=SRC + ":134"),),
           (For(off, sp.floor(BINS * 4 / 2048),
                (Assign(Ref(Hm, off * 512, 512), "copy", (Ref(histo, off * 512, 512, h0),),
                        src=SRC + ":137"),), src=SRC + ":136"),),
           src=SRC + ":133"),), src=SRC + ":132")
    body = (setup,
            Barrier(),                       # :72  my_barrier
            Barrier(),                       # :92  barriers[my_histo_id]
            init,
            Barrier(),                       # :101 barriers[my_histo_id]
            blocks,
            Barrier(),                       # :117 my_barrier
            If(NH > 1, (merge,), static=True, src=SRC + ":120"),
            Barrier(),                       # :129 my_barrier
            write)
    return Kernel("HST-L", (SIZE, BINS, TSIZE), (NT, NH), (A, Hm, cache, histo, bar, acc),
                  (ParFor(t, NT, body, src=SRC + ":52"),), src=SRC + ":52")


FUNCTIONS = {"main_kernel1": main_kernel1}


def values(params, build, nt):
    return {**build_values(build, nt), NH: int(build["NR_HISTO"]), SIZE: params["size"],
            BINS: params["bins"], TSIZE: params["transfer_size"]}
