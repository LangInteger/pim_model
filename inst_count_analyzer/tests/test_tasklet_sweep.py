from __future__ import annotations

import csv
import json
import sys
import tempfile
import unittest
from pathlib import Path


ANALYZER_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ANALYZER_ROOT))

import run_tasklet_sweep


class TaskletSweepTests(unittest.TestCase):
    def test_default_tasklet_set_matches_simulator_sweep(self) -> None:
        self.assertEqual(run_tasklet_sweep.DEFAULT_TASKLETS, (1, 2, 4, 8, 11, 16))

    def test_summary_contains_one_row_per_available_result(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            sweep_dir = Path(temporary)
            for tasklets, lower, upper in ((1, 100, 110), (4, 40, 44)):
                result_dir = sweep_dir / f"T{tasklets}"
                result_dir.mkdir()
                result = {
                    "benchmark": "VA",
                    "tasklets": tasklets,
                    "params": {"size": 2097152},
                    "dynamic_instruction_bound": {
                        "lower": lower,
                        "upper": upper,
                        "exact": lower == upper,
                    },
                    "unexpanded_callees": ["barrier_wait"],
                }
                (result_dir / "result.json").write_text(json.dumps(result))

            summary_path = run_tasklet_sweep.write_summary(sweep_dir, [1, 2, 4])
            with summary_path.open(newline="") as summary:
                rows = list(csv.DictReader(summary))

            self.assertEqual([row["tasklets"] for row in rows], ["1", "4"])
            self.assertEqual(rows[0]["instructions_midpoint"], "105.0")
            self.assertEqual(rows[0]["unexpanded_callees"], "barrier_wait")


if __name__ == "__main__":
    unittest.main()
