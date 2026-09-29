"""Ordered performance-relevant segments from final DPU machine instructions.

This layer intentionally does not model cycles.  It preserves just enough
machine-level ordering for a later analytical model to reason about compute,
MRAM operations, and interprocedural calls.
"""

from __future__ import annotations

from dataclasses import asdict, dataclass
import re
from typing import Protocol


@dataclass(frozen=True)
class BehaviorSegment:
    kind: str
    count: int | None = None
    callee: str | None = None
    size_expr: str | None = None


_CALL_RE = re.compile(r"\bcall\s+[^,]+,\s*([-A-Za-z$._0-9]+)")


class HasAssemblyInstructions(Protocol):
    assembly_instructions: list[str]


@dataclass(frozen=True)
class MramEventProvenance:
    kind: str
    size_expr: str


@dataclass(frozen=True)
class BehaviorRepeat:
    # Compact ordered loop behavior; no cost multiplication happens here.
    iterator: str
    trip_count_expr: str
    body: list[BehaviorSegment]


@dataclass(frozen=True)
class OrderedBehaviorSummary:
    function: str
    segments: list[BehaviorSegment]
    definitions: dict[str, str]
    environment: dict[str, int]
    repeats: list[BehaviorRepeat] | None = None

    def to_dict(self) -> dict[str, object]:
        result: dict[str, object] = {
            "function": self.function,
            "environment": dict(self.environment),
            "definitions": dict(self.definitions),
            "segments": [
                {key: value for key, value in asdict(segment).items() if value is not None}
                for segment in self.segments
            ],
        }
        if self.repeats is not None:
            result["repeats"] = [
                {
                    "iterator": repeat.iterator,
                    "trip_count_expr": repeat.trip_count_expr,
                    "body": [
                        {k: v for k, v in asdict(segment).items() if v is not None}
                        for segment in repeat.body
                    ],
                }
                for repeat in self.repeats
            ]
        return result


def segment_instructions(instructions: list[str]) -> list[BehaviorSegment]:
    """Split an ordered MCInst stream at scheduler-relevant boundaries.

    DMA instructions become MRAM events instead of compute instructions, so
    the architecture layer cannot accidentally charge both costs.  Calls are
    retained as explicit insertion points for the existing interprocedural
    expansion machinery.
    """
    segments: list[BehaviorSegment] = []
    compute_count = 0

    def flush_compute() -> None:
        nonlocal compute_count
        if compute_count:
            segments.append(BehaviorSegment("compute", count=compute_count))
            compute_count = 0

    for instruction in instructions:
        opcode = instruction.split(None, 1)[0] if instruction else ""
        if opcode == "ldma":
            flush_compute()
            segments.append(BehaviorSegment("mram_read"))
        elif opcode == "sdma":
            flush_compute()
            segments.append(BehaviorSegment("mram_write"))
        elif opcode == "call":
            match = _CALL_RE.search(instruction)
            if match is None:
                compute_count += 1
            else:
                flush_compute()
                segments.append(BehaviorSegment("call", callee=match.group(1)))
        else:
            compute_count += 1

    flush_compute()
    return segments


def segment_machine_block(block: HasAssemblyInstructions) -> list[BehaviorSegment]:
    """Segment an existing generic_cfg.MachineBlock without coupling modules."""
    return segment_instructions(block.assembly_instructions)


def merge_adjacent_compute(
    segments: list[BehaviorSegment],
) -> list[BehaviorSegment]:
    """Canonicalize a segment stream after interprocedural substitution."""
    out: list[BehaviorSegment] = []
    for segment in segments:
        if (
            segment.kind == "compute"
            and out
            and out[-1].kind == "compute"
            and segment.count is not None
            and out[-1].count is not None
        ):
            out[-1] = BehaviorSegment("compute", count=out[-1].count + segment.count)
        else:
            out.append(segment)
    return out


def expand_compute_only_calls(
    segments: list[BehaviorSegment],
    callee_instruction_counts: dict[str, int],
) -> list[BehaviorSegment]:
    """Replace calls whose full dynamic per-invocation behavior is compute-only.

    The counts must come from the existing interprocedural machine-instruction
    analysis. Unknown callees remain explicit rather than being guessed.
    """
    expanded: list[BehaviorSegment] = []
    for segment in segments:
        if (
            segment.kind == "call"
            and segment.callee is not None
            and segment.callee in callee_instruction_counts
        ):
            count = callee_instruction_counts[segment.callee]
            if count < 0:
                raise ValueError("callee instruction count must be non-negative")
            expanded.append(BehaviorSegment("compute", count=count + 1))
        else:
            expanded.append(segment)
    return merge_adjacent_compute(expanded)


def attach_mram_sizes(
    segments: list[BehaviorSegment], size_exprs: list[str]
) -> list[BehaviorSegment]:
    """Attach callsite-size expressions to MRAM events in program order.

    The expressions come from a higher-level provenance source (source/LLVM),
    while event locations come from final MCInsts.  A count mismatch is an
    error rather than a guessed association.
    """
    event_count = sum(
        s.kind in {"mram_read", "mram_write"} for s in segments
    )
    if event_count != len(size_exprs):
        raise ValueError(
            f"MRAM event/size mismatch: {event_count} events, "
            f"{len(size_exprs)} size expressions"
        )

    sizes = iter(size_exprs)
    out: list[BehaviorSegment] = []
    for segment in segments:
        if segment.kind in {"mram_read", "mram_write"}:
            out.append(
                BehaviorSegment(
                    segment.kind,
                    count=segment.count,
                    callee=segment.callee,
                    size_expr=next(sizes),
                )
            )
        else:
            out.append(segment)
    return out


def attach_mram_provenance(
    segments: list[BehaviorSegment],
    events: list[MramEventProvenance],
) -> list[BehaviorSegment]:
    """Join source/LLVM MRAM provenance to final-machine event positions.

    Both event count and read/write order must agree.  This keeps external
    experiment inputs separate from program-derived expressions: callers pass
    provenance recovered from the program, not a user-authored list of sizes.
    """
    machine_events = [
        segment for segment in segments
        if segment.kind in {"mram_read", "mram_write"}
    ]
    if len(machine_events) != len(events):
        raise ValueError(
            f"MRAM event/provenance mismatch: {len(machine_events)} machine events, "
            f"{len(events)} provenance events"
        )
    for index, (machine, source) in enumerate(zip(machine_events, events)):
        if machine.kind != source.kind:
            raise ValueError(
                f"MRAM event/provenance kind mismatch at {index}: "
                f"machine={machine.kind}, provenance={source.kind}"
            )

    provenance = iter(events)
    out: list[BehaviorSegment] = []
    for segment in segments:
        if segment.kind in {"mram_read", "mram_write"}:
            event = next(provenance)
            out.append(
                BehaviorSegment(
                    segment.kind,
                    count=segment.count,
                    callee=segment.callee,
                    size_expr=event.size_expr,
                )
            )
        else:
            out.append(segment)
    return out

