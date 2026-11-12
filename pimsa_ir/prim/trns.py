"""PrIM TRNS: in-place 3-step matrix transposition, steps 2 and 3 on the DPU.
Source: PrIM/TRNS/dpu/task.c (uPIMulator copy: benchmark/TRNS/dpu/task.c).

The host launches main_kernel1 (step 2) and main_kernel2 (step 3) alternately
(summary.csv lists every execution; setting_bounds sums them per DPU).

main_kernel1 (line 46). After the tasklet-0 heap reset and the barrier
(line 55), tile = t, t+NT, ... < M_ (line 65): read_tile_step2 (line 66 ->
mram_read, line 150), the in-WRAM transpose of the m x n tile (line 67-69),
write_tile_step2 (line 70 -> mram_write, line 164). The two helpers (noinline)
move the m*n*8-byte tile in chunks of at most 2048 B (`while (rest > 0)`,
lines 144 / 158, transfer = min(rest, 2048/8) elements). Their loops live in
the callees, not in main_kernel1's machine code (the toolchain charges the
callees by their stored per-call bound); the IR writes them as For with
`lowered="callee:..."` (no machine loop of this kernel function). For every analyzed input m*n*8 = 512 B, so they run once.
(The WRAM offset `variable + (m*n - rest)*sizeof(T)` scales twice by
sizeof(T); it is reproduced as written and only matters for rest < m*n.)

main_kernel2 (line 77). After the reset and barrier (line 86): tile =
get_tile() (line 103, a mutex-protected counter); while tile < tile_max
(= M_*n - 1, line 94/105): next_in_cycle = p(tile) (line 106, p the in-place
transpose permutation); a fixed point (p(tile) == tile, line 107) only fetches
the next tile; otherwise read_tile_step3 (line 111 -> 170, m*8 B), get_done
(line 113 -> 181: one 8-byte read at the *byte* address done_array + tile),
and while done == 0 (line 114) the cycle walk: read_tile_step3 of the next
tile into backup (line 115 -> 170), get_and_set_done (line 117 -> read 192,
write 195), if it was not yet done write data to it (line 119-120 -> 174),
data = backup (line 122-124, loop over m), next = p(next).

Walk accounting (from the source). A walk ends at the first get_and_set_done
that finds its tile already marked; every earlier trip marks a new tile and
writes it. So per walk: trips = successful marks + 1, writes = trips - 1,
backedges = successful marks. Over the DPU every non-fixed tile is marked
exactly once, hence, with D = tile_max tiles handed out by get_tile, N_nt the
non-fixed tiles, C the non-trivial cycles of p restricted to [0, tile_max),
and F the number of walks:
    while-loop trips = D,  visits (read + get_done) = N_nt,
    inner trips = N_nt + F,  inner backedges = tile writes = N_nt,
    C <= F <= N_nt  (F = C with one tasklet: tiles come in increasing order,
    a walk starts at the first member of each cycle, all later members are
    already marked; with several tasklets any non-fixed tile can start one).

Dynamic tile distribution. Which tasklet obtains which tile is decided at
run time by get_tile (line 133-139). The IR is per tasklet, so the share of
each tasklet is a data-dependent quantity. main_kernel2 charges it as the
toolchain does (inst_count_analyzer upmem_icount/source_loop_semantics.py,
source_loop_total_backedge_bounds, an amortized partition): every tasklet runs
at most CAP = ceil(tile_max / NT) backedges of the while loop and of the walk
loop, and at least 0. Per tasklet, the while loop runs W in [0, CAP+1] trips
and the walk loop B in [0, CAP] backedges (= tile writes) in total. The upper
ends sum to an upper bound of the DPU work (T*(CAP+1) >= D, T*CAP >= N_nt);
the lower end is 0 per tasklet, so the MRAM traffic interval is [step 2 only,
NT times the per-tasklet cap].

Every iteration of an IR loop is alike (metrics.times), so the program is
written in that form:
  - every while trip visits a tile and starts a walk (at the extremes W and
    the number of visits and walks coincide: all 0, or all CAP+1);
  - the walk loop has an average trip count, its total W + B over the W
    walks (For(average=True)): the split of the backedges over the walks is
    decided at run time, their total is what the cap bounds. Its total,
    2*CAP+1 at the upper end, and that of the copy loop, (2*CAP+1)*m, are
    exactly the stored header bounds;
  - whether a walk trip writes its tile depends on the done bit read from
    MRAM (every trip but the walk's last writes), a data-dependent branch:
    WR in [0, 1] (no trip writes / every trip writes).
The counts therefore need neither N_nt nor C (no enumeration of the
permutation). Tile identities (tile, next_in_cycle) only appear in MRAM
offsets, which no count depends on; they are free symbols.
"""
import sympy as sp

from prim.common import NT, Array, Assign, Barrier, For, If, Kernel, ParFor, Ref, build_values, t

