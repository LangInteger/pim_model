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
    compare_machine_cfgs,
    merge_machine_cfgs,
    parse_annotated_assembly,
    parse_lowered_callsites,
    solve_machine_total,
)
from upmem_icount.runtime_semantics import (  # noqa: E402
    _inline_asm_path_bound,
    runtime_function_instruction_bound,
)
from upmem_icount.generic_count import _descendant_unexpanded_calls  # noqa: E402
from upmem_icount.source_loop_semantics import (  # noqa: E402
    source_loop_backedge_bounds,
    source_loop_total_backedge_bounds,
)


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
        self.assertEqual(b_anchor["anchor_kind"], "machine_flow_only")
        self.assertIsNone(b_anchor["representative_machine_block"])


class MachineCfgValidationTests(unittest.TestCase):
    def test_records_block_mapping_and_matching_successors(self) -> None:
        mir = {
            "f": [
                MachineBlock("f", "bb.0.a", 0, "bb.0.a", "a", [1], 2, []),
                MachineBlock("f", "bb.1.b", 1, "bb.1.b", "b", [], 1, []),
            ]
        }
        assembly = {
            "f": [
                MachineBlock("f", "bb.0.a", 0, "bb.0.a", "a", [1], 3, []),
                MachineBlock("f", "bb.1.b", 1, "bb.1.b", "b", [], 2, []),
            ]
        }

        report = compare_machine_cfgs(mir, assembly)

        self.assertEqual(report["status"], "match")
        block = report["functions"][0]["blocks"][0]
        self.assertEqual(block["mapping_status"], "mapped")
        self.assertEqual(block["mir"]["successors"], [1])
        self.assertEqual(block["annotated_assembly"]["emitted_mcinst_count"], 3)

    def test_reports_missing_blocks_and_successor_mismatches(self) -> None:
        mir = {
            "f": [
                MachineBlock("f", "bb.0.a", 0, "bb.0.a", "a", [1], 2, []),
                MachineBlock("f", "bb.1.b", 1, "bb.1.b", "b", [], 1, []),
            ]
        }
        assembly = {
            "f": [
                MachineBlock("f", "bb.0.a", 0, "bb.0.a", "a", [], 3, []),
                MachineBlock("f", "bb.2", 2, "bb.2", None, [], 4, []),
            ]
        }

        report = compare_machine_cfgs(mir, assembly)

        self.assertEqual(report["status"], "error")
        codes = {
            issue["code"]
            for block in report["functions"][0]["blocks"]
            for issue in block["errors"]
        }
        self.assertEqual(
            codes,
            {
                "successors_mismatch",
                "block_missing_in_assembly",
                "block_missing_in_mir",
            },
        )

    def test_merge_uses_mir_edges_and_assembly_instruction_counts(self) -> None:
        mir = {
            "f": [
                MachineBlock("f", "bb.0.a", 0, "bb.0.a", "a", [1], 2, []),
                MachineBlock("f", "bb.1.b", 1, "bb.1.b", "b", [], 1, []),
            ]
        }
        assembly = {
            "f": [
                MachineBlock("f", "bb.0", 0, "bb.0", None, [1], 4, ["g"]),
                MachineBlock("f", "bb.1.b", 1, "bb.1.b", "b", [], 3, []),
            ]
        }
        validation = compare_machine_cfgs(mir, assembly)

        merged = merge_machine_cfgs(mir, assembly, validation)

        self.assertEqual(merged["f"][0].successors, [1])
        self.assertEqual(merged["f"][0].instructions, 4)
        self.assertEqual(merged["f"][0].ir_block, "a")
        self.assertEqual(merged["f"][0].calls, ["g"])

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

    def test_cost_stops_at_the_taken_machine_branch(self) -> None:
        blocks = [
            MachineBlock(
                "f", "bb.0.a", 0, "bb.0.a", "a", [1, 2], 2, [], {1: 1, 2: 2}
            ),
            MachineBlock("f", "bb.1.left", 1, "bb.1.left", None, [], 1, []),
            MachineBlock("f", "bb.2.right", 2, "bb.2.right", None, [], 1, []),
        ]
        total, _, _ = solve_machine_total(blocks, {"a": Bound(1, 1)})

        self.assertEqual(total.lower, 2)
        self.assertEqual(total.upper, 3)

    def test_single_exact_ir_anchor_does_not_disable_merged_taken_path(self) -> None:
        # MBB 1 is labelled as the optional predecessor but also contains the
        # following IR block after tail duplication.  Requiring the separately
        # labelled MBB 2 to execute exactly once would incorrectly force MBB 1
        # to zero executions.
        blocks = [
            MachineBlock("f", "bb.0.entry", 0, "bb.0.entry", "entry", [1, 2], 1, []),
            MachineBlock("f", "bb.1.taken", 1, "bb.1.taken", "taken", [3], 5, []),
            MachineBlock("f", "bb.2.cont", 2, "bb.2.cont", "cont", [3], 2, []),
            MachineBlock("f", "bb.3.exit", 3, "bb.3.exit", "exit", [], 1, []),
        ]
        total, block_bounds, metadata = solve_machine_total(
            blocks,
            {
                "entry": Bound(1, 1),
                "taken": Bound(0, 1),
                "cont": Bound(1, 1),
                "exit": Bound(1, 1),
            },
        )

        self.assertEqual(total, Bound(4, 7))
        self.assertEqual(block_bounds["bb.1.taken"], Bound(0, 1))
        cont = next(a for a in metadata["anchors"] if a["ir_block"] == "cont")
        self.assertEqual(cont["anchor_kind"], "machine_flow_only")


