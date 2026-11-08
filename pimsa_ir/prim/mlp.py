"""PrIM MLP: NUM_LAYERS (3) GEMV layers, one DPU kernel execution per layer.
Source: PrIM/MLP/dpu/task.c.

The DPU program is byte-identical to PrIM/GEMV/dpu/task.c (`diff` reports no
difference): same row split over tasklets in pairs (task.c:49-67), same loop
nest i (:85), pos (:92), n (:94), off (:103), off (:126), j (:140), same
offset/aux-read behaviour (:100-111, :124-135, :153-160) and the same 8-byte
result write per row pair (:163). The only differences in the build are
support/common.h: T is int32_t (GEMV: uint32_t), 4 bytes in both, and
NUM_LAYERS = 3, which the host uses to launch the kernel three times
(summary.csv dpu_execution_inputs_json, executions 0..2, each with its own
n_size/n_size_pad/nr_rows/max_rows). ReLU is applied on the host
(host/app.c:69, C[m] = max(0, C[m])), not on the DPU. Hence the IR of one
execution is the GEMV IR; executions are summed by upmem_cost.setting_bounds.
The machine code used is MLP's own (stored per MLP setting)."""
from prim.common import build_values
from prim.gemv import MAX_ROWS, N_PAD, N_SIZE, NR_ROWS, main

BENCH = "MLP"
SRC = "PrIM/MLP/dpu/task.c"

FUNCTIONS = {"main": main}


def values(params, build, nt):
    # T = int32_t (support/common.h), 4 bytes: build_values' default INT32.
    return {**build_values(build, nt), N_SIZE: params["n_size"], N_PAD: params["n_size_pad"],
            NR_ROWS: params["nr_rows"], MAX_ROWS: params["max_rows"]}
