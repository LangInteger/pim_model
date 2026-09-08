#!/usr/bin/env python3
"""Evaluate one or all benchmarks' cost sensitivities against uPIMulator."""

from __future__ import annotations

import argparse
import ast
import csv
import json
import math
import re
import sys
from pathlib import Path
from typing import Any


BLOCK_SIZE_BYTES = 1 << 10
ELEMENT_SIZE_BYTES = 4
REVOLVER_SCHEDULING_CYCLES = 11
LOOP_TERM_PATTERN = re.compile(
    r"\(\s*input_size_dpu_bytes\s*/\s*"
    r"\(\s*\(\s*1\s*<<\s*\d+\s*\)\s*\*\s*\d+\s*\)\s*\)"
)

# Element and block sizes must match each benchmark's build; they are not
# encoded numerically in the analyzer's symbolic JSON. Benchmark-specific
# adapters below define the meaning of data_prep_params when it is not a flat
# total element count (for example, GEMV uses it as m_size).
STATIC_BENCHMARK_SPECS: dict[str, dict[str, Any]] = {
    # uPIMulator's BS binary uses the source default BL=8 (256-byte blocks).
    "bs": {
        "element_size": 8,
        "block_size": 256,
        "summary_tasklets": 16,
    },
    "va": {"element_size": 4, "block_size": 1024},
    "red": {"element_size": 8, "block_size": 1024},
    # Go uPIMulator's HST-L CMake configuration sets BL=10.
    "hst-l": {"element_size": 4, "block_size": 1024, "bins": 256},
    "hst-s": {"element_size": 4, "block_size": 1024, "bins": 256},
    "gemv": {
        "element_size": 4,
        "block_size": 1024,
        "kernel_functions": ("task.c::main",),
        # uPIMulator interprets data_prep_params as m_size and fixes n_size.
        "n_size": 64,
    },
    "mlp": {
        "element_size": 4,
        "block_size": 1024,
        "kernel_functions": ("task.c::main",),
        "num_layers": 3,
    },
    "sel": {
        "element_size": 8,
        "block_size": 1024,
        "elements_per_tasklet_alignment": 128,
        "selected_elements_per_block_lower": 1,
        "selected_elements_per_block_upper": 128,
    },
    "uni": {
        "element_size": 8,
        "block_size": 1024,
        "elements_per_tasklet_alignment": 128,
        "unique_elements_per_block_lower": 1,
        "unique_elements_per_block_upper": 128,
    },
    "trns": {
        "element_size": 8,
        # read_tile_step2/write_tile_step2 split transfers at the SDK maximum.
        "block_size": 2048,
    },
    "ts": {
        "element_size": 4,
        # TS omits -DBL in its Makefile, so both its normal build and the
        # analyzer use support/common.h's BL=8 fallback.
        "block_size": 256,
        "elements_per_tasklet_alignment": 64,
        "query_length": 64,
    },
    "scan-rss": {
        "element_size": 8,
        "block_size": 1024,
        "elements_per_tasklet_alignment": 128,
    },
    "scan-ssa": {
        "element_size": 8,
        "block_size": 1024,
        "elements_per_tasklet_alignment": 128,
    },
}

SIZEOF_BYTES = {
    "char": 1,
    "short": 2,
    "int": 4,
    "int32_t": 4,
    "uint32_t": 4,
    "float": 4,
    "int64_t": 8,
    "uint64_t": 8,
    "double": 8,
}


def optional_float(value: Any) -> float | str:
    """Parse validation-only data without making it a model dependency."""
    try:
        return float(value)
    except (TypeError, ValueError):
        return ""


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Compare benchmark cost sensitivities with uPIMulator cycles."
    )
    parser.add_argument(
        "benchmark",
        nargs="?",
        help=(
            "Benchmark name used to resolve default paths, such as va or bs. "
            "If omitted, process every aggregated benchmark."
        ),
    )
    parser.add_argument(
        "--static-summary",
        type=Path,
        help="Override the static analyzer summary path",
    )
    parser.add_argument(
        "--simulator-summary",
        type=Path,
        help="Override the aggregated simulator summary path",
    )
    parser.add_argument(
        "--instruction-summary",
        type=Path,
        help="Override the benchmark's static instruction-count summary path",
    )
    parser.add_argument(
        "--output-dir",
        type=Path,
        help="Override the cost-model output directory",
    )
    parser.add_argument("--memory-bandwidth", type=float, default=2.0)
    parser.add_argument("--mram-read-latency", type=float, default=77.0)
    parser.add_argument("--mram-write-latency", type=float, default=61.0)
    parser.add_argument(
        "--compute-stall-rate",
        type=float,
        default=0.10,
        help=(
            "Conservative non-memory pipeline idle fraction in [0, 1) "
            "(default: 0.10; the largest 16-tasklet PrIM case visible in "
            "uPIMulator Figure 6 is approximately 38%%)"
        ),
    )
    return parser.parse_args()


def compose_cycle_bounds(
    instruction_lower: float,
    instruction_upper: float,
    memory_lower: float,
    memory_upper: float,
    tasklets: int,
    stall_rate: float,
) -> dict[str, float | str]:
    """Propagate instruction and memory intervals into cycle bounds."""
    if tasklets <= 0:
        raise ValueError("tasklets must be positive")
    if not 0 <= stall_rate < 1:
        raise ValueError("stall_rate must be in [0, 1)")
    if not instruction_lower <= instruction_upper:
        raise ValueError("instruction lower bound exceeds upper bound")
    if not memory_lower <= memory_upper:
        raise ValueError("memory lower bound exceeds upper bound")

    issue_factor = REVOLVER_SCHEDULING_CYCLES * max(
        1 / tasklets, 1 / REVOLVER_SCHEDULING_CYCLES
    )
    compute_lower = instruction_lower * issue_factor
    compute_upper = instruction_upper * issue_factor
    compute_conservative_upper = compute_upper / (1 - stall_rate)

    # A single tasklet blocks on every DMA and therefore cannot overlap useful
    # computation with memory service. With multiple tasklets, maximal overlap
    # is a valid structural lower endpoint.
    if tasklets == 1:
        composed_lower = compute_lower + memory_lower
        lower_assumption = "single_tasklet_no_overlap"
    else:
        composed_lower = max(compute_lower, memory_lower)
        lower_assumption = "maximal_compute_memory_overlap"
    composed_upper = compute_conservative_upper + memory_upper

    return {
        "issue_factor": issue_factor,
        "compute_lower": compute_lower,
        "compute_upper": compute_upper,
        "compute_conservative_upper": compute_conservative_upper,
        "composed_lower": composed_lower,
        "composed_upper": composed_upper,
        "lower_assumption": lower_assumption,
    }


