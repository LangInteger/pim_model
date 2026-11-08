"""Symbols and helpers shared by the PrIM programs."""
import sympy as sp

from ir import Array, Assign, Barrier, For, If, Kernel, ParFor, Ref  # noqa: F401

NT, BS, E, SIZE = sp.symbols("NT BS E SIZE", integer=True, positive=True)
t, idx, k = sp.symbols("t idx k", integer=True, nonnegative=True)

TYPE_BYTES = {"INT32": 4, "UINT32": 4, "FLOAT": 4, "INT64": 8, "UINT64": 8, "DOUBLE": 8,
              "CHAR": 1, "SHORT": 2}

ROOT = "PrIM"  # source anchors: PrIM/<BENCH>/dpu/task.c:<line>


def build_values(build, nt, default_type="INT32", default_bl=8):
    """BS (block bytes), E (element bytes) and NT from the build configuration."""
    return {BS: 1 << int(build.get("BL", default_bl)),
            E: TYPE_BYTES[build.get("TYPE", default_type)], NT: nt}


def blocks_loop(body, src, lo=None, step=None):
    """The PrIM streaming loop: for (idx = t*BS; idx < SIZE; idx += BS*NT)."""
    return For(idx, SIZE, body, lo=t * BS if lo is None else lo,
               step=BS * NT if step is None else step, src=src)


def l_size():
    """l_size_bytes = min(BS, SIZE - idx)."""
    return sp.Min(BS, SIZE - idx)
