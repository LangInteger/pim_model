"""Timing of a statically derived DRAM command stream under the PIMSimulator
memory-controller rules.

This is the HBM-PIM instantiation of the PIMSA cost model's memory and buffer
terms. The analyzer derives each PU's column-command stream (direction, bank,
row, column, barrier) statically from the kernel source; this module charges
it time. It does not run the simulator, execute PIM instructions, or look at
data. Its only inputs are the command stream, the architecture's timing
parameters, and the controller's issue rules. Every delay is either a timing
parameter of the device ini or a derived delay of Configuration.h, and every
rule below cites the PIMSimulator source line that enforces it (paths
relative to papers/pim/artifacts/Samsung_PIMSimulator/src).

Constraint table (who waits on whom, and for how long):

  edge                      delay                          enforced at
  ACT  -> RD   same bank    tRCDRD - AL                    MemoryController.cpp ACTIVATE case
  ACT  -> WR   same bank    tRCDWR - AL                    "
  ACT  -> PRE  same bank    tRAS                           "
  ACT  -> ACT  same bank    tRC                            "
  ACT  -> ACT  other bank   tRRD_L (same BG) / tRRD_S      "
  RD   -> RD   same rank    max(tCCD_L|tCCD_S, BL/2)       READ case
  RD   -> WR   same rank    RL + BL/2 + tRTRS - WL         READ case, Configuration.h READ_TO_WRITE_DELAY
  RD   -> PRE  same bank    AL + BL/2 + max(tRTP_L,tCCD_L) - tCCD_L   READ_TO_PRE_DELAY
  WR   -> WR   same rank    max(tCCD_L|tCCD_S, BL/2)       WRITE case
  WR   -> RD   same rank    WL + BL/2 + tWTR_L             WRITE case, WRITE_TO_READ_DELAY_B_LONG
  WR   -> PRE  same bank    WL + BL/2 + tWR                WRITE_TO_PRE_DELAY
  PRE  -> ACT  same bank    tRP                            PRECHARGE case
  REF  -> ACT  all banks    tRFC                           REF case
  RD/WR -> RD/WR other rank BL/2 + tRTRS, WRITE_TO_READ_DELAY_R   READ/WRITE cases
  any  -> any  channel      tCMD (one command per cycle)   MemoryController::update, one pop

Not enforced by this controller, hence no term: tFAW (CommandQueue.cpp keeps
tXAWCountdown but never pushes to it), tWTR_S (WRITE uses _B_LONG for every
bank), data-bus occupancy (checked only as an error), and power-down
(USE_LOW_POWER is read but never acted on).

Issue rules (CommandQueue.cpp):
  * pop(): refresh first, then column/ACT commands, then eager precharge.
  * process_command(): scan the rank queue in order; a packet is a candidate
    only if no earlier packet carries BAR (and none has the same address); a
    BAR-tagged packet issues only at the queue head. If no column command can
    issue, ACT the first packet (before the first non-head BAR) whose bank is
    Idle.
  * process_precharge(): round-robin over (rank, bank); close a RowActive bank
    if no packet up to and including the first BAR references its open row.
  * process_refresh(): when a rank's refresh is due, precharge its open banks,
    then REF. Due times (MemoryController.cpp constructor/updateRefresh):
    rank r first at (tREFI / NUM_RANKS) * (r + 1), then every tREFI.
  * Front end: one transaction is decoded into the command queue per cycle
    (updateTransactionQueue), after the pop of that cycle; queue depth
    CMD_QUEUE_DEPTH.
  * Bank state Precharging/Refreshing becomes Idle tRP/tRFC cycles after the
    command (updateBankState).
  * All-bank mode: CommandQueue::isIssuable refuses ACT to bank >= 2 while the
    rank is not in single-bank (SB) mode. Rank.cpp receiveFromBus switches
    SB -> all-bank when it has received ACT(row PIM_ABMR_RA, col 0x1f) on banks
    0, 1, 8 and 9, and all-bank -> SB on PRE(row PIM_SBMR_RA) to banks 0 and 1;
    the rank sees a command tCMD cycles after issue. (HAB vs HAB_PIM, set by a
    data write to the PIM_OP_MODE register, does not affect issue and is not
    tracked.)
Completion: a write leaves the controller WL + BL/2 cycles after issue, a read
returns tCMD + RL + BL/2 cycles after issue; PIMKernel::runPIM counts cycles
until no transaction is in flight, plus one (cycle_ is incremented before the
first update).
"""
from __future__ import annotations

from dataclasses import dataclass

RD, WR, ACT, PRE, REF = range(5)
NAMES = ["RD", "WR", "ACT", "PRE", "REF"]


@dataclass
class Cmd:
    write: bool
    rank: int
    bank: int  # flat bank index within the rank: bg * banks_per_bg + bank
    row: int
    col: int
    bar: bool = False


class _Bank:
    __slots__ = ("state", "row", "idle_at", "nxt", "cause")

    def __init__(self):
        self.state = "idle"
        self.row = None
        self.idle_at = 0
        self.nxt = [0, 0, 0, 0]  # earliest RD, WR, ACT, PRE
        self.cause = ["", "", "", ""]  # constraint that last raised each


