"""Export ordered VA loop behavior from the existing L0 debug artifact.

This module deliberately consumes facts already produced by generic_count.py.
It does not redo CFG/SCEV/call analysis and it fails closed when the saved
artifact does not have the exact shape needed by the current VA exporter.
"""

from __future__ import annotations

from dataclasses import dataclass

from .behavior_segments import (
    BehaviorRepeat,
    BehaviorSegment,
    attach_mram_provenance,
    expand_compute_only_calls,
    merge_adjacent_compute,
    segment_instructions,
)
from .mram_provenance import source_mram_event_provenance, va_parameterized_loop


@dataclass(frozen=True)
class ExportedTaskletLoop:
    tid: int
    repeat: BehaviorRepeat


def _exact_vector_addition_count(per_tasklet: dict) -> int:
    matches = [
        call
        for call in per_tasklet.get("expanded_calls", [])
        if call.get("callee") == "vector_addition"
    ]
    if len(matches) != 1:
        raise ValueError("expected exactly one vector_addition callsite")
    call = matches[0]
    bound = call.get("callee_expanded_bound_per_call", {})
    if not bound.get("exact") or "value" not in bound:
        raise ValueError("vector_addition per-call count is not exact")
    return int(bound["value"])


def export_va_tasklet_loop(per_tasklet: dict) -> ExportedTaskletLoop:
    """Build the current-config VA loop summary from saved analyzer facts.

    bb.4 is always executed. bb.5 is the conditional select path used when
    the chunk differs from the normal full-block case. Current saved VA
    experiments have only full 1024-byte chunks, so accepting an exact 256
    element vector_addition argument proves bb.5 is not taken in these runs.
    General partial-chunk configurations intentionally fail closed for now.
    """
    tid = int(per_tasklet["tid"])
    machine = per_tasklet.get("machine", {})
    blocks = {int(block["number"]): block for block in machine.get("machine_blocks", [])}
    loop_fact_matches = [
        fact
        for fact in machine.get("loop_flow_facts", [])
        if fact.get("ir_loop_header") == "bb16" and fact.get("applied")
    ]
    if len(loop_fact_matches) != 1:
        raise ValueError("expected one applied VA machine loop fact")
    loop_facts = loop_fact_matches[0]
    if loop_facts.get("machine_loop_blocks") != ["bb.4.bb16", "bb.5", "bb.6"]:
        raise ValueError("unexpected VA machine loop shape")
    if loop_facts.get("backedges") != [[6, 4]]:
        raise ValueError("unexpected VA machine backedge")

    count = _exact_vector_addition_count(per_tasklet)
    call = next(
        c for c in per_tasklet["expanded_calls"] if c.get("callee") == "vector_addition"
    )
    elements = call.get("constant_integer_args", {}).get("2")
    if int(elements) != 256:
        raise ValueError(
            "partial/variable VA chunks need symbolic callee demand; refusing to guess"
        )

    # Full-chunk path: bb.4 -> bb.6. Preserve bb.4's branch instructions as
    # compute, then split bb.6 at DMA/call boundaries.
    body = segment_instructions(
        list(blocks[4]["assembly_instructions"]) + list(blocks[6]["assembly_instructions"])
    )
    body = attach_mram_provenance(
        body, source_mram_event_provenance("VA", "main_kernel1")
    )
    body = expand_compute_only_calls(body, {"vector_addition": count})
    body = merge_adjacent_compute(body)
    return ExportedTaskletLoop(
        tid=tid,
        repeat=va_parameterized_loop(body),
    )

