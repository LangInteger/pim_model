from __future__ import annotations

import json
import math
import re
import subprocess
from dataclasses import dataclass, asdict
from pathlib import Path
from typing import Iterable

import numpy as np
from scipy.optimize import linprog


# ---------- Source/IR parameter discovery ----------

def parse_dpu_argument_fields(benchmark_dir: Path) -> list[str]:
    """Return dpu_arguments_t field names in declaration order.

    This is intentionally small and C-oriented, but it handles the enum field
    style used by the PrIM benchmarks. LLVM IR remains the source of truth for
    the actual field types; this routine only supplies field *names*.
    """
    texts = []
    for p in sorted((benchmark_dir / "support").glob("*.h")):
        texts.append(p.read_text(errors="replace"))
    text = "\n".join(texts)
    m = re.search(r"typedef\s+struct\s*\{(.*?)\}\s*dpu_arguments_t\s*;", text, re.S)
    if not m:
        return []
    body = m.group(1)
    fields: list[str] = []

    # Replace nested enum definitions by just their declarator, e.g.
    #   enum kernels { ... } kernel;  -> int kernel;
    body = re.sub(
        r"enum\s+[A-Za-z_]\w*\s*\{.*?\}\s*([A-Za-z_]\w*)\s*;",
        lambda mm: f"int {mm.group(1)};",
        body,
        flags=re.S,
    )
    body = re.sub(r"/\*.*?\*/", "", body, flags=re.S)
    body = re.sub(r"//.*", "", body)
    for decl in body.split(";"):
        decl = decl.strip()
        if not decl:
            continue
        # Last identifier before an optional array suffix is the field name.
        mm = re.search(r"([A-Za-z_]\w*)\s*(?:\[[^\]]*\])?\s*$", decl)
        if mm:
            fields.append(mm.group(1))
    return fields


def _llvm_int_constant(ty: str, value) -> str | None:
    if re.fullmatch(r"i\d+", ty):
        try:
            return str(int(value, 0) if isinstance(value, str) else int(value))
        except Exception:
            return None
    # Floating point parameters are not currently specialized because LLVM's
    # textual canonical FP literal syntax is more restrictive. They are usually
    # not loop-control variables in the PrIM kernels; leaving them symbolic is safe.
    return None


def specialize_ir_text(ir_text: str, benchmark_dir: Path, tid: int, params: dict[str, object]) -> tuple[str, dict]:
    """Specialize only analysis values, never the machine-code build.

    The original optimized IR is left structurally intact as much as possible.
    We replace the tasklet-id intrinsic and direct loads from DPU_INPUT_ARGUMENTS
    with SSA constants represented as `select true, c, c`. Later analysis passes
    can fold them, while the real machine instruction counts are still obtained
    from the unspecialized code.
    """
    fields = parse_dpu_argument_fields(benchmark_dir)
    replacements = {"tid": 0, "dpu_args": 0, "skipped_non_integer": []}

    # Tasklet id calls.
    tid_pat = re.compile(
        r"^(\s*)(%[-A-Za-z$._0-9]+)\s*=\s*(?:tail\s+)?call\s+i32\s+@llvm\.dpu\.tid\.i32\(\)[^\n]*$",
        re.M,
    )
    def repl_tid(m):
        replacements["tid"] += 1
        return f"{m.group(1)}{m.group(2)} = select i1 true, i32 {int(tid)}, i32 {int(tid)}"
    ir_text = tid_pat.sub(repl_tid, ir_text)

    # Direct loads from DPU_INPUT_ARGUMENTS. The optimized PrIM IR uses this
    # canonical GEP form for the benchmark arguments.
    load_pat = re.compile(
        r"^(\s*)(%[-A-Za-z$._0-9]+)\s*=\s*load\s+([^,]+),\s+[^\n]*?"
        r"getelementptr\s+inbounds\s*\(%struct\.dpu_arguments_t,\s*%struct\.dpu_arguments_t\*\s*@DPU_INPUT_ARGUMENTS,\s*"
        r"i32\s+0,\s*i32\s+(\d+)\)[^\n]*$",
        re.M,
    )
    def repl_arg(m):
        indent, ssa, ty, idxs = m.group(1), m.group(2), m.group(3).strip(), m.group(4)
        idx = int(idxs)
        name = fields[idx] if idx < len(fields) else f"field_{idx}"
        if name not in params:
            return m.group(0)
        c = _llvm_int_constant(ty, params[name])
        if c is None:
            replacements["skipped_non_integer"].append({"field": name, "type": ty, "value": params[name]})
            return m.group(0)
        replacements["dpu_args"] += 1
        return f"{indent}{ssa} = select i1 true, {ty} {c}, {ty} {c}"
    ir_text = load_pat.sub(repl_arg, ir_text)
    replacements["fields"] = fields
    return ir_text, replacements


