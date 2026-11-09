# PIMSA-IR: one program representation for UPMEM and HBM-PIM

Static analysis runs on a single IR, the paper's programming model (Sec. 3.2). Target differences are parameters of the architecture instance 𝒜, the arrow from "Architecture model" in Figure 2.

| file | role |
| --- | --- |
| `ir.py` | IR nodes: `Kernel`, `For`, `ParFor` (`for parallel`), `Assign` of slices between H/M/B/R arrays, `Barrier` |
| `kernels.py` | HBM-PIM programs: ADD, MUL, RELU, GEMV (from PIMSimulator `PIMKernel.cpp`) |
| `prim/` | UPMEM programs: the 13 PrIM benchmarks, one module each (`prim/__init__.py` lists them) |
| `prim_check.py` | per-setting check of a PrIM module against uPIMulator counters, the toolchain's stored bound and the paper's intervals |
| `metrics.py` | metric extraction, shared by both targets: bytes, transfers and transactions per boundary, primitive operations |
| `lower_cmd.py` | lowering to DRAM column commands for command-triggered, lockstep targets (HBM-PIM) |
| `analyze.py` | HBM-PIM analysis on PIMSA-IR alone: metrics, constraint-evaluation cycles, closed form |
| `upmem_cost.py` | UPMEM instruction and cycle bounds: IR trip counts and MRAM traffic, with per-body costs from the toolchain's stored machine code |
| `arch/upmem.json` | UPMEM instance; the HBM-PIM instance is `../hbmpim_static/arch/hbm2_pim.json` (`exec` section) |

## SIMD in one form

A vector operation is a slice assignment. Its width is not in the program: a slice of n elements is ⌈n/W⌉ target primitives, with W from 𝒜.

```
# HBM-PIM ADD, per PU
for parallel blk < P:
  for i < n_t:
    for b < NB:
      R[grf]{file=b}[0:G·W]  ← M[A]{bank=b}[i·G·W : +G·W]
      R[grf]{file=b}[0:G·W]  ← add(R[grf]{file=b}, M[B]{bank=b}[...])
      M[C]{bank=b}[...]      ← R[grf]{file=b}

# UPMEM VA, per DPU
for parallel t < NT:
  barrier
  for idx = t·BS; idx < SIZE; idx += BS·NT:      # n = min(BS, SIZE - idx) / E
    B[cache_A][0:n] ← M[A][idx/E : +n]
    B[cache_B][0:n] ← M[B][idx/E : +n]
    B[cache_B][0:n] ← add(B[cache_B][0:n], B[cache_A][0:n])
    M[B][idx/E : +n] ← B[cache_B][0:n]
```

What 𝒜 decides (`exec` in the arch JSON):

| | UPMEM | HBM-PIM |
| --- | --- | --- |
| W | 1 | 16 × fp16 |
| memory operands in computation | no (DMA into WRAM first) | yes (RD feeds the PIM unit) |
| `for parallel` | threads (tasklets) | lockstep (PIM blocks, one broadcast command stream) |
| trigger | self (instruction fetch) | command (each column command advances the CRF) |
| transaction | 8 B DMA unit | 32 B column command |
| launch | — | park, mode switches, CRF program (`exec.protocol`) |
| per-loop-body cost | toolchain: dpu-clang instruction counts E_b, looked up by the loops' `src` anchors | controller rules: critical cycle of one period |

In both cases cost = Σ (per-loop-body cost from 𝒜) × (trip count from the IR).

## Validation (`test_unified_ir.py`)

- HBM-PIM: the command stream lowered from each PIMSA-IR program equals the one derived from the vendor generator, command for command (direction, bank, row, column, barrier), on all 42 sweep configurations.
- HBM-PIM: the symbolic metrics from PIMSA-IR equal those from the vendor IR (rd, wr, bar and the boundary classes).
- HBM-PIM: from PIMSA-IR alone, constraint-evaluation cycles equal the simulator on 42/42 configurations, and the closed form reproduces the recorded estimates (max error 0.42 %).
- UPMEM, all 13 PrIM benchmarks, 116 settings (`prim_check.py`, summary below).