def delays(t: dict) -> dict:
    """Derived delays, exactly as Configuration.h computes them."""
    al, bl2 = t["AL"], t["BL"] // 2
    return {
        "READ_TO_PRE": al + bl2 + max(t["tRTP_L"], t["tCCD_L"]) - t["tCCD_L"],
        "WRITE_TO_PRE": t["WL"] + bl2 + t["tWR"],
        "READ_TO_WRITE": t["RL"] + bl2 + t["tRTRS"] - t["WL"],
        "WRITE_TO_READ_B_LONG": t["WL"] + bl2 + t["tWTR_L"],
        "WRITE_TO_READ_R": max(t["WL"] + bl2 + t["tRTRS"] - t["RL"], 0),
    }


ABMR_RA, SBMR_RA = 0x27FF, 0x2FFF  # Configuration.h PIM_ABMR_RA / PIM_SBMR_RA


def schedule(cmds: list[Cmd], timing: dict, ranks: int, banks: int, banks_per_bg: int,
             queue_depth: int = 64, trace: list | None = None):
    """Issue times of `cmds` (one channel) under the controller rules.

    Returns (cycles, breakdown, counts): runPIM cycle count, cycles charged to
    each constraint (gap since the previous command on the channel, charged to
    the constraint that set the issued command's ready time), and DRAM command
    counts.
    """
    t_ = timing
    d = delays(t_)
    bl2 = t_["BL"] // 2
    B = [[_Bank() for _ in range(banks)] for _ in range(ranks)]
    same_bg = lambda a, b: a // banks_per_bg == b // banks_per_bg

    queue: list[Cmd] = []
    nxt_in = 0  # next command to decode
    rr_pre = [0, 0]  # process_precharge round-robin pointer (rank, bank)
    ref_due = [(t_["tREFI"] // ranks) * (r + 1) for r in range(ranks)]
    ref_rank = 0
    ref_wait = None  # rank waiting for refresh
    counts = [0] * 5
    breakdown: dict[str, int] = {}
    last_issue = 0
    done = 0
    t = 0
    sb_mode = [True] * ranks
    abmr = [set() for _ in range(ranks)]
    sbmr = [set() for _ in range(ranks)]
    mode_events = []  # (time the rank sees it, rank, new SB flag)

    def raise_(bk, f, val, why):
        if val > bk.nxt[f]:
            bk.nxt[f] = val
            bk.cause[f] = why

    def issuable(kind, r, b, row=None):
        bk = B[r][b]
        if kind == REF:
            return True
        if kind == ACT:
            if not sb_mode[r] and b >= 2:
                return False
            return bk.state in ("idle", "ref") and t >= bk.nxt[ACT]
        if kind == PRE:
            return bk.state == "active" and t >= bk.nxt[PRE]
        return bk.state == "active" and t >= bk.nxt[kind] and row == bk.row

    def issue(kind, r, b, row=None, col=None):
        nonlocal last_issue, done
        bk = B[r][b]
        gap = t - last_issue
        why = bk.cause[kind] if kind != REF and bk.nxt[kind] == t and bk.cause[kind] else None
        if why is None:
            why = "tCMD" if gap <= t_["tCMD"] else "order"
        breakdown[why] = breakdown.get(why, 0) + gap
        if trace is not None:
            trace.append((t, NAMES[kind], b, row if row is not None else bk.row, why, gap))
        last_issue = t
        counts[kind] += 1
        if kind in (RD, WR):
            for rr in range(ranks):
                for bb in range(banks):
                    o = B[rr][bb]
                    if rr != r:
                        if o.state == "active":
                            if kind == RD:
                                raise_(o, RD, t + bl2 + t_["tRTRS"], "tRTRS")
                                raise_(o, WR, t + d["READ_TO_WRITE"], "R2W")
                            else:
                                raise_(o, RD, t + d["WRITE_TO_READ_R"], "W2R_rank")
                                raise_(o, WR, t + bl2 + t_["tRTRS"], "tRTRS")
                        continue
                    sg = same_bg(bb, b)
                    ccd = max(t_["tCCD_L"] if sg else t_["tCCD_S"], bl2)
                    ccd_name = "tCCD_L" if sg else "tCCD_S"
                    if kind == RD:
                        raise_(o, RD, t + ccd, ccd_name)
                        raise_(o, WR, t + d["READ_TO_WRITE"], "R2W")
                    else:
                        raise_(o, RD, t + d["WRITE_TO_READ_B_LONG"], "W2R")
                        raise_(o, WR, t + ccd, ccd_name)
            if kind == RD:
                raise_(bk, PRE, t + d["READ_TO_PRE"], "tRTP")
                done = max(done, t + t_["tCMD"] + t_["RL"] + bl2)
            else:
                raise_(bk, PRE, t + d["WRITE_TO_PRE"], "tWR")
                done = max(done, t + t_["WL"] + bl2)
        elif kind == ACT:
            if sb_mode[r] and row == ABMR_RA and col == 0x1F and b in (0, 1, 8, 9):
                abmr[r].add(b)
                if len(abmr[r]) == (4 if banks > 2 else 2):
                    abmr[r].clear()
                    mode_events.append((t + t_["tCMD"], r, False))
            bk.state, bk.row = "active", row
            raise_(bk, ACT, t + t_["tRC"], "tRC")
            raise_(bk, PRE, t + t_["tRAS"], "tRAS")
            raise_(bk, RD, t + t_["tRCD_RD"] - t_["AL"], "tRCD_RD")
            raise_(bk, WR, t + t_["tRCD_WR"] - t_["AL"], "tRCD_WR")
            for bb in range(banks):
                if bb != b:
                    sg = same_bg(bb, b)
                    raise_(B[r][bb], ACT, t + (t_["tRRD_L"] if sg else t_["tRRD_S"]),
                           "tRRD_L" if sg else "tRRD_S")
        elif kind == PRE:
            if not sb_mode[r] and bk.row == SBMR_RA and b in (0, 1):
                sbmr[r].add(b)
                if len(sbmr[r]) == 2:
                    sbmr[r].clear()
                    mode_events.append((t + t_["tCMD"], r, True))
            bk.state, bk.idle_at = "pre", t + t_["tRP"]
            raise_(bk, ACT, t + t_["tRP"], "tRP")
        elif kind == REF:
            for o in B[r]:
                o.state, o.idle_at = "ref", t + t_["tRFC"]
                o.nxt[ACT], o.cause[ACT] = t + t_["tRFC"], "tRFC"

    def window():
        """Queue entries a scan may look at: up to and including the first BAR."""
        for i, c in enumerate(queue):
            yield i, c
            if c.bar:
                return

    def pop():
        nonlocal ref_wait
        # process_refresh
        if ref_wait is not None:
            r = ref_wait
            active = [b for b in range(banks) if B[r][b].state == "active"]
            for b in active:
                if issuable(PRE, r, b):
                    issue(PRE, r, b)
                    return True
            if not active:
                issue(REF, r, 0)
                ref_wait = None
                return True
        # process_command: column commands
        for i, c in enumerate(queue):
            kind = WR if c.write else RD
            if issuable(kind, c.rank, c.bank, c.row):
                if i != 0 and c.bar:
                    break
                dep = any(q.bar or (q.bank == c.bank and q.row == c.row and q.col == c.col)
                          for q in queue[:i])
                if not dep:
                    issue(kind, c.rank, c.bank, c.row)
                    queue.pop(i)
                    return True
        # process_command: activations
        for i, c in enumerate(queue):
            if i != 0 and c.bar:
                break
            if B[c.rank][c.bank].state == "idle" and issuable(ACT, c.rank, c.bank):
                issue(ACT, c.rank, c.bank, c.row, c.col)
                return True
        # process_precharge
        start = tuple(rr_pre)
        while True:
            r, b = rr_pre
            bk = B[r][b]
            found = any(c.rank == r and c.bank == b and bk.state == "active" and c.row == bk.row
                        for _, c in window())
            if not found and issuable(PRE, r, b):
                issue(PRE, r, b)
                return True
            rr_pre[0] += 1
            if rr_pre[0] == ranks:
                rr_pre[0] = 0
                rr_pre[1] = (rr_pre[1] + 1) % banks
            if tuple(rr_pre) == start:
                return False

    n = len(cmds)
    progress = col_seen = 0  # last cycle a column command issued or one was decoded
    while nxt_in < n or queue:
        # the rank decodes commands tCMD after issue (mode registers)
        for ev in [e for e in mode_events if e[0] <= t]:
            sb_mode[ev[1]] = ev[2]
            mode_events.remove(ev)
        # updateBankState
        for rk in B:
            for bk in rk:
                if bk.state in ("pre", "ref") and t >= bk.idle_at:
                    bk.state, bk.row = "idle", None
        # updateRefresh
        if t == ref_due[ref_rank]:
            ref_wait = ref_rank
            ref_due[ref_rank] = t + t_["tREFI"]
            ref_rank = (ref_rank + 1) % ranks
        issued = pop()
        decoded = False
        if nxt_in < n and len(queue) < queue_depth:
            queue.append(cmds[nxt_in])
            nxt_in += 1
            decoded = True
        if decoded or counts[RD] + counts[WR] != col_seen:
            progress, col_seen = t, counts[RD] + counts[WR]
        elif t - progress > 4 * t_["tREFI"]:
            raise RuntimeError(f"command stream cannot issue (stuck at t={t}, head={queue[0]})")
        if issued or decoded or ref_wait is not None:
            t += 1
            continue
        # Nothing can change until the next timer: skip ahead.
        future = [ref_due[ref_rank]] + [e[0] for e in mode_events]
        for rk in B:
            for bk in rk:
                future += [x for x in bk.nxt if x > t]
                if bk.state in ("pre", "ref") and bk.idle_at > t:
                    future.append(bk.idle_at)
        future = [x for x in future if x > t]
        t = min(future) if future else t + 1

    cycles = done + 1
    return cycles, breakdown, dict(zip(NAMES, counts))
