# PIMSA static analysis for HBM-PIM (plan A)

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
3. **Row factor estimation** (`pimsa_hbm.py`, concrete): abstract execution of
   one PU's address stream through `addrGenSafe` (column overflow carries into
   the row), with the PIMSimulator controller row policy (rows not reused by the
   next barrier group are precharged early -> cold miss; same-bank row change
   inside a group -> conflict miss). No data, timing or simulator involved.
4. **Cost model**: `T = (rd+wr)·tCCD_L + conflict·(tRP+tRCD) + cold·tRCD +
   turnarounds + refresh`, all coefficients from `arch/hbm2_pim.json`, each
   citing its source in the simulator's ini/Configuration.h. No fitted values.

Per-channel closed forms (n_in = ⌈N/128⌉, n_out = ⌈M/(64C)⌉,
n_t = ⌊B⌈L/16⌉/(128C)⌋), checked on a grid by `test_pimsa_hbm.py`:

| kernel | reads | writes | barriers |
| --- | --- | --- | --- |
| GEMV | 64·B·n_in·n_out + 32 | B·n_out·(8·n_in + 10) + 7 | B·n_out·(9·n_in + 3) + 6 |
| ADD, MUL | 32·n_t + 32 | 16·n_t + 9 | 6·n_t + 8 |
| RELU | 16·n_t + 32 | 16·n_t + 9 | 4·n_t + 8 |

## Validation (results/sweep.json, 42 configurations)

- Column-command counts equal the simulator's channel-0 READ/WRITE counts in
  **42/42** configurations; estimated ACT counts within 1.5%.
- Cycle estimate / simulated: GEMV 0.978–1.011 (mean |err| 1.1%);
  ADD/MUL 1.012–1.349 (1.018–1.047 above 5k cycles); RELU 1.166–1.513.
  Overall mean |err| 6.9%.
- Worst-case factors (every transaction a row conflict and a bus turnaround):
  7.9–11.4× the simulated cycles.

Known residuals: very short runs (< ~3k cycles) are dominated by mode-switch
and parking overhead that the additive model over-charges; RELU over-charges
because activation and bus turnaround overlap in hardware but are added in the
model (the paper's cost composition is additive).

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
