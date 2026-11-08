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
each tasklet is a data-dependent quantity. Two accountings are provided:

  main_kernel2 (used by FUNCTIONS): the toolchain's amortized partition
    (inst_count_analyzer upmem_icount/source_loop_semantics.py,
    source_loop_total_backedge_bounds): every tasklet is charged at most
    CAP = ceil(tile_max / NT) backedges of the while loop and of the walk
    loop, and at least 0. Per tasklet: while trips W in [0, CAP+1], of which
    V visit non-fixed tiles and E start walks (E <= V <= W), and B in [0, CAP]
    walk backedges (= tile writes). The B backedges are carried by the first
    walk (the per-tasklet split over walks does not change any count). The
    upper ends are reached together at the 'hi' extreme (W = V = E = CAP+1,
    B = CAP): walk-loop header 2*CAP+1, copy loop (2*CAP+1)*m, exactly the
    stored header bounds. This sums to an upper bound of the DPU work
    (T*(CAP+1) >= D, T*CAP >= N_nt), but the lower end is 0 per tasklet and
    the sum over tasklets is not tied to D, so the MRAM traffic interval is
    [step 2 only, NT times the per-tasklet cap].

  main_kernel2_domain: an accounting partition of the exact DPU totals:
    tasklet t is charged share(X) = floor((X + NT - 1 - t) / NT) of each
    total X in {D, N_nt, F, N_nt}, so the shares sum to the totals; F is the
    only unknown (C .. N_nt, C when NT = 1). Its MRAM traffic is the paper's
    trns_static_memory_bounds; its instruction bound is tighter than the
    stored one (no tasklet is charged 0 or CAP+1). See domain_report().

Kernel.unknowns needs numeric ranges, but the caps depend on M_, n and NT, so
the unknowns are fractions u in [0, 1] of their cap (floor(u * cap)).
Tile identities (tile, next_in_cycle) only appear in MRAM offsets, which no
count depends on; they are free symbols.
"""
import math
import types

import sympy as sp

from prim.common import NT, Array, Assign, Barrier, For, If, Kernel, ParFor, Ref, build_values, t

BENCH = "TRNS"
SRC = "PrIM/TRNS/dpu/task.c"

M_, m, n = sp.symbols("M_ m n", integer=True, positive=True)
NNT, NC = sp.symbols("N_nt C", integer=True, nonnegative=True)  # non-fixed tiles, non-trivial cycles
tile, nxt = sp.symbols("tile next_in_cycle", integer=True, nonnegative=True)  # runtime tile ids
r, i, w, j = sp.symbols("r i w j", integer=True, nonnegative=True)
uW, uV, uE, uB, uF = sp.symbols("u_W u_V u_E u_B u_F", nonnegative=True)

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


def _kernel2(W, V, E, B, unknowns, tag):
    """main_kernel2 with per-tasklet counts: W while trips, V of them visit a
    non-fixed tile, E of those start a walk, B walk backedges (tile writes)."""
    A, done = _arrays()
    data, backup = Array("data", "B", T_BYTES), Array("backup", "B", T_BYTES)
    rdone = Array("read_done", "B", 1)
    trips = 1 + sp.Piecewise((B, sp.Eq(w, 0)), (0, True))  # the first walk carries the backedges
    walk = For(j, trips, (
        Assign(Ref(backup, 0, m), "copy", (Ref(A, nxt * m, m),), src=SRC + ":170"),       # line 115
        Assign(Ref(rdone, 0, T_BYTES), "copy", (Ref(done, nxt, T_BYTES),), src=SRC + ":192"),  # 117
        Assign(Ref(done, nxt, T_BYTES), "copy", (Ref(rdone, 0, T_BYTES),), src=SRC + ":195"),
        If(sp.Lt(j, trips - 1),  # !done: all but the walk's last trip
           (Assign(Ref(A, nxt * m, m), "copy", (Ref(data, 0, m),), src=SRC + ":174"),),  # line 120
           src=SRC + ":119"),
        For(i, m, (Assign(Ref(data, i, 1), "copy", (Ref(backup, i, 1),), src=SRC + ":123"),),
            src=SRC + ":122")), src=SRC + ":114")
    visit = (Assign(Ref(data, 0, m), "copy", (Ref(A, tile * m, m),), src=SRC + ":170"),       # line 111
             Assign(Ref(rdone, 0, T_BYTES), "copy", (Ref(done, tile, T_BYTES),), src=SRC + ":181"),  # 113
             If(sp.Lt(w, E), (walk,), src=SRC + ":114"))  # done == 0 on entry
    loop = For(w, W, (If(sp.Ge(w, V), (), visit, src=SRC + ":107"),), src=SRC + ":105")
    return Kernel("TRNS_step3" + tag, (M_, m, n), (NT,), (A, done, data, backup, rdone),
                  (ParFor(t, NT, (Barrier(), loop), src=SRC + ":77"),), src=SRC + ":77",
                  unknowns=unknowns)


def main_kernel2():
    """The toolchain's amortized per-tasklet partition (see module doc)."""
    cap = sp.ceiling(TILE_MAX / NT)
    W, V, E = (sp.floor(u * (cap + 1)) for u in (uW, uV, uE))
    B = sp.floor(uB * cap)
    return _kernel2(W, V, E, B, {uW: (0, 1), uV: (0, 1), uE: (0, 1), uB: (0, 1)}, "")


