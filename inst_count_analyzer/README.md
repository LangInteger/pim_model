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

## Reproduce the VA T=16 static result

Important: use the **same VA source revision as the simulator**. For the result below, the VA source is the uPIMulator-style version where `vector_addition` is `__attribute__((noinline))`.

Assume your benchmark root contains:

```text
/path/to/benchmarks/VA/Makefile
/path/to/benchmarks/VA/dpu/task.c
...
```

Run:

```bash
python3 count_instructions.py \
  --root /path/to/benchmarks \
  --benchmark VA \
  --tasklets 16 \
  --sdk-root /path/to/LoCaLUT/upmem-2023.2.0-Linux-x86_64 \
  --param size=2097152 \
  --param transfer_size=2097152 \
  --param kernel=0 \
  --experiment tasklet_sweep \
  --num-dpus 1 \
  --data-prep-param 524288 \
  --outdir results/VA_T16_runtime_alloc
```

The two output locations have deliberately different roles:

```text
results/VA_T16_runtime_alloc/result.json              final compact result
inst_count_analyzer/.work/runs/VA_T16_runtime_alloc/  disposable artifacts
```

Use `--workdir /some/ignored/path` to override the intermediate-artifact path.
Use `--debug` when the full per-tasklet analysis is needed; it adds
`results/VA_T16/debug.json`. Without `--debug`, `result.json` contains only the
benchmark, tasklet count, parameters, final dynamic-instruction bound,
and unexpanded callees. Simulator matching metadata and other detailed fields
are kept only in `debug.json`.

The pre-runtime-expansion result remains in `results/VA_T16/` and is also
preserved as the regression fixture `tests/data/VA_T16_pre_runtime.json`:

```json
"dynamic_instruction_bound": {
  "lower": 3719617,
  "upper": 3721761,
  "exact": false
}
```

The full baseline debug output also contains the direct bound `45505–47649`. Its large
difference from the final bound comes from recursively expanding the internal
`vector_addition` call.

The analyzer now compiles the SDK `alloc.c` translation unit independently and
uses the same recursive mechanism to expand `mem_alloc`, `mem_alloc_nolock`, and
`mem_reset`. It does not llvm-link runtime IR with benchmark IR. The current
milestone deliberately leaves only this collective primitive unresolved:

```text
barrier_wait
```

Its runtime artifacts are kept under
`.work/runs/VA_T16_runtime_alloc/runtime/syslib_alloc/`. Run the command above
on Linux and confirm the new interval is closer to the simulator count
`3,727,420` before enabling barrier accounting.

## Reproduce the simulator comparison

For exact row matching when `summary.csv` contains several runs with the same
benchmark and tasklet count, add `--debug` to the analyzer command above. The
comparison reads matching metadata from `debug.json` without adding it to the
compact `result.json`. The command below shows the preserved pre-runtime
baseline; replace the directory with `results/VA_T16_runtime_alloc` for the new
allocation-expanded result.

With the simulator `summary.csv` used in our experiment:

```bash
python3 compare_simulator.py \
  --static-dir results/VA_T16 \
  --simulator /path/to/summary.csv \
  -o results/VA_T16/q1_comparison.csv
```

For the matching row:

```text
benchmark          = VA
experiment         = tasklet_sweep
num_dpus_configured= 1
num_tasklets       = 16
data_prep_params   = 524288
instructions_mean  = 3727420
```

this package reproduces:

```text
static lower       = 3719617
static upper       = 3721761
static midpoint    = 3720689
midpoint error     = -0.18058%
nearest-bound gap  = 0.15182%
interval width     = 0.05752% of simulator instruction count
```

## VA tasklet sweep

The simulator tasklet sweep used `1, 2, 4, 8, 11, 16`. From the repository
root, run all six static instruction analyses with:

```bash
./run_inst_count_tasklet_sweep.sh
```

Final results are written to:

```text
inst_count_analyzer/results/VA_tasklet_sweep/
├── T1/result.json
├── T2/result.json
├── T4/result.json
├── T8/result.json
├── T11/result.json
├── T16/result.json
└── instruction_counts.csv
```

Compiler output and LLVM/MIR/SCEV artifacts remain under the ignored directory
`inst_count_analyzer/.work/runs/VA_tasklet_sweep/`. Existing settings are
skipped, so an interrupted sweep can be resumed. Pass `--force` to rerun all
settings, or `--debug` to additionally produce a detailed `debug.json` for each
setting.

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
