# PIMSA static analysis for HBM-PIM (plan A)

Overview, with a worked GEMV example: dissertation repo,
`manuscripts/pimsa/case_studies/hbmpim/OVERVIEW_2026-11-06.md` (Chinese:
`OVERVIEW_2026-11-06.zh.md`).

Applies the PIMSA method (manuscripts/pimsa: architecture model, metric
extraction, cost model, automatic factor estimation) to Samsung HBM-PIM, with
the same structure as the UPMEM case study:

| UPMEM case study | HBM-PIM case study |
| --- | --- |
| DPU/host C source of PrIM | `PIMKernel::executeGemv` / `executeEltwise` in Samsung PIMSimulator (host-side command generator, C++) |
| Clang analyzer + `mram_read`/`mram_write` matchers | Clang frontend `--target=hbmpim`, primitives `MultiChannelMemorySystem::addTransaction` / `addBarrier` |
| uPIMulator cycles | PIMSimulator cycles (cycle-accurate, DRAMSim2-based) |

## Pipeline

1. **Frontend** (`static_analyzer/lib/HBMPIMFrontend.cpp`): lowers the entry
   functions to PIMSA-IR (let/assign/for/for-range/if/call/event JSON with
   structured expressions; callees with visible bodies are inlined with their
   parameter bindings). `run_frontend.sh build/ir.json`.
2. **Metric extraction** (`pimsa_hbm.py`, symbolic): per-PU (= per
   pseudo-channel) column reads, column writes and barriers, as closed forms in
   M, N, L, batch B and channel count C. The loop over `pim_chans_` is the PIMSA
   parallel region over PUs, so per-PU metrics are not scaled by it.
3. **Command-stream timing** (`controller.py`, concrete): abstract execution
   of one PU's column-command stream (direction, bank, row via `addrGenSafe`,
   column, BAR), then its issue time under the PIMSimulator controller's
   constraint table and issue rules (BAR fence, eager precharge, refresh
   stagger, all-bank-mode ACT restriction). Every delay is an ini timing
   parameter or a Configuration.h derived delay; every rule cites the source
   line enforcing it. Output: total cycles plus cycles per constraint. No data,
   PIM instruction semantics or simulator involved. Derivation:
   `manuscripts/pimsa/case_studies/hbmpim/COST_DERIVATION_FROM_CONTROLLER_2026-11-05.md`.

Per-channel closed forms (n_in = ⌈N/128⌉, n_out = ⌈M/(64C)⌉,
n_t = ⌊B⌈L/16⌉/(128C)⌋), checked on a grid by `test_pimsa_hbm.py`:

| kernel | reads | writes | barriers |
| --- | --- | --- | --- |
| GEMV | 64·B·n_in·n_out + 32 | B·n_out·(8·n_in + 10) + 7 | B·n_out·(9·n_in + 3) + 6 |
| ADD, MUL | 32·n_t + 32 | 16·n_t + 9 | 6·n_t + 8 |
| RELU | 16·n_t + 32 | 16·n_t + 9 | 4·n_t + 8 |

The same commands are also counted, as closed forms, by the boundary their data crosses. This is decided from the row address (`classify()`):
- `bank2pu` / `pu2bank`: data rows, P·32 B inside the die per command;
- `host2pu` / `pu2host`: the PIM register row 0x3fff, 32 B over the bus;
- `mode_rd` / `mode_wr`: parking and ABMR/SBMR, no payload.

`analyze()` returns these as the paper's per-PU `metric_vector`:
- N_host, V_host;
- N_mem, V_mem = P·32 B·N_mem;
- C_step = N_mem;
- N_mode, N_bar, N_act, ρ_row.

It also returns the cycles grouped into the paper's cost terms (`estimate.by_term`):
- `column` = tCCD (the V/BW term);
- `row` = tRCD/tRP/tRAS/tRC/tRTP/tWR/tRRD (the ρ_row term);
- `refresh`, `turnaround`, `issue` and `drain`.

The terms partition the total.

## Validation (results/sweep.json, 42 configurations)

- RD/WR counts equal the simulator's channel-0 counts: **42/42**.
- Cycle count equals the simulator's: **42/42**; ACT counts 42/42.
- Cost terms vs the simulator's attribution grouped the same way: within 19 cycles (column, refresh and turnaround exact).
- Per-constraint breakdown vs the simulator's stall attribution
  (`../hbmpim_sim/instrument.py`): within 19 cycles everywhere (trailing PREs
  and one REF issued during the read drain, after the last transaction).
- `worst_case_additive` (every column command a full row cycle + turnaround):
  10.9–15.4× the simulated cycles; its soundness is not yet argued.

## Reproduce

```bash
brew install llvm cmake scons googletest
cmake -S ../static_analyzer -B ../static_analyzer/build && cmake --build ../static_analyzer/build -j
../hbmpim_sim/build.sh                       # simulator + PIMSA sweep driver, out of tree
python3 -m venv ../.venv && ../.venv/bin/pip install -r requirements.txt
mkdir -p build && ./run_frontend.sh build/ir.json
PIMSA_HBM_IR=build/ir.json ../.venv/bin/python -m unittest -v test_pimsa_hbm
../.venv/bin/python sweep.py --ir build/ir.json --sim ../hbmpim_sim/build/pimsim/sim
```

The Samsung simulator source is read from
`papers/pim/artifacts/Samsung_PIMSimulator` and is not copied into this
repository; the generated IR (`build/`) is likewise not committed.
`hbmpim_sim/build.sh` adds counting-only instrumentation (per-channel DRAM
command counters) and does not change timing: vendor PIMBench cycles are
reproduced exactly (GEMV 4096×4096: 13,166; ADD 1M: 3,349).
