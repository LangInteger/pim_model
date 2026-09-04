from __future__ import annotations

from .generic_cfg import Bound, add_bounds


COLLECTIVE_RUNTIME_PRIMITIVES = frozenset({"barrier_wait"})


def is_collective_runtime_primitive(function: str) -> bool:
    return function in COLLECTIVE_RUNTIME_PRIMITIVES


def scale_bound(bound: Bound, count: int) -> Bound:
    if count < 0:
        raise ValueError("count must be non-negative")
    return Bound(
        None if bound.lower is None else bound.lower * count,
        None if bound.upper is None else bound.upper * count,
    )


def barrier_generation_bound(
    participants: int,
    nonlast_path: Bound,
    last_path: Bound,
) -> Bound:
    """Combine CFG/MIR-derived paths for one complete barrier generation.

    The path bounds must come from the independently compiled barrier runtime
    translation unit. This function deliberately does not guess either cost.
    """
    if participants < 1:
        raise ValueError("a barrier generation needs at least one participant")
    return add_bounds(scale_bound(nonlast_path, participants - 1), last_path)
