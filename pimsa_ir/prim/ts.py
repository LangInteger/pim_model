"""PrIM TS (STREAMP matrix profile): distance of a query to every subsequence
of the time-series slice. Source: PrIM/TS/dpu/task.c (uPIMulator copy:
benchmark/TS/dpu/task.c).

Per tasklet, elements [myStartElem, myEndElem) (lines 69-73, myEndElem
clamped to slice_per_dpu - query_length) in steps of DOTPIP = BLOCK_SIZE /
sizeof(DTYPE) (line 112). Per step: cache_dotprods is zeroed (line 114; the
compiler lowers this loop to a __memset_wram_4align call, so it has no
machine loop and is marked `unrolled`), query_length / DOTPIP rounds of
three BLOCK_SIZE reads (time series, its next block, query; lines 122-124)
and a dot_product call (line 128, noinline callee: cost from its stored
per-call bound), one BLOCK_SIZE read each of the means and standard
deviations (lines 132-133), and the distance loop over DOTPIP elements
(line 137). TS has no -DBL in its Makefile: BL=8 (support/common.h), so
BLOCK_SIZE = 256 B and DOTPIP = 64. No data-dependent control flow.
"""
import sympy as sp

from prim.common import BS, NT, Array, Assign, Barrier, For, Kernel, ParFor, Ref, build_values, t

BENCH = "TS"
SRC = "PrIM/TS/dpu/task.c"

SLICE, QLEN = sp.symbols("slice_per_dpu query_length", integer=True, positive=True)
i, d, j, kk = sp.symbols("i d j kk", integer=True, nonnegative=True)
EB = 4  # sizeof(DTYPE), int32_t (support/common.h)


def main_kernel1():
    dotpip = BS / EB
    per_t = sp.floor(SLICE / NT)
    my_start = t * per_t
    my_end = sp.Min(my_start + per_t - 1, SLICE - QLEN)
    Qm = Array("query", "M", EB, 0)
    TSm = Array("TS", "M", EB, QLEN * EB)
    Mean = Array("TSMean", "M", EB, (2 * QLEN + SLICE) * EB)
    Sigma = Array("TSSigma", "M", EB, (3 * QLEN + 2 * SLICE) * EB)
    cTS, cAux, cQ, cMean, cSig, cDot = (Array(nm, "B", EB) for nm in
                                        ("cache_TS", "cache_TS_aux", "cache_query", "cache_TSMean",
                                         "cache_TSSigma", "cache_dotprods"))
    ts_at = i + j * dotpip  # element offset of the current time-series block
    blk = (i - my_start) / dotpip  # i-step index: means/sigmas advance one block per step
    j_body = (Assign(Ref(cTS, 0, dotpip), "copy", (Ref(TSm, ts_at, dotpip),), src=SRC + ":122"),
              Assign(Ref(cAux, 0, dotpip), "copy", (Ref(TSm, ts_at + dotpip, dotpip),), src=SRC + ":123"),
              Assign(Ref(cQ, 0, dotpip), "copy", (Ref(Qm, j * dotpip, dotpip),), src=SRC + ":124"),
              Assign(Ref(cDot, 0, dotpip), "dot_product",
                     (Ref(cDot, 0, dotpip), Ref(cTS, 0, dotpip), Ref(cAux, 0, dotpip), Ref(cQ, 0, dotpip)),
                     src=SRC + ":128"))
    k_body = (Assign(Ref(cDot, kk, 1), "distance",
                     (Ref(cDot, kk, 1), Ref(cMean, kk, 1), Ref(cSig, kk, 1)), src=SRC + ":139"),)
    i_body = (For(d, dotpip, (Assign(Ref(cDot, d, 1), "copy", ()),), lowered="libcall:__memset_wram_4align", src=SRC + ":114"),
              For(j, sp.floor(QLEN / dotpip), j_body, src=SRC + ":120"),
              Assign(Ref(cMean, 0, dotpip), "copy", (Ref(Mean, my_start + blk * dotpip, dotpip),),
                     src=SRC + ":132"),
              Assign(Ref(cSig, 0, dotpip), "copy", (Ref(Sigma, my_start + blk * dotpip, dotpip),),
                     src=SRC + ":133"),
              For(kk, dotpip, k_body, src=SRC + ":137"))
    return Kernel("TS", (SLICE, QLEN), (NT,), (Qm, TSm, Mean, Sigma, cTS, cAux, cQ, cMean, cSig, cDot),
                  (ParFor(t, NT, (Barrier(), For(i, my_end, i_body, lo=my_start, step=dotpip,
                                                 src=SRC + ":112")), src=SRC + ":51"),),
                  src=SRC + ":51")


FUNCTIONS = {"main_kernel1": main_kernel1}


def values(params, build, nt):
    return {**build_values(build, nt, default_bl=8), SLICE: params["slice_per_dpu"],
            QLEN: params["query_length"]}
