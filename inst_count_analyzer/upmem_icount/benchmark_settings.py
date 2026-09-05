from __future__ import annotations

import re
import math
from dataclasses import dataclass
from pathlib import Path


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
    arguments_path: Path


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


ARGUMENT_FILE_RE = re.compile(
    r"^input_DPU_INPUT_ARGUMENTS_(?P<execution>\d+)_(?P<dpu>\d+)\.bin$"
)


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


def simulator_setting_dir(
    simulator_root: Path,
    experiment: str,
    benchmark: str,
    num_dpus: int,
    tasklets: int,
    data_prep: int,
) -> Path:
    benchmark_upper = normalize_benchmark(benchmark)
    parent = simulator_root / benchmark_upper.lower() / experiment
    basename = (
        f"{benchmark_upper}_dpu{num_dpus}_tasklets{tasklets}_size{data_prep}"
    )
    path = parent / basename
    if not path.is_dir():
        raise FileNotFoundError(
            f"simulator artifacts for {basename} do not exist under {parent}"
        )
    return path


def read_byte_dump(path: Path) -> bytes:
    values: list[int] = []
    for token in path.read_text(encoding="utf-8").split():
        value = int(token, 0)
        if not 0 <= value <= 255:
            raise ValueError(f"invalid byte {value} in {path}")
        values.append(value)
    return bytes(values)


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
    if benchmark == "TRNS" and params.get("kernel") == 1:
        # get_tile() assigns at most M*n-1 non-sentinel tiles. A permutation
        # cycle cannot visit more tiles than that same finite domain.
        tile_max = max(0, params["M_"] * params["n"] - 1)
        return {"main_kernel2": tile_max}
    return {}


def load_setting_phases(setting_dir: Path, benchmark: str) -> list[DpuPhase]:
    phases: list[DpuPhase] = []
    for path in sorted(setting_dir.glob("input_DPU_INPUT_ARGUMENTS_*.bin")):
        match = ARGUMENT_FILE_RE.match(path.name)
        if match is None:
            continue
        params = decode_arguments(benchmark, read_byte_dump(path))
        phases.append(
            DpuPhase(
                execution=int(match.group("execution")),
                dpu=int(match.group("dpu")),
                function=entry_function(benchmark, params),
                params=params,
                arguments_path=path,
            )
        )
    if not phases:
        raise ValueError(f"no DPU_INPUT_ARGUMENTS dumps found in {setting_dir}")
    return sorted(phases, key=lambda phase: (phase.dpu, phase.execution))
