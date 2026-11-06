# PIM Model

Implementation of the PIMSA static analysis (paper: `manuscripts/pimsa` in the
dissertation repository), with its two case studies:
- UPMEM, validated against uPIMulator;
- Samsung HBM-PIM, validated against PIMSimulator.

```text
pim_model/
├── static_analyzer/          # Clang-based analyzer shared by both case studies
│   ├── lib/UPMEMMatchers.cpp #   UPMEM: mram_read / mram_write matchers
│   ├── lib/HBMPIMFrontend.cpp#   HBM-PIM: PIMKernel C++ -> PIMSA-IR (JSON)
│   ├── run_benchmarks.sh     #   UPMEM: symbolic results for the PrIM benchmarks
│   └── build_and_run_benchmarks.sh
├── inst_count_analyzer/      # UPMEM: static dynamic-instruction counter and work-span analysis
├── uPIMulator/               # UPMEM reference simulator
├── sdk/LoCaLUT               # UPMEM SDK (git submodule)
├── draw_figs/                # UPMEM figures from analyzer / instruction-count / uPIMulator results
├── hbmpim_static/            # HBM-PIM: symbolic metrics, controller constraint model, sweep
├── hbmpim_sim/               # HBM-PIM: out-of-tree PIMSimulator build with bookkeeping-only
│                             #   instrumentation and the sweep driver
├── run_go_simulator.sh       # run the Go version of uPIMulator
├── run_inst_count_sweeps.sh  # run the UPMEM instruction-count sweeps
└── run_draw_figs.sh          # regenerate the UPMEM figures
```

See `hbmpim_static/README.md` for how to run the HBM-PIM analysis. The
Samsung PIMSimulator source is not part of this repository (license): it is
read from `papers/pim/artifacts/Samsung_PIMSimulator` in the dissertation
repository, and build outputs (`*/build/`, `.venv/`) are not committed.
