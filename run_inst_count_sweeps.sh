#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ANALYZER_ROOT="$REPO_ROOT/inst_count_analyzer"
SDK_ROOT="${UPMEM_SDK_ROOT:-$REPO_ROOT/sdk/LoCaLUT/upmem-2023.2.0-Linux-x86_64}"
VENV_ROOT="$REPO_ROOT/.venv"

if [[ ! -d "$VENV_ROOT" ]]; then
  python3 -m venv "$VENV_ROOT"
fi

"$VENV_ROOT/bin/python" -m pip install \
  -r "$ANALYZER_ROOT/requirements.txt"

"$ANALYZER_ROOT/prepare_localut_sdk.sh" "$SDK_ROOT"
source "$ANALYZER_ROOT/.work/sdk_compat/upmem_env.sh"

exec "$VENV_ROOT/bin/python" "$ANALYZER_ROOT/run_benchmark_sweeps.py" \
  --sdk-root "$SDK_ROOT" \
  "$@"
