"""UPMEM cycle bounds from PIMSA-IR counts and toolchain per-body costs.

The architecture supplies per-loop-body costs through its toolchain: dpu-clang
compiles the original DPU source, and inst_count_analyzer records, for every
setting it analyzed, each machine basic block of every kernel function (final
assembly, instruction count, edge-dependent cost), the per-call bounds of
expanded callees, and the barrier (collective) contribution. These records are
read from inst_count_analyzer/results/<BENCH>/<setting>/phases/*/debug.json.
They depend only on the build configuration (BL, TYPE, NR_TASKLETS and other
compile-time macros), not on the input, which is passed at run time.

PIMSA-IR supplies the counts that depend on the input:
  - each loop's total iteration count per tasklet, which pins the execution
    count of its machine loop header (and the per-entry trip count when it is
    the same for every entry);
  - barrier executions per tasklet;
  - MRAM traffic: bytes and DMA calls per direction (metrics.dma_counts).
Blocks inside a loop body other than its header keep the execution frequency
per iteration that the toolchain's own flow analysis found at the stored
input: their stored bound is scaled by (IR iterations / stored iterations) of
the innermost enclosing loop. Callee calls are counted the same way. The
machine-CFG flow problem is then solved by the analyzer's own solver
(generic_cfg.solve_machine_total), and instruction and memory bounds are
composed into cycles by the paper's UPMEM cost model
(draw_figs/scripts/estimate_cost.py, compose_cycle_bounds and its memory model),
with BW_1, t_read, t_write, D and the stall fraction read from arch/upmem.json.

IR loops are matched to machine loops structurally: the loop trees are walked
in preorder, IR loops in source order and machine loops by header block
number, and the nesting depths must agree.
"""
from __future__ import annotations

import json
import re
import sys
from collections import Counter, defaultdict
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
sys.path[:0] = [str(HERE), str(ROOT / "inst_count_analyzer"), str(ROOT / "draw_figs/scripts")]

import estimate_cost as EC  # noqa: E402
from ir import Barrier, For, If, ParFor  # noqa: E402
from lower_cmd import ev, ev_count  # noqa: E402
from upmem_icount.generic_cfg import Bound, LoopInfo, MachineBlock, solve_machine_total  # noqa: E402

import metrics as MX  # noqa: E402

RESULTS = ROOT / "inst_count_analyzer/results"
ARCH = json.loads((HERE / "arch/upmem.json").read_text())


# ----------------------------------------------------------------------------
# IR side
# ----------------------------------------------------------------------------
def _region(kernel):
    regions = [s for s in kernel.body if isinstance(s, ParFor)]
    if len(regions) != 1:
        raise NotImplementedError("one tasklet region expected")
    return regions[0]


def _static(body, env, depth=1, loops=None, bars=None):
    """IR loops (preorder, with depth) and barriers (preorder) that have
    machine code: unrolled loops and dead sides of compile-time branches
    (If.static, evaluated at env) are left out."""
    loops = [] if loops is None else loops
    bars = [] if bars is None else bars
    for s in body:
        if isinstance(s, For):
            if s.lowered:
                continue  # inside a callee or a library call
            if s.unrolled:
                _static(s.body, env, depth, loops, bars)
            else:
                loops.append((s, depth))
                _static(s.body, env, depth + 1, loops, bars)
        elif isinstance(s, If):
            if s.static:
                _static(s.body if ev(s.cond, env) else s.orelse, env, depth, loops, bars)
            else:
                _static(s.body, env, depth, loops, bars)
                _static(s.orelse, env, depth, loops, bars)
        elif isinstance(s, Barrier):
            bars.append(s)
    return loops, bars


def _dynamic(body, env, iters, entries, bar_exec):
    """Execute the control structure: per loop total iterations and per-entry
    trip counts; per barrier executions (keyed by node identity). Loop bodies
    are counted with MX.times (first iteration times the trip count), so the
    work does not grow with the trip count."""
    for s in body:
        if isinstance(s, For):
            lo, st, n = ev(s.lo, env), ev(s.step, env), ev_count(s.trips(), env)
            iters[id(s)] += n
            entries[id(s)].add(n)

            def run(q, s=s, lo=lo, st=st):
                i, e, b = defaultdict(int), defaultdict(set), defaultdict(int)
                _dynamic(s.body, {**env, s.var: lo + q * st}, i, e, b)
                for k, v in e.items():  # per-entry trip sets, merged below
                    entries[k] |= v
                return Counter({("i", k): v for k, v in i.items()}) + \
                    Counter({("b", k): v for k, v in b.items()})

            for (kind, k), v in MX.times(n, run).items():
                (iters if kind == "i" else bar_exec)[k] += v
        elif isinstance(s, If):
            _dynamic(s.body if ev(s.cond, env) else s.orelse, env, iters, entries, bar_exec)
        elif isinstance(s, Barrier):
            bar_exec[id(s)] += 1


