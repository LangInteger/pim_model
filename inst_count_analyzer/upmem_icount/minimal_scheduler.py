"""Small analytical tasklet scheduler over ordered behavior summaries.

This intentionally models only the mechanisms needed to study latency hiding:
one global issue slot, an 11-cycle same-tasklet issue interval, and tasklet
blocking on MRAM events.  It is not an instruction-level uPIMulator clone.
"""

from __future__ import annotations

from dataclasses import dataclass

from .behavior_segments import BehaviorSegment
from .ordered_export import ExportedTaskletLoop


@dataclass(frozen=True)
class SchedulerParams:
    issue_interval: int = 11
    pipeline_stages: int = 14
    read_alpha: int = 77
    write_alpha: int = 61
    bytes_per_cycle: int = 2
    serialize_mram: bool = True


@dataclass(frozen=True)
class ScheduleResult:
    cycles: int
    issued_instructions: int
    idle_cycles: int
    memory_blocked_idle_cycles: int
    issue_wait_idle_cycles: int
    mixed_idle_cycles: int


@dataclass
class _TaskletState:
    body: list[BehaviorSegment]
    repeats_left: int
    segment_index: int = 0
    compute_left: int = 0
    next_issue: int = 0
    blocked_until: int = 0
    waiting_memory: bool = False
    done: bool = False


_VA_TRIP_COUNT_EXPR = (
    "ceil_div(max(0, input_size_dpu_bytes - tid * BLOCK_SIZE), "
    "BLOCK_SIZE * NR_TASKLETS)"
)


def instantiate_trip_count(
    loop: ExportedTaskletLoop,
    environment: dict[str, int],
) -> int:
    """Instantiate a symbolic Repeat from configuration, not SCEV output."""
    if loop.repeat.trip_count_expr != _VA_TRIP_COUNT_EXPR:
        raise ValueError("unsupported symbolic Repeat expression")
    n = environment["input_size_dpu_bytes"]
    block = environment["BLOCK_SIZE"]
    tasklets = environment["NR_TASKLETS"]
    numerator = max(0, n - loop.tid * block)
    denominator = block * tasklets
    return (numerator + denominator - 1) // denominator


def _latency(segment: BehaviorSegment, size_bytes: int, params: SchedulerParams) -> int:
    transfer = (size_bytes + params.bytes_per_cycle - 1) // params.bytes_per_cycle
    if segment.kind == "mram_read":
        return params.read_alpha + transfer
    if segment.kind == "mram_write":
        return params.write_alpha + transfer
    raise ValueError("not an MRAM segment")


def _normalize(state: _TaskletState) -> None:
    while not state.done:
        if state.segment_index >= len(state.body):
            state.repeats_left -= 1
            if state.repeats_left <= 0:
                state.done = True
                return
            state.segment_index = 0
            state.compute_left = 0
        segment = state.body[state.segment_index]
        if segment.kind == "compute":
            if segment.count is None:
                raise ValueError("scheduler requires concrete compute counts")
            if state.compute_left == 0:
                state.compute_left = segment.count
            if state.compute_left == 0:
                state.segment_index += 1
                continue
        return


def schedule_loops(
    loops: list[ExportedTaskletLoop],
    *,
    mram_size_bytes: int,
    environment: dict[str, int],
    params: SchedulerParams = SchedulerParams(),
) -> ScheduleResult:
    if params.issue_interval < 1 or params.pipeline_stages < 2:
        raise ValueError("invalid scheduler parameters")
    states = [
        _TaskletState(loop.repeat.body, instantiate_trip_count(loop, environment))
        for loop in sorted(loops, key=lambda item: item.tid)
    ]
    for state in states:
        if not state.waiting_memory:
            _normalize(state)

    cycle = 0
    rr = 0
    issued = 0
    idle = 0
    memory_idle = 0
    issue_idle = 0
    mixed_idle = 0
    last_issue_cycle = -1
    memory_available = 0
    while not all(state.done for state in states):
        for state in states:
            if state.waiting_memory and cycle >= state.blocked_until:
                state.waiting_memory = False
                _normalize(state)
        if all(state.done for state in states):
            break
        chosen = None
        for offset in range(len(states)):
            index = (rr + offset) % len(states)
            state = states[index]
            if (
                not state.done
                and not state.waiting_memory
                and cycle >= state.next_issue
                and cycle >= state.blocked_until
            ):
                chosen = index
                break
        if chosen is None:
            wakeups = []
            for state in states:
                if state.done:
                    continue
                if state.waiting_memory:
                    wakeups.append(state.blocked_until)
                else:
                    wakeups.append(max(state.next_issue, state.blocked_until))
            next_cycle = min(wakeups)
            delta = max(1, next_cycle - cycle)
            idle += delta
            unfinished = [state for state in states if not state.done]
            # Match uPIMulator's RevolverScheduler breakdown semantics:
            # when no tasklet can issue, classify the scheduler cycle as DMA
            # if at least one BLOCK tasklet is already issue-eligible.
            # Otherwise the miss is an issue/revolver wait ("etc").
            dma_eligible = any(
                state.waiting_memory and cycle >= state.next_issue
                for state in unfinished
            )
            if dma_eligible:
                memory_idle += delta
            elif all(
                (not state.waiting_memory and cycle < state.next_issue)
                or (state.waiting_memory and cycle < state.next_issue)
                for state in unfinished
            ):
                issue_idle += delta
            else:
                mixed_idle += delta
            cycle += delta
            continue

        state = states[chosen]
        segment = state.body[state.segment_index]
        issued += 1
        last_issue_cycle = cycle
        state.next_issue = cycle + params.issue_interval
        if segment.kind == "compute":
            state.compute_left -= 1
            if state.compute_left == 0:
                state.segment_index += 1
        elif segment.kind in {"mram_read", "mram_write"}:
            latency = _latency(segment, mram_size_bytes, params)
            if params.serialize_mram:
                memory_start = max(cycle, memory_available)
                state.blocked_until = memory_start + latency
                memory_available = state.blocked_until
            else:
                state.blocked_until = cycle + latency
            state.waiting_memory = True
            state.segment_index += 1
        else:
            raise ValueError(f"unsupported scheduler segment: {segment.kind}")
        if not state.waiting_memory:
            _normalize(state)
        rr = (chosen + 1) % len(states)
        cycle += 1

    # The last issued instruction still traverses the remaining pipeline.
    issue_tail = 0 if last_issue_cycle < 0 else last_issue_cycle + params.pipeline_stages
    memory_tail = max((state.blocked_until for state in states), default=0)
    total = max(issue_tail, memory_tail)
    return ScheduleResult(total, issued, idle, memory_idle, issue_idle, mixed_idle)