# ---------- LLVM IR CFG ----------

@dataclass
class IRBlock:
    function: str
    name: str
    successors: list[str]
    constant_successor: str | None
    terminator: str


@dataclass
class LoopInfo:
    function: str
    header: str
    depth: int
    blocks: list[str]
    latch_blocks: list[str]
    exiting_blocks: list[str]
    backedge_count: int | None = None

    @property
    def trip_count(self) -> int | None:
        return None if self.backedge_count is None else self.backedge_count + 1


def parse_ir_cfg(text: str) -> dict[str, dict[str, IRBlock]]:
    functions: dict[str, dict[str, IRBlock]] = {}
    cur_fn = None
    cur_block = None
    block_lines: list[str] = []

    def finish_block():
        nonlocal cur_block, block_lines
        if cur_fn is None or cur_block is None:
            return
        body = "\n".join(block_lines)
        # Last IR terminator is enough. Support br/switch/ret/unreachable.
        term_lines = [ln.strip() for ln in block_lines if ln.strip().startswith(("br ", "switch ", "ret ", "unreachable", "indirectbr "))]
        term = term_lines[-1] if term_lines else ""
        succ: list[str] = []
        const_succ = None
        m = re.search(r"br\s+label\s+%([-A-Za-z$._0-9]+)", term)
        if m:
            succ = [m.group(1)]
            const_succ = succ[0]
        else:
            m = re.search(r"br\s+i1\s+(true|false),\s*label\s+%([-A-Za-z$._0-9]+),\s*label\s+%([-A-Za-z$._0-9]+)", term)
            if m:
                succ = [m.group(2), m.group(3)]
                const_succ = m.group(2) if m.group(1) == "true" else m.group(3)
            else:
                m = re.search(r"br\s+i1\s+[^,]+,\s*label\s+%([-A-Za-z$._0-9]+),\s*label\s+%([-A-Za-z$._0-9]+)", term)
                if m:
                    succ = [m.group(1), m.group(2)]
                elif term.startswith("switch "):
                    succ = re.findall(r"label\s+%([-A-Za-z$._0-9]+)", body[body.rfind("switch "):])
        functions.setdefault(cur_fn, {})[cur_block] = IRBlock(cur_fn, cur_block, succ, const_succ, term)
        cur_block = None
        block_lines = []

    in_fn = False
    for line in text.splitlines():
        fm = re.match(r"^define\b.*@([^\s(]+)\(", line)
        if fm:
            finish_block()
            cur_fn = fm.group(1)
            functions[cur_fn] = {}
            in_fn = True
            # instnamer names the entry block "bb", but tolerate an implicit entry.
            cur_block = "bb"
            block_lines = []
            continue
        if in_fn and line.strip() == "}":
            finish_block()
            cur_fn = None
            in_fn = False
            continue
        if not in_fn:
            continue
        bm = re.match(r"^([-A-Za-z$._0-9]+):\s*(?:;.*)?$", line)
        if bm:
            finish_block()
            cur_block = bm.group(1)
            block_lines = []
            continue
        if cur_block is not None:
            block_lines.append(line)
    finish_block()
    return functions


