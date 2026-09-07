from __future__ import annotations

import json
import math
from dataclasses import dataclass


@dataclass(frozen=True)
class ArgumentField:
    name: str
    width: int
    signed: bool = False


@dataclass(frozen=True)
class BenchmarkConfig:
    fields: tuple[ArgumentField, ...]
    direct_entry: str | None = None
    make_args: tuple[str, ...] = ()
    non_control_params: frozenset[str] = frozenset()


@dataclass(frozen=True)
class DpuPhase:
    execution: int
    dpu: int
    function: str
    params: dict[str, int]
    arguments_source: str


F = ArgumentField
BENCHMARK_CONFIGS: dict[str, BenchmarkConfig] = {
    "BS": BenchmarkConfig((F("input_size", 8), F("slice_per_dpu", 8), F("kernel", 4))),
    "VA": BenchmarkConfig((F("size", 4), F("transfer_size", 4), F("kernel", 4))),
    "RED": BenchmarkConfig(
        (F("size", 4), F("kernel", 4), F("t_count", 4, True)),
        non_control_params=frozenset({"t_count"}),
    ),
    "HST-L": BenchmarkConfig(
        (F("size", 4), F("transfer_size", 4), F("bins", 4), F("kernel", 4)),
        make_args=("BL=10", "NR_HISTO=1"),
    ),
    "HST-S": BenchmarkConfig(
        (F("size", 4), F("transfer_size", 4), F("bins", 4), F("kernel", 4))
    ),
    "GEMV": BenchmarkConfig(
        (F("n_size", 4), F("n_size_pad", 4), F("nr_rows", 4), F("max_rows", 4)),
        direct_entry="main",
    ),
    "MLP": BenchmarkConfig(
        (F("n_size", 4), F("n_size_pad", 4), F("nr_rows", 4), F("max_rows", 4)),
        direct_entry="main",
    ),
    "SEL": BenchmarkConfig((F("size", 4), F("kernel", 4))),
    "UNI": BenchmarkConfig((F("size", 4), F("kernel", 4))),
    "TRNS": BenchmarkConfig(
        (F("m", 4), F("n", 4), F("M_", 4), F("kernel", 4))
    ),
    "TS": BenchmarkConfig(
        (
            F("ts_length", 4),
            F("query_length", 4),
            F("query_mean", 4, True),
            F("query_std", 4, True),
            F("slice_per_dpu", 4),
            F("exclusion_zone", 4, True),
            F("kernel", 4),
        )
    ),
    "SCAN-RSS": BenchmarkConfig(
        (F("size", 4), F("kernel", 4), F("t_count", 8, True)),
        non_control_params=frozenset({"t_count"}),
    ),
    "SCAN-SSA": BenchmarkConfig(
        (F("size", 4), F("kernel", 4), F("t_count", 8, True)),
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


def decode_arguments(benchmark: str, data: bytes) -> dict[str, int]:
    config = BENCHMARK_CONFIGS[normalize_benchmark(benchmark)]
    expected = sum(field.width for field in config.fields)
    if len(data) != expected:
        raise ValueError(
            f"{benchmark} DPU_INPUT_ARGUMENTS has {len(data)} bytes; expected {expected}"
        )
    params: dict[str, int] = {}
    offset = 0
    for field in config.fields:
        chunk = data[offset : offset + field.width]
        params[field.name] = int.from_bytes(chunk, "little", signed=field.signed)
        offset += field.width
    return params


def entry_function(benchmark: str, params: dict[str, int]) -> str:
    config = BENCHMARK_CONFIGS[normalize_benchmark(benchmark)]
    if config.direct_entry:
        return config.direct_entry
    kernel = params.get("kernel")
    if kernel is None:
        raise ValueError(f"{benchmark} argument schema has no kernel selector")
    return f"main_kernel{kernel + 1}"


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


def load_summary_phases(encoded: str, benchmark: str) -> list[DpuPhase]:
    """Decode per-DPU/execution argument records embedded in summary.csv."""
    try:
        records = json.loads(encoded)
    except json.JSONDecodeError as error:
        raise ValueError("invalid dpu_input_arguments_json") from error
    if not isinstance(records, list) or not records:
        raise ValueError("dpu_input_arguments_json must be a non-empty list")

    phases: list[DpuPhase] = []
    for record in records:
        if not isinstance(record, dict):
            raise ValueError("DPU argument record must be an object")
        try:
            execution = int(record["execution"])
            dpu = int(record["dpu"])
            data = bytes.fromhex(str(record["data_hex"]))
        except (KeyError, TypeError, ValueError) as error:
            raise ValueError(f"invalid DPU argument record: {record!r}") from error
        params = decode_arguments(benchmark, data)
        phases.append(
            DpuPhase(
                execution=execution,
                dpu=dpu,
                function=entry_function(benchmark, params),
                params=params,
                arguments_source=str(record.get("source", "summary.csv")),
            )
        )
    return sorted(phases, key=lambda phase: (phase.dpu, phase.execution))
