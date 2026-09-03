#include "Analyzer.h"
#include "clang/AST/ASTConsumer.h"
#include "clang/AST/RecursiveASTVisitor.h"
#include "clang/Analysis/CFG.h"
#include "clang/Frontend/CompilerInstance.h"
#include "clang/Frontend/FrontendAction.h"
#include "clang/Tooling/Tooling.h"

using namespace clang;

class UPMEMVisitor : public RecursiveASTVisitor<UPMEMVisitor> {
public:
  explicit UPMEMVisitor(ASTContext *Context,
                        std::map<std::string, FunctionSummary> &Summaries)
      : Context(Context), Summaries(Summaries) {}

  std::string getFuncName(const FunctionDecl *FD) {
    std::string filename =
        llvm::sys::path::filename(
            Context->getSourceManager().getFilename(FD->getLocation()))
            .str();
    return filename + "::" + FD->getNameInfo().getName().getAsString();
  }

  bool VisitFunctionDecl(FunctionDecl *Declaration) {
    if (Declaration->hasBody() && !Context->getSourceManager().isInSystemHeader(
                                      Declaration->getLocation())) {
      std::string funcName = getFuncName(Declaration);
      if (Summaries.find(funcName) == Summaries.end()) {
        FunctionSummary summary;
        summary.functionName = funcName;
        Summaries[funcName] = summary;
        analyzeFunction(Declaration, Summaries[funcName]);
      }
    }
    return true;
  }

private:
  ASTContext *Context;
  std::map<std::string, FunctionSummary> &Summaries;

  void analyzeFunction(FunctionDecl *D, FunctionSummary &S) {
    Stmt *Body = D->getBody();
    if (!Body)
      return;
    std::unique_ptr<CFG> cfg =
        CFG::buildCFG(D, Body, Context, CFG::BuildOptions());

    S.features = analyzeStmt(Body);
    S.isAnalyzed = true;
  }

  std::string extractExprString(const Expr *E) {
    std::string exprStr;
    llvm::raw_string_ostream stream(exprStr);
    E->printPretty(stream, nullptr, Context->getPrintingPolicy());
    return stream.str();
  }

  std::string extractLoopBound(const Stmt *S) {
    if (const ForStmt *FS = dyn_cast<ForStmt>(S)) {
      std::string boundStr = "N";
      if (FS->getCond()) {
        if (const BinaryOperator *Cond =
                dyn_cast<BinaryOperator>(FS->getCond())) {
          if (Cond->getOpcode() == BO_LT || Cond->getOpcode() == BO_LE) {
            boundStr.clear();
            llvm::raw_string_ostream stream(boundStr);
            Cond->getRHS()->printPretty(stream, nullptr,
                                        Context->getPrintingPolicy());
          }
        }
      }
      std::string incStr = "1";
      if (FS->getInc()) {
        if (const BinaryOperator *IncOp =
                dyn_cast<BinaryOperator>(FS->getInc())) {
          if (IncOp->getOpcode() == BO_AddAssign) {
            incStr.clear();
            llvm::raw_string_ostream stream(incStr);
            IncOp->getRHS()->printPretty(stream, nullptr,
                                         Context->getPrintingPolicy());
          }
        }
      }
      if (boundStr != "N") {
        if (incStr != "1")
          return "(" + boundStr + " / (" + incStr + "))";
        return boundStr;
      }
    }
    return "N";
  }

