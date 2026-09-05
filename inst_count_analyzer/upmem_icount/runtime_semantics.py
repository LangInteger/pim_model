from __future__ import annotations

import ast
import re
from pathlib import Path

from .generic_cfg import Bound, add_bounds


COLLECTIVE_RUNTIME_PRIMITIVES = frozenset({"barrier_wait"})


def is_collective_runtime_primitive(function: str) -> bool:
    return function in COLLECTIVE_RUNTIME_PRIMITIVES


def _function_body(source: str, function: str) -> str | None:
    match = re.search(rf"\b{re.escape(function)}\s*\([^;]*?\)\s*\{{", source, re.S)
    if not match:
        return None
    start = match.end() - 1
    depth = 0
    for index in range(start, len(source)):
        if source[index] == "{":
            depth += 1
        elif source[index] == "}":
            depth -= 1
            if depth == 0:
                return source[start + 1 : index]
    return None


def _inline_asm_path_bound(source_path: Path, function: str) -> Bound | None:
    """Derive min/max executed instructions inside one acyclic inline asm body."""
    body = _function_body(source_path.read_text(errors="replace"), function)
    if body is None:
        return None
    asm = re.search(r"__asm__\s+volatile\s*\((.*?)\)\s*;", body, re.S)
    if asm is None:
        return None
    # Only the leading adjacent string literals form the assembly template;
    # quoted output/input constraints (for example ``"=r"``) are not code.
    template = re.match(
        r'\s*((?:"(?:\\.|[^"\\])*"\s*)+)', asm.group(1), re.S
    )
    literals = (
        re.findall(r'"(?:\\.|[^"\\])*"', template.group(1))
        if template
        else []
    )
    if not literals:
        return None
    try:
        text = "".join(ast.literal_eval(literal) for literal in literals)
    except (SyntaxError, ValueError):
        return None

    instructions: list[str] = []
    labels: dict[str, int] = {}
    for raw in text.splitlines():
        line = raw.strip()
        if not line:
            continue
        if line.endswith(":"):
            labels[line[:-1]] = len(instructions)
        else:
            instructions.append(line)
    if not instructions:
        return None

    def target_of(line: str) -> int | None:
        token = line.rsplit(",", 1)[-1].strip().split()[-1]
        return labels.get(token)

    successors: dict[int, list[int]] = {}
    for index, line in enumerate(instructions):
        opcode = line.split(None, 1)[0]
        fallthrough = index + 1 if index + 1 < len(instructions) else None
        target = target_of(line)
        if opcode == "jump":
            next_nodes = [target] if target is not None else []
        elif opcode.startswith("j") or opcode == "mul_step":
            next_nodes = [node for node in (target, fallthrough) if node is not None]
        elif opcode == "move" and re.search(r",\s*true\s*,", line):
            next_nodes = [target] if target is not None else []
        else:
            next_nodes = [fallthrough] if fallthrough is not None else []
        successors[index] = list(dict.fromkeys(next_nodes))

    visiting: set[int] = set()
    cache: dict[int, tuple[int, int]] = {}

    def path(node: int) -> tuple[int, int]:
        if node in cache:
            return cache[node]
        if node in visiting:
            raise ValueError("cyclic inline assembly is not supported")
        visiting.add(node)
        tails = [path(successor) for successor in successors[node]]
        visiting.remove(node)
        result = (
            (1, 1)
            if not tails
            else (1 + min(x[0] for x in tails), 1 + max(x[1] for x in tails))
        )
        cache[node] = result
        return result

    try:
        lower, upper = path(0)
    except ValueError:
        return None
    return Bound(float(lower), float(upper))


def runtime_function_instruction_bound(
    function: str, source_path: Path | None, mir_direct: Bound
) -> tuple[Bound, dict | None]:
    """Replace a one-instruction INLINEASM pseudo with its real path cost."""
    if function != "__mulsi3" or source_path is None:
        return mir_direct, None
    inline = _inline_asm_path_bound(source_path, function)
    if inline is None:
        return mir_direct, None
    # Late MIR charges one instruction for the INLINEASM_BR pseudo.  The
    # independently compiled routine has one additional return instruction.
    adjusted = Bound(
        None if mir_direct.lower is None else mir_direct.lower + inline.lower - 1,
        None if mir_direct.upper is None else mir_direct.upper + inline.upper - 1,
    )
    return adjusted, {
        "kind": "inline_asm_path_expansion",
        "source": str(source_path),
        "inline_asm_bound": inline.to_dict(),
        "mir_placeholder_instructions": 1,
    }


def scale_bound(bound: Bound, count: int) -> Bound:
    if count < 0:
        raise ValueError("count must be non-negative")
    return Bound(
        None if bound.lower is None else bound.lower * count,
        None if bound.upper is None else bound.upper * count,
    )


def barrier_generation_bound(
    participants: int,
    nonlast_path: Bound,
    last_path: Bound,
) -> Bound:
    """Combine CFG/MIR-derived paths for one complete barrier generation.

    The path bounds must come from the independently compiled barrier runtime
    translation unit. This function deliberately does not guess either cost.
    """
    if participants < 1:
        raise ValueError("a barrier generation needs at least one participant")
    return add_bounds(scale_bound(nonlast_path, participants - 1), last_path)
