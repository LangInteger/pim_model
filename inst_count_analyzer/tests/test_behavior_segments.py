from types import SimpleNamespace

from upmem_icount.behavior_segments import (
    BehaviorRepeat,
    BehaviorSegment,
    MramEventProvenance,
    attach_mram_provenance,
    attach_mram_sizes,
    expand_compute_only_calls,
    segment_instructions,
    segment_machine_block,
)
from upmem_icount.mram_provenance import (
    build_ordered_summary,
    configuration_environment,
    source_mram_event_provenance,
    source_symbolic_definitions,
    va_parameterized_loop,
)
from upmem_icount.ordered_export import export_va_tasklet_loop
import json


def test_va_loop_body_splits_inside_machine_block():
    instructions = [
        "add r0, r0, r20",
        "move r1, __sys_used_mram_end",
        "add r1, r17, r1",
        "move r2, -1",
        "lsr_add r2, r2, r0, 3",
        "lsl_add r3, r14, r2, 24",
        "ldma r3, r1, 0",
        "lw r1, r22, -16",
        "add r21, r1, r17",
        "lsl_add r18, r15, r2, 24",
        "ldma r18, r21, 0",
        "lsr r2, r0, 2",
        "move r0, r15",
        "move r1, r14",
        "call r23, vector_addition",
        "sdma r18, r21, 0",
        "add r17, r17, 16384",
        "add r19, r19, 16384",
        "add r20, r20, -16384",
        "jleu r16, r17, .LBB1_7",
    ]
    assert segment_instructions(instructions) == [
        BehaviorSegment("compute", count=6),
        BehaviorSegment("mram_read"),
        BehaviorSegment("compute", count=3),
        BehaviorSegment("mram_read"),
        BehaviorSegment("compute", count=3),
        BehaviorSegment("call", callee="vector_addition"),
        BehaviorSegment("mram_write"),
        BehaviorSegment("compute", count=4),
    ]


def test_mram_provenance_rejects_read_write_order_mismatch():
    try:
        attach_mram_provenance(
            [BehaviorSegment("mram_read")],
            [MramEventProvenance("mram_write", "n")],
        )
    except ValueError as exc:
        assert "kind mismatch" in str(exc)
    else:
        raise AssertionError("MRAM provenance order must not be guessed")


def test_dma_is_not_double_counted_as_compute():
    assert segment_instructions(["ldma r1, r2, 0", "sdma r3, r4, 0"]) == [
        BehaviorSegment("mram_read"),
        BehaviorSegment("mram_write"),
    ]


def test_unrecognized_call_syntax_remains_compute():
    assert segment_instructions(["call r23"]) == [
        BehaviorSegment("compute", count=1)
    ]


def test_machine_block_adapter_uses_existing_assembly_stream():
    block = SimpleNamespace(
        assembly_instructions=["add r0, r0, 1", "ldma r1, r2, 0"]
    )
    assert segment_machine_block(block) == [
        BehaviorSegment("compute", count=1),
        BehaviorSegment("mram_read"),
    ]


def test_va_symbolic_chunk_size_attaches_to_each_dma_event():
    skeleton = [
        BehaviorSegment("compute", count=6),
        BehaviorSegment("mram_read"),
        BehaviorSegment("compute", count=3),
        BehaviorSegment("mram_read"),
        BehaviorSegment("compute", count=3),
        BehaviorSegment("call", callee="vector_addition"),
        BehaviorSegment("mram_write"),
        BehaviorSegment("compute", count=4),
    ]
    assert attach_mram_provenance(
        skeleton, source_mram_event_provenance("VA", "main_kernel1")
    ) == [
        BehaviorSegment("compute", count=6),
        BehaviorSegment("mram_read", size_expr="l_size_bytes"),
        BehaviorSegment("compute", count=3),
        BehaviorSegment("mram_read", size_expr="l_size_bytes"),
        BehaviorSegment("compute", count=3),
        BehaviorSegment("call", callee="vector_addition"),
        BehaviorSegment("mram_write", size_expr="l_size_bytes"),
        BehaviorSegment("compute", count=4),
    ]


def test_va_chunk_size_keeps_input_dependent_symbolic_definition():
    assert source_symbolic_definitions("VA", "main_kernel1") == {
        "byte_index(tid, j)": (
            "tid * BLOCK_SIZE + j * BLOCK_SIZE * NR_TASKLETS"
        ),
        "l_size_bytes": "min(BLOCK_SIZE, input_size_dpu_bytes - byte_index)"
    }


