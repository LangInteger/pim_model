"""PrIM VA: C[i] = A[i] + B[i] (in place into B). Source: PrIM/VA/dpu/task.c."""
from prim.common import (BS, E, NT, SIZE, Array, Assign, Barrier, Kernel, ParFor, Ref,
                         blocks_loop, build_values, idx, l_size, t)

BENCH = "VA"
SRC = "PrIM/VA/dpu/task.c"


def main_kernel1():
    A = Array("A", "M", 4, 0)
    Bm = Array("Bm", "M", 4, SIZE)
    cA, cB = Array("cache_A", "B", 4), Array("cache_B", "B", 4)
    n = l_size() / 4
    th = (("tasklet", t),)
    body = (Assign(Ref(cA, 0, n, th), "copy", (Ref(A, idx / 4, n),)),
            Assign(Ref(cB, 0, n, th), "copy", (Ref(Bm, idx / 4, n),)),
            Assign(Ref(cB, 0, n, th), "add", (Ref(cB, 0, n, th), Ref(cA, 0, n, th)), src=SRC + ":19"),
            Assign(Ref(Bm, idx / 4, n), "copy", (Ref(cB, 0, n, th),)))
    return Kernel("VA", (SIZE,), (NT,), (A, Bm, cA, cB),
                  (ParFor(t, NT, (Barrier(), blocks_loop(body, SRC + ":60")), src=SRC + ":37"),),
                  src=SRC + ":37")


FUNCTIONS = {"main_kernel1": main_kernel1}


def values(params, build, nt):
    return {**build_values(build, nt), SIZE: params["size"]}
