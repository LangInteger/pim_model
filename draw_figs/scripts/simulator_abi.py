"""Decode simulator DPU argument dumps at the ingestion boundary.

This module owns the benchmark-specific binary ABI. Downstream analyses receive
only named parameters and entry functions; they never interpret byte layouts.
"""

from __future__ import annotations

from dataclasses import dataclass


@dataclass(frozen=True)
class ArgumentField:
    name: str
    width: int
    signed: bool = False


@dataclass(frozen=True)
class SimulatorArgumentABI:
    fields: tuple[ArgumentField, ...]
    direct_entry: str | None = None


F = ArgumentField
SIMULATOR_ARGUMENT_ABIS: dict[str, SimulatorArgumentABI] = {
    "BS": SimulatorArgumentABI(
        (F("input_size", 8), F("slice_per_dpu", 8), F("kernel", 4))
    ),
    "VA": SimulatorArgumentABI(
        (F("size", 4), F("transfer_size", 4), F("kernel", 4))
    ),
    "RED": SimulatorArgumentABI(
        (F("size", 4), F("kernel", 4), F("t_count", 4, True))
    ),
    "HST-L": SimulatorArgumentABI(
        (F("size", 4), F("transfer_size", 4), F("bins", 4), F("kernel", 4))
    ),
    "HST-S": SimulatorArgumentABI(
        (F("size", 4), F("transfer_size", 4), F("bins", 4), F("kernel", 4))
    ),
    "GEMV": SimulatorArgumentABI(
        (F("n_size", 4), F("n_size_pad", 4), F("nr_rows", 4), F("max_rows", 4)),
        direct_entry="main",
    ),
    "MLP": SimulatorArgumentABI(
        (F("n_size", 4), F("n_size_pad", 4), F("nr_rows", 4), F("max_rows", 4)),
        direct_entry="main",
    ),
    "SEL": SimulatorArgumentABI((F("size", 4), F("kernel", 4))),
    "UNI": SimulatorArgumentABI((F("size", 4), F("kernel", 4))),
    "TRNS": SimulatorArgumentABI(
        (F("m", 4), F("n", 4), F("M_", 4), F("kernel", 4))
    ),
    "TS": SimulatorArgumentABI(
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
    "SCAN-RSS": SimulatorArgumentABI(
        (F("size", 4), F("kernel", 4), F("t_count", 8, True))
    ),
    "SCAN-SSA": SimulatorArgumentABI(
        (F("size", 4), F("kernel", 4), F("t_count", 8, True))
    ),
}


def normalize_benchmark(name: str) -> str:
    benchmark = name.upper()
    if benchmark not in SIMULATOR_ARGUMENT_ABIS:
        raise ValueError(f"unsupported simulator argument ABI for {name!r}")
    return benchmark


def decode_execution_input(benchmark: str, data: bytes) -> tuple[str, dict[str, int]]:
    """Translate one binary DPU_INPUT_ARGUMENTS value into semantic input."""
    benchmark = normalize_benchmark(benchmark)
    abi = SIMULATOR_ARGUMENT_ABIS[benchmark]
    expected = sum(field.width for field in abi.fields)
    if len(data) != expected:
        raise ValueError(
            f"{benchmark} DPU_INPUT_ARGUMENTS has {len(data)} bytes; expected {expected}"
        )

    params: dict[str, int] = {}
    offset = 0
    for field in abi.fields:
        chunk = data[offset : offset + field.width]
        params[field.name] = int.from_bytes(chunk, "little", signed=field.signed)
        offset += field.width

    if abi.direct_entry is not None:
        function = abi.direct_entry
    else:
        kernel = params.get("kernel")
        if kernel is None:
            raise ValueError(f"{benchmark} argument schema has no kernel selector")
        function = f"main_kernel{kernel + 1}"
    return function, params