  FeatureDomain analyzeStmt(const Stmt *S) {
    FeatureDomain F;
    if (!S)
      return F;

    if (const CompoundStmt *CS = dyn_cast<CompoundStmt>(S)) {
      for (auto *child : CS->children())
        F += analyzeStmt(child);
      return F;
    } else if (const IfStmt *IS = dyn_cast<IfStmt>(S)) {
      FeatureDomain F_cond = analyzeStmt(IS->getCond());
      FeatureDomain F_then = analyzeStmt(IS->getThen());
      FeatureDomain F_else = analyzeStmt(IS->getElse());
      return F_cond + FeatureDomain::max(F_then, F_else);
    } else if (const ForStmt *FS = dyn_cast<ForStmt>(S)) {
      FeatureDomain F_init = analyzeStmt(FS->getInit());
      FeatureDomain F_cond = analyzeStmt(FS->getCond());
      FeatureDomain F_inc = analyzeStmt(FS->getInc());
      FeatureDomain F_body = analyzeStmt(FS->getBody());

      std::string bound = extractLoopBound(FS);
      return F_init + F_cond + F_inc + F_body.multiply(bound);
    } else if (const WhileStmt *WS = dyn_cast<WhileStmt>(S)) {
      FeatureDomain F_cond = analyzeStmt(WS->getCond());
      FeatureDomain F_body = analyzeStmt(WS->getBody());
      return F_cond + F_body.multiply("UNKNOWN_WHILE_BOUND");
    }

    auto inc1 = [](std::string &s) {
      if (s == "0")
        s = "1";
      else {
        try {
          s = std::to_string(std::stoll(s) + 1);
        } catch (...) {
          s = "(" + s + " + 1)";
        }
      }
    };

    if (const CallExpr *CE = dyn_cast<CallExpr>(S)) {
      if (const FunctionDecl *FD = CE->getDirectCallee()) {
        std::string calleeName = FD->getNameInfo().getName().getAsString();
        if (calleeName == "dpu_launch")
          inc1(F.launches);
        else if (calleeName == "dpu_sync")
          inc1(F.waits);
        else if (calleeName == "barrier_wait")
          inc1(F.barriers);
        else if (calleeName == "mram_read") {
          inc1(F.mram_read_tx);
          if (CE->getNumArgs() >= 3) {
            std::string sizeStr = extractExprString(CE->getArg(2));
            F.mram_read = (F.mram_read == "0")
                              ? sizeStr
                              : "(" + F.mram_read + " + " + sizeStr + ")";
          } else
            inc1(F.mram_read);
        } else if (calleeName == "mram_write") {
          inc1(F.mram_write_tx);
          if (CE->getNumArgs() >= 3) {
            std::string sizeStr = extractExprString(CE->getArg(2));
            F.mram_write = (F.mram_write == "0")
                               ? sizeStr
                               : "(" + F.mram_write + " + " + sizeStr + ")";
          } else
            inc1(F.mram_write);
        } else if (calleeName == "mutex_lock")
          inc1(F.mutexes);
        else if (calleeName == "sem_down" || calleeName == "sem_up")
          inc1(F.semaphores);
        else if (calleeName.find("atomic") != std::string::npos)
          inc1(F.atomics);
        else if (calleeName == "dpu_push_xfer" || calleeName == "dpu_copy_to" ||
                 calleeName == "dpu_copy_from") {
          if (CE->getNumArgs() >= 5) {
            std::string dirStr = extractExprString(CE->getArg(1));
            std::string sizeStr = extractExprString(CE->getArg(4));
            if (dirStr.find("DPU_XFER_TO_DPU") != std::string::npos ||
                dirStr == "1") {
              F.h2d_bytes = (F.h2d_bytes == "0")
                                ? sizeStr
                                : "(" + F.h2d_bytes + " + " + sizeStr + ")";
            } else if (dirStr.find("DPU_XFER_FROM_DPU") != std::string::npos ||
                       dirStr == "2") {
              F.d2h_bytes = (F.d2h_bytes == "0")
                                ? sizeStr
                                : "(" + F.d2h_bytes + " + " + sizeStr + ")";
            }
          }
        } else if (FD->hasBody() &&
                   !Context->getSourceManager().isInSystemHeader(
                       FD->getLocation())) {
          std::string fullFuncName = getFuncName(FD);
          if (Summaries.find(fullFuncName) == Summaries.end()) {
            FunctionSummary summary;
            summary.functionName = fullFuncName;
            Summaries[fullFuncName] = summary;
            analyzeFunction(const_cast<FunctionDecl *>(FD),
                            Summaries[fullFuncName]);
          }
          if (Summaries[fullFuncName].isAnalyzed) {
            F += Summaries[fullFuncName].features;
          }
        }
      }
    }

    if (const BinaryOperator *BO = dyn_cast<BinaryOperator>(S)) {
      if (BO->isAdditiveOp() || BO->isMultiplicativeOp() ||
          BO->isCompoundAssignmentOp() || BO->isShiftOp()) {
        inc1(F.arith_ops);
      }
    } else if (const UnaryOperator *UO = dyn_cast<UnaryOperator>(S)) {
      if (UO->isIncrementOp() || UO->isDecrementOp()) {
        inc1(F.arith_ops);
      }
    }

    if (!isa<CompoundStmt>(S) && !isa<IfStmt>(S) && !isa<ForStmt>(S) &&
        !isa<WhileStmt>(S)) {
      for (const Stmt *Child : S->children()) {
        F += analyzeStmt(Child);
      }
    }

    return F;
  }
};

class UPMEMConsumer : public ASTConsumer {
public:
  explicit UPMEMConsumer(ASTContext *Context,
                         std::map<std::string, FunctionSummary> &Summaries)
      : Visitor(Context, Summaries) {}

  virtual void HandleTranslationUnit(ASTContext &Context) override {
    Visitor.TraverseDecl(Context.getTranslationUnitDecl());
  }

private:
  UPMEMVisitor Visitor;
};

class UPMEMAction : public ASTFrontendAction {
public:
  explicit UPMEMAction(std::map<std::string, FunctionSummary> &Summaries)
      : Summaries(Summaries) {}

  virtual std::unique_ptr<ASTConsumer>
  CreateASTConsumer(CompilerInstance &CI, StringRef file) override {
    return std::make_unique<UPMEMConsumer>(&CI.getASTContext(), Summaries);
  }

private:
  std::map<std::string, FunctionSummary> &Summaries;
};

class UPMEMActionFactory : public tooling::FrontendActionFactory {
public:
  explicit UPMEMActionFactory(std::map<std::string, FunctionSummary> &Summaries)
      : Summaries(Summaries) {}

  std::unique_ptr<clang::FrontendAction> create() override {
    return std::make_unique<UPMEMAction>(Summaries);
  }

private:
  std::map<std::string, FunctionSummary> &Summaries;
};

std::unique_ptr<clang::tooling::FrontendActionFactory>
createUPMEMActionFactory(std::map<std::string, FunctionSummary> &Summaries) {
  return std::make_unique<UPMEMActionFactory>(Summaries);
}
