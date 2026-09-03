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

        # Match the CMake configuration used by Go uPIMulator. The Makefiles
        # belong to a separate manual/PrIM build path and are not authoritative
        # for binaries produced by benchmark/build.py.
        analyzer_defines=(-DT=int -DDIV=1 -DNR_DPUS=1 -DNR_TASKLETS=16)
        benchmark_cmake="../uPIMulator/golang/uPIMulator/benchmark/$benchmark/dpu/CMakeLists.txt"
        bl=""
        if [[ -f "$benchmark_cmake" ]]; then
            # Only mirror BL when CMake actually passes it as -DBL=<value>.
            # TS currently spells this as -DBL${BL}, which defines BL10 rather
            # than BL and therefore leaves support/common.h's BL=8 fallback in
            # effect; merely parsing SET(BL 10) would model the wrong binary.
            if grep -Fq -- '-DBL=${BL}' "$benchmark_cmake"; then
                bl=$(sed -nE 's/^[[:space:]]*[Ss][Ee][Tt]\([[:space:]]*BL[[:space:]]+([0-9]+)[[:space:]]*\).*$/\1/p' "$benchmark_cmake" | head -n 1)
            fi
        fi
        if [[ -n "$bl" ]]; then
            analyzer_defines+=("-DBL=$bl")
        fi
        if [[ -f "$benchmark_cmake" ]]; then
            nr_histo=$(sed -nE 's/^[[:space:]]*[Ss][Ee][Tt]\([[:space:]]*NR_HISTO[[:space:]]+([0-9]+)[[:space:]]*\).*$/\1/p' "$benchmark_cmake" | head -n 1)
            if [[ -n "$nr_histo" ]]; then
                analyzer_defines+=("-DNR_HISTO=$nr_histo")
            fi
        fi

        ./build/pim-analyzer "../uPIMulator/golang/uPIMulator/benchmark/$benchmark/host/app.c" "../uPIMulator/golang/uPIMulator/benchmark/$benchmark/dpu/task.c" -- \
            "${EXTRA_FLAGS[@]}" \
            -I"../uPIMulator/golang/uPIMulator/benchmark/$benchmark/support" \
            -Imock_dpu_includes \
            "${analyzer_defines[@]}" > /dev/null 2>&1
        
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
