#!/usr/bin/env bash
# Build Samsung PIMSimulator plus the PIMSA sweep driver out of tree.
# Usage: build.sh [SIM_SRC] [BUILD_DIR]
# Requires: scons, googletest (brew install scons googletest on macOS).
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$HERE/../.." && pwd)"
SRC="${1:-$ROOT/papers/pim/artifacts/Samsung_PIMSimulator}"
OUT="${2:-$HERE/build/pimsim}"

rm -rf "$OUT"; mkdir -p "$(dirname "$OUT")"
cp -R "$SRC" "$OUT"
cp "$HERE/PIMSASweep.cpp" "$OUT/src/tests/PIMSASweep.cpp"

# Bookkeeping-only instrumentation (counts + stall attribution); timing untouched.
python3 "$HERE/instrument.py" "$OUT/src/MemoryController.cpp"

PREFIX="$(brew --prefix 2>/dev/null || echo /usr/local)"
cd "$OUT"
# Point SCons at the gtest install; recent googletest needs C++17.
sed -i.bak \
  -e "s|LIBPATH=\['.'\]|LIBPATH=['.','$PREFIX/lib']|" \
  -e "s|CPPPATH=\[base_path\[\"lib\"\], base_path\[\"source\"\], base_path\[\"tools\"\]\]|CPPPATH=[base_path['lib'], base_path['source'], base_path['tools'], '$PREFIX/include']|" \
  -e "s|-std=c++14|-std=c++17|g" Sconstruct
scons -j8 NO_LIBRARY=1 >/dev/null
echo "built $OUT/sim"
