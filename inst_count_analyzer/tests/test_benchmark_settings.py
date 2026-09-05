from __future__ import annotations

import csv
import importlib.util
import sys
import tempfile
import unittest
from pathlib import Path
from types import SimpleNamespace


ANALYZER_ROOT = Path(__file__).resolve().parents[1]
REPO_ROOT = ANALYZER_ROOT.parent
sys.path.insert(0, str(ANALYZER_ROOT))

from upmem_icount.benchmark_settings import (  # noqa: E402
    decode_arguments,
    load_setting_phases,
    loop_backedge_uppers,
    setting_id,
)


def load_estimate_cost_module():
    path = REPO_ROOT / "draw_figs" / "scripts" / "estimate_cost.py"
    spec = importlib.util.spec_from_file_location("estimate_cost", path)
    assert spec is not None and spec.loader is not None
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


class BenchmarkSettingTests(unittest.TestCase):
    def test_decode_all_argument_schemas(self):
        fixtures = {
            "BS": (32768).to_bytes(8, "little") + (4096).to_bytes(8, "little") + bytes(4),
            "VA": (2097152).to_bytes(4, "little") * 2 + bytes(4),
            "RED": (4194304).to_bytes(4, "little") + bytes(8),
            "HST-L": (524288).to_bytes(4, "little") * 2 + (256).to_bytes(4, "little") + bytes(4),
            "HST-S": (524288).to_bytes(4, "little") * 2 + (256).to_bytes(4, "little") + bytes(4),
            "GEMV": b"".join(value.to_bytes(4, "little") for value in (64, 64, 2048, 2048)),
            "MLP": b"".join(value.to_bytes(4, "little") for value in (256, 256, 256, 256)),
            "SEL": (4194304).to_bytes(4, "little") + bytes(4),
            "UNI": (4201472).to_bytes(4, "little") + bytes(4),
            "TRNS": b"".join(value.to_bytes(4, "little") for value in (16, 4, 1024, 1)),
            "TS": b"".join(value.to_bytes(4, "little", signed=True) for value in (2048, 64, 31, 18, 2048, 0, 0)),
            "SCAN-RSS": (2097152).to_bytes(4, "little") + bytes(12),
            "SCAN-SSA": (2097152).to_bytes(4, "little") + bytes(12),
        }
        for benchmark, data in fixtures.items():
            with self.subTest(benchmark=benchmark):
                self.assertTrue(decode_arguments(benchmark, data))

    def test_loads_sequential_kernel_phases(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            first = b"".join(value.to_bytes(4, "little") for value in (16, 4, 1024, 0))
            second = b"".join(value.to_bytes(4, "little") for value in (16, 4, 1024, 1))
            (root / "input_DPU_INPUT_ARGUMENTS_0_0.bin").write_text("\n".join(map(str, first)))
            (root / "input_DPU_INPUT_ARGUMENTS_1_0.bin").write_text("\n".join(map(str, second)))
            phases = load_setting_phases(root, "trns")
            self.assertEqual([phase.function for phase in phases], ["main_kernel1", "main_kernel2"])

    def test_setting_id_is_complete(self):
        self.assertEqual(
            setting_id("dpu_sweep", "va", 4, 16, 2097152),
            "dpu_sweep_VA_dpu4_tasklets16_size2097152",
        )

    def test_source_loop_caps_cover_data_dependent_loops(self):
        self.assertEqual(
            loop_backedge_uppers("BS", {"input_size": 32768}),
            {"search": 32, "main_kernel1": 12},
        )
        self.assertEqual(
            loop_backedge_uppers(
                "TRNS", {"kernel": 1, "M_": 128, "n": 8}
            )["main_kernel2"],
            1023,
        )


class EstimateInstructionLoaderTests(unittest.TestCase):
    def test_exact_setting_lookup(self):
        estimate_cost = load_estimate_cost_module()
        with tempfile.TemporaryDirectory() as temporary:
            summary = Path(temporary) / "instruction_counts.csv"
            fields = [
                "benchmark", "experiment", "num_dpus_configured", "num_tasklets",
                "data_prep_params", "instructions_lower", "instructions_upper",
                "instructions_midpoint", "instruction_scope", "unexpanded_callees",
            ]
            with summary.open("w", newline="") as output:
                writer = csv.DictWriter(output, fieldnames=fields)
                writer.writeheader()
                writer.writerow(
                    {
                        "benchmark": "RED", "experiment": "dpu_sweep",
                        "num_dpus_configured": 4, "num_tasklets": 16,
                        "data_prep_params": 2097152, "instructions_lower": 100,
                        "instructions_upper": 120, "instructions_midpoint": 110,
                        "instruction_scope": "maximum_per_dpu_sum_of_sequential_executions",
                        "unexpanded_callees": "barrier_wait",
                    }
                )
            index = estimate_cost.load_static_instruction_counts(summary, "red")
            measured = {
                "experiment": "dpu_sweep", "num_dpus_configured": "4",
                "num_tasklets": "16", "data_prep_params": "2097152",
            }
            bound = estimate_cost.static_instruction_bound_for_setting(
                index, measured, 1, 1024
            )
            self.assertEqual(bound["midpoint"], 110)
            self.assertEqual(bound["source"], "static_analyzer_exact_setting_midpoint")

    def test_cost_estimate_does_not_require_simulator_instruction_count(self):
        estimate_cost = load_estimate_cost_module()
        source_summary = REPO_ROOT / "draw_figs" / "results" / "red" / "summary.csv"
        with source_summary.open(newline="") as input_file:
            simulator_row = next(csv.DictReader(input_file))
        simulator_row["instructions_mean"] = "not-used"

        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            simulator_summary = root / "simulator.csv"
            with simulator_summary.open("w", newline="") as output:
                writer = csv.DictWriter(output, fieldnames=list(simulator_row))
                writer.writeheader()
                writer.writerow(simulator_row)

            instruction_summary = root / "instructions.csv"
            instruction_row = {
                "benchmark": "RED",
                "experiment": simulator_row["experiment"],
                "num_dpus_configured": simulator_row["num_dpus_configured"],
                "num_tasklets": simulator_row["num_tasklets"],
                "data_prep_params": simulator_row["data_prep_params"],
                "instructions_lower": 90,
                "instructions_upper": 110,
                "instructions_midpoint": 100,
                "instruction_scope": "test",
                "unexpanded_callees": "",
            }
            with instruction_summary.open("w", newline="") as output:
                writer = csv.DictWriter(output, fieldnames=list(instruction_row))
                writer.writeheader()
                writer.writerow(instruction_row)

            args = SimpleNamespace(
                benchmark="red",
                compute_stall_rate=0.10,
                static_summary=REPO_ROOT / "static_analyzer" / "results" / "RED_summary.json",
                instruction_summary=instruction_summary,
                simulator_summary=simulator_summary,
                memory_bandwidth=2.0,
                mram_read_latency=77.0,
                mram_write_latency=61.0,
            )
            row = estimate_cost.estimate_rows(args)[0]

        self.assertEqual(row["compute_instructions_per_dpu"], 100)
        self.assertEqual(row["measured_instructions_per_dpu"], "")


if __name__ == "__main__":
    unittest.main()
