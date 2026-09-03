#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || exit 1

ALL_BENCHMARKS=("BS" "GEMV" "HST-L" "HST-S" "MLP" "RED" "SCAN-RSS" "SCAN-SSA" "SEL" "TRNS" "TS" "UNI" "VA")

if (( $# > 0 )); then
    BENCHMARKS=("$@")
else
    BENCHMARKS=("${ALL_BENCHMARKS[@]}")
fi

mkdir -p results

EXTRA_FLAGS=()

if [[ "$(uname)" == "Darwin" ]]; then
    EXTRA_FLAGS+=(
        -isysroot "$(xcrun --show-sdk-path)"
        -I"$(clang -print-resource-dir)/include"
    )
elif [[ "$(uname)" == "Linux" ]]; then
    EXTRA_FLAGS+=(
        -I"$(clang -print-resource-dir)/include"
    )
fi

for benchmark in "${BENCHMARKS[@]}"; do
    echo "Running analyzer on benchmark: $benchmark"
    if [[ -f "../uPIMulator/golang/uPIMulator/benchmark/$benchmark/host/app.c" && -f "../uPIMulator/golang/uPIMulator/benchmark/$benchmark/dpu/task.c" ]]; then
        ./build/pim-analyzer "../uPIMulator/golang/uPIMulator/benchmark/$benchmark/host/app.c" "../uPIMulator/golang/uPIMulator/benchmark/$benchmark/dpu/task.c" -- \
            "${EXTRA_FLAGS[@]}" \
            -I"../uPIMulator/golang/uPIMulator/benchmark/$benchmark/support" \
            -Imock_dpu_includes \
            -DT=int -DBL=10 -DDIV=1 -DNR_DPUS=1 -DNR_TASKLETS=16 > /dev/null 2>&1
        
        if [ -f "pim_summary.json" ]; then
            mv pim_summary.json "results/${benchmark}_summary.json"
            echo "Successfully generated results/${benchmark}_summary.json"
        else
            echo "Failed to generate summary for $benchmark"
        fi
    else
        echo "Source files missing for $benchmark"
    fi
    echo "-----------------------------------"
done
