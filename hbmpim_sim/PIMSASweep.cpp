// PIMSA ground-truth driver for Samsung PIMSimulator.
//
// Copied into the simulator's src/tests/ by build.sh. Measures exactly the
// same timed region as the vendor PIMBenchFixture (executeGemv/executeEltwise
// + runPIM), but for a shape/channel configuration given by environment
// variables, and prints one machine-readable line:
//   PIMSA_RESULT {"kernel":"GEMV","out":...,"in":...,"batch":...,"chans":...,"cycles":...}
//
// Environment: PIMSA_KERNEL in {GEMV, ADD, MUL, RELU}; PIMSA_OUT, PIMSA_IN,
// PIMSA_BATCH (default 1), PIMSA_CHANS (PIM channels used, default 64).

#include <cstdlib>
#include <iostream>
#include <memory>
#include <string>

#include "gtest/gtest.h"
#include "tests/PIMKernel.h"
#include "tests/TestCases.h"

extern uint64_t pimsa_cmd_count[64][8];

using namespace DRAMSim;
using namespace std;

static unsigned envU(const char* k, unsigned dflt)
{
    const char* v = getenv(k);
    return v ? (unsigned)strtoul(v, nullptr, 10) : dflt;
}

TEST(PIMSASweep, run)
{
    const char* kv = getenv("PIMSA_KERNEL");
    string kname = kv ? kv : "GEMV";
    KernelType k = kname == "GEMV"  ? KernelType::GEMV
                   : kname == "ADD" ? KernelType::ADD
                   : kname == "MUL" ? KernelType::MUL
                                    : KernelType::RELU;
    unsigned out = envU("PIMSA_OUT", 4096), in = envU("PIMSA_IN", 4096);
    unsigned batch = envU("PIMSA_BATCH", 1), chans = envU("PIMSA_CHANS", 64);

    auto mem = make_shared<MultiChannelMemorySystem>(
        "ini/HBM2_samsung_2M_16B_x64.ini", "system_hbm_64ch.ini", ".", "example_app", 256 * 64 * 2);
    auto kernel = make_shared<PIMKernel>(mem, chans, 1);
    DataDim dim(k, batch, out, in, false);

    if (k == KernelType::GEMV)
        kernel->executeGemv(&dim.weight_npbst_, &dim.input_npbst_, false);
    else
        kernel->executeEltwise(dim.output_npbst_.getTotalDim(), pimBankType::ALL_BANK, k, 0, 256,
                               k == KernelType::RELU ? 0 : 128);
    kernel->runPIM();

    // Channel-0 DRAM command counts (instrumented in MemoryController by build.sh).
    const uint64_t* c = pimsa_cmd_count[0];
    cout << "PIMSA_RESULT {\"kernel\":\"" << kname << "\",\"out\":" << out << ",\"in\":" << in
         << ",\"batch\":" << batch << ",\"chans\":" << chans
         << ",\"cycles\":" << kernel->getCycle() << ",\"ch0\":{\"rd\":" << c[0]
         << ",\"wr\":" << c[1] << ",\"act\":" << c[2] << ",\"pre\":" << c[3] << ",\"ref\":" << c[4]
         << "}}" << endl;
}