def parse_loop_analysis(text: str) -> dict[str, list[LoopInfo]]:
    out: dict[str, list[LoopInfo]] = {}
    cur_fn = None
    for raw in text.splitlines():
        fm = re.search(r"for function '([^']+)'", raw)
        if fm:
            cur_fn = fm.group(1)
            out.setdefault(cur_fn, [])
            continue
        lm = re.search(r"Loop at depth\s+(\d+)\s+containing:\s*(.*)$", raw)
        if lm and cur_fn:
            depth = int(lm.group(1))
            toks = [x.strip() for x in lm.group(2).split(",") if x.strip()]
            blocks=[]; header=None; latches=[]; exiting=[]
            for tok in toks:
                nm = re.match(r"%([-A-Za-z$._0-9]+)", tok)
                if not nm: continue
                b=nm.group(1); blocks.append(b)
                if "<header>" in tok: header=b
                if "<latch>" in tok: latches.append(b)
                if "<exiting>" in tok: exiting.append(b)
            if header:
                out[cur_fn].append(LoopInfo(cur_fn, header, depth, blocks, latches, exiting))
    return out


def parse_scev_constant_backedges(text: str) -> dict[tuple[str,str], int | None]:
    cur_fn=None
    result: dict[tuple[str,str], int | None]={}
    for raw in text.splitlines():
        fm=re.search(r"for function '([^']+)'", raw)
        if fm:
            cur_fn=fm.group(1); continue
        lm=re.search(r"Loop %([-A-Za-z$._0-9]+):\s+backedge-taken count is\s+(.+)$",raw)
        if lm and cur_fn:
            expr=lm.group(2).strip()
            if re.fullmatch(r"\d+",expr): result[(cur_fn,lm.group(1))]=int(expr)
            else: result[(cur_fn,lm.group(1))]=None
        um=re.search(r"Loop %([-A-Za-z$._0-9]+):\s+Unpredictable backedge-taken count",raw)
        if um and cur_fn:
            result[(cur_fn,um.group(1))]=None
    return result



@dataclass
class IRCallSite:
    function: str
    block: str
    callee: str
    args: list[tuple[str, str]]
    text: str


def _split_ir_args(text: str) -> list[str]:
    parts=[]; start=0; depth=0
    opens='([{<'; closes=')]}>'
    pairs={')':'(',']':'[','}':'{','>':'<'}
    stack=[]
    for i,ch in enumerate(text):
        if ch in opens:
            stack.append(ch)
        elif ch in closes and stack and stack[-1]==pairs[ch]:
            stack.pop()
        elif ch==',' and not stack:
            parts.append(text[start:i].strip()); start=i+1
    tail=text[start:].strip()
    if tail: parts.append(tail)
    return parts


def parse_ir_callsites(text: str) -> dict[str, list[IRCallSite]]:
    """Parse direct LLVM IR call sites, grouped by function.

    This intentionally records only direct @callee calls. Indirect calls remain
    unresolved and therefore cannot silently contribute a fabricated count.
    """
    out: dict[str,list[IRCallSite]]={}
    cur_fn=None; cur_block='bb'
    for raw in text.splitlines():
        fm=re.match(r'^define\b.*@([-A-Za-z$._0-9]+)\((.*)\).*\{\s*$',raw)
        if fm:
            cur_fn=fm.group(1); cur_block='bb'; out.setdefault(cur_fn,[]); continue
        if cur_fn and raw.strip()=='}':
            cur_fn=None; continue
        if not cur_fn: continue
        bm=re.match(r'^([-A-Za-z$._0-9]+):\s*(?:;.*)?$',raw)
        if bm:
            cur_block=bm.group(1); continue
        # Direct calls only. The argument list in these kernels is single-line.
        cm=re.search(r'\b(?:tail\s+)?call\b.*?@([-A-Za-z$._0-9]+)\((.*)\)',raw)
        if not cm: continue
        callee=cm.group(1)
        # LLVM intrinsics are lowered inside the caller's machine blocks and
        # therefore must not be treated as missing interprocedural callees.
        if callee.startswith('llvm.'):
            continue
        args=[]
        for a in _split_ir_args(cm.group(2)):
            # Capture the leading LLVM type and final operand token. Attributes
            # may appear between them; only integer scalar args are specialized.
            tm=re.match(r'\s*([^\s]+)\s+(.+)$',a)
            if not tm: continue
            ty=tm.group(1); rest=tm.group(2).strip()
            # Strip common parameter attributes to recover the operand token.
            val=rest.split()[-1]
            args.append((ty,val))
        out[cur_fn].append(IRCallSite(cur_fn,cur_block,callee,args,raw.strip()))
    return out


