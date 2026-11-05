#!/usr/bin/env bash
# Lower Samsung PIMSimulator's PIMKernel entry points to PIMSA-IR.
# Usage: run_frontend.sh OUT.json [ANALYZER_BIN] [SIM_SRC]
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$HERE/../.." && pwd)"
OUT="${1:?output IR path}"
BIN="${2:-$HERE/../static_analyzer/build/pim-analyzer}"
SIM="${3:-$ROOT/papers/pim/artifacts/Samsung_PIMSimulator}"
CLANG="$(brew --prefix llvm 2>/dev/null || echo /usr)/bin/clang"

FLAGS=(-std=c++17 -w -include iterator
       -resource-dir "$("$CLANG" -print-resource-dir)"
       -I"$SIM/src" -I"$SIM/lib" -I"$SIM/tools")
if [[ "$(uname)" == "Darwin" ]]; then
  FLAGS+=(-isysroot "$(xcrun --show-sdk-path)")
fi

"$BIN" --target=hbmpim \
  --entry=PIMKernel::executeGemv --entry=PIMKernel::executeEltwise \
  --ir-out="$OUT" "$SIM/src/tests/PIMKernel.cpp" -- "${FLAGS[@]}"