def _share(X):
    return sp.floor((X + NT - 1 - t) / NT)


def main_kernel2_domain():
    """Accounting partition of the exact DPU totals; F (walks) is the only unknown."""
    fmax = sp.Piecewise((NC, sp.Eq(NT, 1)), (NNT, True))
    F = NC + sp.floor(uF * (fmax - NC))
    return _kernel2(_share(TILE_MAX), _share(NNT), _share(F), _share(NNT), {uF: (0, 1)}, "_domain")


FUNCTIONS = {"main_kernel1": main_kernel1, "main_kernel2": main_kernel2}


def permutation_stats(M, nn):
    """(N_nt, C) of p(x) = x*M - tile_max*(x/n) on [0, tile_max) (lines 106, 114)."""
    tm = M * nn - 1
    seen = bytearray(tm)
    nnt = nc = 0
    for s in range(tm):
        if seen[s] or s * M - tm * (s // nn) == s:
            continue
        x, length = s, 0
        while not seen[x]:
            seen[x] = 1
            x = x * M - tm * (x // nn)
            length += 1
        nnt += length
        nc += 1
    return nnt, nc


def values(params, build, nt):
    v = {**build_values(build, nt), M_: params["M_"], m: params["m"], n: params["n"]}
    v[NNT], v[NC] = permutation_stats(params["M_"], params["n"])
    return v


# ----------------------------------------------------------------------------
# Domain accounting, evaluated through the shared setting_bounds (no shared
# code changed): FUNCTIONS with main_kernel2 replaced by main_kernel2_domain.
# ----------------------------------------------------------------------------
def domain_module():
    return types.SimpleNamespace(BENCH=BENCH, values=values,
                                 FUNCTIONS={"main_kernel1": main_kernel1,
                                            "main_kernel2": main_kernel2_domain})


def domain_report():
    """Run from pimsa_ir: ../.venv/bin/python -c "import prim.trns as T; T.domain_report()"."""
    import csv
    import upmem_cost as U
    from prim_check import FIG
    est = {(e["experiment"], e["num_dpus"], e["num_tasklets"]): e
           for e in csv.DictReader(open(FIG / "trns" / "trns_cost_estimates.csv"))}
    mod = domain_module()
    for row in csv.DictReader(open(FIG / "trns" / "summary.csv")):
        sid = U.setting_id(row, BENCH)
        res = U.setting_bounds(mod, sid, row)
        d, e = res["dma_total"], est[(row["experiment"], row["num_dpus"], row["num_tasklets"])]
        nd = int(row["num_dpus"])
        rb = (d["read_bytes_lower"], d["read_bytes_upper"])
        wb = (d["write_bytes_lower"], d["write_bytes_upper"])
        paper_r = (float(e["memory_read_bytes_lower_per_dpu"]) * nd, float(e["memory_read_bytes_upper_per_dpu"]) * nd)
        paper_w = (float(e["memory_write_bytes_lower_per_dpu"]) * nd, float(e["memory_write_bytes_upper_per_dpu"]) * nd)
        meas = {k: float(row[k]) for k in ("read_bytes_sum", "write_bytes_sum", "num_reads_sum", "num_writes_sum")}
        ok = lambda a, x: a[0] <= x <= a[1]
        rd = (d["reads_lower"], d["reads_upper"])
        wr = (d["writes_lower"], d["writes_upper"])
        print(f"{sid:46s} rB {'=paper' if rb == paper_r else rb} wB {'=paper' if wb == paper_w else wb} "
              f"bytes {'in' if ok(rb, meas['read_bytes_sum']) and ok(wb, meas['write_bytes_sum']) else 'OUT'} "
              f"units {'in' if ok(rd, meas['num_reads_sum']) and ok(wr, meas['num_writes_sum']) else 'OUT'} "
              f"(reads-meas {meas['num_reads_sum'] - rd[1]:+.0f}, writes-meas {meas['num_writes_sum'] - wr[1]:+.0f} vs upper) "
              f"instr [{res['instructions'][0]:.0f}, {res['instructions'][1]:.0f}] "
              f"stored [{res['stored_instructions'][0]:.0f}, {res['stored_instructions'][1]:.0f}] "
              f"cycles [{res['cycles'][0]:.0f}, {res['cycles'][1]:.0f}] paper "
              f"[{float(e['composed_cycles_lower']):.0f}, {float(e['composed_cycles_upper']):.0f}] "
              f"actual {float(e['actual_cycles']):.0f} "
              f"{'in' if res['cycles'][0] <= float(e['actual_cycles']) <= res['cycles'][1] else 'OUT'}")