class FinalAssemblyParsingTests(unittest.TestCase):
    def test_counts_expanded_mcinsts_and_machine_edges(self) -> None:
        assembly = r"""
        .type f,@function
f:                                      // @f
// %bb.0: // %entry
        add r0, r0, r1 // <MCInst #1 ADDrrr>
        addc r2, r2, r3 // <MCInst #2 ADDCrrr>
        jeq r0, 0, .LBB0_2 // <MCInst #3 JEQrii>
.LBB0_1: // %left
        add r4, r4, 1 // <MCInst #4 ADDrri>
        jump .LBB0_3 // <MCInst #5 JUMPi>
.LBB0_2: // %right
        sub r4, r4, 1 // <MCInst #6 SUBrri>
.LBB0_3: // %exit
        jump r23 // <MCInst #7 JUMPr>
        .size f, .-f
"""
        blocks = parse_annotated_assembly(
            assembly,
            {"f": {"entry", "left", "right", "exit"}},
        )["f"]

        self.assertEqual([block.instructions for block in blocks], [3, 2, 1, 1])
        self.assertEqual(blocks[0].successors, [2, 1])
        self.assertEqual(blocks[0].edge_instruction_costs, {2: 3})
        self.assertEqual(blocks[1].successors, [3])
        total, _, _ = solve_machine_total(
            blocks,
            {
                "entry": Bound(1, 1),
                "left": Bound(0, 1),
                "right": Bound(0, 1),
                "exit": Bound(1, 1),
            },
        )
        self.assertEqual(total, Bound(5, 6))
        fast_total, fast_block_bounds, metadata = solve_machine_total(
            blocks,
            {
                "entry": Bound(1, 1),
                "left": Bound(0, 1),
                "right": Bound(0, 1),
                "exit": Bound(1, 1),
            },
            bound_block_numbers=set(),
        )
        self.assertEqual(fast_total, total)
        self.assertEqual(fast_block_bounds, {})
        self.assertTrue(
            all(block["execution_bound"] is None for block in metadata["machine_blocks"])
        )

    def test_exposes_atomic_acquire_retry_as_collective_cost(self) -> None:
        assembly = r"""
        .type lock,@function
lock:                                   // @lock
// %bb.0: // %entry
.Ltmp1:
        acquire zero, lock_bit, nz, .Ltmp1 // <MCInst #1 ACQUIRErici>
        jump r23 // <MCInst #2 JUMPr>
        .size lock, .-lock
"""
        block = parse_annotated_assembly(assembly, {"lock": {"entry"}})["lock"][0]
        self.assertEqual(block.instructions, 2)
        self.assertIn("__atomic_acquire_retry", block.calls)


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


class TrnsLoopSemanticsTests(unittest.TestCase):
    def test_shared_tile_domain_is_amortized_across_tasklets(self) -> None:
        loops = [
            LoopInfo("main_kernel2", "outer", 1, ["outer"], [], []),
            LoopInfo("main_kernel2", "inner", 2, ["inner"], [], []),
        ]
        bounds = source_loop_total_backedge_bounds(
            "TRNS",
            "main_kernel2",
            loops,
            {"M_": 1024, "n": 4},
            16,
        )
        self.assertEqual(bounds, {"outer": Bound(0, 256), "inner": Bound(0, 256)})


class TargetLoweringTests(unittest.TestCase):
    def test_i32_multiply_is_recorded_as_mulsi3_call(self) -> None:
        ir = """define i32 @f(i32 %a, i32 %b) {
bb:
  %x = mul nsw i32 %a, %b
  ret i32 %x
}
"""
        calls = parse_lowered_callsites(ir)["f"]
        self.assertEqual([(x.block, x.callee) for x in calls], [("bb", "__mulsi3")])

    def test_mul32_inline_asm_path_bound(self) -> None:
        source = (
            ANALYZER_ROOT.parent
            / "sdk/LoCaLUT/upmem-2023.2.0-Linux-x86_64/src/dpu-rt/src/syslib/mul32.c"
        )
        bound = _inline_asm_path_bound(source, "__mulsi3")
        self.assertEqual(bound, Bound(6, 37))
        adjusted, provenance = runtime_function_instruction_bound(
            "__mulsi3", source, Bound(2, 2)
        )
        self.assertEqual(adjusted, Bound(7, 38))
        self.assertEqual(provenance["kind"], "inline_asm_path_expansion")

    def test_nested_unresolved_runtime_costs_are_propagated(self) -> None:
        retry = {"callee": "__atomic_acquire_retry", "reason": "contention"}
        summary = {
            "unexpanded_calls": [],
            "expanded_calls": [
                {"callee_unexpanded_calls": [retry]},
                {"callee_unexpanded_calls": [retry]},
            ],
        }
        self.assertEqual(_descendant_unexpanded_calls(summary), [retry])


if __name__ == "__main__":
    unittest.main()
