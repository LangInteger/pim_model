SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || exit 1

cmake -S . -B build  && cmake --build build -j && bash ./run_benchmarks.sh