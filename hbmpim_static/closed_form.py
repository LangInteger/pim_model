"""Closed-form (steady-state) cycle count for the HBM-PIM kernels.

The command stream of each kernel is a loop nest whose body produces the same
commands every iteration, so its schedule under the controller rules is
periodic. In max-plus terms, after a one-iteration transient every iteration
costs a constant lambda: the weight of the critical cycle of the timing
dependency graph.

Derivation, done once per kernel and architecture and independent of problem
size:
  1. For a few tiny instances (1-5 iterations of each loop), schedule the
     derived command stream with the constraint model (`controller.schedule`,
     refresh disabled) and record, for every command, the earlier command
     whose constraint it waited for.
  2. Walk these predecessors back from the last command to obtain the critical
     path. Every edge is a named delay (tCCD_L, tRP, W2R, ...) and must equal
     that delay's nominal value, otherwise the derivation is rejected.
  3. The difference between the critical paths of n+1 and n iterations is the
     critical cycle of one period: a multiset of named delays. Periodicity is
     checked (two consecutive differences must agree) and so is additivity
     across loop levels.

The result is a formula in the workload parameters (M, N, B, C, L) whose
coefficients are sums of named timing parameters. It holds for this
architecture instance: when timing parameters change, a different cycle can
become critical (lambda is a maximum over cycles), so the derivation is redone
per architecture.

Refresh (PIMSimulator CommandQueue.cpp:169-205, MemoryController.cpp:91,444):
rank r first falls due at tREFI/ranks*(r+1), then every tREFI. A pending REF
is issued only at a cycle when no bank of the rank holds an open row. Other
commands keep issuing while it waits: the guard that would block them is
commented out at CommandQueue.cpp:213-214. A REF still pending when the last
transaction completes is never issued, because PIMKernel::runPIM stops when
nothing is pending. The kernels use rank 0 only. Refresh k (0-based) of rank 0
is therefore issued iff tREFI/ranks + k*tREFI <= T0 - tail + k*tRFC, where
`tail` is the time from the last all-rows-closed instant to the end. `tail` is
the final parking phase, the same in every kernel, and is derived from the
schedule. Each issued refresh is charged tRFC. The charge actually varies with
the refresh's phase within the period by about +-14 cycles, which is the
residual error.
"""
from __future__ import annotations

import collections

import sympy as sp

import controller as ctl
import pimsa_hbm as P

NAMED = ("tRCD_RD", "tRCD_WR", "tCCD_L", "tCCD_S", "R2W", "W2R", "tRTP", "tWR", "tRP", "tRAS",
         "tRC", "tRRD_S", "tRRD_L", "tCMD")
SYM = {k: sp.Symbol(k) for k in NAMED}


def nominal(t: dict) -> dict:
    d = ctl.delays(t)
    out = {k: t[k] for k in NAMED if k in t}
    out.update(R2W=d["READ_TO_WRITE"], W2R=d["WRITE_TO_READ_B_LONG"], tRTP=d["READ_TO_PRE"],
               tWR=d["WRITE_TO_PRE"])
    return out


