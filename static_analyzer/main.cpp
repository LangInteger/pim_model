#include "clang/Tooling/CommonOptionsParser.h"
#include "clang/Tooling/Tooling.h"
#include "Analyzer.h"
#include <iostream>
#include <fstream>
#include "llvm/Support/CommandLine.h" 

using namespace clang::tooling;
using namespace llvm; 

static cl::OptionCategory PIMAnalyzerCategory("pim-analyzer options");

int main(int argc, const char **argv) {
    auto ExpectedParser = CommonOptionsParser::create(argc, argv, PIMAnalyzerCategory);
    if (!ExpectedParser) {
        llvm::errs() << ExpectedParser.takeError();
        return 1;
    }
    CommonOptionsParser &OptionsParser = ExpectedParser.get();
    ClangTool Tool(OptionsParser.getCompilations(), OptionsParser.getSourcePathList());

    std::map<std::string, FunctionSummary> Summaries;
    
    int result = Tool.run(createUPMEMActionFactory(Summaries).get());

    std::cout << "\nUPMEM PIM Static Analysis Summary\n";
    std::cout << "=================================\n\n";
    
    std::cout << "| benchmark | launches | waits | h2d_bytes | d2h_bytes | arith_ops | mram_read | mram_read_tx | mram_write | mram_write_tx | barriers | mutexes | semaphores | atomics | assumptions |\n";
    std::cout << "|-----------|----------|-------|-----------|-----------|-----------|-----------|--------------|------------|---------------|----------|---------|------------|---------|-------------|\n";

    std::ofstream outFile("pim_summary.json");
    if (!outFile.is_open()) {
        std::cerr << "Failed to open pim_summary.json for writing.\n";
        return 1;
    }

    outFile << "[\n";
    bool first = true;
    for (const auto &pair : Summaries) {
        const FunctionSummary &S = pair.second;
        if (!first) outFile << ",\n";
        outFile << "  {\n";
        outFile << "    \"function\": \"" << S.functionName << "\",\n";
        outFile << "    \"features\": ";
        S.features.printJSON(outFile);
        outFile << "\n  }";
        first = false;
    }
    outFile << "\n]\n";
    outFile.close();

    std::cout << "Successfully generated pim_summary.json.\n";
    return result;
}


// Feature composition rules:

//Sequential composition
//F_total = F1 + F2

//Mutually exclusive branches
//F_total = elementwise max(F_then, F_else)

//Loops
//F_total = loop_upper_bound × F_body