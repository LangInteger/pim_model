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
  --outdir results/VA_T16
```

The two output locations have deliberately different roles:

```text
results/VA_T16/result.json              final compact result
inst_count_analyzer/.work/runs/VA_T16/  disposable LLVM/MIR/SCEV artifacts
```

Use `--workdir /some/ignored/path` to override the intermediate-artifact path.
Use `--debug` when the full per-tasklet analysis is needed; it adds
`results/VA_T16/debug.json`. Without `--debug`, `result.json` contains only the
benchmark, tasklet count, parameters, final dynamic-instruction bound,
and unexpanded callees. Simulator matching metadata and other detailed fields
are kept only in `debug.json`.

Expected final bound from the version packaged here:

```json
"dynamic_instruction_bound": {
  "lower": 3719617,
  "upper": 3721761,
  "exact": false
}
```

The full debug output also contains the direct bound `45505–47649`. Its large
difference from the final bound comes from recursively expanding the internal
`vector_addition` call.

The remaining external/runtime callees reported for this VA setting are:

```text
barrier_wait
mem_alloc
mem_reset
```

## Reproduce the simulator comparison

For exact row matching when `summary.csv` contains several runs with the same
benchmark and tasklet count, add `--debug` to the analyzer command above. The
comparison reads matching metadata from `debug.json` without adding it to the
compact `result.json`.

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

## Current scope boundary

Direct calls to functions defined in the same DPU LLVM/MIR module are recursively expanded. Constant integer call arguments proven by the static analysis are propagated into callee summaries.

Runtime/SDK callees whose function bodies are not present in that module are currently reported as unexpanded rather than guessed. LLVM intrinsics already lowered into caller machine blocks are not counted as missing callees.