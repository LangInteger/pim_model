#ifndef ANALYZER_H
#define ANALYZER_H

#include <string>
#include <vector>
#include <map>
#include <iostream>

struct FeatureDomain {
    std::string launches = "0";
    std::string waits = "0";
    std::string h2d_bytes = "0";
    std::string d2h_bytes = "0";
    std::string arith_ops = "0";
    std::string mram_read = "0";
    std::string mram_read_tx = "0";
    std::string mram_write = "0";
    std::string mram_write_tx = "0";
    std::string barriers = "0";
    std::string mutexes = "0";
    std::string semaphores = "0";
    std::string atomics = "0";
    std::string assumptions;

    FeatureDomain& operator+=(const FeatureDomain& other);
    FeatureDomain operator+(const FeatureDomain& other) const;
    static FeatureDomain max(const FeatureDomain& a, const FeatureDomain& b);
    static FeatureDomain memoryPathChoice(const FeatureDomain& a,
                                          const FeatureDomain& b);
    FeatureDomain multiply(const std::string& bound);
    
    void printCSV(std::ostream& os) const;
    void printMarkdown(std::ostream& os) const;
    void printJSON(std::ostream& os) const;
};

struct FunctionSummary {
    std::string functionName;
    FeatureDomain features;
    bool isAnalyzed = false;
};

#include <memory>
namespace clang { namespace tooling { class FrontendActionFactory; } }

std::unique_ptr<clang::tooling::FrontendActionFactory> createUPMEMActionFactory(std::map<std::string, FunctionSummary> &Summaries);

#endif // ANALYZER_H
