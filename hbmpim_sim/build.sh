#!/usr/bin/env bash
# Build Samsung PIMSimulator plus the PIMSA sweep driver out of tree.
# Usage: build.sh [SIM_SRC] [BUILD_DIR]
#   VANILLA=1 build.sh ... builds the uninstrumented simulator with the timing
#   driver (PIMSATime.cpp) instead, for wall-clock comparisons.
# Requires: scons, googletest (brew install scons googletest on macOS).
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$HERE/../.." && pwd)"
SRC="${1:-$ROOT/papers/pim/artifacts/Samsung_PIMSimulator}"
OUT="${2:-$HERE/build/pimsim}"

rm -rf "$OUT"; mkdir -p "$(dirname "$OUT")"
cp -R "$SRC" "$OUT"
if [ "${VANILLA:-0}" = 1 ]; then
  cp "$HERE/PIMSATime.cpp" "$OUT/src/tests/PIMSATime.cpp"
else
  cp "$HERE/PIMSASweep.cpp" "$OUT/src/tests/PIMSASweep.cpp"
  cp "$HERE/PIMSAMicro.cpp" "$OUT/src/tests/PIMSAMicro.cpp"   # bandwidth microbenchmark
  # Bookkeeping-only instrumentation (counts + stall attribution); timing untouched.
  python3 "$HERE/instrument.py" "$OUT/src/MemoryController.cpp"
fi

PREFIX="$(brew --prefix 2>/dev/null || echo /usr/local)"
cd "$OUT"
# Point SCons at the gtest install; recent googletest needs C++17.
sed -i.bak \
  -e "s|LIBPATH=\['.'\]|LIBPATH=['.','$PREFIX/lib']|" \
  -e "s|CPPPATH=\[base_path\[\"lib\"\], base_path\[\"source\"\], base_path\[\"tools\"\]\]|CPPPATH=[base_path['lib'], base_path['source'], base_path['tools'], '$PREFIX/include']|" \
  -e "s|-std=c++14|-std=c++17 -include cstdint -include iterator|g" Sconstruct
scons -j8 NO_LIBRARY=1 >/dev/null
echo "built $OUT/sim"
