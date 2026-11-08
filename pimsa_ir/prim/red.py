"""PrIM RED (VERSION SINGLE): sum of all elements. Source: PrIM/RED/dpu/task.c.

Each tasklet streams BS-byte blocks and reduces them; after a barrier,
tasklet 0 adds the NT partial sums (an unrolled loop over WRAM). The
`#ifdef TREE` variant is not the analyzed build."""
import sympy as sp

from prim.common import (E, NT, SIZE, Array, Assign, Barrier, For, If, Kernel, ParFor, Ref,
                         blocks_loop, build_values, idx, k, l_size, t)

BENCH = "RED"
SRC = "PrIM/RED/dpu/task.c"


def main_kernel1():
    A = Array("A", "M", E, 0)
    cache = Array("cache_A", "B", E)
    msg = Array("message", "B", E)
    n = l_size() / E
    th = (("tasklet", t),)
    body = (Assign(Ref(cache, 0, n, th), "copy", (Ref(A, idx / E, n),)),
            Assign(Ref(msg, t, 1), "sum", (Ref(msg, t, 1), Ref(cache, 0, n, th)), src=SRC + ":19"))
    final = If(sp.Eq(t, 0), (For(k, NT, (Assign(Ref(msg, 0, 1), "add", (Ref(msg, 0, 1), Ref(msg, k, 1))),),
                                 lo=1, unrolled=True, src=SRC + ":135"),))
    return Kernel("RED", (SIZE,), (NT,), (A, cache, msg),
                  (ParFor(t, NT, (Barrier(), blocks_loop(body, SRC + ":79"), Barrier(), final),
                          src=SRC + ":45"),), src=SRC + ":45")


FUNCTIONS = {"main_kernel1": main_kernel1}


def values(params, build, nt):
    return {**build_values(build, nt), SIZE: params["size"]}
