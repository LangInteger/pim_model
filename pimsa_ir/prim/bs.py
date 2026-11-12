"""PrIM BS: binary search of slice_per_dpu queries in a sorted int64 vector.
Source: PrIM/BS/dpu/task.c (uPIMulator copy: benchmark/BS/dpu/task.c).

Per tasklet, slice_per_dpu / NR_TASKLETS queries (line 76). Per query: one
8-byte query read (line 80), the first and last-but-eight blocks (lines 93,
94), then the search loop (line 97): one BLOCK_SIZE read per iteration
(line 100), and in the iteration that ends the search, the start (line 130)
and end (line 144) boundary reads. `search` (line 20, noinline) is a callee;
its cost comes from the stored per-call bound, so its scan loop is not part
of this IR.

Search loop iterations (derived from the address arithmetic, lines 96-141).
Let S = 8 * input_size bytes and L_k the interval [start, end) after k
iterations; L_0 = S. Both updates (lines 115-116 and 122-123) halve the
interval and leave end - current = L_k / 2, and current - start_aux >=
current - start = L_k / 2. With S = BLOCK_SIZE * 2^m (all inputs here), the
divisions are exact, so the end check (line 141, current > end - BLOCK_SIZE)
is false while L_k / 2 >= BLOCK_SIZE and true at k = m, and the start check
(line 127) is false for k < m. Hence the loop runs at most WMAX = max(1, m)
= log2(S / BLOCK_SIZE) iterations: fewer only by the `found` break (line
106), and if it reaches iteration WMAX without that break, the end check
always reads (line 144) and the start check reads (line 130) only when every
step went left (current = start_aux + BLOCK_SIZE / 2). The toolchain's
stored cap is ceil(log2(blocks)) + 2 backedges (benchmark_settings.py), i.e.
WMAX + 3 iterations, so the IR bound is tighter.

The boundary reads happen only in the last iteration (k = WMAX - 1, when the
search does not break). The IR places them after the loop, which gives the
same counts and makes every iteration of the loop alike, so its counts are
the body's counts times the trip count.

Data-dependent symbols:
  F     iteration (1-based) at which the found-break fires; F > WMAX means
        the loop ends at the boundary checks. Range [1, FMAX]; the loop runs
        min(F, WMAX) iterations. FMAX = 24 covers WMAX + 1 for every MRAM
        vector: 64 MB MRAM / 8 B blocks (BL >= 3) = 2^23 blocks, WMAX <= 23
        (checked in values()).
  LEFT  1 when the search went left at every step (start-check read), [0, 1].
"""
import sympy as sp

from prim.common import BS, NT, Array, Assign, Barrier, For, If, Kernel, ParFor, Ref, build_values, t

BENCH = "BS"
SRC = "PrIM/BS/dpu/task.c"

N_IN, SLICE, WMAX = sp.symbols("input_size slice_per_dpu WMAX", integer=True, positive=True)
F, LEFT = sp.symbols("F LEFT", integer=True, nonnegative=True)
q, w = sp.symbols("q w", integer=True, nonnegative=True)
FMAX = 24
EB = 8  # sizeof(DTYPE), int64_t (support/common.h)


def main_kernel1():
    A = Array("A", "M", EB, 0)
    Q = Array("querys", "M", EB, N_IN * EB)
    sq = Array("searching_for", "B", EB)
    cA, cAuxA, cAuxB = (Array(nm, "B", EB) for nm in ("cache_A", "cache_aux_A", "cache_aux_B"))
    blk = BS / EB  # elements per BLOCK_SIZE read
    per_t = sp.floor(SLICE / NT)  # queries per tasklet
    no_break = F > WMAX
    read = lambda line: Assign(Ref(cA, 0, blk), "copy", (Ref(A, 0, blk),), src=f"{SRC}:{line}")
    while_body = (read(100),
                  Assign(Ref(sq, 0, 1), "search", (Ref(cA, 0, blk), Ref(sq, 0, 1)), src=SRC + ":103"))
    target_body = (Assign(Ref(sq, 0, 1), "copy", (Ref(Q, t * per_t + q, 1),), src=SRC + ":80"),
                   Assign(Ref(cAuxA, 0, blk), "copy", (Ref(A, 0, blk),), src=SRC + ":93"),
                   Assign(Ref(cAuxB, 0, blk), "copy", (Ref(A, N_IN - BS, blk),), src=SRC + ":94"),
                   For(w, sp.Min(F, WMAX), while_body, src=SRC + ":97"),
                   # the boundary reads of the last iteration, placed after the loop
                   If(sp.And(no_break, sp.Eq(LEFT, 1)), (read(130),), src=SRC + ":127"),
                   If(no_break, (read(144),), src=SRC + ":141"))
    return Kernel("BS", (N_IN, SLICE), (NT,), (A, Q, sq, cA, cAuxA, cAuxB),
                  (ParFor(t, NT, (Barrier(), For(q, per_t, target_body, src=SRC + ":76")),
                          src=SRC + ":48"),),
                  src=SRC + ":48", unknowns={F: (1, FMAX), LEFT: (0, 1)})


FUNCTIONS = {"main_kernel1": main_kernel1}


def values(params, build, nt):
    v = build_values(build, nt, default_type="INT64", default_bl=8)
    blocks, r = divmod(params["input_size"] * EB, v[BS])
    if r or blocks & (blocks - 1):
        raise NotImplementedError("search depth derived for 8*input_size = BLOCK_SIZE * 2^m only")
    wmax = max(1, blocks.bit_length() - 1)
    assert wmax < FMAX
    return {**v, N_IN: params["input_size"], SLICE: params["slice_per_dpu"], WMAX: wmax}
