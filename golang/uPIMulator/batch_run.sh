#!/usr/bin/env bash

set -u
set -o pipefail

UPIM_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SIMULATOR="$UPIM_ROOT/build/uPIMulator"
RESULT_ROOT="$UPIM_ROOT/results"

TASKLETS=(1 2 4 8 11 16)
DPU_COUNTS=(1 4 16 64)

BENCHMARKS=(
  BS
  GEMV
  HST-L
  HST-S
  MLP
  RED
  SCAN-RSS
  SCAN-SSA
  SEL
  TRNS
  TS
  UNI
  VA
)

# Figures 5–9 使用的单 DPU输入规模。
declare -A SINGLE_DPU_SIZE=(
  [BS]=32768
  [GEMV]=2048
  [HST-L]=131072
  [HST-S]=131072
  [MLP]=256
  [RED]=524288
  [SCAN-RSS]=262144
  [SCAN-SSA]=262144
  [SEL]=524288
  [TRNS]=1024
  [TS]=2048
  [UNI]=524288
  [VA]=524288
)

# Figure 10 使用的多 DPU输入规模。
declare -A MULTI_DPU_SIZE=(
  [BS]=131072
  [GEMV]=4096
  [HST-L]=524288
  [HST-S]=524288
  [MLP]=1024
  [RED]=2097152
  [SCAN-RSS]=1048576
  [SCAN-SSA]=1048576
  [SEL]=2097152
  [TRNS]=128
  [TS]=65536
  [UNI]=2097152
  [VA]=2097152
)

if [[ ! -x "$SIMULATOR" ]]; then
  echo "ERROR: simulator not found: $SIMULATOR" >&2
  echo "Run: python3 script/build.py" >&2
  exit 1
fi

mkdir -p "$RESULT_ROOT"

run_one() {
  local experiment="$1"
  local benchmark="$2"
  local tasklets="$3"
  local dpus="$4"
  local input_size="$5"

  local setting_name
  setting_name="${benchmark}_dpu${dpus}_tasklets${tasklets}_size${input_size}"

  local output_dir
  output_dir="$RESULT_ROOT/$experiment/$setting_name"

  local done_file="$output_dir/.done"
  local failed_file="$output_dir/.failed"
  local console_log="$output_dir/console.log"

  if [[ -f "$done_file" ]]; then
    echo "SKIP: $setting_name"
    return 0
  fi

  # 如果上次运行中断，清理该 setting 的不完整文件。
  if [[ -d "$output_dir" ]]; then
    mv "$output_dir" "${output_dir}.incomplete.$(date +%Y%m%d_%H%M%S)"
  fi

  mkdir -p "$output_dir"

  {
    echo "experiment=$experiment"
    echo "benchmark=$benchmark"
    echo "num_tasklets=$tasklets"
    echo "num_dpus=$dpus"
    echo "data_prep_params=$input_size"
    echo "start_time=$(date --iso-8601=seconds)"
    echo "upimulator_commit=$(git -C "$UPIM_ROOT" rev-parse HEAD 2>/dev/null || echo unknown)"
    echo "docker_image=$(docker image inspect bongjoonhyun/upimulator --format '{{.Id}}' 2>/dev/null || echo unknown)"
  } > "$output_dir/metadata.txt"

  echo "RUN: $setting_name"

  if "$SIMULATOR" \
    --root_dirpath "$UPIM_ROOT" \
    --bin_dirpath "$output_dir" \
    --benchmark "$benchmark" \
    --num_channels 1 \
    --num_ranks_per_channel 1 \
    --num_dpus_per_rank "$dpus" \
    --num_tasklets "$tasklets" \
    --data_prep_params "$input_size" \
    > "$console_log" 2>&1
  then
    {
      echo "end_time=$(date --iso-8601=seconds)"
      echo "status=success"
    } >> "$output_dir/metadata.txt"

    touch "$done_file"
    echo "DONE: $setting_name"
  else
    exit_code=$?

    {
      echo "end_time=$(date --iso-8601=seconds)"
      echo "status=failed"
      echo "exit_code=$exit_code"
    } >> "$output_dir/metadata.txt"

    touch "$failed_file"
    echo "FAILED: $setting_name, see $console_log" >&2
    return 1
  fi
}

run_tasklet_sweep() {
  echo "Starting single-DPU tasklet sweep"

  for benchmark in "${BENCHMARKS[@]}"; do
    input_size="${SINGLE_DPU_SIZE[$benchmark]}"

    for tasklets in "${TASKLETS[@]}"; do
      run_one \
        tasklet_sweep \
        "$benchmark" \
        "$tasklets" \
        1 \
        "$input_size" || true
    done
  done
}

run_dpu_sweep() {
  echo "Starting multi-DPU scaling sweep"

  for benchmark in "${BENCHMARKS[@]}"; do
    input_size="${MULTI_DPU_SIZE[$benchmark]}"

    for dpus in "${DPU_COUNTS[@]}"; do
      run_one \
        dpu_sweep \
        "$benchmark" \
        16 \
        "$dpus" \
        "$input_size" || true
    done
  done
}

case "${1:-all}" in
  tasklets)
    run_tasklet_sweep
    ;;
  dpus)
    run_dpu_sweep
    ;;
  all)
    run_tasklet_sweep
    run_dpu_sweep
    ;;
  *)
    echo "Usage: $0 {tasklets|dpus|all}" >&2
    exit 1
    ;;
esac

echo "Sweep finished. Results: $RESULT_ROOT"
