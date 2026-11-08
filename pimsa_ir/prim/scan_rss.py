"""PrIM SCAN-RSS (reduce-scan-scan). Source: PrIM/SCAN-RSS/dpu/task.c.

main_kernel1: each tasklet streams BS-byte blocks of A and reduces each one
(`reduction`, unrolled over REGS) into its local count; after the barrier,
tasklet 0 sums the NT local counts (loop at line 123, unrolled by the
compiler; WRAM only). main_kernel2 is the same scan-with-handshake kernel as
SCAN-SSA main_kernel1 (see prim.scan_ssa.scan_kernel), at its own source
lines. Every DMA moves a full BS block."""
import sympy as sp

from prim.common import (BS, E, NT, SIZE, Array, Assign, Barrier, For, If, Kernel, ParFor, Ref,
                         build_values, idx, k, t)
from prim.scan_ssa import scan_kernel

BENCH = "SCAN-RSS"
SRC = "PrIM/SCAN-RSS/dpu/task.c"


def main_kernel1():
    A = Array("A", "M", E, 0)
    cA = Array("cache_A", "B", E)
    msg = Array("message", "B", E)
    n = BS / E
    th = (("tasklet", t),)
    body = (Assign(Ref(cA, 0, n, th), "copy", (Ref(A, idx / E, n),), src=SRC + ":109"),
            Assign(Ref(msg, t, 1), "sum", (Ref(msg, t, 1), Ref(cA, 0, n, th)), src=SRC + ":112"))
    loop = For(idx, SIZE, body, lo=t * BS, step=BS * NT, src=SRC + ":106")
    final = If(sp.Eq(t, 0),
               (For(k, NT, (Assign(Ref(msg, 0, 1), "add", (Ref(msg, 0, 1), Ref(msg, k, 1)), src=SRC + ":124"),),
                    lo=1, unrolled=True, src=SRC + ":123"),), src=SRC + ":122")
    region = (Barrier(),  # :90
              loop,
              Barrier(),  # :121
              final)
    return Kernel("SCAN-RSS.main_kernel1", (SIZE,), (NT,), (A, cA, msg),
                  (ParFor(t, NT, region, src=SRC + ":81"),), src=SRC + ":81")


def main_kernel2():
    return scan_kernel("SCAN-RSS.main_kernel2", SRC,
                       {"fn": 134, "bar0": 143, "init": 159, "bar1": 162, "loop": 164, "read": 167,
                        "scan": 170, "hs": 173, "bar_loop": 176, "add": 179, "write": 182,
                        "if_last": 185})


FUNCTIONS = {"main_kernel1": main_kernel1, "main_kernel2": main_kernel2}


def values(params, build, nt):
    return {**build_values(build, nt), SIZE: params["size"]}
