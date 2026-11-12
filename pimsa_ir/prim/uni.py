"""PrIM UNI: drop consecutive duplicates. Source: PrIM/UNI/dpu/task.c.

Per tasklet: BS-byte blocks are read (line 116); unique() (line 27, unrolled
over REGS = BS/8 elements, a callee whose per-call bound the toolchain stores)
compacts the block into cache_B and returns l_count; handshake_sync (line 42,
a stored callee) passes prefix count, last value and duplicate offset to the
next tasklet; l_count elements starting at cache_B[po_count.z] are written at
the global prefix offset (line 125); the loop ends with a barrier (line 141).

Data-dependent quantity: `uni` = l_count, elements written per block. From
unique(): output[0] is always written and pos grows by at most one for each
of the other REGS-1 elements, so 1 <= l_count <= REGS (the paper's adapter
uses the same 1..REGS). It is taken equal for all blocks; DMA bytes grow
monotonically with every block's count, so the uniform extremes bound the
total. The symbol ranges over 1..256 (REGS <= 256 because a single mram_read
moves at most 2048 B) and the written count is Min(uni, REGS). This form dates
from when Kernel.unknowns took numeric ranges only; ranges may now depend on
the build (metrics.extremes, e.g. SEL's (1, BS/E)), and (1, REGS) directly
would give the same counts.
The write offset (message_partial_count + x - y) depends on the data beyond
l_count (duplicates across block boundaries); it does not affect the counts
and is written with the uniform count, uni times the earlier blocks."""
import sympy as sp

from prim.common import (BS, E, NT, SIZE, Array, Assign, Barrier, Kernel, ParFor, Ref,
                         blocks_loop, build_values, idx, t)

BENCH = "UNI"
SRC = "PrIM/UNI/dpu/task.c"

UNI = sp.Symbol("uni", integer=True, positive=True)
REGS_MAX = 2048 // 8  # mram_read transfers at most 2048 B per call


def main_kernel1():
    A = Array("A", "M", E, 0)
    Bm = Array("Bm", "M", E, SIZE)
    cA, cB = Array("cache_A", "B", E), Array("cache_B", "B", E)
    regs = BS / E
    n_out = sp.Min(UNI, regs)
    th = (("tasklet", t),)
    body = (Assign(Ref(cA, 0, regs, th), "copy", (Ref(A, idx / E, regs),), src=SRC + ":116"),
            Assign(Ref(cB, 0, n_out, th), "unique", (Ref(cA, 0, regs, th),), src=SRC + ":119"),
            Assign(Ref(Bm, (idx / BS) * n_out, n_out), "copy", (Ref(cB, 0, n_out, th),),
                   src=SRC + ":125"),
            Barrier())  # line 141
    return Kernel("UNI", (SIZE,), (NT,), (A, Bm, cA, cB),
                  (ParFor(t, NT, (Barrier(),  # line 89
                                  Barrier(),  # line 110
                                  blocks_loop(body, SRC + ":113")), src=SRC + ":80"),),
                  src=SRC + ":80", unknowns={UNI: (1, REGS_MAX)})


FUNCTIONS = {"main_kernel1": main_kernel1}


def values(params, build, nt):
    # T is int64_t (support/common.h), not a build option
    return {**build_values(build, nt, default_type="INT64", default_bl=8), E: 8,
            SIZE: params["size"]}
