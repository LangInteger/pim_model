// Bandwidth microbenchmark for the bandwidth-based baseline (PrIM-style alpha + beta * s).
//
// Copied into the simulator's src/tests/ by build.sh. Independent of the four
// evaluated kernels: it issues N transfers of K column commands each and
// prints the cycles they take, so that the per-transfer cost can be fitted as
// alpha + beta * bytes, as PrIM does for UPMEM's mram_read/mram_write.
//
// A transfer is K consecutive column commands to one row; transfer t uses
// row ROW0 + t, so every transfer opens a new row. With PIMSA_MB_BAR=1 (the
// default) a barrier follows every transfer, i.e., a transfer is blocking,
// like a DPU's mram_read.
//
// Environment:
//   PIMSA_MB_MODE  MEM_RD | MEM_WR  all-bank mode (HAB): one command moves
//                                    P x 32 B between the banks and the PIM
//                                    blocks of a pseudo-channel
//                  BUS_RD | BUS_WR  single-bank mode (SB): one command moves
//                                    32 B over the channel bus, to bank 0
//   PIMSA_MB_K     column commands per transfer (1..32)
//   PIMSA_MB_N     transfers
//   PIMSA_MB_BAR   1: barrier after every transfer (default); 0: none
//
// Only channel 0 is used. The mode change (SB -> HAB) is run and timed
// separately before the measured region, so the printed cycles cover the
// transfers alone:
//   PIMSA_MICRO {"mode":"MEM_RD","k":..,"n":..,"bar":..,"cycles":..,"ch0":{...}}

#include <cstdlib>
#include <cstring>
#include <iostream>
#include <memory>
#include <string>

#include "gtest/gtest.h"
#include "tests/PIMKernel.h"
#include "tests/TestCases.h"

extern uint64_t pimsa_cmd_count[64][8];

using namespace DRAMSim;
using namespace std;

static unsigned mbEnv(const char* k, unsigned dflt)
{
    const char* v = getenv(k);
    return v ? (unsigned)strtoul(v, nullptr, 10) : dflt;
}

TEST(PIMSAMicro, run)
{
    const char* mv = getenv("PIMSA_MB_MODE");
    string mode = mv ? mv : "MEM_RD";
    unsigned K = mbEnv("PIMSA_MB_K", 8), N = mbEnv("PIMSA_MB_N", 64);
    bool bar = mbEnv("PIMSA_MB_BAR", 1) != 0;
    bool mem_side = mode.rfind("MEM_", 0) == 0;
    bool is_write = mode == "MEM_WR" || mode == "BUS_WR";
    const unsigned ROW0 = 0x100;

    auto mem = make_shared<MultiChannelMemorySystem>(
        "ini/HBM2_samsung_2M_16B_x64.ini", "system_hbm_64ch.ini", ".", "example_app", 256 * 64 * 2);
    auto kernel = make_shared<PIMKernel>(mem, 1, 1);
    auto addr_mgr = make_shared<PIMAddrManager>(1, 1);
    BurstType bst;

    // Setup, not measured: enter all-bank mode for the MEM_* transfers.
    if (mem_side)
    {
        kernel->parkIn();
        kernel->changePIMMode(dramMode::SB, dramMode::HAB);
    }
    kernel->addBarrier();
    kernel->runPIM();
    uint64_t c0 = kernel->getCycle();
    uint64_t base[8];
    memcpy(base, pimsa_cmd_count[0], sizeof(base));

    for (unsigned t = 0; t < N; t++)
    {
        if (mem_side)
            kernel->addTransactionAll(is_write, 0, 0, ROW0 + t, 0, "MB", &bst, bar, K);
        else
        {
            for (unsigned c = 0; c < K; c++)
            {
                unsigned row = ROW0 + t, col = c;
                mem->addTransaction(is_write, addr_mgr->addrGenSafe(0, 0, 0, 0, row, col), &bst);
            }
            if (bar) mem->addBarrier(0);
        }
    }
    kernel->runPIM();
    uint64_t cycles = kernel->getCycle() - c0;

    const uint64_t* c = pimsa_cmd_count[0];
    cout << "PIMSA_MICRO {\"mode\":\"" << mode << "\",\"k\":" << K << ",\"n\":" << N
         << ",\"bar\":" << bar << ",\"cycles\":" << cycles << ",\"ch0\":{\"rd\":" << c[0] - base[0]
         << ",\"wr\":" << c[1] - base[1] << ",\"act\":" << c[2] - base[2]
         << ",\"pre\":" << c[3] - base[3] << ",\"ref\":" << c[4] - base[4] << "}}" << endl;
}
