// Uninstrumented timing driver: same kernel setup and timed region as PIMSASweep.
#include <chrono>
#include <cstdlib>
#include <iostream>
#include <memory>
#include <string>
#include "gtest/gtest.h"
#include "tests/PIMKernel.h"
#include "tests/TestCases.h"
using namespace DRAMSim;
using namespace std;
static unsigned envU(const char* k, unsigned d) { const char* v = getenv(k); return v ? (unsigned)strtoul(v, nullptr, 10) : d; }
TEST(PIMSATime, run)
{
    auto t0 = chrono::steady_clock::now();
    const char* kv = getenv("PIMSA_KERNEL");
    string kname = kv ? kv : "GEMV";
    KernelType k = kname == "GEMV" ? KernelType::GEMV : kname == "ADD" ? KernelType::ADD
                 : kname == "MUL" ? KernelType::MUL : KernelType::RELU;
    unsigned out = envU("PIMSA_OUT", 4096), in = envU("PIMSA_IN", 4096);
    unsigned batch = envU("PIMSA_BATCH", 1), chans = envU("PIMSA_CHANS", 64);
    auto mem = make_shared<MultiChannelMemorySystem>("ini/HBM2_samsung_2M_16B_x64.ini", "system_hbm_64ch.ini", ".", "example_app", 256 * 64 * 2);
    auto kernel = make_shared<PIMKernel>(mem, chans, 1);
    DataDim dim(k, batch, out, in, false);
    auto t1 = chrono::steady_clock::now();
    if (k == KernelType::GEMV) kernel->executeGemv(&dim.weight_npbst_, &dim.input_npbst_, false);
    else kernel->executeEltwise(dim.output_npbst_.getTotalDim(), pimBankType::ALL_BANK, k, 0, 256, k == KernelType::RELU ? 0 : 128);
    kernel->runPIM();
    auto t2 = chrono::steady_clock::now();
    cout << "PIMSA_TIME " << kernel->getCycle() << " " << chrono::duration<double>(t2 - t1).count()
         << " " << chrono::duration<double>(t2 - t0).count() << endl;
}
