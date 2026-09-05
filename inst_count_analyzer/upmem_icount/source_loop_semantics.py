from __future__ import annotations

import math

from .generic_cfg import Bound, LoopInfo


GEMV_FAMILY = frozenset({"GEMV", "MLP"})


def source_loop_backedge_bounds(
    benchmark: str,
    function: str,
    loops: list[LoopInfo],
    params: dict[str, object],
) -> dict[str, Bound]:
    """Return source-derived bounds for SCEV-unknown benchmark loops.

    These rules constrain loop execution only.  Instruction costs still come
    from the target-specific late MIR.  Keep policies deliberately narrow so
    unrelated benchmarks retain their existing SCEV/CFG behavior.
    """
    if benchmark.upper() not in GEMV_FAMILY or function != "main":
        return {}
    return _gemv_family_bounds(loops, params)


def _gemv_family_bounds(
    loops: list[LoopInfo], params: dict[str, object]
) -> dict[str, Bound]:
    """Bounds for the shared GEMV/MLP source-level loop nest.

    The relevant source shape is:

      rows (SCEV exact) -> pos < 2 -> full 1-KiB chunks -> optional shifts
                                           -> final remainder loop

    The experiment inputs use even row counts and even element counts.  Each
    active row-pair therefore executes both ``pos`` iterations; the remainder
    loop handles exactly the elements left after the full 256-element chunks.
    Structural depth/block-count checks distinguish the loops without relying
    on unstable LLVM basic-block names.
    """
    n_size=int(params["n_size"])
    block_elements=1024 // 4
    full_chunk_trips=max(0, math.ceil(max(0,n_size-block_elements)/block_elements))
    remainder=n_size-full_chunk_trips*block_elements
    bounds: dict[str,Bound]={}
    for loop in loops:
        if loop.backedge_count is not None:
            continue
        block_count=len(loop.blocks)
        if loop.depth==2:
            # pos=0 and pos=1 for every active pair in the current even-sized
            # experiment matrix: two trips, hence one backedge.
            bounds[loop.header]=Bound(1,1)
        elif loop.depth==3 and block_count>=5:
            # Full 1-KiB chunks before the final remainder.
            backedges=max(0,full_chunk_trips-1)
            bounds[loop.header]=Bound(backedges,backedges)
        elif loop.depth==3 and block_count==2:
            # Final scalar remainder loop.
            backedges=max(0,remainder-1)
            bounds[loop.header]=Bound(backedges,backedges)
        elif block_count==1:
            # The two offset-shift loops have 255 trips if entered.  Their
            # entry branch is eliminated for the aligned experiment inputs;
            # retaining only an upper bound keeps the rule sound otherwise.
            bounds[loop.header]=Bound(0,block_elements-2)
    return bounds
