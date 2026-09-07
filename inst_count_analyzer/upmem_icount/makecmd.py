from __future__ import annotations
import re, shlex, subprocess
from pathlib import Path
from .build import discover_dpu_target


def apply_required_compile_defines(
    argv: list[str], make_assignments: list[str] | None
) -> list[str]:
    """Make effective BL explicit even when a benchmark Makefile ignores it."""
    assignments = {}
    for item in make_assignments or []:
        if "=" in item:
            name, value = item.split("=", 1)
            assignments[name] = value
    if "BL" not in assignments:
        return list(argv)

    define = f"-DBL={assignments['BL']}"
    result = [
        token
        for token in argv
        if token != "-DBL" and not token.startswith("-DBL=")
    ]
    result.append(define)
    return result


def dry_run_dpu_command(benchmark_dir: Path, tasklets: int, extra_make: list[str] | None=None) -> list[str]:
    target=discover_dpu_target(benchmark_dir)
    cmd=['make','-B','-n',target,f'NR_TASKLETS={tasklets}'] + (extra_make or [])
    p=subprocess.run(cmd,cwd=benchmark_dir,text=True,capture_output=True)
    if p.returncode != 0:
        raise RuntimeError(f"make -n failed: {' '.join(cmd)}\n{p.stdout}\n{p.stderr}")
    lines=[x.strip() for x in p.stdout.splitlines() if 'dpu-upmem-dpurte-clang' in x and not x.lstrip().startswith('#')]
    if not lines:
        raise RuntimeError('Could not find dpu-upmem-dpurte-clang command in make -n output')
    # Last DPU compiler line is normally the link/compile target command.
    line=lines[-1]
    # Make recipes in these benchmarks do not use shell pipes; shlex is sufficient.
    return apply_required_compile_defines(shlex.split(line), extra_make)


def compile_command_info(argv: list[str]) -> dict:
    src=[x for x in argv if x.endswith(('.c','.cc','.cpp'))]
    out=None
    if '-o' in argv:
        i=argv.index('-o')
        if i+1<len(argv): out=argv[i+1]
    return {'argv':argv,'sources':src,'output':out}


def derive_emit_llvm_command(argv: list[str], out_path: Path) -> list[str]:
    # Reuse the exact benchmark compile flags, but emit textual LLVM IR instead of linking.
    a=list(argv)
    if '-o' in a:
        i=a.index('-o'); del a[i:i+2]
    a += ['-S','-emit-llvm','-o',str(out_path)]
    return a