### PrIM results

| | settings |
| --- | --- |
| MRAM traffic equal to uPIMulator's counters | 81 exact; 35 inside the IR interval (data-dependent: SEL, UNI, BS; TRNS's run-time tile distribution) |
| instruction bound equal to the toolchain's stored bound | 102 |
| instruction bound strictly inside the stored bound and containing the measured count | 14 (MLP dpu sweep, BS, TS ×2) |
| measured cycles inside the interval | 102 of 116 (87.9 %), the same settings as the paper's |
| cycle interval narrower than the paper's / wider | 26 / 9 |

Where the IR is tighter, it knows a count the toolchain or the paper's memory adapter could only bound: GEMV/MLP rows are 8 B aligned, so the shift-and-aux-read branch never runs (the paper's adapter charged an extra read per row); MLP's tail loop runs exactly n_size − n_end times; BS's search loop runs at most log2(8·n/BS) times, derived from the interval-halving updates (the toolchain capped it 3 higher); TS's clamped loop has an exact trip count of 1 in some tasklets.

Where the IR is wider: TRNS's kernel 2 distributes tiles at run time; the IR uses the toolchain's amortized per-tasklet rule (0 to ceil(D/NT)+1 tiles per tasklet), which reproduces the stored instruction bound but lets the traffic lower bound go to 0.

The 14 uncovered settings are all 16-tasklet runs of HST-L, SCAN-SSA and SCAN-RSS, where the measured time includes mutex spinning (HST-L) or serialized handshake chains (SCAN) that the cycle composition (`estimate_cost.compose_cycle_bounds`) does not model. Instruction and traffic counts are exact there; the gap is in the composition, and the paper's intervals miss the same settings.

### UPMEM per-body costs

`upmem_cost.py` reads, for a setting the toolchain analyzed, its machine blocks (final assembly, instruction counts, edge costs), the per-call bounds of expanded callees and the barrier contribution from `inst_count_analyzer/results/<BENCH>/<setting>/phases/*/debug.json`. It pins each machine loop to the IR trip count (IR loops matched in source order), solves the machine-CFG flow with the analyzer's own `solve_machine_total`, adds callees by their IR call counts, and composes cycles with `estimate_cost.compose_cycle_bounds` and its memory model, fed with the IR's MRAM bytes and DMA calls.

One build is needed per build configuration (BL, TYPE, NR_TASKLETS are compile-time macros), not per input size.

```bash
PIMSA_HBM_IR=../hbmpim_static/build/ir.json ../.venv/bin/python -m unittest -v test_unified_ir
../.venv/bin/python analyze.py ADD L=1048576 B=1 C=64
```

## Not done yet

- The programs are written by hand from the vendor source. The stream comparison checks them mechanically, but the frontend does not yet lift `PIMKernel.cpp` (or PrIM C) to PIMSA-IR automatically.
- PIMSA-IR has no lock or handshake construct, so contention (HST-L) and handshake serialization (SCAN) are not bounded.
- Per-tasklet shares of a run-time-distributed domain (TRNS) cannot be constrained to sum to the domain; `prim/trns.py` has a prototype (`main_kernel2_domain`) that makes the traffic exact but no longer reproduces the stored instruction bound.
- 8 B unit counts ignore DMA splits at 1 KiB wordline boundaries; this only shows for TRNS's unaligned 8 B accesses (the IR has no MRAM heap base address).
- A new build configuration (BL, TYPE or tasklet count not analyzed before) needs one toolchain run, which needs the UPMEM SDK.
- Callee costs are the toolchain's per-call bounds for the analyzed call arguments (full BS blocks in every PrIM setting); a callee whose cost depends on a runtime argument would need its bound as a function of that argument.
- In VA and similar loops, the bound-check branch keeps a one-instruction-per-iteration gap between the bounds. The IR knows which side of `Min(BS, SIZE - idx)` each iteration takes; mapping that to the machine branch would close the gap.
