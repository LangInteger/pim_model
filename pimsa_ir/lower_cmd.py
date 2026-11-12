"""Lowering of PIMSA-IR to a DRAM column-command stream, for targets whose
architecture instance says computation is command-triggered (exec.trigger =
"command") and parallel regions run in lockstep (exec.parallel = "lockstep"),
i.e. HBM-PIM.

Everything target-specific is read from the architecture instance:
  - a statement with a memory operand becomes one column command per
    transaction (exec.transaction_bytes) of that operand, RD when the memory
    slice is read and WR when it is written, addressed through
    exec.broadcast_address and the bank's row/column geometry (column overflow
    carries into the row);
  - a host-to-register statement becomes register-row writes
    (exec.register_file);
  - a parallel region is entered and left with exec.protocol.region_enter /
    region_exit, and the kernel is wrapped in launch_enter / launch_exit, which
    includes writing the CRF program (exec.crf);
  - Barrier marks the last command issued.
The output is the per-PU command stream that controller.schedule times.

The CRF program itself is not needed for timing, only its length in bursts.
crf_length() counts instructions the way the target's code generator lays
them out: one instruction per statement with a memory operand, loops over the
bank level unrolled (the bank is an instruction operand), and one JUMP per
remaining loop nest (a loop whose only instruction-bearing content is another
loop shares that loop's JUMP), plus EXIT.
"""
from __future__ import annotations

import math
import sys
from pathlib import Path

import sympy as sp

from ir import Assign, Barrier, For, If, Kernel, ParFor, Ref
from kernels import arch_values

sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "hbmpim_static"))
import controller as ctl  # noqa: E402

_FUNCS = {"floor": math.floor, "ceiling": math.ceil, "Min": min, "Max": max}
_CACHE: dict = {}


def ev_count(expr, env):
    """Evaluate a trip count: an int, or an exact Fraction for an average count."""
    try:
        return ev(expr, env)
    except ValueError as e:
        if "is not an integer" not in str(e):
            raise
    from fractions import Fraction
    e = sp.sympify(expr)
    v = sp.nsimplify(e.subs({s: env[s] for s in e.free_symbols}))
    if not v.is_Rational:
        raise ValueError(f"{expr} = {v} is not rational")
    return Fraction(int(v.p), int(v.q))


def ev(expr, env) -> int:
    """Evaluate an integer index expression at a concrete environment."""
    if isinstance(expr, int):
        return expr
    e = sp.sympify(expr)
    if e.is_Integer:
        return int(e)
    fn = _CACHE.get(e)
    if fn is None:
        syms = sorted(e.free_symbols, key=lambda s: s.name)
        f = sp.lambdify(syms, e, modules=[_FUNCS, "math"])
        fn = _CACHE[e] = (syms, f)
    syms, f = fn
    try:
        args = [env[s] for s in syms]
    except KeyError as k:
        raise ValueError(f"{e}: no value for {k} (address depends on a lockstep loop variable?)")
    v = f(*args)
    if v != int(v):
        raise ValueError(f"{e} = {v} is not an integer")
    return int(v)


def _mem_refs(s: Assign):
    out = [(s.dst, True)] + [(r, False) for r in s.srcs if isinstance(r, Ref)]
    return [(r, w) for r, w in out if r.array.space in ("M", "H")]


def _uses(body, var) -> bool:
    """Does any slice in body select its bank with `var`?"""
    for s in body:
        if isinstance(s, Assign):
            for r, _ in _mem_refs(s):
                bank = r.at("bank")
                if bank is not None and var in sp.sympify(bank).free_symbols:
                    return True
        elif isinstance(s, (For, ParFor)) and _uses(s.body, var):
            return True
    return False


def _count(body, env):
    """(instructions, loops): instruction count of body, and the loops among its
    instruction-bearing items (used to share a JUMP with an enclosing loop)."""
    n, items = 0, []
    for s in body:
        if isinstance(s, Assign) and any(r.array.space == "M" for r, _ in _mem_refs(s)):
            n += 1
            items.append(s)
        elif isinstance(s, For):
            if _uses(s.body, s.var):
                trips = ev(s.trips(), env)
                k = sum(_count(s.body, {**env, s.var: ev(s.lo, env) + q * ev(s.step, env)})[0]
                        for q in range(trips))
                n += k
                if k:
                    items.append(s)
                continue
            inner, inner_items = _count(s.body, {**env, s.var: ev(s.lo, env)})
            if not inner:
                continue
            nested = len(inner_items) == 1 and isinstance(inner_items[0], For)
            n += inner + (0 if nested else 1)  # a nested single loop already has its JUMP
            items.append(s)
    return n, items


def crf_length(region: ParFor, env) -> int:
    n, _ = _count(region.body, env)
    return n + 1  # EXIT