def parse_scev_scalar_constants(text: str) -> dict[tuple[str,str], int]:
    """Return SSA values that ScalarEvolution proves to be integer constants."""
    cur_fn=None; pending=None; result={}
    for raw in text.splitlines():
        fm=re.search(r"for function '([^']+)'",raw)
        if fm:
            cur_fn=fm.group(1); pending=None; continue
        vm=re.match(r'\s*(%[-A-Za-z$._0-9]+)\s*=\s*',raw)
        if vm and cur_fn:
            pending=vm.group(1); continue
        em=re.match(r'\s*-->\s+(-?\d+)\s+(?:U:|S:|LoopDispositions:|$)',raw)
        if em and cur_fn and pending:
            result[(cur_fn,pending)]=int(em.group(1)); pending=None
        elif raw.strip() and not raw.lstrip().startswith('-->') and not vm:
            # Keep pending across the immediate SCEV arrow only.
            if not raw.startswith(' '): pending=None
    return result


def _function_argument_names(ir_text: str, function: str) -> list[tuple[str,str]]:
    fm=re.search(r'^define\b.*@'+re.escape(function)+r'\((.*?)\).*\{\s*$',ir_text,re.M)
    if not fm: return []
    out=[]
    for a in _split_ir_args(fm.group(1)):
        nm=re.findall(r'(%[-A-Za-z$._0-9]+)',a)
        ty=re.match(r'\s*([^\s]+)',a)
        if nm and ty: out.append((ty.group(1),nm[-1]))
        else: out.append((ty.group(1) if ty else '', ''))
    return out


def specialize_function_arguments_ir_text(ir_text: str, function: str, arg_constants: dict[int,int] | None) -> tuple[str,dict]:
    """Analysis-only specialization of scalar function arguments.

    The original IR/MIR used for machine costs is never changed. Only the
    analysis copy is specialized, allowing SCEV to derive callee loop counts
    from constants discovered at a caller's call site.
    """
    arg_constants=arg_constants or {}
    if not arg_constants: return ir_text, {'function':function,'args':{}}
    args=_function_argument_names(ir_text,function)
    repl={}
    for idx,val in arg_constants.items():
        if idx>=len(args): continue
        ty,name=args[idx]
        if not name or not re.fullmatch(r'i\d+',ty): continue
        repl[name]=int(val)
    if not repl: return ir_text, {'function':function,'args':{}}

    lines=ir_text.splitlines()
    in_fn=False; out=[]
    start_pat=re.compile(r'^define\b.*@'+re.escape(function)+r'\(')
    for line in lines:
        if start_pat.match(line):
            in_fn=True; out.append(line); continue
        if in_fn and line.strip()=='}':
            in_fn=False; out.append(line); continue
        if in_fn:
            for name,val in repl.items():
                line=re.sub(r'(?<![-A-Za-z$._0-9])'+re.escape(name)+r'\b',str(val),line)
        out.append(line)
    return '\n'.join(out)+'\n', {'function':function,'args':repl}


def resolve_callsite_integer_args(call: IRCallSite, scalar_constants: dict[tuple[str,str],int]) -> dict[int,int]:
    resolved={}
    for idx,(ty,val) in enumerate(call.args):
        if not re.fullmatch(r'i\d+',ty): continue
        if re.fullmatch(r'-?\d+',val):
            resolved[idx]=int(val)
        elif val.startswith('%') and (call.function,val) in scalar_constants:
            resolved[idx]=scalar_constants[(call.function,val)]
    return resolved

