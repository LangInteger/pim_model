"""PrIM SEL: keep the elements that fail pred (odd values). Source: PrIM/SEL/dpu/task.c.

Per tasklet: BS-byte blocks are read (line 100); select() (line 24, unrolled
over REGS = BS/8 elements, a callee whose per-call bound the toolchain stores)
compacts the kept elements into cache_B and returns their count l_count;
handshake_sync (line 37, a stored callee) passes the running prefix count to
the next tasklet; after the barrier (line 109) the l_count kept elements are
written at the global prefix offset (line 112).

Data-dependent quantity: `sel` = l_count, elements kept per block, in
1..REGS (REGS = BS/8). select() grows pos by one per kept element, so
l_count <= REGS. The source would issue a 0-byte mram_write for a block with
no kept element, but the UPMEM SDK requires DMA sizes of at least 8 B, so a
valid run keeps at least one element per block: the lower end is 1 (the same
assumption as the paper's memory adapter). The count is taken equal for all
blocks; DMA bytes grow monotonically with every block's count, so the uniform
extremes bound the total. With a uniform count, the write offset
message_partial_count + p_count equals sel times the number of earlier blocks,
idx/BS."""
import sympy as sp

from prim.common import (BS, E, NT, SIZE, Array, Assign, Barrier, Kernel, ParFor, Ref,
                         blocks_loop, build_values, idx, t)

BENCH = "SEL"
SRC = "PrIM/SEL/dpu/task.c"

SEL = sp.Symbol("sel", integer=True, nonnegative=True)


def main_kernel1():
    A = Array("A", "M", E, 0)
    Bm = Array("Bm", "M", E, SIZE)
    cA, cB = Array("cache_A", "B", E), Array("cache_B", "B", E)
    regs = BS / E
    n_out = SEL
    th = (("tasklet", t),)
    body = (Assign(Ref(cA, 0, regs, th), "copy", (Ref(A, idx / E, regs),), src=SRC + ":100"),
            Assign(Ref(cB, 0, n_out, th), "select", (Ref(cA, 0, regs, th),), src=SRC + ":103"),
            Barrier(),  # line 109
            Assign(Ref(Bm, (idx / BS) * n_out, n_out), "copy", (Ref(cB, 0, n_out, th),),
                   src=SRC + ":112"))
    return Kernel("SEL", (SIZE,), (NT,), (A, Bm, cA, cB),
                  (ParFor(t, NT, (Barrier(),  # line 76
                                  Barrier(),  # line 95
                                  blocks_loop(body, SRC + ":97")), src=SRC + ":67"),),
                  src=SRC + ":67", unknowns={SEL: (1, BS / E)})


FUNCTIONS = {"main_kernel1": main_kernel1}


def values(params, build, nt):
    # T is uint64_t (support/common.h), not a build option
    return {**build_values(build, nt, default_type="UINT64", default_bl=8), E: 8,
            SIZE: params["size"]}