def load_static_instruction_counts(
    path: Path, benchmark: str
) -> dict[str, Any]:
    """Load static instruction bounds for exact experiment settings."""
    with path.open(newline="", encoding="utf-8") as input_file:
        rows = list(csv.DictReader(input_file))
    if not rows:
        raise ValueError(f"no static instruction results found in {path}")
    if "experiment" not in rows[0]:
        raise ValueError(f"instruction summary lacks exact experiment settings: {path}")

    benchmark_upper = benchmark.upper()
    counts: dict[tuple[str, int, int, int], dict[str, Any]] = {}
    for row in rows:
        if row.get("benchmark", "").upper() != benchmark_upper:
            raise ValueError(
                f"non-{benchmark_upper} row in instruction summary: {row}"
            )
        key = (
            row["experiment"],
            int(row["num_dpus"]),
            int(row["num_tasklets"]),
            int(row["data_prep_params"]),
        )
        if key in counts:
            raise ValueError(f"duplicate static instruction setting: {key}")
        lower = float(row["instructions_lower"])
        upper = float(row["instructions_upper"])
        if lower > upper:
            raise ValueError(f"invalid static instruction interval for {key}")
        counts[key] = {
            "lower": lower,
            "upper": upper,
            "midpoint": float(row.get("instructions_midpoint") or (lower + upper) / 2),
            "source": "static_analyzer_exact_setting_midpoint",
            "scope": row.get("instruction_scope", ""),
            "unexpanded_callees": row.get("unexpanded_callees", ""),
        }
    return {"settings": counts, "path": path}


def static_instruction_bound_for_setting(
    index: dict[str, Any],
    measured: dict[str, str],
) -> dict[str, Any]:
    """Return the static instruction bound for one exact experiment setting."""
    key = (
        measured["experiment"],
        int(measured["num_dpus"]),
        int(measured["num_tasklets"]),
        int(measured["data_prep_params"]),
    )
    try:
        return index["settings"][key]
    except KeyError as error:
        raise ValueError(
            f"no exact static instruction result for setting {key} in {index['path']}"
        ) from error


def load_kernel_features(
    path: Path, kernel_functions: tuple[str, ...] | None = None
) -> list[dict[str, Any]]:
    records = json.loads(path.read_text(encoding="utf-8"))
    kernels: list[dict[str, Any]] = []
    for record in records:
        function = str(record.get("function", ""))
        selected = (
            function in kernel_functions
            if kernel_functions is not None
            else re.fullmatch(r"task\.c::main_kernel\d+", function) is not None
        )
        if selected:
            features = record.get("features", {})
            required = {
                "mram_read",
                "mram_read_tx",
                "mram_write",
                "mram_write_tx",
            }
            missing = required - features.keys()
            if missing:
                raise ValueError(
                    f"{function} missing analyzer features: {sorted(missing)}"
                )
            kernels.append(
                {
                    "function": function,
                    "features": {name: str(features[name]) for name in required},
                }
            )
    if not kernels:
        expected = ", ".join(kernel_functions or ("task.c::main_kernelN",))
        raise ValueError(f"no supported kernel function found; expected {expected}")
    return sorted(kernels, key=lambda kernel: kernel["function"])


def normalize_expression(expression: str) -> str:
    def replace_sizeof(match: re.Match[str]) -> str:
        type_name = " ".join(match.group(1).split())
        if type_name not in SIZEOF_BYTES:
            raise ValueError(f"unsupported sizeof type: {type_name}")
        return str(SIZEOF_BYTES[type_name])

    normalized = re.sub(r"sizeof\s*\(\s*([A-Za-z_][\w\s]*)\s*\)", replace_sizeof, expression)
    normalized = re.sub(
        r"\(\s*(?:u?int(?:8|16|32|64)_t|int|unsigned\s+int)\s*\)\s*",
        "",
        normalized,
    )
    return LOOP_TERM_PATTERN.sub("iterations", normalized)


