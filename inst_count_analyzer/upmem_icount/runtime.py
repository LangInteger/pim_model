from __future__ import annotations

import subprocess
from dataclasses import dataclass
from pathlib import Path

from .generic_cfg import IRBlock, MachineBlock, parse_ir_cfg, parse_mir, run_late_mir
from .toolchain import Toolchain


@dataclass(frozen=True)
class AnalysisModule:
    """One independently compiled translation unit used by the analyzer."""

    name: str
    kind: str
    source_dir: Path
    source_path: Path | None
    llvm_ir: Path
    named_ir: Path
    late_mir: Path
    cfg: dict[str, dict[str, IRBlock]]
    machine: dict[str, list[MachineBlock]]
    emit_info: dict

    def artifact_dict(self) -> dict:
        return {
            "name": self.name,
            "kind": self.kind,
            "source": str(self.source_path) if self.source_path else None,
            "llvm_ir": str(self.llvm_ir),
            "named_ir": str(self.named_ir),
            "late_mir": str(self.late_mir),
            "functions": sorted(set(self.cfg) & set(self.machine)),
            "emit_info": self.emit_info,
        }


@dataclass(frozen=True)
class RuntimeTranslationUnit:
    name: str
    source: str
    requested_functions: frozenset[str]


RUNTIME_TRANSLATION_UNITS = (
    RuntimeTranslationUnit(
        "syslib_alloc",
        "src/syslib/alloc.c",
        frozenset({"mem_alloc", "mem_reset"}),
    ),
    RuntimeTranslationUnit(
        "syslib_barrier",
        "src/syslib/barrier.c",
        frozenset({"barrier_wait"}),
    ),
    RuntimeTranslationUnit(
        "syslib_handshake",
        "src/syslib/handshake.c",
        frozenset({"handshake_notify", "handshake_wait_for"}),
    ),
)

DEFAULT_RUNTIME_FUNCTIONS = frozenset(
    {"mem_alloc", "mem_reset", "handshake_notify", "handshake_wait_for"}
)


def _run(command: list[str], cwd: Path | None = None) -> subprocess.CompletedProcess:
    completed = subprocess.run(
        command, cwd=cwd, text=True, capture_output=True
    )
    if completed.returncode != 0:
        raise RuntimeError(
            f"command failed: {' '.join(command)}\n"
            f"{completed.stdout}\n{completed.stderr}"
        )
    return completed


def _emit_runtime_ir(
    toolchain: Toolchain,
    runtime_root: Path,
    source: Path,
    output: Path,
) -> dict:
    """Compile one SDK runtime source exactly as an independent RT object TU."""
    syslib = runtime_root / "src" / "syslib"
    stdlib = runtime_root / "src" / "stdlib"
    command = [
        str(toolchain.dpu_clang),
        "-std=c11",
        "-O2",
        "-g",
        "-DNDEBUG",
        "-DCOMPILER_TIMESTAMP=0",
        "-nostdlib",
        "-nostdinc",
        "-Wno-incompatible-library-redeclaration",
        "-Wall",
        "-Wextra",
        "-Werror",
        "-I",
        str(stdlib),
        "-I",
        str(syslib),
        "-S",
        "-emit-llvm",
        str(source),
        "-o",
        str(output),
    ]
    _run(command, cwd=runtime_root)
    return {"source": str(source), "emit_llvm_argv": command}


def _prepare_runtime_module(
    toolchain: Toolchain,
    llc: str,
    runtime_root: Path,
    work_dir: Path,
    translation_unit: RuntimeTranslationUnit,
) -> AnalysisModule:
    module_dir = work_dir / "runtime" / translation_unit.name
    module_dir.mkdir(parents=True, exist_ok=True)
    source = runtime_root / translation_unit.source
    if not source.is_file():
        raise RuntimeError(f"UPMEM runtime source not found: {source}")

    llvm_ir = module_dir / "module.ll"
    emit_info = _emit_runtime_ir(toolchain, runtime_root, source, llvm_ir)

    named_ir = module_dir / "module.named.ll"
    _run(
        [str(toolchain.opt), "-S", "-instnamer", str(llvm_ir), "-o", str(named_ir)]
    )
    cfg = parse_ir_cfg(named_ir.read_text())

    late_mir = module_dir / "module.late.mir"
    run_late_mir(llc, named_ir, late_mir)
    ir_names = {function: set(blocks) for function, blocks in cfg.items()}
    machine = parse_mir(late_mir.read_text(), ir_names)

    missing = translation_unit.requested_functions - (set(cfg) & set(machine))
    if missing:
        raise RuntimeError(
            f"runtime module {translation_unit.name} is missing functions: "
            f"{sorted(missing)}"
        )

    return AnalysisModule(
        name=translation_unit.name,
        kind="runtime",
        source_dir=runtime_root,
        source_path=source,
        llvm_ir=llvm_ir,
        named_ir=named_ir,
        late_mir=late_mir,
        cfg=cfg,
        machine=machine,
        emit_info=emit_info,
    )


def prepare_runtime_modules(
    toolchain: Toolchain,
    llc: str,
    work_dir: Path,
    requested_functions: frozenset[str] = DEFAULT_RUNTIME_FUNCTIONS,
) -> list[AnalysisModule]:
    """Prepare selected SDK runtime TUs without linking them to benchmark IR."""
    if not toolchain.sdk_root:
        raise RuntimeError("UPMEM SDK root is required for runtime expansion")
    runtime_root = Path(toolchain.sdk_root) / "src" / "dpu-rt"
    if not runtime_root.is_dir():
        raise RuntimeError(f"UPMEM runtime source tree not found: {runtime_root}")

    modules = []
    covered: set[str] = set()
    for translation_unit in RUNTIME_TRANSLATION_UNITS:
        selected = translation_unit.requested_functions & requested_functions
        if not selected:
            continue
        modules.append(
            _prepare_runtime_module(
                toolchain, llc, runtime_root, work_dir, translation_unit
            )
        )
        covered.update(selected)

    missing = set(requested_functions) - covered
    if missing:
        raise RuntimeError(
            f"no SDK runtime translation unit registered for: {sorted(missing)}"
        )
    return modules


def build_function_index(
    modules: list[AnalysisModule],
) -> dict[str, AnalysisModule]:
    """Map analyzable function names to their independently compiled owner TU."""
    function_index: dict[str, AnalysisModule] = {}
    for module in modules:
        for function in sorted(set(module.cfg) & set(module.machine)):
            # Modules are ordered with the benchmark first, matching the fact
            # that a program definition takes precedence over archive members.
            function_index.setdefault(function, module)
    return function_index
