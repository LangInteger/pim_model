from __future__ import annotations
import subprocess
from pathlib import Path
from .makecmd import dry_run_dpu_command, derive_emit_llvm_command, compile_command_info
from .toolchain import Toolchain


def emit_llvm_ir(benchmark_dir: Path, tasklets: int, out_path: Path, extra_make=None) -> dict:
    argv=dry_run_dpu_command(benchmark_dir,tasklets,extra_make)
    # Make's command should already use the UPMEM wrapper from PATH.
    cmd=derive_emit_llvm_command(argv,out_path)
    p=subprocess.run(cmd,cwd=benchmark_dir,text=True,capture_output=True)
    if p.returncode != 0:
        raise RuntimeError(f"LLVM IR emission failed\nCMD: {' '.join(cmd)}\n{p.stdout}\n{p.stderr}")
    return {'original_compile':compile_command_info(argv),'emit_llvm_argv':cmd,'llvm_ir':str(out_path)}


def run_scev(ir: Path, opt: str, out_path: Path) -> dict:
    # LLVM 12 supports the legacy -analyze -scalar-evolution syntax. Newer LLVM supports
    # the new PM print pass. Try both and preserve raw output because its syntax is version-specific.
    attempts=[
        [opt,'-analyze','-scalar-evolution',str(ir)],
        [opt,'-passes=print<scalar-evolution>','-disable-output',str(ir)],
    ]
    err=[]
    for cmd in attempts:
        p=subprocess.run(cmd,text=True,capture_output=True)
        text=(p.stdout or '')+(p.stderr or '')
        if p.returncode==0 and text.strip():
            out_path.write_text(text)
            return {'command':cmd,'output':str(out_path)}
        err.append({'command':cmd,'returncode':p.returncode,'stderr':p.stderr[-4000:]})
    raise RuntimeError('ScalarEvolution failed: '+repr(err))
