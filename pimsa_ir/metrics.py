"""Metric extraction on PIMSA-IR (paper Sec. 4.1), shared by all targets.

Statements are classified by the architectural boundary their data crosses,
from the spaces of their operands: host-memory (H<->M), memory-buffer (M<->B),
memory-register (M<->R, a target whose arch says exec.memory_operands),
host-register (H<->R) and buffer-register. For each boundary the extraction
counts bytes (V), statement executions (transfers) and transactions of
exec.transaction_bytes (beats: DRAM column commands on HBM-PIM, 8 B DMA beats
on UPMEM). Computation is counted in target primitives: a slice operation of
n elements is ceil(n / W) primitive operations, W from the architecture.

How a parallel region multiplies these comes from the architecture too:
  exec.parallel = "lockstep": one command stream serves all P blocks, so
      transfers and beats are counted once per region execution while bytes
      and primitive operations are multiplied by the region's extent;
  exec.parallel = "threads": every iteration runs its own instance, so
      everything is summed over the region variable.

A loop contributes its body's counts at its first iteration times its trip
count: every iteration of a loop is alike (see times()). Both a symbolic pass
(counts as formulas) and a concrete pass (one instance) are provided.
"""
from __future__ import annotations

import collections
import math

import sympy as sp

from ir import Assign, Barrier, For, If, Kernel, ParFor, Ref
from kernels import arch_values
from lower_cmd import crf_length, _first_region, ev, ev_count

BOUNDARY = {("M", "R"): "mem2reg", ("R", "M"): "reg2mem", ("M", "B"): "mld", ("B", "M"): "mst",
            ("H", "R"): "host2reg", ("R", "H"): "reg2host", ("H", "M"): "hld", ("M", "H"): "hst",
            ("B", "R"): "bld", ("R", "B"): "bst"}


def times(n, run):
    """Counts of n iterations of a loop: the counts of its first iteration,
    run(0), times n. Every iteration of a loop is alike (paper Sec. 4.1): a
    difference between iterations is written in the program as a
    data-dependent value (any) or as an average trip count, not as a branch on
    the loop variable; check_uniform_loops.py checks this for the PrIM programs."""
    if n <= 0:
        return collections.Counter()
    return collections.Counter({k: v * n for k, v in run(0).items()})


def loop_trips(kernel: Kernel, arch: dict) -> list:
    """Trip counts of the kernel's sequential loops, in program order, as
    (loop variable name, symbolic trip count) with the architecture values
    substituted. The closed-form cost of a command-driven target is a formula
    in these counts (hbmpim_static/closed_form.py)."""
    av = arch_values(arch)
    out = []

    def walk(body):
        for s in body:
            if isinstance(s, For):
                out.append((str(s.var), sp.sympify(s.trips()).subs(av)))
                walk(s.body)
            elif isinstance(s, ParFor):
                walk(s.body)
            elif isinstance(s, If):
                walk(s.body)
                walk(s.orelse)

    walk(kernel.body)
    return out