def ir_counts(kernel, values, tid):
    """Per tasklet: {loop id: (lo, hi) iterations}, {loop id: per-entry trips or
    None}, {barrier id: (lo, hi) executions}, over the data-dependent extremes."""
    region = _region(kernel)
    res = []
    for v in MX.extremes(kernel, values):
        iters, entries, bars = defaultdict(int), defaultdict(set), defaultdict(int)
        _dynamic(region.body, {**v, region.var: tid}, iters, entries, bars)
        res.append((iters, entries, bars))
    (i0, e0, b0), (i1, e1, b1) = res
    loops = {k: (i0[k], i1[k]) for k in set(i0) | set(i1)}
    # a per-entry trip count is passed on only when it is one integer (an average
    # trip count is not the count of any entry)
    per_entry = {k: (next(iter(e0[k])) if len(e0[k]) == 1 and e0[k] == e1[k]
                     and next(iter(e0[k])) == int(next(iter(e0[k]))) else None)
                 for k in set(e0) | set(e1)}
    bar = {k: (b0[k], b1[k]) for k in set(b0) | set(b1)}
    return loops, per_entry, bar


# ----------------------------------------------------------------------------
# Toolchain side
# ----------------------------------------------------------------------------
def _num(label):
    m = re.match(r"bb(\d+)", label)
    return int(m.group(1)) if m else -1


def _loop_tree(stored):
    """Stored machine-level loops in preorder (roots and children by header number)."""
    def parent(l):
        cands = [p for p in stored if p is not l and l["header"] in p["blocks"]
                 and p["depth"] == l["depth"] - 1]
        return cands[0]["header"] if cands else None
    kids = defaultdict(list)
    for l in stored:
        kids[parent(l)].append(l)
    out = []

    def visit(h):
        for l in sorted(kids[h], key=lambda x: _num(x["header"])):
            out.append(l)
            visit(l["header"])
    visit(None)
    return out


def _innermost(stored, block):
    c = [l for l in stored if block in l["blocks"]]
    return max(c, key=lambda l: l["depth"]) if c else None


def load_setting(bench, setting_id):
    return json.loads((RESULTS / bench / setting_id / "result.json").read_text())


def load_phase(bench, setting_id, result_path):
    p = RESULTS / bench / setting_id / Path(result_path).parent / "debug.json"
    return json.loads(p.read_text())


def phase_bound(kernel, dbg, values) -> dict:
    """Instruction bound of one kernel execution on one DPU (sum over tasklets
    plus collectives), from IR counts and the stored machine code."""
    ir_loops, ir_bars = _static(_region(kernel).body, values)
    lower = upper = 0.0
    checks = []
    bar_exec = None
    for tdata in dbg["per_tasklet"]:
        t = tdata["tid"]
        loops, per_entry, bars = ir_counts(kernel, values, t)
        if bar_exec is None:
            bar_exec = bars
        stored = _loop_tree(tdata["ir_analysis"]["loops"])
        if [d for _, d in ir_loops] != [l["depth"] for l in stored]:
            raise ValueError(f"loop nests differ: IR depths {[d for _, d in ir_loops]}, "
                             f"machine depths {[l['depth'] for l in stored]}")
        sb = {k: (v["lower"], v["upper"]) for k, v in tdata["ir_block_bounds"].items()}
        ratio, infos = {}, []
        for (f, _), l in zip(ir_loops, stored):
            lo, hi = loops.get(id(f), (0, 0))
            slo, shi = sb[l["header"]]
            checks.append((t, l["header"], (lo, hi), (slo, shi)))
            ratio[l["header"]] = (lo / slo if slo else (0 if lo == 0 else None),
                                  hi / shi if shi else (0 if hi == 0 else None))
            sb[l["header"]] = (float(lo), float(hi))
            pe = per_entry.get(id(f))
            infos.append(LoopInfo(kernel.name, l["header"], l["depth"], l["blocks"], [], [],
                                  backedge_count=None if not pe else pe - 1))
        bounds = {}
        for b, (blo, bhi) in sb.items():
            l = _innermost(stored, b)
            if l is None or b == l["header"]:
                bounds[b] = Bound(blo, bhi)
                continue
            rlo, rhi = ratio[l["header"]]
            # a block that never ran stays at 0; a block that ran in a loop
            # whose stored bound is 0 has no per-iteration frequency to scale
            if (rlo is None and blo != 0) or (rhi is None and bhi != 0):
                raise ValueError(f"tid {t}: loop {l['header']} never ran at the stored input")
            bounds[b] = Bound(0.0 if blo == 0 else blo * rlo, 0.0 if bhi == 0 else bhi * rhi)
        blocks = [MachineBlock(**{**{k: v for k, v in mb.items() if k != "execution_bound"},
                                  "successors": list(mb["successors"]),
                                  "edge_instruction_costs": {int(k): v for k, v in
                                                             mb["edge_instruction_costs"].items()}})
                  for mb in tdata["machine"]["machine_blocks"]]
        direct, _, _ = solve_machine_total(blocks, bounds, ir_loops=infos)
        if direct.lower is None or direct.upper is None:
            raise ValueError(f"tid {t}: machine flow problem infeasible or unbounded")
        lo, hi = direct.lower, direct.upper
        for c in tdata["expanded_calls"]:
            n = bounds.get(c["block"], Bound(0.0, 0.0))
            per = c["callee_expanded_bound_per_call"]
            lo += n.lower * per["lower"]
            hi += n.upper * per["upper"]
        lower += lo
        upper += hi
    sites = dbg.get("collective_expansions", [])
    if sites:
        if len(sites) != len(ir_bars):
            raise ValueError(f"{len(sites)} barrier sites in machine code, {len(ir_bars)} in IR")
        for col, b in zip(sites, ir_bars):
            glo, ghi = bar_exec.get(id(b), (0, 0))
            g = col["generations"]
            lower += col["contribution"]["lower"] * glo / g
            upper += col["contribution"]["upper"] * ghi / g
    return {"lower": lower, "upper": upper, "checks": checks,
            "stored": dbg["dynamic_instruction_bound"]}


