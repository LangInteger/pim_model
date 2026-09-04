from __future__ import annotations

import json
import os
import tempfile
import unittest
from pathlib import Path


ANALYZER_ROOT = Path(__file__).resolve().parents[1]
REPOSITORY_ROOT = ANALYZER_ROOT.parent
BASELINE_PATH = ANALYZER_ROOT / "tests" / "data" / "VA_T16_pre_runtime.json"
SIMULATOR_INSTRUCTIONS = 3_727_420


class VaRuntimeExpansionTests(unittest.TestCase):
    def test_pre_runtime_baseline_is_preserved(self) -> None:
        baseline = json.loads(BASELINE_PATH.read_text())
        saved_result = json.loads(
            (ANALYZER_ROOT / "results" / "VA_T16" / "result.json").read_text()
        )
        self.assertEqual(baseline, saved_result)
        self.assertEqual(
            baseline["dynamic_instruction_bound"],
            {"lower": 3_719_617, "upper": 3_721_761, "exact": False},
        )

    @unittest.skipUnless(
        os.environ.get("UPMEM_ICOUNT_RUN_INTEGRATION") == "1",
        "set UPMEM_ICOUNT_RUN_INTEGRATION=1 on Linux to run the UPMEM toolchain",
    )
    def test_alloc_expansion_preserves_baseline_and_moves_toward_simulator(self) -> None:
        # Delay the numerical-analysis import so baseline-only tests remain
        # runnable without numpy/scipy or the Linux UPMEM SDK.
        import sys

        sys.path.insert(0, str(ANALYZER_ROOT))
        from count_instructions import collect_unexpanded_callees
        from upmem_icount.generic_count import generic_dynamic_instruction_count

        benchmark_dir = (
            REPOSITORY_ROOT
            / "uPIMulator"
            / "golang"
            / "uPIMulator"
            / "benchmark"
            / "VA"
        )
        sdk_root = (
            REPOSITORY_ROOT
            / "sdk"
            / "LoCaLUT"
            / "upmem-2023.2.0-Linux-x86_64"
        )
        params = {"size": 2097152, "transfer_size": 2097152, "kernel": 0}
        expected = json.loads(BASELINE_PATH.read_text())["dynamic_instruction_bound"]

        with tempfile.TemporaryDirectory() as temporary:
            work_root = Path(temporary)
            before = generic_dynamic_instruction_count(
                benchmark_dir,
                16,
                params,
                work_root / "before",
                str(sdk_root),
                runtime_functions=frozenset(),
            )
            after = generic_dynamic_instruction_count(
                benchmark_dir,
                16,
                params,
                work_root / "after",
                str(sdk_root),
            )

        self.assertEqual(before["dynamic_instruction_bound"]["lower"], expected["lower"])
        self.assertEqual(before["dynamic_instruction_bound"]["upper"], expected["upper"])

        after_bound = after["dynamic_instruction_bound"]
        self.assertGreater(after_bound["lower"], expected["lower"])
        self.assertGreater(after_bound["upper"], expected["upper"])
        old_midpoint = (expected["lower"] + expected["upper"]) / 2
        new_midpoint = (after_bound["lower"] + after_bound["upper"]) / 2
        self.assertLess(
            abs(SIMULATOR_INSTRUCTIONS - new_midpoint),
            abs(SIMULATOR_INSTRUCTIONS - old_midpoint),
        )
        self.assertEqual(collect_unexpanded_callees(after), ["barrier_wait"])


if __name__ == "__main__":
    unittest.main()
