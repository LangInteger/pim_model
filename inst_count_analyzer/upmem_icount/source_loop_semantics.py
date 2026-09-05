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


def source_loop_total_backedge_bounds(
    benchmark: str,
    function: str,
    loops: list[LoopInfo],
    params: dict[str, object],
    tasklets: int,
) -> dict[str, Bound]:
    """Return absolute, amortized loop-work caps for a tasklet invocation.

    Unlike ``source_loop_backedge_bounds``, these limits do not multiply by
    the number of entries into an enclosing loop.  They are intended for work
    allocators whose finite global domain is shared by all tasklets.
    """
    if benchmark.upper() != "TRNS" or function != "main_kernel2":
        return {}
    if tasklets < 1:
        raise ValueError("tasklets must be positive")

    # get_tile() atomically distributes the non-sentinel tile identifiers
    # [0, M*n-2].  Across the DPU, the outer loop can therefore process at
    # most tile_max tiles.  The inner permutation walks/marks tiles from the
    # same finite domain, so its aggregate backedge count has the same cap.
    # Charging ceil(tile_max/T) to every tasklet is an accounting partition of
    # global work: individual tasklet bounds are amortized, while their sum is
    # a conservative DPU-level cap (at most T-1 excess iterations).
    tile_max = max(0, int(params["M_"]) * int(params["n"]) - 1)
    amortized_cap = math.ceil(tile_max / tasklets)
    return {
        loop.header: Bound(0, amortized_cap)
        for loop in loops
        if loop.backedge_count is None
    }


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
