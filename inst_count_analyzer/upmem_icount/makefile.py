from __future__ import annotations

import re
from pathlib import Path
from dataclasses import dataclass

_VAR_RE = re.compile(r"^\s*([A-Za-z_][A-Za-z0-9_]*)\s*(?:\?=|:=|=)\s*(.*?)\s*$")

@dataclass
class MakefileInfo:
    benchmark: str
    path: Path
    variables: dict[str, str]

    @property
    def dpu_target(self) -> str | None:
        return self.variables.get("DPU_TARGET")

    @property
    def default_tasklets(self) -> int | None:
        raw = self.variables.get("NR_TASKLETS")
        try:
            return int(raw) if raw is not None else None
        except ValueError:
            return None

    @property
    def dpu_flags(self) -> str | None:
        return self.variables.get("DPU_FLAGS")


def parse_makefile(path: Path) -> MakefileInfo:
    variables: dict[str, str] = {}
    for line in path.read_text(errors="replace").splitlines():
        m = _VAR_RE.match(line)
        if not m:
            continue
        key, val = m.groups()
        # Keep only direct textual definitions. This is enough for discovery/reporting;
        # make itself remains the source of truth for actual builds.
        variables[key] = val.strip()
    return MakefileInfo(path.parent.name, path, variables)