def run_opt_analysis(opt: str, named_ir: Path, benchmark_dir: Path, tid: int, params: dict[str,object], outdir: Path, function: str | None=None, function_args: dict[int,int] | None=None) -> dict:
    outdir.mkdir(parents=True, exist_ok=True)
    spec_text, repl = specialize_ir_text(named_ir.read_text(), benchmark_dir, tid, params)
    fn_repl={'function':function,'args':{}}
    if function and function_args:
        spec_text, fn_repl = specialize_function_arguments_ir_text(spec_text,function,function_args)
    spec = outdir / f"specialized_tid{tid}.ll"
    spec.write_text(spec_text)
    analyzed = outdir / f"analysis_tid{tid}.ll"
    cmd=[opt,'-S','-sccp','-instcombine','-loop-simplify','-indvars',str(spec),'-o',str(analyzed)]
    p=subprocess.run(cmd,text=True,capture_output=True)
    if p.returncode!=0:
        raise RuntimeError(f"opt specialization failed: {' '.join(cmd)}\n{p.stdout}\n{p.stderr}")
    loops_txt = subprocess.run([opt,'-analyze','-loops',str(analyzed)],text=True,capture_output=True)
    scev_txt = subprocess.run([opt,'-analyze','-scalar-evolution',str(analyzed)],text=True,capture_output=True)
    lt=(loops_txt.stdout or '')+(loops_txt.stderr or '')
    st=(scev_txt.stdout or '')+(scev_txt.stderr or '')
    (outdir/f"loops_tid{tid}.txt").write_text(lt)
    (outdir/f"scev_tid{tid}.txt").write_text(st)
    cfg=parse_ir_cfg(analyzed.read_text())
    loops=parse_loop_analysis(lt)
    backs=parse_scev_constant_backedges(st)
    for fn, lis in loops.items():
        for li in lis: li.backedge_count=backs.get((fn,li.header))
    scalar_constants=parse_scev_scalar_constants(st)
    callsites=parse_ir_callsites(analyzed.read_text())
    return {'cfg':cfg,'loops':loops,'replacements':repl,'function_arg_replacements':fn_repl,'scalar_constants':scalar_constants,'callsites':callsites,'analysis_ir':str(analyzed)}


# ---------- Generic linear-flow solver ----------

@dataclass
class Bound:
    lower: float | None
    upper: float | None

    @property
    def exact(self):
        return self.lower is not None and self.upper is not None and abs(self.lower-self.upper)<1e-7

    def to_dict(self):
        d=asdict(self); d['exact']=self.exact
        if self.exact: d['value']=round(self.lower)
        return d


def _reachable_blocks(blocks: dict[str, IRBlock], entry: str) -> set[str]:
    seen=set(); stack=[entry]
    while stack:
        b=stack.pop()
        if b in seen or b not in blocks: continue
        seen.add(b); blk=blocks[b]
        succ=[blk.constant_successor] if blk.constant_successor else blk.successors
        for s in succ:
            if s and s not in seen: stack.append(s)
    return seen


