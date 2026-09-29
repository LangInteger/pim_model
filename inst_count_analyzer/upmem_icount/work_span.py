"""Closed-form Work/Span summaries over compact tasklet loops."""
from dataclasses import dataclass
from typing import Literal

from .minimal_scheduler import SchedulerParams, instantiate_trip_count
from .ordered_export import ExportedTaskletLoop

@dataclass(frozen=True)
class WorkSpanResult:
    work: int
    span: int
    lower_bound: int
    upper_bound: int

def _latency(kind: str, size: int, p: SchedulerParams) -> int:
    transfer = (size + p.bytes_per_cycle - 1) // p.bytes_per_cycle
    if kind == "mram_read": return p.read_alpha + transfer
    if kind == "mram_write": return p.write_alpha + transfer
    raise ValueError(kind)

def summarize_work_span(
    loops: list[ExportedTaskletLoop], *, environment: dict[str, int],
    mram_size_bytes: int, span_model: Literal["memory", "upmem"] = "upmem",
    params: SchedulerParams = SchedulerParams(),
) -> WorkSpanResult:
    """Compute W=sum(W_t), S=max(S_t) without expanding Repeat K times."""
    if span_model not in {"memory", "upmem"}: raise ValueError(span_model)
    work = 0
    spans = []
    for loop in sorted(loops, key=lambda x: x.tid):
        k = instantiate_trip_count(loop, environment)
        body_work = 0
        memory_extra = 0
        for seg in loop.repeat.body:
            if seg.kind == "compute":
                if seg.count is None: raise ValueError("missing compute count")
                body_work += seg.count
            elif seg.kind in {"mram_read", "mram_write"}:
                body_work += 1  # ldma/sdma issue is work; waiting is not
                latency = _latency(seg.kind, mram_size_bytes, params)
                base = 1 if span_model == "memory" else params.issue_interval
                memory_extra += max(0, latency - base)
            else:
                raise ValueError(f"unsupported segment {seg.kind}")
        events = k * body_work
        work += events
        if not events:
            spans.append(0)
        elif span_model == "memory":
            spans.append(k * (body_work + memory_extra))
        else:
            # Same-tasklet issue edges are 11 cycles; an MRAM edge replaces
            # that edge by its longer blocking latency.
            spans.append(1 + (events - 1) * params.issue_interval + k * memory_extra)
    span = max(spans, default=0)
    # The DPU has one global instruction-issue resource, so P=1 here.
    return WorkSpanResult(work, span, max(work, span), work + span)
