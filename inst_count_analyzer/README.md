# UPMEM Static Dynamic-Instruction Counter

This is the stripped-down Q1 analyzer only. It estimates/bounds the dynamic DPU machine-instruction count:

```text
N_dyn-inst = sum_b E_b * n_b
```

It does **not** model cycles, stalls, IPC, or MRAM latency.

## What is included

```text
inst_count_analyzer/
├── count_instructions.py        # main analyzer CLI
├── compare_simulator.py         # optional comparison with summary.csv
├── prepare_localut_sdk.sh       # optional compatibility helper for LoCaLUT SDK
├── requirements.txt
├── upmem_icount/
    ├── __init__.py
    ├── generic_count.py         # interprocedural orchestration
    ├── generic_cfg.py           # CFG/SCEV/MIR analysis and flow solver
    ├── runtime.py               # independent SDK runtime translation units
    ├── runtime_semantics.py     # collective-runtime composition rules
    ├── llvm_ir.py               # emit optimized DPU LLVM IR
    ├── makecmd.py               # capture real DPU compile command
    ├── build.py
    ├── makefile.py
    └── toolchain.py
├── tests/                       # artifact-management regression tests
└── .work/                       # ignored compatibility and analysis artifacts
```

Old cost models and VA-specific counters are not included.

## Analyze the experiment matrix

`run_benchmark_sweeps.py` analyzes the exact settings present in
`draw_figs/results/<benchmark>/summary.csv`. Each row contains the experiment
configuration and semantic per-DPU/execution inputs (`function` plus named
`params`). Binary `DPU_INPUT_ARGUMENTS` layout and endianness are decoded by the
simulator-results aggregator and are not known by this analyzer. The analyzer
does not access the raw simulator artifact tree, and simulator instruction
counts are not inputs to the analysis.

The summary records code-generating choices in `dpu_build_options_json`,
including the effective compile-time `BL` value and options such as `TYPE`,
`NR_HISTO`, `VERSION`, and `SYNC`. The sweep runner passes them back to the
benchmark build; it does not infer these settings from the analyzer's current
source tree.

From the repository root on the Linux server, run all benchmarks:

```bash
./run_inst_count_sweeps.sh
```

Or run selected benchmarks:

```bash
./run_inst_count_sweeps.sh RED HST-S TS
```

The wrapper creates/reuses the repository `.venv`, installs the analyzer
requirements, prepares the LoCaLUT compatibility environment without modifying
the SDK, and invokes `run_benchmark_sweeps.py`. It accepts the runner's options,
for example `--force`, `--debug`, and `--fail-fast`. Set `UPMEM_SDK_ROOT` when
the SDK is not at the repository's default `sdk/LoCaLUT/...` path.

The runner discovers only settings that survived aggregation, so removed
tasklet-11 points and failed simulator settings are not recreated. Sequential
executions are composed per DPU (for example, three MLP executions and both
SCAN/TRNS kernels), then the maximum per-DPU instruction bound is emitted for
comparison with `cycles_max`:

```text
inst_count_analyzer/results/<BENCHMARK>/instruction_counts.csv
inst_count_analyzer/results/<BENCHMARK>/<setting-id>/result.json
inst_count_analyzer/results/<BENCHMARK>/<setting-id>/phases/<key>/machine_cfg_validation.json
```

Each phase also stores a Git-trackable Machine-CFG validation report. It maps
every `function + bb.N` between late MIR and final annotated assembly, records
both successor sets and the emitted MCInst count, and preserves missing-block,
successor-mismatch, and IR-annotation diagnostics. Missing blocks or different
successor sets fail the phase after writing the report. IR provenance-label
differences are warnings because backend transformations may legitimately drop
or duplicate those annotations. A result generated before this validation was
added is treated as stale and is regenerated rather than silently skipped.

Loops resolved by LLVM SCEV use their exact backedge counts. Source-derived
finite caps are supplied only for SCEV-unknown, early-exit/data-dependent loops
in BS, GEMV/MLP, and TRNS. These caps constrain CFG path optimization while
machine-CFG edges come from late MIR and post-expansion instruction counts come
from the final annotated assembly. TRNS's shared work queue is intentionally
conservative until a collective work-
distribution constraint is added.

For an exact SCEV loop count, the machine-flow solver also transfers entry,
backedge, and exit counts when the IR header maps to one cyclic machine block
and the MIR CFG proves a single-entry natural loop. This prevents an otherwise
legal LP circulation from satisfying the loop count without any path from the
function entry. Unproven or structurally complex loops retain the previous
conservative flow model, and every applied or skipped loop fact is recorded in
the phase `debug.json` under `machine.loop_flow_facts`.

After generating the instruction summaries, regenerate every cost model with:

```bash
python3 draw_figs/scripts/estimate_cost.py
```

`estimate_cost.py` requires exact static instruction settings for every
benchmark. `instructions_mean` remains in its output CSV only as validation
data and is never used in the compute-cost equations.

## Dependencies

```bash
python3 -m pip install -r requirements.txt
```

You need an UPMEM SDK containing at least:

```text
bin/dpu-upmem-dpurte-clang
bin/opt
bin/llc
```

If using the LoCaLUT UPMEM 2023.2.0 SDK on a newer Linux system and it needs the libtinfo compatibility setup:

```bash
./prepare_localut_sdk.sh /path/to/LoCaLUT/upmem-2023.2.0-Linux-x86_64
source .work/sdk_compat/upmem_env.sh
```

The helper treats the SDK as read-only. Compatibility SONAME links, the optional
`libtinfo.so.5` shim, and the generated environment file are all created below
`inst_count_analyzer/.work/sdk_compat/`; no `chmod`, symlink, or other write is
performed inside the SDK tree.

## Current scope boundary

Direct calls are resolved through a function-to-translation-unit index. Every
benchmark or SDK runtime translation unit retains its own optimized LLVM IR and
late MIR; only the analysis summaries cross module boundaries. Constant integer
arguments proven by the static analysis are propagated into callee summaries.

`barrier_wait` is not treated as an ordinary per-tasklet call. Its eventual
generation-level rule is `(T - 1) * C_nonlast + C_last`, where both path costs
must first be derived from the independently compiled barrier CFG/MIR. Until
that path extraction is implemented, it remains explicitly unresolved. Other
runtime/SDK callees without a registered translation unit are also unresolved.
LLVM intrinsics already lowered into caller machine blocks are not counted as
missing callees.

## Tests

The baseline-only regression test runs without the UPMEM SDK dependencies:

```bash
python3 -m unittest discover -s inst_count_analyzer/tests -v
```

On the Linux server, from the repository root, run the full runtime-expansion
regression with:

```bash
source inst_count_analyzer/.work/sdk_compat/upmem_env.sh
UPMEM_ICOUNT_RUN_INTEGRATION=1 \
  .venv/bin/python -m unittest discover -s inst_count_analyzer/tests -v
```