def solve_ir_block_bounds(
    blocks: dict[str, IRBlock],
    loops: list[LoopInfo],
    entry: str = 'bb',
    unknown_loop_backedge_upper: int | None = None,
    unknown_loop_backedge_bounds: dict[str, Bound] | None = None,
) -> tuple[dict[str,Bound], dict]:
    names=list(blocks)
    if entry not in blocks:
        entry=names[0]
    reachable=_reachable_blocks(blocks,entry)
    edges=[]
    for b,blk in blocks.items():
        for s in blk.successors:
            if s in blocks: edges.append((b,s))
    nx=len(names); ne=len(edges); nvar=nx+ne
    xi={b:i for i,b in enumerate(names)}; ei={e:nx+i for i,e in enumerate(edges)}
    Aeq=[]; beq=[]; Aub=[]; bub=[]
    def eq(row, rhs=0.0): Aeq.append(row); beq.append(rhs)
    # Block flow conservation.
    for b in names:
        row=np.zeros(nvar); row[xi[b]]=1
        for e in edges:
            if e[1]==b: row[ei[e]]-=1
        rhs=1.0 if b==entry else 0.0
        eq(row,rhs)
    # Outflow = executions for non-return blocks.
    for b,blk in blocks.items():
        if not blk.successors: continue
        row=np.zeros(nvar); row[xi[b]]=-1
        for e in edges:
            if e[0]==b: row[ei[e]]+=1
        eq(row,0)
    # Constant branches and unreachable blocks.
    for b,blk in blocks.items():
        if blk.constant_successor and len(blk.successors)>1:
            for s in blk.successors:
                if s!=blk.constant_successor and (b,s) in ei:
                    row=np.zeros(nvar); row[ei[(b,s)]]=1; eq(row,0)
    for b in names:
        if b not in reachable:
            row=np.zeros(nvar); row[xi[b]]=1; eq(row,0)
    # Loop relation: total backedges = BTC * number of entries into header.
    unknown_loops=[]
    bounded_unknown_loops=[]
    for li in loops:
        if li.header not in blocks or li.header not in reachable: continue
        loopset=set(li.blocks)
        back=[e for e in edges if e[1]==li.header and e[0] in loopset]
        ext=[e for e in edges if e[1]==li.header and e[0] not in loopset]
        if li.backedge_count is None:
            source_bound=(unknown_loop_backedge_bounds or {}).get(li.header)
            lower=source_bound.lower if source_bound is not None else None
            upper=source_bound.upper if source_bound is not None else None
            if upper is None:
                upper=unknown_loop_backedge_upper
            if upper is None:
                unknown_loops.append(li.header); continue
            implicit_entry=1.0 if li.header==entry else 0.0
            if lower is not None and lower==upper:
                row=np.zeros(nvar)
                for e in back: row[ei[e]]+=1
                for e in ext: row[ei[e]]-=upper
                eq(row,float(upper)*implicit_entry)
            else:
                # backedges <= U * loop entries. A function-entry loop
                # receives one implicit entry from the invocation itself.
                row=np.zeros(nvar)
                for e in back: row[ei[e]]+=1
                for e in ext: row[ei[e]]-=upper
                Aub.append(row); bub.append(float(upper)*implicit_entry)
                if lower is not None and lower>0:
                    row=np.zeros(nvar)
                    for e in back: row[ei[e]]-=1
                    for e in ext: row[ei[e]]+=lower
                    Aub.append(row); bub.append(-float(lower)*implicit_entry)
            bounded_unknown_loops.append(
                {
                    "header": li.header,
                    "backedge_lower": lower,
                    "backedge_upper": upper,
                    "source_specific": source_bound is not None,
                }
            )
            continue
        row=np.zeros(nvar)
        for e in back: row[ei[e]]+=1
        for e in ext: row[ei[e]]-=li.backedge_count
        # Function-entry loop: entry injection is one invocation.
        rhs=float(li.backedge_count) if li.header==entry else 0.0
        eq(row,rhs)
    bounds=[(0,None)]*nvar
    A=np.array(Aeq) if Aeq else None; B=np.array(beq) if beq else None
    AU=np.array(Aub) if Aub else None; BU=np.array(bub) if bub else None
    result={}
    status={}
    for b in names:
        c=np.zeros(nvar); c[xi[b]]=1
        lo=linprog(c,A_ub=AU,b_ub=BU,A_eq=A,b_eq=B,bounds=bounds,method='highs')
        hi=linprog(-c,A_ub=AU,b_ub=BU,A_eq=A,b_eq=B,bounds=bounds,method='highs')
        lower=float(lo.fun) if lo.success else None
        upper=float(-hi.fun) if hi.success else None
        result[b]=Bound(lower,upper)
        status[b]={'min_status':lo.message,'max_status':hi.message}
    return result, {
        'unknown_loops': unknown_loops,
        'bounded_unknown_loops': bounded_unknown_loops,
        'reachable': sorted(reachable),
        'solver_status': status,
    }


# ---------- MIR machine CFG ----------

@dataclass
class MachineBlock:
    function: str
    key: str
    number: int
    label: str
    ir_block: str | None
    successors: list[int]
    instructions: int
    calls: list[str]


def run_late_mir(llc: str, named_ir: Path, out_path: Path) -> None:
    cmd=[llc,'-mtriple=dpu-upmem-dpurte','-stop-after=livedebugvalues',str(named_ir),'-o',str(out_path)]
    p=subprocess.run(cmd,text=True,capture_output=True)
    if p.returncode!=0:
        raise RuntimeError(f"llc MIR failed: {' '.join(cmd)}\n{p.stdout}\n{p.stderr}")


