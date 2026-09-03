from __future__ import annotations

import re
import subprocess
from pathlib import Path
from .makefile import parse_makefile


def _expand_simple_make_vars(value: str, variables: dict[str, str]) -> str:
    # Enough for ${BUILDDIR}/name and $(BUILDDIR)/name target discovery.
    pat = re.compile(r"\$[({]([A-Za-z_][A-Za-z0-9_]*)[)}]")
    prev = None
    while value != prev:
        prev = value
        value = pat.sub(lambda m: variables.get(m.group(1), m.group(0)), value)
    return value


def discover_dpu_target(benchmark_dir: Path) -> str:
    info = parse_makefile(benchmark_dir / "Makefile")
    raw = info.dpu_target
    if not raw:
        raise RuntimeError(f"No DPU_TARGET in {info.path}")
    vars_ = dict(info.variables)
    vars_.setdefault("BUILDDIR", "bin")
    return _expand_simple_make_vars(raw, vars_)


def build_dpu(benchmark_dir: Path, tasklets: int, extra_make: list[str] | None = None) -> Path:
    target = discover_dpu_target(benchmark_dir)
    cmd = ["make", target, f"NR_TASKLETS={tasklets}"]
    if extra_make:
        cmd.extend(extra_make)
    proc = subprocess.run(cmd, cwd=benchmark_dir, text=True, capture_output=True)
    if proc.returncode != 0:
        raise RuntimeError(
            "DPU build failed. Ensure the UPMEM SDK environment is sourced.\n"
            f"Command: {' '.join(cmd)}\nSTDOUT:\n{proc.stdout}\nSTDERR:\n{proc.stderr}"
        )
    elf = benchmark_dir / target
    if not elf.exists():
        raise RuntimeError(f"make succeeded but DPU ELF was not found at {elf}")
    return elf
