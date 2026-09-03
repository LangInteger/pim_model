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
  struct LoopFlow {
    FeatureDomain fallthrough;
    FeatureDomain breaks;
    bool canFallThrough = true;
    bool hasBreak = false;
    bool supported = true;
  };

  ASTContext *Context;
  std::map<std::string, FunctionSummary> &Summaries;

  static void mergePath(FeatureDomain &destination, bool &hasDestination,
                        const FeatureDomain &candidate) {
    destination = hasDestination
                      ? FeatureDomain::memoryPathChoice(destination, candidate)
                      : candidate;
    hasDestination = true;
  }

  bool isConstantTrue(const Expr *E) const {
    if (!E)
      return false;
    E = E->IgnoreParenImpCasts();
    if (const auto *IL = dyn_cast<IntegerLiteral>(E))
      return !IL->getValue().isZero();
    if (const auto *BL = dyn_cast<CXXBoolLiteralExpr>(E))
      return BL->getValue();
    return false;
  }

  bool isVariableReference(const Expr *E, const VarDecl *Variable) const {
    if (!E || !Variable)
      return false;
    E = E->IgnoreParenImpCasts();
    const auto *Reference = dyn_cast<DeclRefExpr>(E);
    if (!Reference)
      return false;
    const auto *ReferencedVariable = dyn_cast<VarDecl>(Reference->getDecl());
    return ReferencedVariable && ReferencedVariable->getCanonicalDecl() ==
                                     Variable->getCanonicalDecl();
  }

  const VarDecl *getNegatedLoopFlag(const WhileStmt *WS) const {
    if (!WS || !WS->getCond())
      return nullptr;
    const Expr *Condition = WS->getCond()->IgnoreParenImpCasts();
    const auto *Negation = dyn_cast<UnaryOperator>(Condition);
    if (!Negation || Negation->getOpcode() != UO_LNot)
      return nullptr;
    const Expr *Flag = Negation->getSubExpr()->IgnoreParenImpCasts();
    const auto *Reference = dyn_cast<DeclRefExpr>(Flag);
    return Reference ? dyn_cast<VarDecl>(Reference->getDecl()) : nullptr;
  }

  bool isTrueConstant(const Expr *E) const {
    if (!E)
      return false;
    E = E->IgnoreParenImpCasts();
    if (const auto *Literal = dyn_cast<IntegerLiteral>(E))
      return !Literal->getValue().isZero();
    if (const auto *Literal = dyn_cast<CXXBoolLiteralExpr>(E))
      return Literal->getValue();
    return false;
  }

  bool assignsTrueToFlag(const Stmt *S, const VarDecl *Flag) const {
    if (!S)
      return false;
    if (const auto *Assignment = dyn_cast<BinaryOperator>(S)) {
      if (Assignment->getOpcode() == BO_Assign &&
          isVariableReference(Assignment->getLHS(), Flag) &&
          isTrueConstant(Assignment->getRHS()))
        return true;
    }
    for (const Stmt *Child : S->children()) {
      if (assignsTrueToFlag(Child, Flag))
        return true;
    }
    return false;
  }

  bool containsLoopBreak(const Stmt *S) const {
    if (!S)
      return false;
    if (isa<BreakStmt>(S))
      return true;
    // Breaks in nested loops or switches do not terminate the current loop.
    if (isa<ForStmt>(S) || isa<WhileStmt>(S) || isa<DoStmt>(S) ||
        isa<SwitchStmt>(S))
      return false;
    for (const Stmt *Child : S->children()) {
      if (containsLoopBreak(Child))
        return true;
    }
    return false;
  }

  std::string getUnknownWhileBound(const WhileStmt *WS) const {
    const SourceManager &SM = Context->getSourceManager();
    SourceLocation location = SM.getExpansionLoc(WS->getWhileLoc());
    PresumedLoc presumed = SM.getPresumedLoc(location);
    if (presumed.isInvalid())
      return "UNKNOWN_WHILE_BOUND_UNKNOWN_LOCATION";

    std::string filename =
        llvm::sys::path::filename(presumed.getFilename()).str();
    for (char &character : filename) {
      bool isAlphaNumeric =
          (character >= 'a' && character <= 'z') ||
          (character >= 'A' && character <= 'Z') ||
          (character >= '0' && character <= '9');
      if (!isAlphaNumeric)
        character = '_';
    }

    return "UNKNOWN_WHILE_BOUND_" + filename + "_L" +
           std::to_string(presumed.getLine()) + "_C" +
           std::to_string(presumed.getColumn());
  }

  std::string getUnknownForBound(const ForStmt *FS) const {
    const SourceManager &SM = Context->getSourceManager();
    SourceLocation location = SM.getExpansionLoc(FS->getForLoc());
    PresumedLoc presumed = SM.getPresumedLoc(location);
    if (presumed.isInvalid())
      return "UNKNOWN_FOR_BOUND_UNKNOWN_LOCATION";

    std::string filename =
        llvm::sys::path::filename(presumed.getFilename()).str();
    for (char &character : filename) {
      bool isAlphaNumeric =
          (character >= 'a' && character <= 'z') ||
          (character >= 'A' && character <= 'Z') ||
          (character >= '0' && character <= '9');
      if (!isAlphaNumeric)
        character = '_';
    }

    return "UNKNOWN_FOR_BOUND_" + filename + "_L" +
           std::to_string(presumed.getLine()) + "_C" +
           std::to_string(presumed.getColumn());
  }

  // Summarize paths through one loop body until they either reach the loop's
  // back edge or execute a break targeting this loop. Nested loops and
  // switches are treated atomically so their breaks do not escape here.
  LoopFlow analyzeLoopFlow(const Stmt *S) {
    LoopFlow result;
    if (!S)
      return result;

    if (isa<BreakStmt>(S)) {
      result.canFallThrough = false;
      result.hasBreak = true;
      return result;
    }

    // These exits need separate return/continue summaries. Fall back to the
    // existing conservative loop model rather than handling them incorrectly.
    if (isa<ContinueStmt>(S) || isa<ReturnStmt>(S) || isa<GotoStmt>(S)) {
      result.supported = false;
      return result;
    }

    if (const auto *CS = dyn_cast<CompoundStmt>(S)) {
      for (const Stmt *child : CS->children()) {
        if (!result.canFallThrough)
          break;

        LoopFlow childFlow = analyzeLoopFlow(child);
        if (!childFlow.supported) {
          result.supported = false;
          return result;
        }

        if (childFlow.hasBreak) {
          FeatureDomain breakPath = result.fallthrough + childFlow.breaks;
          mergePath(result.breaks, result.hasBreak, breakPath);
        }
        if (childFlow.canFallThrough)
          result.fallthrough += childFlow.fallthrough;
        else
          result.canFallThrough = false;
      }
      return result;
    }

    if (const auto *IS = dyn_cast<IfStmt>(S)) {
      FeatureDomain condition = analyzeStmt(IS->getCond());
      LoopFlow thenFlow = analyzeLoopFlow(IS->getThen());
      LoopFlow elseFlow = analyzeLoopFlow(IS->getElse());
      result.supported = thenFlow.supported && elseFlow.supported;
      if (!result.supported)
        return result;

      result.canFallThrough = false;
      bool hasFallthrough = false;
      if (thenFlow.canFallThrough) {
        FeatureDomain path = condition + thenFlow.fallthrough;
        mergePath(result.fallthrough, hasFallthrough, path);
      }
      if (elseFlow.canFallThrough) {
        FeatureDomain path = condition + elseFlow.fallthrough;
        mergePath(result.fallthrough, hasFallthrough, path);
      }
      result.canFallThrough = hasFallthrough;

      if (thenFlow.hasBreak) {
        FeatureDomain path = condition + thenFlow.breaks;
        mergePath(result.breaks, result.hasBreak, path);
      }
      if (elseFlow.hasBreak) {
        FeatureDomain path = condition + elseFlow.breaks;
        mergePath(result.breaks, result.hasBreak, path);
      }
      return result;
    }

    result.fallthrough = analyzeStmt(S);
    return result;
  }

  // Model loops such as `while (!end)`: ordinary work repeats W times, while
  // DMA in branches that set end=true occurs only on the final iteration.
  // A break branch is another terminal alternative and may have zero extra
  // memory cost.  Non-memory features retain the existing conservative model.
  bool analyzeFlagTerminatedLoop(const WhileStmt *WS, const VarDecl *Flag,
                                 const std::string &Bound,
                                 FeatureDomain &Result) {
    const auto *Body = dyn_cast<CompoundStmt>(WS->getBody());
    if (!Body || !Flag)
      return false;

    FeatureDomain Repeated;
    FeatureDomain FinalExtras;
    bool HasTerminalBranch = false;

    for (const Stmt *Child : Body->children()) {
      const auto *Branch = dyn_cast<IfStmt>(Child);
      if (!Branch) {
        Repeated += analyzeStmt(Child);
        continue;
      }

      const Stmt *Then = Branch->getThen();
      const Stmt *Else = Branch->getElse();
      bool ThenTerminates = containsLoopBreak(Then) ||
                            assignsTrueToFlag(Then, Flag);
      bool ElseTerminates = containsLoopBreak(Else) ||
                            assignsTrueToFlag(Else, Flag);
      if (!ThenTerminates && !ElseTerminates) {
        Repeated += analyzeStmt(Child);
        continue;
      }

      HasTerminalBranch = true;
      Repeated += analyzeStmt(Branch->getCond());

      FeatureDomain ThenFeatures = analyzeStmt(Then);
      FeatureDomain ElseFeatures = analyzeStmt(Else);
      if (!ThenTerminates)
        Repeated += ThenFeatures;
      if (!ElseTerminates)
        Repeated += ElseFeatures;

      FeatureDomain NoExtra;
      if (ThenTerminates)
        FinalExtras +=
            FeatureDomain::memoryPathChoice(NoExtra, ThenFeatures);
      if (ElseTerminates)
        FinalExtras +=
            FeatureDomain::memoryPathChoice(NoExtra, ElseFeatures);
    }

    if (!HasTerminalBranch)
      return false;

    FeatureDomain Condition = analyzeStmt(WS->getCond());
    Result = Condition + analyzeStmt(WS->getBody()).multiply(Bound);
    FeatureDomain Memory = Condition + Repeated.multiply(Bound) + FinalExtras;
    Result.mram_read = Memory.mram_read;
    Result.mram_read_tx = Memory.mram_read_tx;
    Result.mram_write = Memory.mram_write;
    Result.mram_write_tx = Memory.mram_write_tx;
    if (!Result.assumptions.empty())
      Result.assumptions += "; ";
    Result.assumptions += Bound + " >= 1";
    return true;
  }

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

  bool isLoopVariable(const Expr *E, const VarDecl *LoopVariable) const {
    return isVariableReference(E, LoopVariable);
  }

  bool extractForInduction(const ForStmt *FS, const VarDecl *&LoopVariable,
                           std::string &InitialValue) {
    LoopVariable = nullptr;
    const Stmt *Init = FS->getInit();
    if (const auto *Declaration = dyn_cast_or_null<DeclStmt>(Init)) {
      if (!Declaration->isSingleDecl())
        return false;
      const auto *Variable = dyn_cast<VarDecl>(Declaration->getSingleDecl());
      if (!Variable || !Variable->hasInit())
        return false;
      LoopVariable = Variable;
      InitialValue = extractExprString(Variable->getInit());
      return true;
    }

    const auto *Assignment = dyn_cast_or_null<BinaryOperator>(Init);
    if (!Assignment || Assignment->getOpcode() != BO_Assign)
      return false;
    const auto *Reference =
        dyn_cast<DeclRefExpr>(Assignment->getLHS()->IgnoreParenImpCasts());
    if (!Reference)
      return false;
    LoopVariable = dyn_cast<VarDecl>(Reference->getDecl());
    if (!LoopVariable)
      return false;
    InitialValue = extractExprString(Assignment->getRHS());
    return true;
  }

  bool extractPositiveForStep(const ForStmt *FS, const VarDecl *LoopVariable,
                              std::string &Step) {
    const Expr *Increment = FS->getInc();
    if (!Increment)
      return false;
    Increment = Increment->IgnoreParenImpCasts();

    if (const auto *Unary = dyn_cast<UnaryOperator>(Increment)) {
      if (Unary->isIncrementOp() &&
          isLoopVariable(Unary->getSubExpr(), LoopVariable)) {
        Step = "1";
        return true;
      }
      return false;
    }

    const auto *Binary = dyn_cast<BinaryOperator>(Increment);
    if (!Binary || Binary->getOpcode() != BO_AddAssign ||
        !isLoopVariable(Binary->getLHS(), LoopVariable))
      return false;
    Step = extractExprString(Binary->getRHS());
    return true;
  }

  static std::string subtractExpression(const std::string &Left,
                                        const std::string &Right) {
    if (Right == "0")
      return Left;
    if (Left == Right)
      return "0";
    return "((" + Left + ") - (" + Right + "))";
  }

  // Return the number of unit increments permitted by a loop condition.  For
  // conjunctions, each recognized clause is an upper bound, so their minimum
  // is the bound for the complete condition.
  bool extractConditionDistance(const Expr *Condition,
                                const VarDecl *LoopVariable,
                                const std::string &InitialValue,
                                std::string &Distance) {
    if (!Condition)
      return false;
    Condition = Condition->IgnoreParenImpCasts();
    const auto *Binary = dyn_cast<BinaryOperator>(Condition);
    if (!Binary)
      return false;

    if (Binary->getOpcode() == BO_LAnd) {
      std::string LeftDistance;
      std::string RightDistance;
      bool HasLeft = extractConditionDistance(
          Binary->getLHS(), LoopVariable, InitialValue, LeftDistance);
      bool HasRight = extractConditionDistance(
          Binary->getRHS(), LoopVariable, InitialValue, RightDistance);
      if (HasLeft && HasRight) {
        Distance = LeftDistance == RightDistance
                       ? LeftDistance
                       : "min(" + LeftDistance + ", " + RightDistance + ")";
        return true;
      }
      // A recognized conjunct still provides a sound upper bound even if the
      // other conjunct cannot be expressed symbolically.
      if (HasLeft || HasRight) {
        Distance = HasLeft ? LeftDistance : RightDistance;
        return true;
      }
      return false;
    }

    if (Binary->getOpcode() != BO_LT && Binary->getOpcode() != BO_LE)
      return false;

    const Expr *Left = Binary->getLHS()->IgnoreParenImpCasts();
    std::string ExclusiveUpper;
    if (isLoopVariable(Left, LoopVariable)) {
      ExclusiveUpper = extractExprString(Binary->getRHS());
    } else if (const auto *LeftBinary = dyn_cast<BinaryOperator>(Left)) {
      if (LeftBinary->getOpcode() == BO_Add &&
          isLoopVariable(LeftBinary->getLHS(), LoopVariable)) {
        ExclusiveUpper = subtractExpression(
            extractExprString(Binary->getRHS()),
            extractExprString(LeftBinary->getRHS()));
      } else if (LeftBinary->getOpcode() == BO_Add &&
                 isLoopVariable(LeftBinary->getRHS(), LoopVariable)) {
        ExclusiveUpper = subtractExpression(
            extractExprString(Binary->getRHS()),
            extractExprString(LeftBinary->getLHS()));
      } else if (LeftBinary->getOpcode() == BO_Sub &&
                 isLoopVariable(LeftBinary->getLHS(), LoopVariable)) {
        ExclusiveUpper = "((" + extractExprString(Binary->getRHS()) +
                         ") + (" + extractExprString(LeftBinary->getRHS()) +
                         "))";
      } else {
        return false;
      }
    } else {
      return false;
    }

    Distance = subtractExpression(ExclusiveUpper, InitialValue);
    if (Binary->getOpcode() == BO_LE)
      Distance = "((" + Distance + ") + 1)";
    return true;
  }

  bool extractCancelledSpan(const ForStmt *FS, const VarDecl *LoopVariable,
                            const std::string &InitialValue,
                            std::string &Span, bool &Inclusive) {
    const Expr *Condition = FS->getCond();
    if (!Condition)
      return false;
    Condition = Condition->IgnoreParenImpCasts();
    const auto *Comparison = dyn_cast<BinaryOperator>(Condition);
    if (!Comparison ||
        (Comparison->getOpcode() != BO_LT &&
         Comparison->getOpcode() != BO_LE) ||
        !isLoopVariable(Comparison->getLHS(), LoopVariable))
      return false;

    const Expr *Upper = Comparison->getRHS()->IgnoreParenImpCasts();
    const auto *Addition = dyn_cast<BinaryOperator>(Upper);
    if (!Addition || Addition->getOpcode() != BO_Add)
      return false;

    std::string Left = extractExprString(Addition->getLHS());
    std::string Right = extractExprString(Addition->getRHS());
    if (Left == InitialValue)
      Span = Right;
    else if (Right == InitialValue)
      Span = Left;
    else
      return false;

    Inclusive = Comparison->getOpcode() == BO_LE;
    return true;
  }

  std::string extractLegacyForBound(const ForStmt *FS,
                                    const std::string &Step) {
    const Expr *Condition = FS->getCond();
    if (!Condition)
      return getUnknownForBound(FS);
    Condition = Condition->IgnoreParenImpCasts();
    const auto *Comparison = dyn_cast<BinaryOperator>(Condition);
    if (!Comparison ||
        (Comparison->getOpcode() != BO_LT &&
         Comparison->getOpcode() != BO_LE))
      return getUnknownForBound(FS);

    std::string Upper = extractExprString(Comparison->getRHS());
    if (Step == "1")
      return Upper;
    return "(" + Upper + " / (" + Step + "))";
  }

  std::string extractLoopBound(const Stmt *S) {
    if (const ForStmt *FS = dyn_cast<ForStmt>(S)) {
      const VarDecl *LoopVariable = nullptr;
      std::string InitialValue;
      std::string Step;
      std::string Distance;
      if (!extractForInduction(FS, LoopVariable, InitialValue) ||
          !extractPositiveForStep(FS, LoopVariable, Step))
        return getUnknownForBound(FS);

      const Expr *Condition = FS->getCond();
      const auto *ConditionBinary = Condition
                                        ? dyn_cast<BinaryOperator>(
                                              Condition->IgnoreParenImpCasts())
                                        : nullptr;
      if (ConditionBinary && ConditionBinary->getOpcode() == BO_LAnd) {
        if (!extractConditionDistance(Condition, LoopVariable, InitialValue,
                                      Distance))
          return getUnknownForBound(FS);
        if (Step == "1")
          return Distance;
        return "ceil_div(" + Distance + ", " + Step + ")";
      }

      std::string Span;
      bool Inclusive = false;
      if (extractCancelledSpan(FS, LoopVariable, InitialValue, Span,
                               Inclusive)) {
        if (Inclusive)
          Span = "((" + Span + ") + 1)";
        if (Step == "1")
          return Span;
        return "ceil_div(" + Span + ", " + Step + ")";
      }

      // Preserve the historical expression for ordinary loops.  This keeps
      // existing benchmark adapters stable until the analyzer can substitute
      // tasklet-local initializers such as base_tasklet and tasklet_id.
      return extractLegacyForBound(FS, Step);
    }
    return "UNKNOWN_FOR_BOUND_UNKNOWN_LOCATION";
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
      std::string unknownBound = getUnknownWhileBound(WS);
      if (isConstantTrue(WS->getCond())) {
        LoopFlow flow = analyzeLoopFlow(WS->getBody());
        if (flow.supported && flow.hasBreak) {
          FeatureDomain F_loop = flow.breaks;
          if (flow.canFallThrough) {
            F_loop = flow.fallthrough.multiply("(" + unknownBound + " - 1)") +
                     F_loop;
          }
          if (!F_loop.assumptions.empty())
            F_loop.assumptions += "; ";
          F_loop.assumptions += unknownBound + " >= 1";
          return F_cond + F_loop;
        }
      }
      if (const VarDecl *Flag = getNegatedLoopFlag(WS)) {
        FeatureDomain FlagLoop;
        if (analyzeFlagTerminatedLoop(WS, Flag, unknownBound, FlagLoop))
          return FlagLoop;
      }
      FeatureDomain F_body = analyzeStmt(WS->getBody());
      return F_cond + F_body.multiply(unknownBound);
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
