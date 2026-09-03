#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || exit 1

if [ ! -d ".venv" ]; then
    python3 -m venv .venv
fi

.venv/bin/pip install -r draw_figs/requirements.txt \
&& cd "$SCRIPT_DIR" \
&& .venv/bin/python3 draw_figs/scripts/aggregate_simulator_results.py \
&& .venv/bin/python3 draw_figs/scripts/estimate_cost.py