def evaluate_expression(
    expression: str,
    iterations: int,
    environment: dict[str, float] | None = None,
    *,
    truncate_division: bool = False,
    branch_join: str = "max",
) -> float:
    """Evaluate analyzer arithmetic; join ``path`` alternatives at either bound."""
    if branch_join not in {"min", "max"}:
        raise ValueError("branch_join must be 'min' or 'max'")
    normalized = normalize_expression(expression)
    values = {
        "iterations": float(iterations),
        "l_size": BLOCK_SIZE_BYTES // ELEMENT_SIZE_BYTES,
        "l_size_bytes": BLOCK_SIZE_BYTES,
    }
    if environment:
        values.update(environment)
    tree = ast.parse(normalized, mode="eval")

    def visit(node: ast.AST) -> float:
        if isinstance(node, ast.Expression):
            return visit(node.body)
        if isinstance(node, ast.Constant) and isinstance(node.value, (int, float)):
            return float(node.value)
        if isinstance(node, (ast.Name, ast.Attribute)):
            parts: list[str] = []
            symbol: ast.AST = node
            while isinstance(symbol, ast.Attribute):
                parts.append(symbol.attr)
                symbol = symbol.value
            if not isinstance(symbol, ast.Name):
                raise ValueError(
                    f"unsupported analyzer symbol in {expression!r}"
                )
            parts.append(symbol.id)
            symbol_name = ".".join(reversed(parts))
            if symbol_name not in values:
                raise ValueError(
                    f"unresolved analyzer symbol {symbol_name!r} in {expression!r}"
                )
            return float(values[symbol_name])
        if isinstance(node, ast.UnaryOp) and isinstance(node.op, ast.USub):
            return -visit(node.operand)
        if isinstance(node, ast.BinOp):
            left, right = visit(node.left), visit(node.right)
            if isinstance(node.op, ast.Add):
                return left + right
            if isinstance(node.op, ast.Sub):
                return left - right
            if isinstance(node.op, ast.Mult):
                return left * right
            if isinstance(node.op, ast.Div):
                quotient = left / right
                return (
                    float(math.trunc(quotient))
                    if truncate_division
                    else quotient
                )
            if isinstance(node.op, ast.LShift):
                return float(int(left) << int(right))
            if isinstance(node.op, ast.RShift):
                return float(int(left) >> int(right))
        if (
            isinstance(node, ast.Call)
            and isinstance(node.func, ast.Name)
            and node.func.id in {"ceil_div", "min", "max", "path"}
            and not node.keywords
        ):
            arguments = [visit(argument) for argument in node.args]
            if node.func.id == "ceil_div":
                if len(arguments) != 2:
                    raise ValueError("ceil_div requires exactly two arguments")
                numerator, denominator = arguments
                if denominator == 0:
                    raise ValueError("ceil_div denominator must be nonzero")
                return float(math.ceil(numerator / denominator))
            if node.func.id == "min":
                return min(arguments)
            if node.func.id == "path" and branch_join == "min":
                return min(arguments)
            return max(arguments)
        raise ValueError(f"unsupported expression element: {ast.dump(node)}")

    return visit(tree)


