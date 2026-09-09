from __future__ import annotations

import ast
import re
from pathlib import Path

from .generic_cfg import Bound, MachineBlock, add_bounds, solve_machine_total


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


def _has_opcode(block: MachineBlock, opcode: str) -> bool:
    return any(
        instruction.split(None, 1)[0] == opcode
        for instruction in block.assembly_instructions
        if instruction
    )


def _cyclic_machine_blocks(blocks: list[MachineBlock]) -> set[int]:
    by_number = {block.number: block for block in blocks}

    def reaches_self(start: int) -> bool:
        pending = list(by_number[start].successors)
        seen: set[int] = set()
        while pending:
            number = pending.pop()
            if number == start:
                return True
            if number in seen or number not in by_number:
                continue
            seen.add(number)
            pending.extend(by_number[number].successors)
        return False

    return {block.number for block in blocks if reaches_self(block.number)}


def barrier_runtime_path_bounds(
    blocks: list[MachineBlock], participants: int
) -> tuple[Bound, Bound, dict]:
    """Extract non-last and last ``barrier_wait`` paths from its Machine CFG.

    The SDK implementation has one stop path for each non-last participant.
    The last participant resumes the circular wait queue: one final resume and
    ``participants - 2`` executions of the cyclic resume block.  We constrain
    those architectural operations in the ordinary machine-flow LP, so all
    instruction costs still come from final emitted MCInsts.
    """
    if participants < 1:
        raise ValueError("a barrier generation needs at least one participant")
    stop_blocks = [block for block in blocks if _has_opcode(block, "stop")]
    resume_blocks = [block for block in blocks if _has_opcode(block, "resume")]
    if len(stop_blocks) != 1:
        raise ValueError(
            "barrier_wait Machine CFG must contain exactly one stop block"
        )

    cyclic = _cyclic_machine_blocks(blocks)
    cyclic_resume = [block for block in resume_blocks if block.number in cyclic]
    final_resume = [block for block in resume_blocks if block.number not in cyclic]
    if participants > 1 and (len(cyclic_resume) != 1 or len(final_resume) != 1):
        raise ValueError(
            "barrier_wait Machine CFG must contain one cyclic and one final "
            "resume block"
        )

    nonlast_constraints = {
        stop_blocks[0].number: Bound(1, 1),
        **{block.number: Bound(0, 0) for block in resume_blocks},
    }
    nonlast, _, nonlast_meta = solve_machine_total(
        blocks,
        {},
        bound_block_numbers=set(),
        machine_block_bounds=nonlast_constraints,
    )

    last_constraints = {stop_blocks[0].number: Bound(0, 0)}
    for block in resume_blocks:
        executions = (
            participants - 2
            if block.number in cyclic
            else 1
        ) if participants > 1 else 0
        last_constraints[block.number] = Bound(executions, executions)
    last, _, last_meta = solve_machine_total(
        blocks,
        {},
        bound_block_numbers=set(),
        machine_block_bounds=last_constraints,
    )
    if nonlast.lower is None or nonlast.upper is None:
        raise ValueError("non-last barrier path is infeasible or unbounded")
    if last.lower is None or last.upper is None:
        raise ValueError("last barrier path is infeasible or unbounded")

    return nonlast, last, {
        "kind": "barrier_generation_machine_cfg",
        "participants": participants,
        "stop_blocks": [block.key for block in stop_blocks],
        "cyclic_resume_blocks": [block.key for block in cyclic_resume],
        "final_resume_blocks": [block.key for block in final_resume],
        "nonlast_machine_flow": nonlast_meta,
        "last_machine_flow": last_meta,
    }


def fair_round_robin_retry_bound(
    successful_acquires: Bound,
    holder_instruction_bound: Bound,
    participants: int,
) -> tuple[Bound, dict]:
    """Bound failed acquire attempts under the DPU revolver scheduler.

    Between two instructions issued by a lock holder, every other runnable
    tasklet can issue at most one attempt.  Charging every instruction in the
    enclosing lock-holding routine (including instructions outside the actual
    critical section) therefore gives a conservative upper bound.  The lower
    bound is zero because an acquire may succeed without contention.
    """
    if participants < 1:
        raise ValueError("participants must be positive")
    upper = None
    if successful_acquires.upper is not None and holder_instruction_bound.upper is not None:
        upper = (
            successful_acquires.upper
            * max(participants - 1, 0)
            * holder_instruction_bound.upper
        )
    bound = Bound(0.0, upper)
    return bound, {
        "kind": "fair_round_robin_atomic_retry",
        "assumption": (
            "fair DPU revolver scheduling; a runnable contender issues at most "
            "one failed acquire per instruction issued by the lock holder"
        ),
        "participants": participants,
        "successful_acquires": successful_acquires.to_dict(),
        "holder_instruction_bound": holder_instruction_bound.to_dict(),
    }


def barrier_generation_retry_bound(
    nonlast_holder_bound: Bound, participants: int
) -> tuple[Bound, dict]:
    """Bound failed acquires while one barrier generation drains contenders."""
    if participants < 1:
        raise ValueError("participants must be positive")
    # Before each non-last participant stops, the maximum numbers of other
    # runnable contenders are T-1, T-2, ..., 1.  The last participant has no
    # remaining contender while it walks the wait queue.
    contender_holder_pairs = participants * (participants - 1) // 2
    upper = (
        None
        if nonlast_holder_bound.upper is None
        else contender_holder_pairs * nonlast_holder_bound.upper
    )
    return Bound(0.0, upper), {
        "kind": "fair_round_robin_barrier_atomic_retry",
        "assumption": (
            "fair DPU revolver scheduling; stopped non-last participants no "
            "longer contend, and each remaining contender issues at most one "
            "failed acquire per instruction issued by the lock holder"
        ),
        "participants": participants,
        "contender_holder_pairs": contender_holder_pairs,
        "nonlast_holder_bound": nonlast_holder_bound.to_dict(),
    }
