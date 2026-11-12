"""PIMSA-IR: the unified program representation (paper Sec. 3.2).

A kernel is <name, params, body>. Its statements are the paper's grammar:
sequential `For` loops, `ParFor` parallel regions, slice assignments between
arrays in host (H), memory (M), buffer (B) and register (R) space, and
`Barrier`. Nothing in a program says how the target realizes it: vector width,
whether a parallel region runs as threads or as lockstep PIM blocks, how a
memory slice becomes DRAM commands or DMA beats, and how a kernel is launched
are properties of the architecture instance (arch JSON) and are applied by
metric extraction and by the target lowering.

Index expressions and extents are sympy expressions over the kernel
parameters, loop variables and deployment symbols, so the same tree serves the
symbolic pass (trip counts as formulas) and the concrete pass (one instance).
"""
from __future__ import annotations

from dataclasses import dataclass, field
from typing import Union

import sympy as sp

Expr = Union[sp.Expr, int]

SPACES = ("H", "M", "B", "R")


@dataclass(frozen=True)
class Array:
    """An array in one space. `base_bytes` is its placement inside one memory
    unit (a bank for HBM-PIM, the MRAM heap for UPMEM): part of the program's
    data layout, not of the architecture."""
    name: str
    space: str
    elem_bytes: int
    base_bytes: Expr = 0

    def __post_init__(self):
        assert self.space in SPACES, self.space


@dataclass(frozen=True)
class Ref:
    """Slice array[loc..., off : off + n] of `n` elements.

    `loc` is the location identifier vector m / b / r of the paper, keyed by the
    architecture's hierarchy level names (e.g. {"bank": b}). Levels a program
    leaves out are implied by the enclosing parallel region (the PU or PIM block
    executing the statement)."""
    array: Array
    off: Expr
    n: Expr = 1
    loc: tuple = ()  # tuple of (level, expr)

    def at(self, level):
        for k, v in self.loc:
            if k == level:
                return v
        return None


@dataclass(frozen=True)
class Assign:
    """dst <- op(srcs). op is the target-level primitive ("copy", "add", "mul",
    "mac", "relu"); computation is counted at the granularity of the target
    primitive (paper Sec. 4.1)."""
    dst: Ref
    op: str
    srcs: tuple
    src: str = ""


@dataclass(frozen=True)
class For:
    """Sequential counted loop: var = lo, lo+step, ... while var < hi.
    `src` anchors the loop to the original source (file:line); targets whose
    per-body cost comes from their toolchain (UPMEM) use it to find the body's
    machine code."""
    var: sp.Symbol
    hi: Expr
    body: tuple
    lo: Expr = 0
    step: Expr = 1
    src: str = ""
    unrolled: bool = False  # fully unrolled by the target compiler (no machine loop)
    # the loop is not a loop of this function's machine code: it runs inside a
    # noinline callee ("callee:read_tile_step2") or was replaced by a library
    # call ("libcall:memset"); its cost is the callee's per-call cost
    lowered: str = ""
    # hi is the average number of iterations per entry (total / entries), which
    # need not be an integer: for a loop whose total over the program is known
    # but whose split over its entries is decided at run time (paper Sec. 3.2).
    # lo = 0 and step = 1; the body must not depend on var.
    average: bool = False

    def trips(self):
        if self.average:
            assert self.lo == 0 and self.step == 1, "an average loop counts from 0 by 1"
            return sp.Max(0, sp.sympify(self.hi))
        return sp.Max(0, sp.ceiling((sp.sympify(self.hi) - self.lo) / self.step))


@dataclass(frozen=True)
class ParFor:
    """`for parallel(extent)`: application-level parallel work inside one PU.
    The architecture decides whether it is realized as threads, SIMD lanes or
    lockstep PIM blocks."""
    var: sp.Symbol
    extent: Expr
    body: tuple
    src: str = ""


@dataclass(frozen=True)
class If:
    """if cond then body else orelse; cond is a sympy relational/boolean."""
    cond: object
    body: tuple
    orelse: tuple = ()
    src: str = ""
    # decided at compile time (cond uses only build macros such as NT): the
    # compiler deletes the dead side, so it has no machine code. The branch
    # counterpart of For(unrolled=True).
    static: bool = False


@dataclass(frozen=True)
class Barrier:
    pass


Stmt = Union[Assign, For, ParFor, If, Barrier]


@dataclass(frozen=True)
class Kernel:
    name: str
    params: tuple  # sympy symbols: application parameters
    deploy: tuple  # sympy symbols: deployment parameters (number of PUs, threads)
    arrays: tuple
    body: tuple
    src: str = ""
    lets: dict = field(default_factory=dict, hash=False, compare=False)  # derived quantities, for reports
    # data-dependent quantities: symbol -> (lowest, highest) value. Counts that
    # depend on them become intervals, assuming they grow monotonically with
    # each such symbol.
    unknowns: dict = field(default_factory=dict, hash=False, compare=False)


def refs(s: Assign):
    yield s.dst
    for r in s.srcs:
        if isinstance(r, Ref):
            yield r


def walk(body, fn, env=None):
    """Pre-order walk calling fn(stmt, loops) where loops is the list of
    enclosing For/ParFor nodes."""
    loops = env if env is not None else []
    for s in body:
        fn(s, loops)
        if isinstance(s, (For, ParFor)):
            walk(s.body, fn, loops + [s])
        elif isinstance(s, If):
            walk(s.body, fn, loops)
            walk(s.orelse, fn, loops)
