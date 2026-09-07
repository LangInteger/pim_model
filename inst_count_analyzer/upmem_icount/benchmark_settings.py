from __future__ import annotations

import math
from dataclasses import dataclass


@dataclass(frozen=True)
class BenchmarkConfig:
    make_args: tuple[str, ...] = ()
    non_control_params: frozenset[str] = frozenset()


@dataclass(frozen=True)
class DpuPhase:
    execution: int
    dpu: int
    function: str
    params: dict[str, int]
    arguments_source: str


BENCHMARK_CONFIGS: dict[str, BenchmarkConfig] = {
    "BS": BenchmarkConfig(),
    "VA": BenchmarkConfig(),
    "RED": BenchmarkConfig(
        non_control_params=frozenset({"t_count"}),
    ),
    "HST-L": BenchmarkConfig(
        make_args=("BL=10", "NR_HISTO=1"),
    ),
    "HST-S": BenchmarkConfig(),
    "GEMV": BenchmarkConfig(),
    "MLP": BenchmarkConfig(),
    "SEL": BenchmarkConfig(),
    "UNI": BenchmarkConfig(),
    "TRNS": BenchmarkConfig(),
    "TS": BenchmarkConfig(),
    "SCAN-RSS": BenchmarkConfig(
        non_control_params=frozenset({"t_count"}),
    ),
    "SCAN-SSA": BenchmarkConfig(
        non_control_params=frozenset({"t_count"}),
    ),
}


def normalize_benchmark(name: str) -> str:
    benchmark = name.upper()
    if benchmark not in BENCHMARK_CONFIGS:
        raise ValueError(f"unsupported benchmark {name!r}")
    return benchmark


def setting_id(
    experiment: str, benchmark: str, num_dpus: int, tasklets: int, data_prep: int
) -> str:
    return (
        f"{experiment}_{normalize_benchmark(benchmark)}_dpu{num_dpus}_"
        f"tasklets{tasklets}_size{data_prep}"
    )


def loop_backedge_uppers(
    benchmark: str, params: dict[str, int]
) -> dict[str, int]:
    """Return source-derived caps only for loops SCEV may leave unknown.

    These caps constrain path analysis; they do not replace machine-block
    instruction counting. Functions whose loops are expected to be fully
    resolved by SCEV deliberately have no entry here.
    """
    benchmark = normalize_benchmark(benchmark)
    if benchmark == "BS":
        # search() linearly scans one 256-byte block of int64 values. The
        # surrounding while loop halves the remaining block range each round.
        block_elements = 256 // 8
        blocks = max(1, math.ceil(params["input_size"] / block_elements))
        return {
            # Count a final header/backedge visit conservatively; LLVM loop
            # form may test the exit either in the header or the latch.
            "search": block_elements,
            "main_kernel1": math.ceil(math.log2(blocks)) + 2,
        }
    return {}


def load_summary_phases(records: object) -> list[DpuPhase]:
    """Validate semantic per-DPU execution inputs loaded from summary.csv."""
    if not isinstance(records, list) or not records:
        raise ValueError("dpu_execution_inputs_json must be a non-empty list")

    phases: list[DpuPhase] = []
    for record in records:
        if not isinstance(record, dict):
            raise ValueError("DPU argument record must be an object")
        try:
            execution = int(record["execution"])
            dpu = int(record["dpu"])
            function = str(record["function"])
            raw_params = record["params"]
        except (KeyError, TypeError, ValueError) as error:
            raise ValueError(f"invalid DPU execution input: {record!r}") from error
        if not function or not isinstance(raw_params, dict):
            raise ValueError(f"invalid DPU execution input: {record!r}")
        if any(
            not isinstance(name, str)
            or isinstance(value, bool)
            or not isinstance(value, int)
            for name, value in raw_params.items()
        ):
            raise ValueError(f"execution params must map names to integers: {record!r}")
        params = dict(raw_params)
        phases.append(
            DpuPhase(
                execution=execution,
                dpu=dpu,
                function=function,
                params=params,
                arguments_source="summary.csv:dpu_execution_inputs_json",
            )
        )
    return sorted(phases, key=lambda phase: (phase.dpu, phase.execution))
