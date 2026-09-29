"""Lightweight program-derived provenance for ordered MRAM events.

This module deliberately has no CFG/numpy/scipy dependency.  It is the
source/LLVM-facing half of the join with final-machine DMA event positions.
"""

from __future__ import annotations

from .behavior_segments import (
    BehaviorRepeat,
    BehaviorSegment,
    MramEventProvenance,
    OrderedBehaviorSummary,
    attach_mram_provenance,
)


def configuration_environment(
    benchmark: str,
    function: str,
    *,
    build_options: dict[str, object],
    runtime_params: dict[str, int],
    num_tasklets: int,
) -> dict[str, int]:
    """Map recorded experiment inputs to source-level root symbols."""
    if benchmark.upper() != "VA" or function != "main_kernel1":
        return {}
    try:
        block_log2 = int(build_options["BL"])
        input_size_dpu_bytes = int(runtime_params["size"])
    except (KeyError, TypeError, ValueError) as error:
        raise ValueError("VA requires build option BL and runtime param size") from error
    if block_log2 < 0 or input_size_dpu_bytes < 0 or num_tasklets < 1:
        raise ValueError("invalid VA configuration")
    return {
        "BLOCK_SIZE": 1 << block_log2,
        "input_size_dpu_bytes": input_size_dpu_bytes,
        "NR_TASKLETS": num_tasklets,
    }


def source_symbolic_definitions(
    benchmark: str,
    function: str,
) -> dict[str, str]:
    """Program definitions needed to interpret MRAM size expressions.

    Values remain symbolic here.  Build/runtime configuration supplies values
    for roots such as BLOCK_SIZE and input_size; execution state supplies
    changing variables such as byte_index.
    """
    if benchmark.upper() == "VA" and function == "main_kernel1":
        return {
            "byte_index(tid, j)": (
                "tid * BLOCK_SIZE + j * BLOCK_SIZE * NR_TASKLETS"
            ),
            "l_size_bytes": (
                "min(BLOCK_SIZE, input_size_dpu_bytes - byte_index)"
            ),
        }
    return {}


def source_mram_event_provenance(
    benchmark: str,
    function: str,
) -> list[MramEventProvenance]:
    """Return program-derived MRAM size expressions in source event order.

    The expressions are not experiment inputs.  They name program state that
    can later be instantiated or bounded from the existing build/runtime
    configuration.  Keep benchmark rules narrow until equivalent provenance is
    recovered generically from LLVM/source callsites.
    """
    if benchmark.upper() == "VA" and function == "main_kernel1":
        return [
            MramEventProvenance("mram_read", "l_size_bytes"),
            MramEventProvenance("mram_read", "l_size_bytes"),
            MramEventProvenance("mram_write", "l_size_bytes"),
        ]
    return []


def va_parameterized_loop(body: list[BehaviorSegment]) -> BehaviorRepeat:
    return BehaviorRepeat(
        iterator="j",
        trip_count_expr=(
            "ceil_div(max(0, input_size_dpu_bytes - tid * BLOCK_SIZE), "
            "BLOCK_SIZE * NR_TASKLETS)"
        ),
        body=body,
    )


def build_ordered_summary(
    benchmark: str,
    function: str,
    segments: list[BehaviorSegment],
    *,
    build_options: dict[str, object],
    runtime_params: dict[str, int],
    num_tasklets: int,
) -> OrderedBehaviorSummary:
    """Assemble machine ordering, program provenance, and experiment inputs."""
    provenance = source_mram_event_provenance(benchmark, function)
    if any(segment.kind in {"mram_read", "mram_write"} for segment in segments):
        segments = attach_mram_provenance(segments, provenance)
    return OrderedBehaviorSummary(
        function=function,
        segments=segments,
        definitions=source_symbolic_definitions(benchmark, function),
        environment=configuration_environment(
            benchmark,
            function,
            build_options=build_options,
            runtime_params=runtime_params,
            num_tasklets=num_tasklets,
        ),
    )
