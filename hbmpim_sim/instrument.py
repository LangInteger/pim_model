#!/usr/bin/env python3
"""Bookkeeping-only instrumentation of PIMSimulator's MemoryController.cpp.

Nothing here changes timing or scheduling. It adds:
  * per-channel DRAM command counts by BusPacketType;
  * stall attribution. For every bank and every ready time the controller
    keeps (nextRead, nextWrite, nextActivate, nextPrecharge) we remember which
    timing constraint last raised it. When a command issues exactly at its
    bank's ready time, the gap since the previous command on that channel is
    charged to that constraint. Otherwise the gap is charged to "slot" (gap of
    one command-bus cycle, tCMD) or "other" (the command was held back by
    something that is not a bank timing constraint: queue order/BAR, front-end
    decode, row state).

Usage: instrument.py path/to/MemoryController.cpp
"""
import sys

HEADER = r"""#include <cstdint>
#include <vector>
#include <cstdio>
#include <cstdlib>
uint64_t pimsa_cmd_count[64][8];
// Cause ids; PIMSASweep.cpp prints names in this order.
enum { PC_NONE, PC_RCDRD, PC_RCDWR, PC_CCDL, PC_CCDS, PC_R2W, PC_W2R, PC_RTRS, PC_W2R_R,
       PC_RC, PC_RP, PC_RRDL, PC_RRDS, PC_RFC, PC_RTP, PC_WR, PC_RAS, PC_SLOT, PC_OTHER, PC_N };
uint64_t pimsa_gap[64][PC_N], pimsa_gapn[64][PC_N], pimsa_gap_by[64][8][PC_N];
uint64_t pimsa_last_issue[64], pimsa_mc_cycle[64];
static unsigned char pimsa_cause[64][64][4];  // [ch][rank*NUM_BANKS+bank][rd,wr,act,pre]
"""

PRE = r"""    pimsa_cmd_count[parentMemorySystem->systemID][poppedBusPacket->busPacketType]++;
    const unsigned pch = parentMemorySystem->systemID;
    const unsigned NB = config.NUM_BANKS;
    {
        const BusPacketType t = poppedBusPacket->busPacketType;
        const BankState& st = bankStates[poppedBusPacket->rank][poppedBusPacket->bank];
        int f = t == READ ? 0 : t == WRITE ? 1 : t == ACTIVATE ? 2 : t == PRECHARGE ? 3 : -1;
        uint64_t ready = f == 0 ? st.nextRead : f == 1 ? st.nextWrite
                       : f == 2 ? st.nextActivate : f == 3 ? st.nextPrecharge : 0;
        uint64_t gap = currentClockCycle - pimsa_last_issue[pch];
        int c = (f >= 0 && ready == currentClockCycle)
                    ? pimsa_cause[pch][poppedBusPacket->rank * NB + poppedBusPacket->bank][f]
                    : PC_NONE;
        if (c == PC_NONE) c = gap <= config.tCMD ? PC_SLOT : PC_OTHER;
        pimsa_gap[pch][c] += gap;
        pimsa_gapn[pch][c]++;
        pimsa_gap_by[pch][t < 8 ? t : 7][c] += gap;
        pimsa_last_issue[pch] = currentClockCycle;
        static const char* tr = getenv("PIMSA_TRACE");
        if (tr && pch == 0)
            fprintf(stderr, "T %llu %d %u %u %u %d %llu %s\n",
                    (unsigned long long)currentClockCycle, (int)t, poppedBusPacket->bank,
                    poppedBusPacket->row, poppedBusPacket->column, c, (unsigned long long)gap,
                    poppedBusPacket->tag.c_str());
    }
    std::vector<BankState> pimsa_old;
    for (size_t r = 0; r < config.NUM_RANKS; r++)
        for (size_t b = 0; b < NB; b++) pimsa_old.push_back(bankStates[r][b]);
"""

POST = r"""    {
        const BusPacketType t = poppedBusPacket->busPacketType;
        const unsigned R = poppedBusPacket->rank, B = poppedBusPacket->bank;
        for (size_t r = 0; r < config.NUM_RANKS; r++)
            for (size_t b = 0; b < NB; b++)
            {
                const BankState& o = pimsa_old[r * NB + b];
                const BankState& n = bankStates[r][b];
                const bool sr = r == R, sb = sr && b == B, sg = sr && am.isSameBankgroup(b, B);
                unsigned char* c = pimsa_cause[pch][r * NB + b];
                int cr = PC_NONE, cw = PC_NONE, ca = PC_NONE, cp = PC_NONE;
                if (t == READ)
                {
                    cr = !sr ? PC_RTRS : sg ? PC_CCDL : PC_CCDS;
                    cw = PC_R2W;
                    cp = PC_RTP;
                }
                if (t == WRITE)
                {
                    cr = !sr ? PC_W2R_R : PC_W2R;
                    cw = !sr ? PC_RTRS : sg ? PC_CCDL : PC_CCDS;
                    cp = PC_WR;
                }
                if (t == ACTIVATE)
                {
                    cr = PC_RCDRD;
                    cw = PC_RCDWR;
                    ca = sb ? PC_RC : sg ? PC_RRDL : PC_RRDS;
                    cp = PC_RAS;
                }
                if (t == PRECHARGE) ca = PC_RP;
                if (t == REF) ca = PC_RFC;
                if (n.nextRead > o.nextRead) c[0] = cr;
                if (n.nextWrite > o.nextWrite) c[1] = cw;
                if (n.nextActivate > o.nextActivate) c[2] = ca;
                if (n.nextPrecharge > o.nextPrecharge) c[3] = cp;
            }
    }
"""


def patch(s: str) -> str:
    anchor = "void MemoryController::updateCommandQueue(BusPacket* poppedBusPacket)\n{\n"
    post_anchor = "    // issue on bus and print debug\n"
    up = "void MemoryController::update()\n{\n"
    for a in (anchor, post_anchor, up):
        assert s.count(a) == 1, a
    s = s.replace(anchor, anchor + PRE)
    s = s.replace(post_anchor, POST + post_anchor)
    s = s.replace(up, up + "    pimsa_mc_cycle[parentMemorySystem->systemID] = currentClockCycle;\n")
    return HEADER + s


if __name__ == "__main__":
    p = sys.argv[1]
    src = open(p).read()
    open(p, "w").write(patch(src))
