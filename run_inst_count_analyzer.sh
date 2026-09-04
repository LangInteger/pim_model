#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || exit 1

if [ ! -d ".venv" ]; then
    python3 -m venv .venv
fi

.venv/bin/pip install -r inst_count_analyzer/requirements.txt \
&& cd inst_count_analyzer \
&& ./prepare_localut_sdk.sh ../sdk/LoCaLUT/upmem-2023.2.0-Linux-x86_64 \
&& source .work/sdk_compat/upmem_env.sh \
&& ../.venv/bin/python count_instructions.py \
  --debug \
  --root ../uPIMulator/golang/uPIMulator/benchmark \
  --benchmark VA \
  --tasklets 16 \
  --sdk-root ../sdk/LoCaLUT/upmem-2023.2.0-Linux-x86_64 \
  --function main_kernel1 \
  --param size=2097152 \
  --param transfer_size=2097152 \
  --param kernel=0 \
  --experiment tasklet_sweep \
  --num-dpus 1 \
  --data-prep-param 524288 \
  --outdir results/VA_T16
