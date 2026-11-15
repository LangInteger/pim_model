"""Quantities derived from an architecture instance A = <M, B, P, C> (paper Sec. 3.1).

M lists |I_l| for every level (M.I), the level of the banks (M.L_D), and the
tree depth (M.L); P attaches P PUs to each node of level k; C makes each node
of level k_C, with its subtree, a PU control region.
"""
from __future__ import annotations

from math import prod


def val(x):
    return x["value"] if isinstance(x, dict) else x


def nodes_below(arch: dict, top: int, level: int) -> int:
    """Number of level-`level` nodes in the subtree of one level-`top` node."""
    sizes = val(arch["M"]["I"])
    return prod(sizes[top + 1:level + 1])


def pus_per_region(arch: dict) -> int:
    """P_C = P * prod_{l=k_C+1}^{k} |I_l|."""
    return val(arch["P"]["P"]) * nodes_below(arch, val(arch["C"]["k_C"]), val(arch["P"]["k"]))


def banks_per_pu(arch: dict) -> int:
    """Banks (level L_D) in the subtree of one PU's node (level k)."""
    return nodes_below(arch, val(arch["P"]["k"]), val(arch["M"]["L_D"]))


def banks_per_region(arch: dict) -> int:
    """Banks (level L_D) in one PU control region."""
    return nodes_below(arch, val(arch["C"]["k_C"]), val(arch["M"]["L_D"]))


def issuer(arch: dict) -> str:
    return val(arch["C"]["issuer"])


def coord(arch: dict) -> str:
    return val(arch["C"]["coord"])
