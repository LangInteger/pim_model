"""PrIM benchmarks (UPMEM) in PIMSA-IR, one module per benchmark.

Each module defines
  BENCH       directory name under inst_count_analyzer/results and draw_figs/results
  FUNCTIONS   {DPU kernel function name: () -> ir.Kernel}
  values(params, build, nt) -> {symbol: value}
              params: one DPU execution's arguments (summary.csv
              dpu_execution_inputs_json), build: dpu_build_options_json,
              nt: NR_TASKLETS
"""
import importlib

NAMES = ("va", "red", "gemv", "mlp", "hst_s", "hst_l", "sel", "uni", "scan_ssa", "scan_rss",
         "bs", "ts", "trns")


def load(name):
    return importlib.import_module(f"prim.{name}")