def parse_mir(text: str, ir_block_names: dict[str,set[str]] | None=None) -> dict[str,list[MachineBlock]]:
    out: dict[str,list[MachineBlock]]={}
    cur_fn=None; cur=None; blocks=[]; in_body=False
    def finish():
        nonlocal cur
        if cur is not None:
            blocks.append(cur); cur=None
    def finish_fn():
        nonlocal blocks
        finish()
        if cur_fn and blocks: out[cur_fn]=blocks
        blocks=[]
    for raw in text.splitlines():
        if raw.startswith('name:'):
            finish_fn(); cur_fn=raw.split(':',1)[1].strip(); in_body=False; continue
        if cur_fn and raw.startswith('body:'):
            in_body=True; continue
        if not in_body: continue
        bm=re.match(r'^  bb\.(\d+)([^:]*):',raw)
        if bm:
            finish(); num=int(bm.group(1)); suffix=bm.group(2).lstrip('.')
            label=f"bb.{num}" + (f".{suffix}" if suffix else '')
            ir=None
            mm=re.search(r'\(%ir-block\.([^\)]+)\)',raw)
            if mm: ir=mm.group(1)
            elif ir_block_names and cur_fn in ir_block_names:
                # instnamer causes exact IR block names to appear as suffixes.
                if suffix in ir_block_names[cur_fn]: ir=suffix
            cur=MachineBlock(cur_fn,label,num,label,ir,[],0,[]); continue
        if cur is None: continue
        sm=re.match(r'^\s+successors:\s*(.*)$',raw)
        if sm:
            cur.successors=[int(x) for x in re.findall(r'%bb\.(\d+)',sm.group(1))]; continue
        if not raw.startswith('    '): continue
        s=raw.strip()
        if not s or s.startswith(('successors:','liveins:','DBG_VALUE','CFI_INSTRUCTION','frame-setup CFI_INSTRUCTION','#',';')): continue
        # CFI directives do not emit DPU instructions; all remaining late MIR MIs
        # at this pass correspond one-for-one with final instructions for tested DPU kernels.
        cur.instructions += 1
        cm=re.search(r'\bCALL\w*.*?@([-A-Za-z$._0-9]+)',s)
        if cm: cur.calls.append(cm.group(1))
    finish_fn()
    return out


