from __future__ import annotations
import os, shutil, subprocess
from dataclasses import dataclass, asdict
from pathlib import Path

@dataclass
class Toolchain:
    sdk_root: str | None
    clang: str | None
    dpu_clang: str | None
    objdump: str | None
    opt: str | None
    llvm_dis: str | None

    def to_dict(self): return asdict(self)
    @property
    def complete(self): return bool(self.dpu_clang and self.objdump)


def _exe(p: Path | str | None):
    if not p: return None
    p = str(p)
    if os.path.isfile(p) and os.access(p, os.X_OK): return p
    return shutil.which(p)


def discover_toolchain(explicit_root: str | None = None) -> Toolchain:
    roots=[]
    if explicit_root: roots.append(Path(explicit_root))
    for e in ('UPMEM_HOME','UPMEM_SDK_DIR','UPMEM_SDK_ROOT'):
        if os.environ.get(e): roots.append(Path(os.environ[e]))
    # Infer root from PATH wrapper.
    wrapper=shutil.which('dpu-upmem-dpurte-clang')
    if wrapper:
        roots.append(Path(wrapper).resolve().parent.parent)
    seen=[]
    for r in roots:
        if r not in seen: seen.append(r)
    for r in seen:
        b=r/'bin'
        dpu=_exe(b/'dpu-upmem-dpurte-clang')
        if dpu:
            return Toolchain(str(r), _exe(b/'clang'), dpu,
                _exe(b/'llvm-objdump') or _exe('llvm-objdump'),
                _exe(b/'opt') or _exe('opt'),
                _exe(b/'llvm-dis') or _exe('llvm-dis'))
    return Toolchain(None, _exe('clang'), wrapper,
                     _exe('llvm-objdump') or _exe('objdump'), _exe('opt'), _exe('llvm-dis'))


def probe_toolchain(tc: Toolchain) -> dict:
    out=tc.to_dict(); out['checks']={}
    for name in ('dpu_clang','objdump','opt'):
        exe=getattr(tc,name)
        if not exe:
            out['checks'][name]={'ok':False,'reason':'not found'}; continue
        try:
            p=subprocess.run([exe,'--version'],capture_output=True,text=True,timeout=10)
            text=(p.stdout or p.stderr).splitlines()
            out['checks'][name]={'ok':p.returncode==0,'first_line':text[0] if text else ''}
        except Exception as e:
            out['checks'][name]={'ok':False,'reason':str(e)}
    # Verify this clang actually knows the DPU target.
    if tc.dpu_clang:
        try:
            p=subprocess.run([tc.dpu_clang,'-###','-x','c','/dev/null','-c'],capture_output=True,text=True,timeout=10)
            out['checks']['dpu_target']={'ok':'dpu-upmem-dpurte' in (p.stderr+p.stdout), 'returncode':p.returncode}
        except Exception as e:
            out['checks']['dpu_target']={'ok':False,'reason':str(e)}
    return out
