from __future__ import annotations

import sys
import unittest
from pathlib import Path


ANALYZER_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ANALYZER_ROOT))

from upmem_icount.generic_cfg import (  # noqa: E402
    Bound,
    LoopInfo,
    MachineBlock,
    solve_machine_total,
)
from upmem_icount.source_loop_semantics import source_loop_backedge_bounds  # noqa: E402


class MachineIrAnchoringTests(unittest.TestCase):
    def test_one_ir_block_split_across_alternative_machine_paths(self) -> None:
        blocks = [
            MachineBlock("f", "bb.0.a", 0, "bb.0.a", "a", [1, 2], 1, []),
            MachineBlock("f", "bb.1.b", 1, "bb.1.b", "b", [3], 2, []),
            MachineBlock("f", "bb.2.b", 2, "bb.2.b", "b", [3], 4, []),
            MachineBlock("f", "bb.3.b", 3, "bb.3.b", "b", [], 3, []),
        ]
        total, block_bounds, metadata = solve_machine_total(
            blocks,
            {"a": Bound(1, 1), "b": Bound(1, 1)},
        )

        self.assertEqual(total.lower, 6)
        self.assertEqual(total.upper, 8)
        self.assertEqual(block_bounds["bb.3.b"].lower, 1)
        b_anchor = next(a for a in metadata["anchors"] if a["ir_block"] == "b")
        self.assertEqual(
            b_anchor["machine_blocks"], ["bb.1.b", "bb.2.b", "bb.3.b"]
        )
        self.assertEqual(b_anchor["representative_machine_block"], "bb.3.b")

    def test_self_loop_uses_ir_execution_count_not_external_entry_count(self) -> None:
        blocks = [
            MachineBlock("f", "bb.0.a", 0, "bb.0.a", "a", [1], 1, []),
            MachineBlock("f", "bb.1.loop", 1, "bb.1.loop", "loop", [1, 2], 2, []),
            MachineBlock("f", "bb.2.exit", 2, "bb.2.exit", "exit", [], 1, []),
        ]
        total, block_bounds, _ = solve_machine_total(
            blocks,
            {"a": Bound(1, 1), "loop": Bound(5, 5), "exit": Bound(1, 1)},
        )

        self.assertEqual(block_bounds["bb.1.loop"].lower, 5)
        self.assertEqual(block_bounds["bb.1.loop"].upper, 5)
        self.assertEqual(total.lower, 12)
        self.assertEqual(total.upper, 12)


class GemvLoopSemanticsTests(unittest.TestCase):
    def test_gemv_64_element_remainder_and_pos_loop(self) -> None:
        loops = [
            LoopInfo("main", "outer", 1, ["outer"], ["outer"], ["outer"], 127),
            LoopInfo("main", "pos", 2, [f"p{i}" for i in range(20)], [], []),
            LoopInfo("main", "remainder", 3, ["r0", "r1"], [], []),
        ]
        bounds = source_loop_backedge_bounds(
            "GEMV", "main", loops, {"n_size": 64}
        )
        self.assertEqual(bounds["pos"], Bound(1, 1))
        self.assertEqual(bounds["remainder"], Bound(63, 63))

    def test_mlp_full_chunks_and_256_element_remainder(self) -> None:
        loops = [
            LoopInfo("main", "chunks", 3, [f"c{i}" for i in range(6)], [], []),
            LoopInfo("main", "remainder", 3, ["r0", "r1"], [], []),
        ]
        bounds = source_loop_backedge_bounds(
            "MLP", "main", loops, {"n_size": 1024}
        )
        self.assertEqual(bounds["chunks"], Bound(2, 2))
        self.assertEqual(bounds["remainder"], Bound(255, 255))


if __name__ == "__main__":
    unittest.main()
