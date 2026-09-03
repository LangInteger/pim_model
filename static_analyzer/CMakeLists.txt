cmake_minimum_required(VERSION 3.10)
project(PIMStaticAnalyzer)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# LLVM and Clang paths for Homebrew
set(LLVM_DIR "/opt/homebrew/opt/llvm/lib/cmake/llvm")
set(Clang_DIR "/opt/homebrew/opt/llvm/lib/cmake/clang")

find_package(LLVM REQUIRED CONFIG)
find_package(Clang REQUIRED CONFIG)

include_directories(${LLVM_INCLUDE_DIRS} ${CLANG_INCLUDE_DIRS} ${PROJECT_SOURCE_DIR}/include)
link_directories(${LLVM_LIBRARY_DIRS})

add_definitions(${LLVM_DEFINITIONS})

add_executable(pim-analyzer 
    main.cpp
    lib/Analyzer.cpp
    lib/UPMEMMatchers.cpp
)

target_link_libraries(pim-analyzer
    PRIVATE
    clangAST
    clangASTMatchers
    clangAnalysis
    clangBasic
    clangDriver
    clangEdit
    clangFrontend
    clangLex
    clangParse
    clangRewrite
    clangSema
    clangSerialization
    clangTooling
    LLVMCore
    LLVMSupport
)
