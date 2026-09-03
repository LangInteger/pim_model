#include "Analyzer.h"
#include <sstream>
#include <algorithm>

static std::string addStr(const std::string& a, const std::string& b) {
    if (a == "0") return b;
    if (b == "0") return a;
    try { return std::to_string(std::stoll(a) + std::stoll(b)); }
    catch(...) { return "(" + a + " + " + b + ")"; }
}

static std::string maxStr(const std::string& a, const std::string& b) {
    if (a == "0") return b;
    if (b == "0") return a;
    try { return std::to_string(std::max(std::stoll(a), std::stoll(b))); }
    catch(...) { return "max(" + a + ", " + b + ")"; }
}

static std::string pathChoiceStr(const std::string& a, const std::string& b) {
    if (a == b) return a;
    return "path(" + a + ", " + b + ")";
}

static std::string mulStr(const std::string& a, const std::string& b) {
    if (a == "0" || b == "0") return "0";
    if (a == "1") return b;
    if (b == "1") return a;
    try { return std::to_string(std::stoll(a) * std::stoll(b)); }
    catch(...) { return "(" + a + " * " + b + ")"; }
}

FeatureDomain& FeatureDomain::operator+=(const FeatureDomain& other) {
    launches = addStr(launches, other.launches);
    waits = addStr(waits, other.waits);
    h2d_bytes = addStr(h2d_bytes, other.h2d_bytes);
    d2h_bytes = addStr(d2h_bytes, other.d2h_bytes);
    arith_ops = addStr(arith_ops, other.arith_ops);
    mram_read = addStr(mram_read, other.mram_read);
    mram_read_tx = addStr(mram_read_tx, other.mram_read_tx);
    mram_write = addStr(mram_write, other.mram_write);
    mram_write_tx = addStr(mram_write_tx, other.mram_write_tx);
    barriers = addStr(barriers, other.barriers);
    mutexes = addStr(mutexes, other.mutexes);
    semaphores = addStr(semaphores, other.semaphores);
    atomics = addStr(atomics, other.atomics);
    if (!other.assumptions.empty()) {
        if (!assumptions.empty()) assumptions += "; ";
        assumptions += other.assumptions;
    }
    return *this;
}

FeatureDomain FeatureDomain::operator+(const FeatureDomain& other) const {
    FeatureDomain result = *this;
    result += other;
    return result;
}

FeatureDomain FeatureDomain::max(const FeatureDomain& a, const FeatureDomain& b) {
    FeatureDomain res;
    res.launches = maxStr(a.launches, b.launches);
    res.waits = maxStr(a.waits, b.waits);
    res.h2d_bytes = maxStr(a.h2d_bytes, b.h2d_bytes);
    res.d2h_bytes = maxStr(a.d2h_bytes, b.d2h_bytes);
    res.arith_ops = maxStr(a.arith_ops, b.arith_ops);
    res.mram_read = maxStr(a.mram_read, b.mram_read);
    res.mram_read_tx = maxStr(a.mram_read_tx, b.mram_read_tx);
    res.mram_write = maxStr(a.mram_write, b.mram_write);
    res.mram_write_tx = maxStr(a.mram_write_tx, b.mram_write_tx);
    res.barriers = maxStr(a.barriers, b.barriers);
    res.mutexes = maxStr(a.mutexes, b.mutexes);
    res.semaphores = maxStr(a.semaphores, b.semaphores);
    res.atomics = maxStr(a.atomics, b.atomics);
    res.assumptions = a.assumptions;
    if (!b.assumptions.empty()) {
        if (!res.assumptions.empty()) res.assumptions += " | ";
        res.assumptions += b.assumptions;
    }
    return res;
}

FeatureDomain FeatureDomain::memoryPathChoice(const FeatureDomain& a,
                                              const FeatureDomain& b) {
    FeatureDomain res = FeatureDomain::max(a, b);
    res.mram_read = pathChoiceStr(a.mram_read, b.mram_read);
    res.mram_read_tx = pathChoiceStr(a.mram_read_tx, b.mram_read_tx);
    res.mram_write = pathChoiceStr(a.mram_write, b.mram_write);
    res.mram_write_tx = pathChoiceStr(a.mram_write_tx, b.mram_write_tx);
    return res;
}

FeatureDomain FeatureDomain::multiply(const std::string& bound) {
    FeatureDomain res = *this;
    if (bound == "1") return res;
    
    res.launches = mulStr(res.launches, bound);
    res.waits = mulStr(res.waits, bound);
    res.h2d_bytes = mulStr(res.h2d_bytes, bound);
    res.d2h_bytes = mulStr(res.d2h_bytes, bound);
    res.arith_ops = mulStr(res.arith_ops, bound);
    res.mram_read = mulStr(res.mram_read, bound);
    res.mram_read_tx = mulStr(res.mram_read_tx, bound);
    res.mram_write = mulStr(res.mram_write, bound);
    res.mram_write_tx = mulStr(res.mram_write_tx, bound);
    res.barriers = mulStr(res.barriers, bound);
    res.mutexes = mulStr(res.mutexes, bound);
    res.semaphores = mulStr(res.semaphores, bound);
    res.atomics = mulStr(res.atomics, bound);
    return res;
}

void FeatureDomain::printCSV(std::ostream& os) const {
    os << launches << "," << waits << "," << h2d_bytes << "," << d2h_bytes << "," 
       << arith_ops << "," << mram_read << "," << mram_read_tx << "," << mram_write << "," << mram_write_tx << "," 
       << barriers << "," << mutexes << "," << semaphores << "," << atomics << ",\"" << assumptions << "\"";
}

void FeatureDomain::printMarkdown(std::ostream& os) const {
    os << "| " << launches << " | " << waits << " | " << h2d_bytes << " | " << d2h_bytes << " | " 
       << arith_ops << " | " << mram_read << " | " << mram_read_tx << " | " << mram_write << " | " << mram_write_tx << " | " 
       << barriers << " | " << mutexes << " | " << semaphores << " | " << atomics << " | " << assumptions << " |";
}

void FeatureDomain::printJSON(std::ostream& os) const {
    os << "{\n"
       << "      \"launches\": \"" << launches << "\",\n"
       << "      \"waits\": \"" << waits << "\",\n"
       << "      \"h2d_bytes\": \"" << h2d_bytes << "\",\n"
       << "      \"d2h_bytes\": \"" << d2h_bytes << "\",\n"
       << "      \"arith_ops\": \"" << arith_ops << "\",\n"
       << "      \"mram_read\": \"" << mram_read << "\",\n"
       << "      \"mram_read_tx\": \"" << mram_read_tx << "\",\n"
       << "      \"mram_write\": \"" << mram_write << "\",\n"
       << "      \"mram_write_tx\": \"" << mram_write_tx << "\",\n"
       << "      \"barriers\": \"" << barriers << "\",\n"
       << "      \"mutexes\": \"" << mutexes << "\",\n"
       << "      \"semaphores\": \"" << semaphores << "\",\n"
       << "      \"atomics\": \"" << atomics << "\",\n"
       << "      \"assumptions\": \"" << assumptions << "\"\n"
       << "    }";
}
