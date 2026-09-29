from upmem_icount.behavior_segments import BehaviorRepeat, BehaviorSegment
from upmem_icount.minimal_scheduler import (
    SchedulerParams,
    instantiate_trip_count,
    schedule_loops,
)
from upmem_icount.ordered_export import ExportedTaskletLoop


def _loop(tid: int, body: list[BehaviorSegment], trips: int = 1):
    return ExportedTaskletLoop(
        tid,
        BehaviorRepeat(
            "j",
            "ceil_div(max(0, input_size_dpu_bytes - tid * BLOCK_SIZE), "
            "BLOCK_SIZE * NR_TASKLETS)",
            body,
        ),
    )


def _env(tasklets: int, blocks: int = 1):
    return {
        "BLOCK_SIZE": 1024,
        "input_size_dpu_bytes": blocks * tasklets * 1024,
        "NR_TASKLETS": tasklets,
    }


def test_parameterized_repeat_instantiates_from_configuration():
    loop = _loop(0, [BehaviorSegment("compute", count=1)])
    env = {
        "BLOCK_SIZE": 1024,
        "input_size_dpu_bytes": 2097152,
        "NR_TASKLETS": 16,
    }
    assert instantiate_trip_count(loop, env) == 128


def test_one_tasklet_obeys_revolver_issue_interval():
    result = schedule_loops(
        [_loop(0, [BehaviorSegment("compute", count=3)])],
        mram_size_bytes=1024,
        environment=_env(1),
        params=SchedulerParams(issue_interval=11, pipeline_stages=14),
    )
    assert result.issued_instructions == 3
    assert result.cycles == 36
    assert result.issue_wait_idle_cycles == 20


def test_many_tasklets_hide_revolver_wait():
    result = schedule_loops(
        [_loop(tid, [BehaviorSegment("compute", count=2)]) for tid in range(16)],
        mram_size_bytes=1024,
        environment=_env(16),
        params=SchedulerParams(issue_interval=11, pipeline_stages=14),
    )
    assert result.issued_instructions == 32
    assert result.idle_cycles == 0
    assert result.cycles == 45


def test_other_tasklet_compute_can_hide_memory_block():
    params = SchedulerParams(
        issue_interval=1,
        pipeline_stages=2,
        read_alpha=4,
        bytes_per_cycle=1024,
        serialize_mram=False,
    )
    result = schedule_loops(
        [
            _loop(0, [
                BehaviorSegment("mram_read", size_expr="l_size_bytes"),
                BehaviorSegment("compute", count=1),
            ]),
            _loop(1, [BehaviorSegment("compute", count=8)]),
        ],
        mram_size_bytes=1024,
        environment=_env(2),
        params=params,
    )
    assert result.memory_blocked_idle_cycles == 0


def test_shared_mram_serializes_overlapping_requests():
    params = SchedulerParams(
        issue_interval=1,
        pipeline_stages=2,
        read_alpha=4,
        bytes_per_cycle=1024,
        serialize_mram=True,
    )
    result = schedule_loops(
        [
            _loop(0, [BehaviorSegment("mram_read", size_expr="l_size_bytes")]),
            _loop(1, [BehaviorSegment("mram_read", size_expr="l_size_bytes")]),
        ],
        mram_size_bytes=1024,
        environment=_env(2),
        params=params,
    )
    assert result.memory_blocked_idle_cycles > 0