def _stmt(s: Assign, tb, W, env=None):
    """Counts for one execution of s. With env, numbers; else expressions."""
    val = (lambda e: ev(e, env)) if env is not None else sp.sympify
    out = collections.Counter()
    srcs = [r for r in s.srcs if isinstance(r, Ref)]
    for r in srcs:
        if r.array.space == s.dst.array.space:
            continue
        cls = BOUNDARY[(r.array.space, s.dst.array.space)]
        mem = r if r.array.space in ("M", "H") else s.dst  # the slice on the memory side
        nbytes = val(mem.n * mem.array.elem_bytes)
        out[f"V_{cls}"] += nbytes
        out[f"X_{cls}"] += 1
        out[f"N_{cls}"] += nbytes / tb if env is None else nbytes // tb
    if s.op != "copy":  # a reduction reads more elements than it writes
        n = max([val(s.dst.n)] + [val(r.n) for r in srcs])
        out["ops"] += sp.ceiling(n / W) if env is None else -(-n // W)
    return out


def extract(kernel: Kernel, arch: dict, values: dict | None = None):
    """Per-PU counts. Keys: V_<b>, X_<b>, N_<b> per boundary b, ops, bar,
    regions (executions of a parallel region)."""
    ex = arch["exec"]
    tb = ex["transaction_bytes"]["value"]
    W = arch["P"]["W"]["value"]
    lockstep = ex["parallel"]["value"] == "lockstep"
    concrete = values is not None
    av = arch_values(arch)
    env0 = {**av, **(values or {})}

    def add(a, b):
        a.update(b)
        return a

    def body_counts(body, env):
        out = collections.Counter()
        for s in body:
            if isinstance(s, Barrier):
                out["bar"] += 1
            elif isinstance(s, Assign):
                add(out, _stmt(s, tb, W, env if concrete else None))
            elif isinstance(s, For):
                if concrete:
                    lo, st = ev(s.lo, env), ev(s.step, env)
                    add(out, times(ev_count(s.trips(), env),
                                   lambda q: body_counts(s.body, {**env, s.var: lo + q * st})))
                else:  # the body at the first iteration, times the trip count
                    inner = body_counts(s.body, env)
                    n = s.trips().subs(av)
                    for k, v in inner.items():
                        out[k] += sp.sympify(v).subs(s.var, s.lo).subs(av) * n
            elif isinstance(s, If):
                if concrete:
                    add(out, body_counts(s.body if ev(s.cond, env) else s.orelse, env))
                else:
                    a, b = body_counts(s.body, env), body_counts(s.orelse, env)
                    for k in set(a) | set(b):
                        out[k] += sp.Piecewise((a.get(k, 0), s.cond), (b.get(k, 0), True))
            elif isinstance(s, ParFor):
                ext = ev(s.extent, env) if concrete else sp.sympify(s.extent).subs(av)
                if lockstep:
                    inner = body_counts(s.body, env)
                    for k, v in inner.items():
                        out[k] += v * ext if k.startswith("V_") or k == "ops" else v
                elif concrete:
                    for q in range(ext):
                        add(out, body_counts(s.body, {**env, s.var: q}))
                else:
                    inner = body_counts(s.body, env)
                    for k, v in inner.items():
                        v = sp.sympify(v).subs(av)
                        out[k] += sp.summation(v, (s.var, 0, ext - 1)) if s.var in v.free_symbols \
                            else v * ext
                out["regions"] += 1
        return out

    return body_counts(kernel.body, env0)


# ----------------------------------------------------------------------------
# Target views of the shared counts
# ----------------------------------------------------------------------------
def protocol_counts(arch: dict, kernel: Kernel, regions):
    """Commands and barriers of the architecture's launch protocol, by the
    boundary class each template declares."""
    ex, m = arch["exec"], arch["M"]
    nbanks = m["I2_banks"]["value"]
    out = collections.Counter()
    reg = _first_region(kernel.body, arch_values(arch))
    crf_bursts = math.ceil(crf_length(*reg) / ex["crf"]["slots_per_burst"]) if reg else 0
    for name, times in (("launch_enter", 1), ("launch_exit", 1),
                        ("region_enter", regions), ("region_exit", regions)):
        for st in ex["protocol"][name]:
            if st.get("barrier"):
                out["bar"] += times
            elif st.get("crf_program"):
                out[st["class"]] += crf_bursts * times
            else:
                n = nbanks if st["banks"] == "all_bank_major" else len(st["banks"])
                out[st["class"]] += n * times
    return out


def hbm_counts(kernel: Kernel, arch: dict) -> dict:
    """HBM-PIM per-PU command counts in the keys of hbmpim_static.Metrics."""
    c = extract(kernel, arch)
    p = protocol_counts(arch, kernel, c["regions"])
    out = {"bank2pu": c["N_mem2reg"], "pu2bank": c["N_reg2mem"],
           "host2pu": c["N_host2reg"] + p["host2pu"], "pu2host": c["N_reg2host"] + p["pu2host"],
           "mode_rd": p["mode_rd"], "mode_wr": p["mode_wr"], "bar": c["bar"] + p["bar"]}
    out["rd"] = out["bank2pu"] + out["pu2host"] + out["mode_rd"]
    out["wr"] = out["pu2bank"] + out["host2pu"] + out["mode_wr"]
    return {k: sp.simplify(v) for k, v in out.items()}


def extremes(kernel: Kernel, values: dict):
    """(lowest, highest) instantiations of the kernel's data-dependent symbols."""
    # range endpoints may depend on build or input values (e.g. (0, BS / E))
    lo = {**values, **{s: ev(r[0], values) for s, r in kernel.unknowns.items() if s not in values}}
    hi = {**values, **{s: ev(r[1], values) for s, r in kernel.unknowns.items() if s not in values}}
    return lo, hi


def dma_counts(kernel: Kernel, arch: dict, values: dict) -> dict:
    """UPMEM per-DPU MRAM DMA traffic at one instance. Keys without a suffix
    are exact when the kernel has no data-dependent symbols; otherwise every
    key also has _lower and _upper variants."""
    out = {}
    for tag, v in zip(("_lower", "_upper"), extremes(kernel, values)):
        c = extract(kernel, arch, v)
        for k, val in {"read_bytes": c["V_mld"], "write_bytes": c["V_mst"],
                       "reads": c["N_mld"], "writes": c["N_mst"],
                       "read_calls": c["X_mld"], "write_calls": c["X_mst"],
                       "ops": c["ops"]}.items():
            out[k + tag] = val
    for k in [k[:-6] for k in out if k.endswith("_lower")]:
        out[k] = out[k + "_lower"] if out[k + "_lower"] == out[k + "_upper"] else None
    return out