def solve_machine_total(blocks: list[MachineBlock], ir_bounds: dict[str,Bound]) -> tuple[Bound,dict[str,Bound],dict]:
    if not blocks: return Bound(None,None),{}, {'reason':'no machine blocks'}
    nums=[b.number for b in blocks]; bynum={b.number:b for b in blocks}; entry=blocks[0].number
    edges=[]
    for b in blocks:
        for s in b.successors:
            if s in bynum: edges.append((b.number,s))
    nx=len(nums); ne=len(edges); nvar=nx+ne
    xi={b:i for i,b in enumerate(nums)}; ei={e:nx+i for i,e in enumerate(edges)}
    Aeq=[];beq=[]; Aub=[];bub=[]
    def eq(row,rhs=0): Aeq.append(row);beq.append(rhs)
    def ub(row,rhs): Aub.append(row);bub.append(rhs)
    for n in nums:
        row=np.zeros(nvar);row[xi[n]]=1
        for e in edges:
            if e[1]==n: row[ei[e]]-=1
        eq(row,1.0 if n==entry else 0.0)
    for b in blocks:
        if not b.successors: continue
        row=np.zeros(nvar);row[xi[b.number]]=-1
        for e in edges:
            if e[0]==b.number: row[ei[e]]+=1
        eq(row,0)
    # One IR basic block may lower to several machine basic blocks.  In
    # particular, PHI elimination can create several predecessor-specific MBBs
    # carrying the same ``%ir-block`` annotation before they converge on the
    # block that contains the actual instructions.  Constraining *each* such
    # MBB to the IR execution count is incorrect: only one predecessor path is
    # taken per IR-block execution, and the resulting constraints can become
    # infeasible.
    #
    # Anchor the execution count to a representative MBB that is reached from
    # every external entry into the group.  With ordinary one-to-one lowering
    # that is the sole MBB.  With PHI/critical-edge lowering it is the first
    # common convergence block (for example, two predecessor-specific copies
    # followed by the actual IR block).  Anchoring external *flow* instead is
    # insufficient for a loop consisting of one self-looping MBB: external
    # flow counts loop entries, whereas the IR bound counts all iterations.
    groups: dict[str, set[int]] = {}
    for block in blocks:
        if block.ir_block and block.ir_block in ir_bounds:
            groups.setdefault(block.ir_block, set()).add(block.number)

    anchors=[]
    def reachable_within(start: int, members: set[int]) -> dict[int, int]:
        distance={start:0}
        pending=[start]
        while pending:
            current=pending.pop(0)
            for successor in bynum[current].successors:
                if successor in members and successor not in distance:
                    distance[successor]=distance[current]+1
                    pending.append(successor)
        return distance

    for ir_block, members in groups.items():
        bd=ir_bounds[ir_block]
        entry_targets={
            edge[1] for edge in edges
            if edge[1] in members and edge[0] not in members
        }
        if entry in members:
            entry_targets.add(entry)
        if not entry_targets:
            # An unreachable group has no external predecessor.  Any member is
            # sufficient; its IR bound will normally be exactly zero.
            entry_targets.add(min(members))
        reachability=[reachable_within(target,members) for target in entry_targets]
        common=set.intersection(*(set(paths) for paths in reachability))
        representative=None
        if common:
            # Choose the earliest common convergence point.  This minimizes
            # the maximum distance from any alternative group entry.
            representative=min(
                common,
                key=lambda number:(
                    max(paths[number] for paths in reachability), number
                ),
            )
            if bd.lower is not None:
                row=np.zeros(nvar); row[xi[representative]]=-1
                ub(row,-bd.lower)
            if bd.upper is not None:
                row=np.zeros(nvar); row[xi[representative]]=1
                ub(row,bd.upper)
        else:
            # Conservatively bound every fragment.  This fallback is expected
            # only for target lowering that branches out of an IR block before
            # reconverging; it prevents artificial unbounded machine cycles.
            for number in members:
                if bd.upper is not None:
                    row=np.zeros(nvar); row[xi[number]]=1
                    ub(row,bd.upper)
        anchors.append({
            'machine_blocks':[bynum[number].label for number in sorted(members)],
            'ir_block':ir_block,
            'anchor_kind':'common_group_representative' if representative is not None else 'per_fragment_upper_fallback',
            'entry_machine_blocks':[bynum[number].label for number in sorted(entry_targets)],
            'representative_machine_block':bynum[representative].label if representative is not None else None,
            'bound':bd.to_dict(),
        })
    bounds=[(0,None)]*nvar
    AeqN=np.array(Aeq) if Aeq else None;beqN=np.array(beq) if beq else None
    AubN=np.array(Aub) if Aub else None;bubN=np.array(bub) if bub else None
    def solve(c): return linprog(c,A_ub=AubN,b_ub=bubN,A_eq=AeqN,b_eq=beqN,bounds=bounds,method='highs')
    block_bounds={}
    for n in nums:
        c=np.zeros(nvar);c[xi[n]]=1
        lo=solve(c);hi=solve(-c)
        block_bounds[bynum[n].label]=Bound(float(lo.fun) if lo.success else None,float(-hi.fun) if hi.success else None)
    c=np.zeros(nvar)
    for b in blocks: c[xi[b.number]]=b.instructions
    lo=solve(c);hi=solve(-c)
    total=Bound(float(lo.fun) if lo.success else None,float(-hi.fun) if hi.success else None)
    return total,block_bounds,{'anchors':anchors,'machine_blocks':[{**asdict(b),'execution_bound':block_bounds[b.label].to_dict()} for b in blocks]}


def add_bounds(a: Bound,b: Bound)->Bound:
    lo=None if a.lower is None or b.lower is None else a.lower+b.lower
    hi=None if a.upper is None or b.upper is None else a.upper+b.upper
    return Bound(lo,hi)


def mul_bounds(a: Bound,b: Bound)->Bound:
    # Execution/instruction bounds are non-negative in this analyzer.
    lo=None if a.lower is None or b.lower is None else a.lower*b.lower
    hi=None if a.upper is None or b.upper is None else a.upper*b.upper
    return Bound(lo,hi)