BENCH = "TRNS"
SRC = "PrIM/TRNS/dpu/task.c"

M_, m, n = sp.symbols("M_ m n", integer=True, positive=True)
tile, nxt = sp.symbols("tile next_in_cycle", integer=True, nonnegative=True)  # runtime tile ids
r, i, w, j = sp.symbols("r i w j", integer=True, nonnegative=True)
W_, B_, WR = sp.symbols("W_walks B_walks WR", integer=True, nonnegative=True)  # while trips, walk backedges, write flag

T_BYTES = 8  # T = int64_t (support/common.h)
CHUNK = 2048 // T_BYTES  # elements per step-2 transfer (2048 B, the SDK maximum)
TILE_MAX = M_ * n - 1  # line 94


def _arrays():
    A = Array("A", "M", T_BYTES, 0)  # DPU_MRAM_HEAP_POINTER (lines 57 / 88)
    done = Array("done_array", "M", 1, M_ * m * n * T_BYTES)  # line 92, byte-addressed bits
    return A, done


def _step2_xfer(direction, A, buf, mn):
    """read_tile_step2 / write_tile_step2: while (rest > 0) chunks of <= 2048 B."""
    rest = mn - r * CHUNK
    k = sp.Min(CHUNK, rest)
    mram, wram = Ref(A, tile * mn + r * CHUNK, k), Ref(buf, r * CHUNK * T_BYTES, k)  # (m*n - rest) * sizeof(T), in T units
    if direction == "read":
        st = Assign(wram, "copy", (mram,), src=SRC + ":150")
        line, callee = ":144", "read_tile_step2"
    else:
        st = Assign(mram, "copy", (wram,), src=SRC + ":164")
        line, callee = ":158", "write_tile_step2"
    return For(r, sp.ceiling(mn / CHUNK), (st,), lowered="callee:" + callee, src=SRC + line)


def main_kernel1():
    A, _ = _arrays()
    data, backup = Array("data", "B", T_BYTES), Array("backup", "B", T_BYTES)
    mn = m * n
    transpose = For(i, mn, (Assign(Ref(backup, i * m - (mn - 1) * sp.floor(i / n), 1), "copy",
                                   (Ref(data, i, 1),), src=SRC + ":68"),), src=SRC + ":67")
    tiles = For(tile, M_, (_step2_xfer("read", A, data, mn), transpose,
                           _step2_xfer("write", A, backup, mn)),
                lo=t, step=NT, src=SRC + ":65")
    return Kernel("TRNS_step2", (M_, m, n), (NT,), (A, data, backup),
                  (ParFor(t, NT, (Barrier(), tiles), src=SRC + ":46"),), src=SRC + ":46")


def main_kernel2():
    """main_kernel2 per tasklet: W while trips, each visiting a tile and walking
    its cycle; B walk backedges in total (module doc)."""
    A, done = _arrays()
    data, backup = Array("data", "B", T_BYTES), Array("backup", "B", T_BYTES)
    rdone = Array("read_done", "B", 1)
    walk = For(j, (W_ + B_) / sp.Max(W_, 1), (
        Assign(Ref(backup, 0, m), "copy", (Ref(A, nxt * m, m),), src=SRC + ":170"),       # line 115
        Assign(Ref(rdone, 0, T_BYTES), "copy", (Ref(done, nxt, T_BYTES),), src=SRC + ":192"),  # 117
        Assign(Ref(done, nxt, T_BYTES), "copy", (Ref(rdone, 0, T_BYTES),), src=SRC + ":195"),
        If(sp.Eq(WR, 1),  # !done (line 119): decided by the done bit read from MRAM
           (Assign(Ref(A, nxt * m, m), "copy", (Ref(data, 0, m),), src=SRC + ":174"),),  # line 120
           src=SRC + ":119"),
        For(i, m, (Assign(Ref(data, i, 1), "copy", (Ref(backup, i, 1),), src=SRC + ":123"),),
            src=SRC + ":122")), src=SRC + ":114", average=True)
    visit = (Assign(Ref(data, 0, m), "copy", (Ref(A, tile * m, m),), src=SRC + ":170"),       # line 111
             Assign(Ref(rdone, 0, T_BYTES), "copy", (Ref(done, tile, T_BYTES),), src=SRC + ":181"),  # 113
             walk)
    loop = For(w, W_, visit, src=SRC + ":105")
    cap = sp.ceiling(TILE_MAX / NT)
    return Kernel("TRNS_step3", (M_, m, n), (NT,), (A, done, data, backup, rdone),
                  (ParFor(t, NT, (Barrier(), loop), src=SRC + ":77"),), src=SRC + ":77",
                  unknowns={W_: (0, cap + 1), B_: (0, cap), WR: (0, 1)})


FUNCTIONS = {"main_kernel1": main_kernel1, "main_kernel2": main_kernel2}


def values(params, build, nt):
    return {**build_values(build, nt), M_: params["M_"], m: params["m"], n: params["n"]}