def _sched_args(arch):
    m = arch["M"]
    return (m["ranks_per_channel"]["value"], P.banks_per_region(arch),
            P.banks_per_region(arch) // m["bank_groups"]["value"], m["command_queue_depth"]["value"])


def critical_path(arch, cmds):
    """(cycles, Counter of named delays on the critical path, constant, tail)."""
    t = dict(P.timing(arch), tREFI=10 ** 12)
    nom = nominal(t)
    edges = []
    cycles, _, _ = ctl.schedule(cmds, t, *_sched_args(arch), edges=edges)
    comp = collections.Counter()
    i = len(edges) - 1
    while edges[i][5] is not None:
        _, _, _, ti, why, p = edges[i]
        delay = ti - edges[p][3]
        if nom.get(why) != delay:
            raise ValueError(f"critical edge {why} has delay {delay}, not a nominal value")
        comp[why] += 1
        i = edges[i][5]
    const = cycles - sum(nom[k] * v for k, v in comp.items())
    # tail: from the last instant with no open row (rank 0) to the end
    open_rows, last_closed = set(), 0
    for _, kind, b, ti, _, _ in edges:
        if kind == "ACT":
            open_rows.add(b)
        elif kind == "PRE":
            open_rows.discard(b)
        if not open_rows:
            last_closed = ti
    return cycles, comp, const, cycles - last_closed


def _path(ir, arch, kernel, vals):
    """`ir` is the vendor frontend IR (a path), or a callable (kernel, vals) ->
    command stream, e.g. the PIMSA-IR lowering (pim_model/pimsa_ir)."""
    cmds = ir(kernel, vals) if callable(ir) else P.concrete_stream(ir, arch, kernel, vals).cmds
    return critical_path(arch, cmds)


def _sub(a, b):
    out = collections.Counter(a)
    out.subtract(b)
    return +out if all(v >= 0 for v in out.values()) else out


def _check(cond, what):
    if not cond:
        raise ValueError(f"closed-form derivation failed: {what}")


def _gemv(ir, arch):
    one = lambda n_in, R: _path(ir, arch, "GEMV", {P.M: 64, P.N: 128 * n_in, P.BT: R, P.C: 1})
    p = {(n, r): one(n, r) for n, r in [(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (1, 2), (1, 3), (2, 2)]}
    odd, even = _sub(p[2, 1][1], p[1, 1][1]), _sub(p[3, 1][1], p[2, 1][1])
    outer = _sub(p[1, 2][1], p[1, 1][1])
    _check(_sub(p[4, 1][1], p[3, 1][1]) == odd and _sub(p[5, 1][1], p[4, 1][1]) == even,
           "GEMV input-tile loop is not periodic")
    _check(_sub(p[1, 3][1], p[1, 2][1]) == outer, "GEMV outer loop is not periodic")
    nom = nominal(P.timing(arch))
    val = lambda c: sum(nom[k] * v for k, v in c.items())
    _check(p[2, 2][0] == p[1, 1][0] + val(outer) + 2 * val(odd), "GEMV loop levels do not add up")
    _check(len({x[2] for x in p.values()}) == 1 and len({x[3] for x in p.values()}) == 1,
           "constant or tail differs between instances")
    return {"first": p[1, 1][1], "outer": outer, "odd_tile": odd, "even_tile": even,
            "const": p[1, 1][2], "tail": p[1, 1][3]}


def _eltwise(ir, arch, kernel):
    p = {n: _path(ir, arch, kernel, {P.L: 16 * 128 * n, P.BT: 1, P.C: 1}) for n in (1, 2, 3, 4)}
    tile = _sub(p[2][1], p[1][1])
    _check(_sub(p[3][1], p[2][1]) == tile and _sub(p[4][1], p[3][1]) == tile,
           f"{kernel} tile loop is not periodic")
    _check(len({x[2] for x in p.values()}) == 1 and len({x[3] for x in p.values()}) == 1,
           "constant or tail differs between instances")
    return {"first": p[1][1], "tile": tile, "const": p[1][2], "tail": p[1][3]}


_CACHE: dict = {}


def derive(ir, arch, kernel):
    key = (str(ir), id(arch), kernel)
    if key not in _CACHE:
        _CACHE[key] = _gemv(ir, arch) if kernel == "GEMV" else _eltwise(ir, arch, kernel)
    return _CACHE[key]


def _expr(comp, numeric, nom):
    return sum((nom[k] if numeric else SYM[k]) * v for k, v in comp.items())


def formula(ir, arch, kernel, numeric=True):
    """Refresh-free cycle count T0 as a sympy expression in M, N, B, C, L."""
    d = derive(ir, arch, kernel)
    nom = nominal(P.timing(arch))
    e = lambda c: _expr(c, numeric, nom)
    n = trip_counts(ir, kernel)
    if kernel == "GEMV":
        R = n["outer"]
        return (d["const"] + e(d["first"]) + (R - 1) * e(d["outer"])
                + R * (n["odd_tiles"] * e(d["odd_tile"])
                       + (n["even_tiles"] - 1) * e(d["even_tile"])))
    return d["const"] + e(d["first"]) + (n["tiles"] - 1) * e(d["tile"])


def trip_counts(ir, kernel):
    """The loop counts the closed form multiplies its periods by. With the
    PIMSA-IR as stream source they are the trip counts of the program's loops
    (pimsa_ir metrics.loop_trips); for the vendor frontend IR they are restated
    from PIMKernel.cpp."""
    if hasattr(ir, "trips"):
        t = ir.trips(kernel)
        if kernel == "GEMV":  # loops j, bt, i2 (even tiles), c, i2 (odd tiles), c
            (j, nj), (bt, nb), (i0, n0), _, (i1, n1), _ = t
            assert (j, bt, i0, i1) == ("j", "bt", "i2", "i2"), t
            return {"outer": nj * nb, "even_tiles": n0, "odd_tiles": n1}
        (i, ni), _ = t  # loops i (tiles), b (banks of the pair)
        assert i == "i", t
        return {"tiles": ni}
    if kernel == "GEMV":
        n_in = sp.ceiling(P.N / 128)
        return {"outer": P.BT * sp.ceiling(P.M / (64 * P.C)),
                "even_tiles": sp.ceiling(n_in / 2), "odd_tiles": sp.floor(n_in / 2)}
    return {"tiles": sp.floor(P.BT * sp.ceiling(P.L / 16) / (128 * P.C))}


def refreshes(arch, T0, tail):
    """Number of rank-0 refreshes issued before the end (see module docstring)."""
    t = P.timing(arch)
    first = t["tREFI"] // arch["M"]["ranks_per_channel"]["value"]
    room = T0 - tail - first
    return 0 if room < 0 else room // (t["tREFI"] - t["tRFC"]) + 1


def estimate(ir, arch, kernel, values):
    d = derive(ir, arch, kernel)
    T0 = int(formula(ir, arch, kernel).subs(values))
    n_ref = refreshes(arch, T0, d["tail"])
    rfc = P.timing(arch)["tRFC"]
    fmt = lambda c: " + ".join(f"{v}*{k}" for k, v in sorted(c.items()))
    return {
        "total": T0 + n_ref * rfc,
        "refresh_free": T0,
        "refreshes": n_ref,
        "formula": str(formula(ir, arch, kernel)),
        "periods": {k: fmt(v) for k, v in d.items() if isinstance(v, collections.Counter)},
        "tail": d["tail"],
    }