def _first_region(body, env):
    for s in body:
        if isinstance(s, ParFor):
            return s, env
        if isinstance(s, For):
            r = _first_region(s.body, {**env, s.var: ev(s.lo, env)})
            if r:
                return r
    return None


def lower(kernel: Kernel, arch: dict, values: dict) -> list:
    ex, m = arch["exec"], arch["M"]
    if ex["trigger"]["value"] != "command" or ex["parallel"]["value"] != "lockstep":
        raise ValueError("lower_cmd handles command-triggered, lockstep targets only")
    rows = {k: v["value"] for k, v in m["pim_rows"].items() if isinstance(v, dict) and "value" in v}
    nbg = m["bank_groups"]["value"]
    bpg = m["I2_banks"]["value"] // nbg
    cols = m["burst_columns_per_row"]["value"]
    tb = ex["transaction_bytes"]["value"]
    # A command-driven PU takes one W-wide operand per column access (paper,
    # drive mode), so the column access size is W * ESize, not a free parameter.
    val = lambda f: f["value"] if isinstance(f, dict) else f
    w, esize = val(arch["P"]["W"]), val(arch["P"]["ESize"])
    if tb != w * esize:
        raise ValueError(f"column access {tb} B != W * ESize = {w} * {esize} B")
    bcast, rf, crf = ex["broadcast_address"], ex["register_file"], ex["crf"]
    env0 = {**values, **arch_values(arch)}
    cmds: list = []

    def flat(bg, bank):
        return bg * bpg + bank

    def emit(write, bank, row, col):
        cmds.append(ctl.Cmd(write, 0, bank, row, col))

    def barrier():
        if cmds:
            cmds[-1].bar = True

    def protocol(name, crf_bursts=0):
        for st in ex["protocol"][name]:
            if st.get("barrier"):
                barrier()
            elif st.get("crf_program"):
                for q in range(crf_bursts):
                    emit(True, flat(crf["bank_group"], crf["bank"]), rows[crf["row"]], crf["col0"] + q)
            else:
                banks = st["banks"]
                if banks == "all_bank_major":
                    banks = [[bg, bk] for bk in range(bpg) for bg in range(nbg)]
                for bg, bk in banks:
                    emit(st["cmd"] == "WR", flat(bg, bk), rows[st["row"]], st["col"])

    def bursts(r: Ref, env):
        nbytes = ev(r.n, env) * r.array.elem_bytes
        if nbytes % tb:
            raise ValueError(f"slice of {r.array.name} is {nbytes} B, not a multiple of {tb} B")
        return nbytes // tb

    def assign(s: Assign, env, in_region):
        mem = _mem_refs(s)
        if not mem:
            return  # register-only: executes inside the PIM block, no command
        if len(mem) != 1:
            raise ValueError("a command-triggered statement has exactly one memory or host operand")
        r, write = mem[0]
        k = bursts(r, env)
        if r.array.space == "M":
            if not in_region:
                raise ValueError("memory operand outside a parallel region (not in PIM mode)")
            start = ev(r.array.base_bytes, env) + ev(r.off, env) * r.array.elem_bytes
            if start % tb:
                raise ValueError(f"{r.array.name} slice not aligned to {tb} B")
            lin = start // tb
            bank = flat(bcast["bank_group"], ev(r.at(bcast["bank_level"]), env))
            for q in range(k):
                emit(write, bank, (lin + q) // cols, (lin + q) % cols)
        else:  # host <-> PIM registers
            if write or s.dst.array.space != "R":
                raise ValueError("only host-to-register transfers are modeled")
            col0 = rf["files"][str(ev(s.dst.at("file"), env))]
            col0 += ev(s.dst.off, env) * s.dst.array.elem_bytes // tb
            for q in range(k):
                emit(True, flat(rf["bank_group"], rf["bank"]), rows[rf["row"]], col0 + q)

    def run(body, env, in_region):
        for s in body:
            if isinstance(s, Barrier):
                barrier()
            elif isinstance(s, Assign):
                assign(s, env, in_region)
            elif isinstance(s, For):
                lo, step, n = ev(s.lo, env), ev(s.step, env), ev(s.trips(), env)
                for q in range(n):
                    run(s.body, {**env, s.var: lo + q * step}, in_region)
            elif isinstance(s, If):
                run(s.body if ev(s.cond, env) else s.orelse, env, in_region)
            elif isinstance(s, ParFor):
                if ev(s.extent, env) != arch["P"]["P_per_channel"]["value"]:
                    raise ValueError("lockstep region must span the PU's PIM blocks")
                protocol("region_enter")
                run(s.body, env, True)  # one stream for all blocks: s.var stays unbound
                protocol("region_exit")
            else:
                raise TypeError(s)

    reg = _first_region(kernel.body, env0)
    protocol("launch_enter", math.ceil(crf_length(*reg) / crf["slots_per_burst"]) if reg else 0)
    run(kernel.body, env0, False)
    protocol("launch_exit")
    return cmds