def test_va_loop_summary_preserves_iteration_dependent_body():
    body = [
        BehaviorSegment("mram_read", size_expr="l_size_bytes"),
        BehaviorSegment("compute", count=1797),
        BehaviorSegment("mram_write", size_expr="l_size_bytes"),
    ]
    assert va_parameterized_loop(body) == BehaviorRepeat(
        iterator="j",
        trip_count_expr=(
            "ceil_div(max(0, input_size_dpu_bytes - tid * BLOCK_SIZE), "
            "BLOCK_SIZE * NR_TASKLETS)"
        ),
        body=body,
    )


def test_va_configuration_environment_uses_recorded_inputs():
    assert configuration_environment(
        "VA",
        "main_kernel1",
        build_options={"BL": 10, "TYPE": "INT32"},
        runtime_params={"size": 2097152, "transfer_size": 2097152, "kernel": 0},
        num_tasklets=16,
    ) == {
        "BLOCK_SIZE": 1024,
        "input_size_dpu_bytes": 2097152,
        "NR_TASKLETS": 16,
    }


def test_va_ordered_summary_is_serializable_and_keeps_call_boundary():
    skeleton = [
        BehaviorSegment("compute", count=6),
        BehaviorSegment("mram_read"),
        BehaviorSegment("compute", count=3),
        BehaviorSegment("mram_read"),
        BehaviorSegment("compute", count=3),
        BehaviorSegment("call", callee="vector_addition"),
        BehaviorSegment("mram_write"),
        BehaviorSegment("compute", count=4),
    ]
    summary = build_ordered_summary(
        "VA",
        "main_kernel1",
        skeleton,
        build_options={"BL": 10, "TYPE": "INT32"},
        runtime_params={"size": 2097152, "transfer_size": 2097152, "kernel": 0},
        num_tasklets=16,
    ).to_dict()
    assert summary["environment"] == {
        "BLOCK_SIZE": 1024,
        "input_size_dpu_bytes": 2097152,
        "NR_TASKLETS": 16,
    }
    assert summary["definitions"] == {
        "byte_index(tid, j)": (
            "tid * BLOCK_SIZE + j * BLOCK_SIZE * NR_TASKLETS"
        ),
        "l_size_bytes": "min(BLOCK_SIZE, input_size_dpu_bytes - byte_index)"
    }
    assert summary["segments"][5] == {
        "kind": "call",
        "callee": "vector_addition",
    }
    assert summary["segments"][1] == {
        "kind": "mram_read",
        "size_expr": "l_size_bytes",
    }


def test_compute_only_callee_expansion_uses_dynamic_per_call_count():
    segments = [
        BehaviorSegment("compute", count=3),
        BehaviorSegment("call", callee="vector_addition"),
        BehaviorSegment("mram_write", size_expr="l_size_bytes"),
    ]
    assert expand_compute_only_calls(
        segments, {"vector_addition": 1794}
    ) == [
        BehaviorSegment("compute", count=1798),
        BehaviorSegment("mram_write", size_expr="l_size_bytes"),
    ]


def test_unknown_callee_is_preserved():
    call = BehaviorSegment("call", callee="unknown")
    assert expand_compute_only_calls([call], {}) == [call]


def test_saved_va_debug_exports_parameterized_full_chunk_loop():
    path = (
        "results/VA/tasklet_sweep_VA_dpu1_tasklets16_size524288/"
        "phases/8a594846cdbbdc14/debug.json"
    )
    with open(path, encoding="utf-8") as handle:
        per_tasklet = json.load(handle)["per_tasklet"][0]
    exported = export_va_tasklet_loop(per_tasklet)
    assert exported.tid == 0
    assert exported.repeat.trip_count_expr == (
        "ceil_div(max(0, input_size_dpu_bytes - tid * BLOCK_SIZE), "
        "BLOCK_SIZE * NR_TASKLETS)"
    )
    assert exported.repeat.body == [
        BehaviorSegment("compute", count=8),
        BehaviorSegment("mram_read", size_expr="l_size_bytes"),
        BehaviorSegment("compute", count=3),
        BehaviorSegment("mram_read", size_expr="l_size_bytes"),
        BehaviorSegment("compute", count=1798),
        BehaviorSegment("mram_write", size_expr="l_size_bytes"),
        BehaviorSegment("compute", count=4),
    ]


def test_mram_size_join_rejects_count_mismatch():
    try:
        attach_mram_sizes([BehaviorSegment("mram_read")], [])
    except ValueError as exc:
        assert "mismatch" in str(exc)
    else:
        raise AssertionError("missing MRAM size must not be guessed")
