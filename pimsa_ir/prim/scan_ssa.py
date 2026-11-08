"""PrIM SCAN-SSA (scan-scan-add). Source: PrIM/SCAN-SSA/dpu/task.c.

main_kernel1: each tasklet streams BS-byte blocks of A (block index
t, t+NT, ...); per block it scans the block into cache_B (`scan`, unrolled
over REGS), passes its running total to the next tasklet (`handshake_sync`,
an expanded callee whose per-call cost the toolchain stores per tasklet),
waits at the loop barrier, adds the carried prefix (`add_`, unrolled) and
writes the block to B. Every DMA moves a full BS block (no tail handling in
the source). main_kernel2 adds the DPU's prefix t_count to every block of B
in place. The host's t_count argument only changes data, not control flow.

The two `if (tasklet_id == NR_TASKLETS - 1)` branches (lines 99, 125) touch
only WRAM scalars; they are kept as If nodes for fidelity."""
import sympy as sp

from prim.common import (BS, E, NT, SIZE, Array, Assign, Barrier, For, If, Kernel, ParFor, Ref,
                         build_values, idx, t)

BENCH = "SCAN-SSA"
SRC = "PrIM/SCAN-SSA/dpu/task.c"


def scan_kernel(name, src, L):
    """The scan-with-handshake kernel shared by SCAN-SSA main_kernel1 and
    SCAN-RSS main_kernel2. `L` maps statement roles to source lines."""
    A = Array("A", "M", E, 0)
    Bm = Array("B", "M", E, SIZE)
    cA, cB = Array("cache_A", "B", E), Array("cache_B", "B", E)
    msg, mpc = Array("message", "B", E), Array("message_partial_count", "B", E)
    n = BS / E  # REGS: mram_read/mram_write always move BLOCK_SIZE bytes
    th = (("tasklet", t),)
    s = lambda k: f"{src}:{L[k]}"
    last = sp.Eq(t, NT - 1)
    body = (
        Assign(Ref(cA, 0, n, th), "copy", (Ref(A, idx / E, n),), src=s("read")),
        Assign(Ref(cB, 0, n, th), "scan", (Ref(cA, 0, n, th),), src=s("scan")),
        Assign(Ref(msg, t + 1, 1), "add", (Ref(msg, t, 1), Ref(cB, n - 1, 1, th)), src=s("hs")),
        Barrier(),  # s("bar_loop")
        Assign(Ref(cB, 0, n, th), "add", (Ref(cB, 0, n, th), Ref(mpc, 0, 1), Ref(msg, t, 1)), src=s("add")),
        Assign(Ref(Bm, idx / E, n), "copy", (Ref(cB, 0, n, th),), src=s("write")),
        If(last, (Assign(Ref(mpc, 0, 1), "add", (Ref(mpc, 0, 1), Ref(msg, t, 1), Ref(cB, n - 1, 1, th))),),
           src=s("if_last")),
    )
    loop = For(idx, SIZE, body, lo=t * BS, step=BS * NT, src=s("loop"))
    region = (Barrier(),  # s("bar0")
              If(last, (Assign(Ref(mpc, 0, 1), "copy", (Ref(mpc, 0, 1),)),), src=s("init")),
              Barrier(),  # s("bar1")
              loop)
    return Kernel(name, (SIZE,), (NT,), (A, Bm, cA, cB, msg, mpc),
                  (ParFor(t, NT, region, src=s("fn")),), src=s("fn"))


def add_kernel(name, src, L):
    """SCAN-SSA main_kernel2: B[block] += t_count, in place."""
    Bm = Array("B", "M", E, SIZE)
    cA = Array("cache_A", "B", E)
    tc = Array("t_count", "B", E)
    n = BS / E
    th = (("tasklet", t),)
    s = lambda k: f"{src}:{L[k]}"
    body = (Assign(Ref(cA, 0, n, th), "copy", (Ref(Bm, idx / E, n),), src=s("read")),
            Assign(Ref(cA, 0, n, th), "add", (Ref(cA, 0, n, th), Ref(tc, 0, 1)), src=s("add")),
            Assign(Ref(Bm, idx / E, n), "copy", (Ref(cA, 0, n, th),), src=s("write")))
    loop = For(idx, SIZE, body, lo=t * BS, step=BS * NT, src=s("loop"))
    return Kernel(name, (SIZE,), (NT,), (Bm, cA, tc),
                  (ParFor(t, NT, (Barrier(), loop), src=s("fn")),), src=s("fn"))


def main_kernel1():
    return scan_kernel("SCAN-SSA.main_kernel1", SRC,
                       {"fn": 73, "bar0": 83, "init": 99, "bar1": 102, "loop": 104, "read": 107,
                        "scan": 110, "hs": 113, "bar_loop": 116, "add": 119, "write": 122,
                        "if_last": 125})


def main_kernel2():
    return add_kernel("SCAN-SSA.main_kernel2", SRC,
                      {"fn": 136, "bar0": 145, "loop": 158, "read": 161, "add": 164, "write": 167})


FUNCTIONS = {"main_kernel1": main_kernel1, "main_kernel2": main_kernel2}


def values(params, build, nt):
    return {**build_values(build, nt), SIZE: params["size"]}
