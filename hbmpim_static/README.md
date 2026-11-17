# PIMSA static analysis for HBM-PIM

Applies the PIMSA method (architecture model, metric extraction, cost model)
to Samsung HBM-PIM, with the same structure as the UPMEM case study:

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
   PIM instruction semantics or simulator involved.

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

### Closed-form cycle count (`closed_form.py`)

Each kernel's command stream is a loop nest of identical periods, so its schedule is periodic: after one iteration of transient, every iteration costs a constant amount. In max-plus terms that amount is the weight of the critical cycle. `closed_form.py` derives it once per kernel and architecture, independent of problem size:
1. On tiny instances (1–5 iterations per loop), it schedules the derived stream with the constraint model (refresh disabled). It records, for each command, the earlier command whose constraint it waited for (`controller.schedule(..., edges=...)`).
2. It walks these predecessors back from the last command to get the critical path. Every edge must equal a named delay's nominal value.
3. The difference between n+1 and n iterations is one period's critical cycle. Periodicity and additivity across loop levels are both checked.

Resulting per-period costs, as sums of named delays:

| kernel | period | critical cycle | cycles |
| --- | --- | --- | ---: |
| ADD, MUL | tile | 42·tCCD_L + 2·W2R + 2·tRCD_RD + 2·tRCD_WR + 4·tRP + 4·tRTP | 322 |
| RELU | tile | 28·tCCD_L + 2·W2R + 2·tRCD_WR + 2·tRP + 2·tRTP | 204 |
| GEMV | odd input tile | 69·tCCD_L + 2·tRCD_RD + tRCD_WR + 3·tRP + 2·tRTP + tWR | 388 |
| GEMV | even input tile | 69·tCCD_L + R2W + W2R + tRCD_RD + tRP + tRTP | 341 |
| GEMV | output tile × batch | 76·tCCD_L + R2W + W2R + tRCD_RD + tRCD_WR + 2·tRP + tRTP + tWR | 419 |

Refresh-free closed forms, with R = B·⌈M/(64C)⌉ and n_t = ⌊B⌈L/16⌉/(128C)⌋:
- GEMV: T₀ = 331 + R·(419 + 388·⌊n_in/2⌋ + 341·(⌈n_in/2⌉ − 1))
- ADD, MUL: T₀ = 409 + 322·n_t
- RELU: T₀ = 409 + 204·n_t

These equal the constraint evaluation exactly, which `test_pimsa_hbm.ClosedForm` checks on shapes and channel counts not used in the derivation.

The formulas are symbolic in the workload parameters. In the timing parameters they are piecewise: with other timing values a different cycle can become critical, so the derivation is redone per architecture.

**Refresh.** A pending REF issues only when no bank of the rank has an open row (`CommandQueue.cpp:169-205`). Other commands keep issuing meanwhile; the guard that would stop them is commented out at `CommandQueue.cpp:213-214`. A REF still pending at the end is dropped, because `runPIM` stops when nothing is pending. The last all-rows-closed instant is a constant 110 cycles before the end: this is the final parking phase. Rank-0 refresh k is therefore issued iff tREFI/2 + k·tREFI ≤ T₀ − 110 + k·tRFC, and each issued refresh is charged tRFC. Its true cost varies by ±14 cycles with phase, which is the only residual error: closed form vs simulator, max 0.42 % and mean 0.26 % over the 42 configurations.

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

The Samsung simulator source is read from `$PIMSIM_SRC`, a checkout of
https://github.com/SAITPublic/PIMSimulator, and is not copied into this
repository; the generated IR (`build/`) is likewise not committed.
`hbmpim_sim/build.sh` adds counting-only instrumentation (per-channel DRAM
command counters) and does not change timing: vendor PIMBench cycles are
reproduced exactly (GEMV 4096×4096: 13,166; ADD 1M: 3,349).