def aggregate_gemv_memory_feature(
    kernels: list[dict[str, Any]],
    feature: str,
    matrix_rows: int,
    num_dpus: int,
    matrix_columns: int,
) -> float:
    """Instantiate GEMV's symbolic MRAM expression for one DPU.

    uPIMulator fixes n_size to 64, treats data_prep_params as m_size, and
    requires m_size to divide evenly across DPUs. The analyzer emitted the
    outer-loop upper bound with start_row included; setting it to zero and
    supplying all rows assigned to a DPU aggregates the tasklet work exactly.
    """
    if matrix_rows % num_dpus != 0:
        raise ValueError("GEMV m_size must be divisible by the number of DPUs")
    rows_per_dpu = matrix_rows // num_dpus
    environment = {
        "n_size": float(matrix_columns),
        "element_per_cacheC": float(8 // SIZEOF_BYTES["uint32_t"]),
        # For a nested `pos < 2 && i + pos < nr_rows` loop, the analyzer
        # preserves the per-iteration upper bound as min(2, nr_rows - i).
        # GEMV's aggregate model evaluates that bound at the earliest row,
        # where it is maximal, before multiplying by the outer trip count.
        "i": 0.0,
        "nr_rows": float(rows_per_dpu),
        "start_row": 0.0,
        "rows_per_tasklet": float(rows_per_dpu),
    }
    return sum(
        evaluate_expression(
            kernel["features"][feature],
            0,
            environment,
            # n_size=64 makes (n_size - 256) / 256 negative. C integer
            # division truncates it to zero, matching the skipped full-block
            # loop; Python's ordinary division would incorrectly yield -0.75.
            truncate_division=True,
        )
        for kernel in kernels
    )


def aggregate_affine_feature(
    expression: str,
    tasklets: int,
    blocks: int,
    environment: dict[str, float] | None = None,
) -> float:
    """Aggregate an affine per-tasklet loop expression without assuming balance."""
    base = evaluate_expression(expression, 0, environment)
    one_iteration = evaluate_expression(expression, 1, environment)
    two_iterations = evaluate_expression(expression, 2, environment)
    increment = one_iteration - base
    if not math.isclose(two_iterations - one_iteration, increment):
        raise ValueError(f"feature is not affine in loop iterations: {expression}")
    return tasklets * base + blocks * increment


def aggregate_program_feature(
    kernels: list[dict[str, Any]],
    feature: str,
    tasklets: int,
    blocks: int,
    environment: dict[str, float],
    *,
    singleton_without_loop: bool,
) -> float:
    """Sum one analyzer feature across sequential kernel launches."""
    total = 0.0
    for kernel in kernels:
        expression = kernel["features"][feature]
        if LOOP_TERM_PATTERN.search(expression) or not singleton_without_loop:
            total += aggregate_affine_feature(
                expression, tasklets, blocks, environment
            )
        else:
            # Memory expressions without the distributed input loop represent
            # a one-off transfer, e.g. tasklet 0 writing the final histogram.
            total += evaluate_expression(expression, 0, environment)
    return total


def aggregate_mlp_memory_feature(
    kernels: list[dict[str, Any]],
    feature: str,
    matrix_size: int,
    num_dpus: int,
    num_layers: int,
) -> float:
    """Instantiate MLP's symbolic per-kernel MRAM expression per DPU."""
    if matrix_size % num_dpus != 0:
        raise ValueError("MLP matrix size must be divisible by the number of DPUs")
    rows_per_dpu = matrix_size // num_dpus
    environment = {
        "n_size": float(matrix_size),
        # MLP uses the same two-row loop shape as GEMV.  Evaluate its
        # min(2, nr_rows - i) expression at the earliest row, where the
        # per-iteration count reaches its upper bound.
        "i": 0.0,
        "nr_rows": float(rows_per_dpu),
        # Summaries produced before compound-condition support used N for this
        # fixed two-row inner loop.
        "N": 2.0,
        # Keep start_row for compatibility with summaries generated before the
        # analyzer simplified (start_row + rows_per_tasklet) - start_row.
        # Supplying all DPU rows aggregates the tasklet work by linearity.
        "start_row": 0.0,
        "rows_per_tasklet": float(rows_per_dpu),
    }
    per_layer = sum(
        evaluate_expression(kernel["features"][feature], 0, environment)
        for kernel in kernels
    )
    return num_layers * per_layer


def bs_static_memory_bounds(
    kernels: list[dict[str, Any]],
    input_elements: int,
    num_dpus: int,
    tasklets: int,
    block_size: int,
    summary_tasklets: int,
) -> dict[str, float]:
    """Bind BS loop/remainder bounds and evaluate its JSON memory expressions."""
    parallelism = num_dpus * tasklets
    base_queries = input_elements // 8
    padded_queries = (
        (base_queries + parallelism - 1) // parallelism
    ) * parallelism
    queries_per_dpu = padded_queries // num_dpus

    input_bytes = input_elements * SIZEOF_BYTES["int64_t"]
    search_blocks = max(1, math.ceil(input_bytes / block_size))
    max_nonfinal_iterations = math.ceil(math.log2(search_blocks))

    memory_features = (
        "mram_read",
        "mram_read_tx",
        "mram_write",
        "mram_write_tx",
    )
    while_symbols = {
        symbol
        for kernel in kernels
        for feature in memory_features
        for symbol in re.findall(
            r"\bUNKNOWN_WHILE_BOUND_[A-Za-z0-9_]+\b",
            kernel["features"][feature],
        )
    }
    if len(while_symbols) != 1:
        raise ValueError(
            "BS JSON must contain exactly one DPU while-bound symbol; "
            f"found {sorted(while_symbols)}"
        )
    while_symbol = next(iter(while_symbols))

    def evaluate_bound(
        while_iterations: int,
        remainder_bytes: int,
        branch_join: str,
    ) -> dict[str, float]:
        environment = {
            while_symbol: float(while_iterations),
            "remain_bytes_to_search": float(remainder_bytes),
            "DPU_INPUT_ARGUMENTS.slice_per_dpu": float(queries_per_dpu),
        }
        return {
            feature: summary_tasklets
            * sum(
                evaluate_expression(
                    kernel["features"][feature],
                    0,
                    environment,
                    branch_join=branch_join,
                )
                for kernel in kernels
            )
            for feature in memory_features
        }

    # ``path(a, b)`` records mutually exclusive CFG alternatives. Select the
    # cheaper feasible path for the lower endpoint and the costlier one for the
    # upper endpoint; ordinary source-level max() always remains a maximum.
    lower = evaluate_bound(
        while_iterations=1,
        remainder_bytes=0,
        branch_join="min",
    )
    upper = evaluate_bound(
        while_iterations=max_nonfinal_iterations + 1,
        remainder_bytes=block_size,
        branch_join="max",
    )
    return {
        "read_bytes_lower": lower["mram_read"],
        "read_bytes_upper": upper["mram_read"],
        "write_bytes_lower": lower["mram_write"],
        "write_bytes_upper": upper["mram_write"],
        "read_transactions_lower": lower["mram_read_tx"],
        "read_transactions_upper": upper["mram_read_tx"],
        "write_transactions_lower": lower["mram_write_tx"],
        "write_transactions_upper": upper["mram_write_tx"],
    }


def trns_static_memory_bounds(
    matrix_tiles: int, num_dpus: int, tasklets: int
) -> dict[str, float | int]:
    """Derive per-DPU TRNS traffic from its two source-level kernels.

    Kernel 1 reads and writes every matrix tile exactly once. Kernel 2 walks
    the cycles of the in-place transpose permutation. A sequential walk starts
    each non-trivial permutation cycle once; concurrent tasklets can start the
    same cycle before its done bits become visible. The lower endpoint counts
    one starter per cycle. The upper endpoint permits every non-fixed tile to
    become a starter, which bounds all legal tasklet interleavings without
    consulting simulator counters.
    """
    if matrix_tiles <= 0 or num_dpus <= 0 or tasklets <= 0:
        raise ValueError("TRNS dimensions, DPUs, and tasklets must be positive")

    # These are the two configurations selected by uPIMulator's TRNS data
    # preparator. data_prep_params supplies M in both cases.
    if num_dpus == 1:
        matrix_columns, tile_width, tile_height = 1, 16, 4
    else:
        matrix_columns, tile_width, tile_height = 64, 4, 8
    active_dpus = min(matrix_columns, num_dpus)
    if matrix_columns % active_dpus:
        raise ValueError("TRNS matrix columns must divide across active DPUs")
    rounds_per_dpu = matrix_columns // active_dpus

    tile_bytes = tile_width * tile_height * SIZEOF_BYTES["int64_t"]
    step2_transactions_per_tile = math.ceil(tile_bytes / 2048)
    step2_bytes = matrix_tiles * tile_bytes
    step2_transactions = matrix_tiles * step2_transactions_per_tile

    permutation_size = matrix_tiles * tile_height - 1
    visited: set[int] = set()
    nontrivial_cycle_lengths: list[int] = []
    for start in range(permutation_size):
        if start in visited:
            continue
        cycle: list[int] = []
        current = start
        while current not in visited:
            visited.add(current)
            cycle.append(current)
            current = (current * matrix_tiles) % permutation_size
        if len(cycle) > 1:
            nontrivial_cycle_lengths.append(len(cycle))

    nonfixed_tiles = sum(nontrivial_cycle_lengths)
    num_nontrivial_cycles = len(nontrivial_cycle_lengths)
    inner_iterations_lower = nonfixed_tiles + num_nontrivial_cycles
    inner_iterations_upper = (
        inner_iterations_lower if tasklets == 1 else 2 * nonfixed_tiles
    )
    tile_transfer_bytes = tile_width * SIZEOF_BYTES["int64_t"]

    def traffic(inner_iterations: int) -> dict[str, int]:
        # Each outer/inner step-3 visit performs one tile read and one 8-byte
        # done-bit read. Every inner visit writes the done word; only the first
        # visit to each non-fixed tile writes a transposed tile.
        step3_read_visits = nonfixed_tiles + inner_iterations
        return {
            "read_bytes": step2_bytes
            + step3_read_visits * (tile_transfer_bytes + 8),
            "write_bytes": step2_bytes
            + nonfixed_tiles * tile_transfer_bytes
            + inner_iterations * 8,
            "read_transactions": step2_transactions + 2 * step3_read_visits,
            "write_transactions": step2_transactions
            + nonfixed_tiles
            + inner_iterations,
        }

    lower = traffic(inner_iterations_lower)
    upper = traffic(inner_iterations_upper)
    result: dict[str, float | int] = {
        f"{name}_lower": float(value) for name, value in lower.items()
    }
    result.update({f"{name}_upper": float(value) for name, value in upper.items()})
    result.update(
        {
            "matrix_columns": matrix_columns,
            "tile_width": tile_width,
            "tile_height": tile_height,
            "rounds_per_dpu": rounds_per_dpu,
            "elements_per_dpu": (
                matrix_tiles * tile_width * tile_height * rounds_per_dpu
            ),
            "nonfixed_tiles": nonfixed_tiles,
            "nontrivial_cycles": num_nontrivial_cycles,
        }
    )
    for key in tuple(result):
        if key.endswith(("_lower", "_upper")):
            result[key] = float(result[key]) * rounds_per_dpu
    return result


def estimate_rows(args: argparse.Namespace) -> list[dict[str, Any]]:
    if not 0 <= args.compute_stall_rate < 1:
        raise ValueError("--compute-stall-rate must be in [0, 1)")
    benchmark = args.benchmark.lower()
    spec = STATIC_BENCHMARK_SPECS.get(benchmark)
    if spec is None:
        raise ValueError(f"no static memory adapter for benchmark: {benchmark}")
    kernels = load_kernel_features(args.static_summary, spec.get("kernel_functions"))
    instruction_counts = load_static_instruction_counts(
        args.instruction_summary, benchmark
    )
    with args.simulator_summary.open(newline="", encoding="utf-8") as input_file:
        simulator_rows = list(csv.DictReader(input_file))

    estimates: list[dict[str, Any]] = []
    for measured in simulator_rows:
        tasklets = int(measured["num_tasklets"])
        num_dpus = int(measured["num_dpus"])
        total_elements = int(measured["data_prep_params"])
        element_size = int(spec["element_size"])
        block_size = int(spec["block_size"])
        logical_elements_per_dpu = math.ceil(total_elements / num_dpus)
        if benchmark == "bs":
            # The sorted input array is replicated on every DPU; queries are
            # partitioned separately by the BS adapter below.
            logical_elements_per_dpu = total_elements
        if benchmark == "mlp":
            if total_elements % num_dpus != 0:
                raise ValueError(
                    "MLP data_prep_params must be divisible by the number of DPUs"
                )
            logical_elements_per_dpu = (
                total_elements // num_dpus
            ) * total_elements
        if benchmark == "trns":
            trns_dimensions = trns_static_memory_bounds(
                total_elements, num_dpus, tasklets
            )
            logical_elements_per_dpu = int(trns_dimensions["elements_per_dpu"])
        elements_per_dpu = logical_elements_per_dpu
        if spec.get("elements_per_tasklet_alignment"):
            alignment = tasklets * int(spec["elements_per_tasklet_alignment"])
            elements_per_dpu = math.ceil(elements_per_dpu / alignment) * alignment
        else:
            aligned_bytes = math.ceil(elements_per_dpu * element_size / 8) * 8
            elements_per_dpu = aligned_bytes // element_size
        bytes_per_dpu = elements_per_dpu * element_size
        blocks = math.ceil(bytes_per_dpu / block_size)
        max_blocks_per_tasklet = math.ceil(blocks / tasklets)

        expression_environment = {
            "l_size": float(block_size // element_size),
            "l_size_bytes": float(block_size),
            "bins": float(spec.get("bins", 0)),
        }
        if benchmark == "bs":
            bs_memory = bs_static_memory_bounds(
                kernels,
                total_elements,
                num_dpus,
                tasklets,
                block_size,
                int(spec["summary_tasklets"]),
            )
            memory_read_bytes_lower = bs_memory["read_bytes_lower"]
            memory_read_bytes = bs_memory["read_bytes_upper"]
            memory_write_bytes_lower = bs_memory["write_bytes_lower"]
            memory_write_bytes = bs_memory["write_bytes_upper"]
            memory_read_tx_lower = bs_memory["read_transactions_lower"]
            memory_read_tx = bs_memory["read_transactions_upper"]
            memory_write_tx_lower = bs_memory["write_transactions_lower"]
            memory_write_tx = bs_memory["write_transactions_upper"]
        elif benchmark == "gemv":
            matrix_columns = int(spec["n_size"])
            memory_read_bytes = aggregate_gemv_memory_feature(
                kernels, "mram_read", total_elements, num_dpus, matrix_columns
            )
            memory_write_bytes = aggregate_gemv_memory_feature(
                kernels, "mram_write", total_elements, num_dpus, matrix_columns
            )
            memory_read_tx = aggregate_gemv_memory_feature(
                kernels, "mram_read_tx", total_elements, num_dpus, matrix_columns
            )
            memory_write_tx = aggregate_gemv_memory_feature(
                kernels, "mram_write_tx", total_elements, num_dpus, matrix_columns
            )
        elif benchmark == "mlp":
            num_layers = int(spec["num_layers"])
            memory_read_bytes = aggregate_mlp_memory_feature(
                kernels, "mram_read", total_elements, num_dpus, num_layers
            )
            memory_write_bytes = aggregate_mlp_memory_feature(
                kernels, "mram_write", total_elements, num_dpus, num_layers
            )
            memory_read_tx = aggregate_mlp_memory_feature(
                kernels, "mram_read_tx", total_elements, num_dpus, num_layers
            )
            memory_write_tx = aggregate_mlp_memory_feature(
                kernels, "mram_write_tx", total_elements, num_dpus, num_layers
            )
        elif benchmark in {"sel", "uni"}:
            prefix = "selected" if benchmark == "sel" else "unique"
            lower_environment = {
                **expression_environment,
                "l_count": float(spec[f"{prefix}_elements_per_block_lower"]),
            }
            upper_environment = {
                **expression_environment,
                "l_count": float(spec[f"{prefix}_elements_per_block_upper"]),
            }
            memory_read_bytes = aggregate_program_feature(
                kernels, "mram_read", tasklets, blocks, lower_environment,
                singleton_without_loop=True,
            )
            memory_write_bytes_lower = aggregate_program_feature(
                kernels, "mram_write", tasklets, blocks, lower_environment,
                singleton_without_loop=True,
            )
            memory_write_bytes = aggregate_program_feature(
                kernels, "mram_write", tasklets, blocks, upper_environment,
                singleton_without_loop=True,
            )
            memory_read_tx = aggregate_program_feature(
                kernels, "mram_read_tx", tasklets, blocks, lower_environment,
                singleton_without_loop=True,
            )
            memory_write_tx = aggregate_program_feature(
                kernels, "mram_write_tx", tasklets, blocks, lower_environment,
                singleton_without_loop=True,
            )
        elif benchmark == "trns":
            trns_memory = trns_static_memory_bounds(total_elements, num_dpus, tasklets)
            memory_read_bytes_lower = trns_memory["read_bytes_lower"]
            memory_read_bytes = trns_memory["read_bytes_upper"]
            memory_write_bytes_lower = trns_memory["write_bytes_lower"]
            memory_write_bytes = trns_memory["write_bytes_upper"]
            memory_read_tx_lower = trns_memory["read_transactions_lower"]
            memory_read_tx = trns_memory["read_transactions_upper"]
            memory_write_tx_lower = trns_memory["write_transactions_lower"]
            memory_write_tx = trns_memory["write_transactions_upper"]
        elif benchmark == "ts":
            query_length = int(spec["query_length"])
            if elements_per_dpu < query_length:
                raise ValueError("TS DPU slice is shorter than its query")
            # The JSON expression uses myEndElem as its outer-loop upper bound.
            # Bind it to the total valid starting span for one DPU; this sums
            # the disjoint tasklet ranges without using simulator counters.
            ts_environment = {
                **expression_environment,
                "query_length": float(query_length),
                "myEndElem": float(elements_per_dpu - query_length),
            }
            memory_read_bytes = aggregate_program_feature(
                kernels, "mram_read", tasklets, blocks, ts_environment,
                singleton_without_loop=True,
            )
            memory_write_bytes = aggregate_program_feature(
                kernels, "mram_write", tasklets, blocks, ts_environment,
                singleton_without_loop=True,
            )
            memory_read_tx = aggregate_program_feature(
                kernels, "mram_read_tx", tasklets, blocks, ts_environment,
                singleton_without_loop=True,
            )
            memory_write_tx = aggregate_program_feature(
                kernels, "mram_write_tx", tasklets, blocks, ts_environment,
                singleton_without_loop=True,
            )
        else:
            memory_read_bytes = aggregate_program_feature(
                kernels, "mram_read", tasklets, blocks, expression_environment,
                singleton_without_loop=True,
            )
            memory_write_bytes = aggregate_program_feature(
                kernels, "mram_write", tasklets, blocks, expression_environment,
                singleton_without_loop=True,
            )
            memory_read_tx = aggregate_program_feature(
                kernels, "mram_read_tx", tasklets, blocks, expression_environment,
                singleton_without_loop=True,
            )
            memory_write_tx = aggregate_program_feature(
                kernels, "mram_write_tx", tasklets, blocks, expression_environment,
                singleton_without_loop=True,
            )
        memory_source = (
            "static_analyzer_bounds"
            if benchmark in {"bs", "sel", "trns", "uni"}
            else "static_analyzer"
        )

        if benchmark not in {"bs", "sel", "trns", "uni"}:
            memory_write_bytes_lower = memory_write_bytes
        if benchmark not in {"bs", "trns"}:
            memory_read_bytes_lower = memory_read_bytes
            memory_read_tx_lower = memory_read_tx
            memory_write_tx_lower = memory_write_tx

        memory_bytes_lower = memory_read_bytes_lower + memory_write_bytes_lower
        memory_bytes_upper = memory_read_bytes + memory_write_bytes
        memory_transactions_lower = memory_read_tx_lower + memory_write_tx_lower
        memory_transactions_upper = memory_read_tx + memory_write_tx
        memory_cycles_lower = (
            memory_bytes_lower / args.memory_bandwidth
            + memory_read_tx_lower * args.mram_read_latency
            + memory_write_tx_lower * args.mram_write_latency
        )
        memory_cycles_upper = (
            memory_bytes_upper / args.memory_bandwidth
            + memory_read_tx * args.mram_read_latency
            + memory_write_tx * args.mram_write_latency
        )
        # Retain the simulator count only as a validation column. It must never
        # feed the compute-cost equations below.
        measured_instructions = optional_float(measured.get("instructions_mean"))
        instruction_bound = static_instruction_bound_for_setting(
            instruction_counts, measured
        )
        compute_instructions = float(instruction_bound["midpoint"])
        instruction_fields = {
            "compute_instruction_source": str(instruction_bound["source"]),
            "compute_instruction_scope": str(instruction_bound.get("scope", "")),
            "compute_instructions_per_dpu": compute_instructions,
            "static_instructions_lower_per_dpu": float(
                instruction_bound["lower"]
            ),
            "static_instructions_upper_per_dpu": float(
                instruction_bound["upper"]
            ),
            "static_instructions_midpoint_per_dpu": compute_instructions,
            "instruction_unexpanded_callees": str(
                instruction_bound["unexpanded_callees"]
            ),
            "static_vs_simulator_instruction_midpoint_error_pct": (
                100.0 * (compute_instructions - measured_instructions)
                / measured_instructions
                if isinstance(measured_instructions, float)
                and measured_instructions != 0
                else ""
            ),
            "simulator_instruction_mean_within_static_bounds": (
                float(instruction_bound["lower"])
                <= measured_instructions
                <= float(instruction_bound["upper"])
                if isinstance(measured_instructions, float)
                else ""
            ),
        }

        cycle_bounds = compose_cycle_bounds(
            instruction_lower=float(instruction_bound["lower"]),
            instruction_upper=float(instruction_bound["upper"]),
            memory_lower=memory_cycles_lower,
            memory_upper=memory_cycles_upper,
            tasklets=tasklets,
            stall_rate=args.compute_stall_rate,
        )
        composed_lower = float(cycle_bounds["composed_lower"])
        composed_upper = float(cycle_bounds["composed_upper"])
        actual_cycles = float(measured["cycles_max"])
        composed_interval_width = composed_upper - composed_lower
        if num_dpus <= 0:
            raise ValueError(f"invalid num_dpus: {num_dpus}")

        row: dict[str, Any] = {
            "experiment": measured["experiment"],
            "num_dpus": num_dpus,
            "num_tasklets": tasklets,
            "total_elements": total_elements,
            "logical_elements_per_dpu": logical_elements_per_dpu,
            "elements_per_dpu": elements_per_dpu,
            "element_size_bytes": element_size,
            "block_size_bytes": block_size,
            "blocks_per_dpu": blocks,
            "max_blocks_per_tasklet": max_blocks_per_tasklet,
            "memory_model_source": memory_source,
            "static_kernel_functions": ";".join(
                kernel["function"] for kernel in kernels
            ),
            "memory_read_bytes_lower_per_dpu": memory_read_bytes_lower,
            "memory_read_bytes_upper_per_dpu": memory_read_bytes,
            "memory_write_bytes_lower_per_dpu": memory_write_bytes_lower,
            "memory_write_bytes_upper_per_dpu": memory_write_bytes,
            "memory_read_transactions_lower_per_dpu": memory_read_tx_lower,
            "memory_read_transactions_upper_per_dpu": memory_read_tx,
            "memory_write_transactions_lower_per_dpu": memory_write_tx_lower,
            "memory_write_transactions_upper_per_dpu": memory_write_tx,
            "observed_row_reads_per_dpu": (
                float(measured["num_reads_sum"]) / num_dpus
            ),
            "observed_row_writes_per_dpu": (
                float(measured["num_writes_sum"]) / num_dpus
            ),
            "memory_transactions_lower_per_dpu": memory_transactions_lower,
            "memory_transactions_upper_per_dpu": memory_transactions_upper,
            **instruction_fields,
            "measured_instructions_per_dpu": measured_instructions,
            "actual_cycles": actual_cycles,
            "memory_model_lower_cycles": memory_cycles_lower,
            "memory_model_upper_cycles": memory_cycles_upper,
            "compute_issue_cycles_per_instruction": float(
                cycle_bounds["issue_factor"]
            ),
            "compute_cycles_lower": float(cycle_bounds["compute_lower"]),
            "compute_cycles_upper": float(cycle_bounds["compute_upper"]),
            "compute_cycles_conservative_upper": float(
                cycle_bounds["compute_conservative_upper"]
            ),
            "observed_compute_component_cycles": (
                float(measured["breakdown_run_sum"])
                + float(measured["breakdown_etc_sum"])
                + float(measured["backpressure_sum"])
            ) / num_dpus,
            "observed_dma_component_cycles": (
                float(measured["breakdown_dma_sum"]) / num_dpus
            ),
            "composed_cycles_lower": composed_lower,
            "composed_cycles_upper": composed_upper,
            "composed_lower_assumption": str(cycle_bounds["lower_assumption"]),
            "actual_within_composed_bounds": (
                composed_lower <= actual_cycles <= composed_upper
            ),
            "actual_composed_interval_position": (
                (actual_cycles - composed_lower) / composed_interval_width
                if composed_interval_width else ""
            ),
            "compute_stall_rate": args.compute_stall_rate,
        }
        estimates.append(row)

    estimates.sort(
        key=lambda row: (
            row["experiment"],
            row["num_dpus"],
            row["num_tasklets"],
            row["total_elements"],
        )
    )
    return estimates


def write_csv(path: Path, rows: list[dict[str, Any]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="", encoding="utf-8") as output_file:
        writer = csv.DictWriter(
            output_file, fieldnames=list(rows[0]), lineterminator="\n"
        )
        writer.writeheader()
        writer.writerows(rows)


def write_sensitivity_plot(
    path: Path,
    rows: list[dict[str, Any]],
    *,
    benchmark_label: str,
) -> None:
    import matplotlib

    matplotlib.use("Agg")
    import matplotlib.pyplot as plt

    plt.rcParams.update(
        {
            "font.family": "serif",
            "font.size": 9,
            "axes.titlesize": 10,
            "axes.labelsize": 9,
            "legend.fontsize": 8.5,
        }
    )
    figure, axes = plt.subplots(1, 2, figsize=(10, 3.15))
    panels = [
        ("tasklet_sweep", "num_tasklets", "Number of tasklets", "Tasklet sweep"),
        (
            "dpu_sweep",
            "num_dpus",
            "Number of DPUs",
            "DPU sweep (16 tasklets)",
        ),
    ]
    for axis, (experiment, x_field, x_label, title) in zip(axes, panels):
        selected = sorted(
            (row for row in rows if row["experiment"] == experiment),
            key=lambda row: int(row[x_field]),
        )
        x_values = [int(row[x_field]) for row in selected]
        lower = [float(row["composed_cycles_lower"]) for row in selected]
        upper = [float(row["composed_cycles_upper"]) for row in selected]
        measured = [float(row["actual_cycles"]) for row in selected]
        axis.fill_between(
            x_values,
            lower,
            upper,
            color="#9ecae1",
            alpha=0.28,
            linewidth=0,
            label="_nolegend_",
            zorder=1,
        )
        axis.plot(
            x_values,
            lower,
            label="PIMSA lower bound",
            color="#2563eb",
            marker="^",
            linestyle="--",
            linewidth=1.7,
            markersize=5.5,
            markeredgecolor="white",
            markeredgewidth=0.6,
            zorder=3,
        )
        axis.plot(
            x_values,
            upper,
            label="PIMSA upper bound",
            color="#ea580c",
            marker="v",
            linestyle="--",
            linewidth=1.7,
            markersize=5.5,
            markeredgecolor="white",
            markeredgewidth=0.6,
            zorder=3,
        )
        axis.plot(
            x_values,
            measured,
            label="uPIMulator",
            color="#111827",
            marker="o",
            linestyle="-",
            linewidth=2.0,
            markersize=5.5,
            markeredgecolor="white",
            markeredgewidth=0.6,
            zorder=4,
        )
        axis.set_xticks(x_values)
        axis.set_xlabel(x_label)
        axis.set_ylabel("Execution cycles")
        axis.ticklabel_format(axis="y", style="sci", scilimits=(0, 0))
        axis.set_title(title)
        axis.grid(axis="y", linestyle="--", alpha=0.25)

    handles, labels = axes[0].get_legend_handles_labels()
    figure.legend(
        handles,
        labels,
        loc="upper center",
        bbox_to_anchor=(0.5, 0.91),
        ncol=3,
        frameon=False,
    )
    figure.suptitle(
        f"{benchmark_label} composed-cycle interval",
        fontsize=12,
        fontweight="bold",
        y=0.99,
    )
    figure.subplots_adjust(
        left=0.075,
        right=0.995,
        bottom=0.19,
        top=0.73,
        wspace=0.14,
    )
    path.parent.mkdir(parents=True, exist_ok=True)
    figure.savefig(path, dpi=200, bbox_inches="tight")
    plt.close(figure)


def run_benchmark(args: argparse.Namespace, benchmark: str) -> None:
    """Generate the estimate CSV and linear sensitivity plot for one benchmark."""
    args = argparse.Namespace(**vars(args))
    args.benchmark = benchmark
    benchmark_lower = args.benchmark.lower()
    benchmark_upper = args.benchmark.upper()

    draw_figs_dir = Path(__file__).resolve().parent.parent

    args.static_summary = args.static_summary or (
        draw_figs_dir.parent / "static_analyzer" / "results" / f"{benchmark_upper}_summary.json"
    )
    args.simulator_summary = args.simulator_summary or (
        draw_figs_dir
        / "results"
        / benchmark_lower
        / "summary.csv"
    )
    if args.instruction_summary is None:
        instruction_root = draw_figs_dir.parent / "inst_count_analyzer" / "results"
        args.instruction_summary = instruction_root / benchmark_upper / "instruction_counts.csv"
    if not args.instruction_summary.is_file():
        raise ValueError(
            f"static instruction summary does not exist: {args.instruction_summary}; "
            "run inst_count_analyzer/run_benchmark_sweeps.py first"
        )
    args.output_dir = args.output_dir or (
        draw_figs_dir
        / "results"
        / benchmark_lower
    )
    rows = estimate_rows(args)
    if not rows:
        raise ValueError("simulator summary contains no rows")

    output_dir = args.output_dir
    prefix = benchmark_lower
    benchmark_label = benchmark_upper
    write_csv(output_dir / f"{prefix}_cost_estimates.csv", rows)
    write_sensitivity_plot(
        output_dir / f"{prefix}_component_sensitivity_linear.png",
        rows,
        benchmark_label=benchmark_label,
    )
    print(f"Wrote {len(rows)} {benchmark_label} estimates to {output_dir}")


def discover_benchmarks(aggregated_root: Path) -> list[str]:
    """Return benchmark directories that contain an aggregated summary."""
    if not aggregated_root.is_dir():
        raise ValueError(
            f"aggregated simulator result directory does not exist: {aggregated_root}"
        )
    benchmarks = sorted(
        path.parent.name
        for path in aggregated_root.glob("*/summary.csv")
        if path.is_file()
    )
    if not benchmarks:
        raise ValueError(f"no benchmark summary.csv files found in {aggregated_root}")
    return benchmarks


def main() -> int:
    args = parse_args()
    if args.benchmark:
        benchmarks = [args.benchmark]
    else:
        path_overrides = {
            "--static-summary": args.static_summary,
            "--simulator-summary": args.simulator_summary,
            "--instruction-summary": args.instruction_summary,
            "--output-dir": args.output_dir,
        }
        incompatible = [name for name, value in path_overrides.items() if value]
        if incompatible:
            print(
                "error: path overrides require an explicit benchmark: "
                + ", ".join(incompatible),
                file=sys.stderr,
            )
            return 2
        try:
            draw_figs_dir = Path(__file__).resolve().parent.parent
            benchmarks = discover_benchmarks(draw_figs_dir / "results")
        except ValueError as error:
            print(f"error: {error}", file=sys.stderr)
            return 2

    failures: list[tuple[str, Exception]] = []
    for benchmark in benchmarks:
        try:
            run_benchmark(args, benchmark)
        except (OSError, ValueError, json.JSONDecodeError) as error:
            failures.append((benchmark, error))
            print(f"FAILED: {benchmark}: {error}", file=sys.stderr)

    if failures:
        print(
            f"Generated {len(benchmarks) - len(failures)} of "
            f"{len(benchmarks)} benchmarks; failed: "
            + ", ".join(benchmark for benchmark, _ in failures),
            file=sys.stderr,
        )
        return 2
    if len(benchmarks) > 1:
        print(f"Generated cost models for all {len(benchmarks)} benchmarks.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