# ----------------------------------------------------------------------------
# A whole setting (all DPUs, all executions) and its cycle bounds
# ----------------------------------------------------------------------------
def cost_parameters(arch=None) -> dict:
    """The UPMEM cost parameters of the architecture instance: MRAM DMA
    bandwidth BW_1 and fixed costs t_read / t_write (M), the same-tasklet issue
    distance D (P) and the compute stall fraction (cost)."""
    a = arch or ARCH
    return {"bandwidth": a["M"]["BW"]["1"]["value"], "read_latency": a["M"]["t_read"]["value"],
            "write_latency": a["M"]["t_write"]["value"], "issue_distance": a["P"]["D"]["value"],
            "stall_rate": a["cost"]["stall_fraction"]["value"]}


def setting_bounds(mod, setting_id, row, code_setting=None, arch=None) -> dict:
    """`mod` is a prim.<bench> module. `code_setting` names the stored analysis
    whose machine code is used (default: the setting itself); it must share the
    build configuration. Cost parameters come from the architecture instance
    (default arch/upmem.json)."""
    arch = arch or ARCH
    cp = cost_parameters(arch)
    bandwidth, read_latency, write_latency = cp["bandwidth"], cp["read_latency"], cp["write_latency"]
    code_setting = code_setting or setting_id
    top = load_setting(mod.BENCH, code_setting)
    build = json.loads(row["dpu_build_options_json"])
    nt = int(row["num_tasklets"])
    inputs = json.loads(row["dpu_execution_inputs_json"])
    per_dpu = defaultdict(list)
    for ex in inputs:
        per_dpu[ex["dpu"]].append(ex)
    # machine code per kernel function, from the code setting (any DPU's phase)
    code = {}
    for d in top["per_dpu"]:
        for ph in d["phases"]:
            code.setdefault(ph["function"], ph["result_path"])
    cache = {}
    ins_lo = ins_hi = 0.0
    mem_lo = mem_hi = 0.0
    tot = defaultdict(float)
    checks = []
    for dpu, execs in per_dpu.items():
        lo = hi = mlo = mhi = 0.0
        for ex in sorted(execs, key=lambda e: e["execution"]):
            fn = ex["function"]
            kern = mod.FUNCTIONS[fn]()
            v = mod.values(ex["params"], build, nt)
            key = (fn, json.dumps(ex["params"], sort_keys=True))
            if key not in cache:
                dbg = load_phase(mod.BENCH, code_setting, code[fn])
                pb = phase_bound(kern, dbg, v)
                dma = MX.dma_counts(kern, arch, v)
                cache[key] = (pb, dma)
            pb, dma = cache[key]
            checks.extend(pb["checks"])
            lo += pb["lower"]
            hi += pb["upper"]
            for k in ("read_bytes", "write_bytes", "reads", "writes", "read_calls", "write_calls"):
                tot[k + "_lower"] += dma[k + "_lower"]
                tot[k + "_upper"] += dma[k + "_upper"]
            mlo += ((dma["read_bytes_lower"] + dma["write_bytes_lower"]) / bandwidth
                    + dma["read_calls_lower"] * read_latency + dma["write_calls_lower"] * write_latency)
            mhi += ((dma["read_bytes_upper"] + dma["write_bytes_upper"]) / bandwidth
                    + dma["read_calls_upper"] * read_latency + dma["write_calls_upper"] * write_latency)
        ins_lo, ins_hi = max(ins_lo, lo), max(ins_hi, hi)
        mem_lo, mem_hi = max(mem_lo, mlo), max(mem_hi, mhi)
    comp = EC.compose_cycle_bounds(ins_lo, ins_hi, mem_lo, mem_hi, nt, cp["stall_rate"],
                                  cp["issue_distance"])
    return {"instructions": (ins_lo, ins_hi), "memory_cycles": (mem_lo, mem_hi), "dma_total": dict(tot),
            "cycles": (comp["composed_lower"], comp["composed_upper"]), "compose": comp,
            "checks": checks, "stored_instructions": (top["dynamic_instruction_bound"]["lower"],
                                                      top["dynamic_instruction_bound"]["upper"])}


def setting_id(row, bench):
    return (f"{row['experiment']}_{bench}_dpu{row['num_dpus']}_tasklets{row['num_tasklets']}"
            f"_size{row['data_prep_params']}")
