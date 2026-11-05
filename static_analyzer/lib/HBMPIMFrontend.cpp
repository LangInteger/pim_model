// HBM-PIM frontend: lowers a host-side PIM kernel (e.g. Samsung PIMSimulator's
// PIMKernel::executeGemv) into PIMSA-IR, a JSON tree of the PIMSA programming
// model: let / assign / for / for-range / while / if / event / call nodes with
// structured expressions.
//
// Only the configured primitive calls (by default the DRAM transaction and
// barrier API of MultiChannelMemorySystem) become `event` nodes. Calls to other
// functions whose definition is visible are inlined as `call` nodes carrying
// their parameter bindings, so the downstream analyzer can substitute actual
// arguments. Calls without a visible body become `opaque` nodes. Nothing is
// executed: metric extraction and cost interpretation happen downstream
// (pim_model/hbmpim_static/).

#include "Analyzer.h"
#include "clang/AST/ASTConsumer.h"
#include "clang/AST/RecursiveASTVisitor.h"
#include "clang/Frontend/CompilerInstance.h"
#include "clang/Frontend/FrontendAction.h"
#include "clang/Tooling/Tooling.h"
#include "llvm/Support/JSON.h"

using namespace clang;
namespace json = llvm::json;

namespace {

class IRBuilder {
public:
  IRBuilder(ASTContext &Ctx, const HBMFrontendOptions &Opts)
      : Ctx(Ctx), Opts(Opts) {}

  json::Value entry(const FunctionDecl *FD) {
    json::Array Params;
    for (const ParmVarDecl *P : FD->parameters())
      Params.push_back(P->getNameAsString());
    return json::Object{{"entry", FD->getQualifiedNameAsString()},
                        {"params", std::move(Params)},
                        {"body", stmts(FD->getBody())}};
  }

private:
  ASTContext &Ctx;
  const HBMFrontendOptions &Opts;
  int Depth = 0;

  std::string pretty(const Stmt *S) const {
    std::string Out;
    llvm::raw_string_ostream OS(Out);
    S->printPretty(OS, nullptr, Ctx.getPrintingPolicy());
    return OS.str();
  }

  static const char *binOp(BinaryOperatorKind K) {
    switch (K) {
    case BO_Add: return "+";
    case BO_Sub: return "-";
    case BO_Mul: return "*";
    case BO_Div: return "/";
    case BO_Rem: return "%";
    case BO_Shl: return "<<";
    case BO_Shr: return ">>";
    case BO_LT: return "<";
    case BO_GT: return ">";
    case BO_LE: return "<=";
    case BO_GE: return ">=";
    case BO_EQ: return "==";
    case BO_NE: return "!=";
    case BO_And: return "&";
    case BO_Or: return "|";
    case BO_LAnd: return "&&";
    case BO_LOr: return "||";
    default: return nullptr;
    }
  }

  // Integer constant folding, including enum constants and `const` data
  // members with a constant in-class initializer (e.g. pim_reg_ra_ = 0x3fff).
  bool constInt(const Expr *E, int64_t &V) const {
    if (E->isValueDependent() || !E->getType()->isIntegralOrEnumerationType())
      return false;
    Expr::EvalResult R;
    if (E->EvaluateAsInt(R, Ctx)) {
      V = R.Val.getInt().getExtValue();
      return true;
    }
    if (const auto *ME = dyn_cast<MemberExpr>(E->IgnoreParenImpCasts()))
      if (const auto *FD = dyn_cast<FieldDecl>(ME->getMemberDecl()))
        if (FD->getType().isConstQualified() && FD->hasInClassInitializer())
          if (const Expr *Init = FD->getInClassInitializer())
            return constInt(Init, V);
    return false;
  }

  json::Value expr(const Expr *E) {
    if (!E)
      return nullptr;
    E = E->IgnoreParenImpCasts();

    if (const auto *DA = dyn_cast<CXXDefaultArgExpr>(E))
      return expr(DA->getExpr());
    if (const auto *EW = dyn_cast<ExprWithCleanups>(E))
      return expr(EW->getSubExpr());
    if (const auto *MT = dyn_cast<MaterializeTemporaryExpr>(E))
      return expr(MT->getSubExpr());
    if (const auto *BT = dyn_cast<CXXBindTemporaryExpr>(E))
      return expr(BT->getSubExpr());

    int64_t V;
    if (constInt(E, V))
      return json::Object{{"c", V}};

    if (const auto *FL = dyn_cast<FloatingLiteral>(E))
      return json::Object{{"c", FL->getValueAsApproximateDouble()}};
    if (const auto *SL = dyn_cast<StringLiteral>(E))
      return json::Object{{"str", SL->getString().str()}};

    if (const auto *CE = dyn_cast<ExplicitCastExpr>(E)) {
      json::Value Sub = expr(CE->getSubExpr());
      if (CE->getType()->isRealFloatingType())
        return json::Object{{"op", "real"}, {"a", std::move(Sub)}};
      return Sub;
    }
    if (const auto *CC = dyn_cast<CXXConstructExpr>(E)) {
      if (CC->getNumArgs() == 1)
        return expr(CC->getArg(0));
      return json::Object{{"opaque", pretty(E)}};
    }

    if (const auto *BO = dyn_cast<BinaryOperator>(E)) {
      if (const char *Op = binOp(BO->getOpcode())) {
        json::Object O{{"op", Op},
                       {"a", expr(BO->getLHS())},
                       {"b", expr(BO->getRHS())}};
        if (BO->getOpcode() == BO_Div)
          O["int"] = BO->getType()->isIntegerType();
        return O;
      }
    }
    if (const auto *UO = dyn_cast<UnaryOperator>(E)) {
      switch (UO->getOpcode()) {
      case UO_Minus:
        return json::Object{{"op", "neg"}, {"a", expr(UO->getSubExpr())}};
      case UO_LNot:
        return json::Object{{"op", "!"}, {"a", expr(UO->getSubExpr())}};
      case UO_Deref:
      case UO_Plus:
        return expr(UO->getSubExpr());
      default:
        return json::Object{{"opaque", pretty(E)}};
      }
    }
    if (const auto *CO = dyn_cast<ConditionalOperator>(E))
      return json::Object{{"op", "?:"},
                          {"c", expr(CO->getCond())},
                          {"a", expr(CO->getTrueExpr())},
                          {"b", expr(CO->getFalseExpr())}};

    if (const auto *DR = dyn_cast<DeclRefExpr>(E))
      return json::Object{{"s", DR->getDecl()->getNameAsString()}};

    if (const auto *ME = dyn_cast<MemberExpr>(E)) {
      std::string Name = ME->getMemberDecl()->getNameAsString();
      if (isa<CXXThisExpr>(ME->getBase()->IgnoreParenImpCasts()))
        return json::Object{{"s", Name}};
      return json::Object{{"mem", Name}, {"base", expr(ME->getBase())}};
    }
    if (const auto *AS = dyn_cast<ArraySubscriptExpr>(E))
      return json::Object{{"idx", expr(AS->getIdx())},
                          {"base", expr(AS->getBase())}};

    if (const auto *OC = dyn_cast<CXXOperatorCallExpr>(E)) {
      OverloadedOperatorKind K = OC->getOperator();
      if (K == OO_Subscript && OC->getNumArgs() == 2)
        return json::Object{{"idx", expr(OC->getArg(1))},
                            {"base", expr(OC->getArg(0))}};
      if (K == OO_Arrow && OC->getNumArgs() >= 1)
        return expr(OC->getArg(0));
      if (OC->getNumArgs() == 2)
        return json::Object{{"op", getOperatorSpelling(K)},
                            {"a", expr(OC->getArg(0))},
                            {"b", expr(OC->getArg(1))}};
      return json::Object{{"opaque", pretty(E)}};
    }
    if (const auto *MC = dyn_cast<CXXMemberCallExpr>(E)) {
      json::Array Args;
      for (const Expr *A : MC->arguments())
        Args.push_back(expr(A));
      const FunctionDecl *FD = MC->getDirectCallee();
      return json::Object{
          {"fn", FD ? FD->getNameAsString() : std::string("?")},
          {"obj", expr(MC->getImplicitObjectArgument())},
          {"args", std::move(Args)}};
    }
    if (const auto *C = dyn_cast<CallExpr>(E)) {
      json::Array Args;
      for (const Expr *A : C->arguments())
        Args.push_back(expr(A));
      const FunctionDecl *FD = C->getDirectCallee();
      return json::Object{
          {"fn", FD ? FD->getNameAsString() : std::string("?")},
          {"args", std::move(Args)}};
    }
    return json::Object{{"opaque", pretty(E)}};
  }

  static void append(json::Array &Out, json::Array &&In) {
    for (auto &V : In)
      Out.push_back(std::move(V));
  }

  bool isPrimitive(const FunctionDecl *FD) const {
    std::string Q = FD->getQualifiedNameAsString();
    for (const std::string &P : Opts.Primitives) {
      if (Q == P)
        return true;
      // Accept an unqualified-namespace suffix match ("Class::method").
      if (Q.size() > P.size() && Q.compare(Q.size() - P.size(), P.size(), P) == 0 &&
          Q[Q.size() - P.size() - 1] == ':')
        return true;
    }
    return false;
  }

  json::Array call(const CallExpr *C) {
    json::Array Out;
    const FunctionDecl *FD = C->getDirectCallee();
    if (!FD) {
      Out.push_back(json::Object{{"k", "opaque"}, {"fn", pretty(C)}});
      return Out;
    }
    json::Array Args;
    for (const Expr *A : C->arguments())
      Args.push_back(expr(A));

    if (isPrimitive(FD)) {
      Out.push_back(json::Object{{"k", "event"},
                                 {"op", FD->getNameAsString()},
                                 {"args", std::move(Args)}});
      return Out;
    }

    const FunctionDecl *Def = nullptr;
    if (FD->hasBody(Def) && Def &&
        !Ctx.getSourceManager().isInSystemHeader(Def->getLocation()) &&
        Depth < 32) {
      json::Array Params;
      for (const ParmVarDecl *P : Def->parameters())
        Params.push_back(P->getNameAsString());
      ++Depth;
      json::Array Body = stmts(Def->getBody());
      --Depth;
      Out.push_back(json::Object{{"k", "call"},
                                 {"fn", Def->getQualifiedNameAsString()},
                                 {"params", std::move(Params)},
                                 {"args", std::move(Args)},
                                 {"body", std::move(Body)}});
      return Out;
    }
    Out.push_back(json::Object{{"k", "opaque"},
                               {"fn", FD->getQualifiedNameAsString()}});
    return Out;
  }

  // Statement-level expression: assignments, increments, calls (possibly
  // under ?: or comma).
  json::Array exprStmt(const Expr *E) {
    json::Array Out;
    if (!E)
      return Out;
    E = E->IgnoreParenImpCasts();
    if (const auto *EW = dyn_cast<ExprWithCleanups>(E))
      return exprStmt(EW->getSubExpr());

    if (const auto *BO = dyn_cast<BinaryOperator>(E)) {
      if (BO->getOpcode() == BO_Comma) {
        append(Out, exprStmt(BO->getLHS()));
        append(Out, exprStmt(BO->getRHS()));
        return Out;
      }
      if (BO->isAssignmentOp()) {
        const char *Op = BO->getOpcode() == BO_Assign      ? "="
                         : BO->getOpcode() == BO_AddAssign ? "+="
                         : BO->getOpcode() == BO_SubAssign ? "-="
                         : BO->getOpcode() == BO_MulAssign ? "*="
                                                           : "?=";
        Out.push_back(json::Object{{"k", "assign"},
                                   {"var", pretty(BO->getLHS())},
                                   {"op", Op},
                                   {"val", expr(BO->getRHS())}});
        append(Out, calls(BO->getRHS()));
        return Out;
      }
    }
    if (const auto *UO = dyn_cast<UnaryOperator>(E)) {
      if (UO->isIncrementDecrementOp()) {
        Out.push_back(json::Object{{"k", "assign"},
                                   {"var", pretty(UO->getSubExpr())},
                                   {"op", UO->isIncrementOp() ? "+=" : "-="},
                                   {"val", json::Object{{"c", 1}}}});
        return Out;
      }
    }
    if (const auto *OC = dyn_cast<CXXOperatorCallExpr>(E)) {
      OverloadedOperatorKind K = OC->getOperator();
      if ((K == OO_Equal || K == OO_PlusEqual) && OC->getNumArgs() == 2) {
        Out.push_back(json::Object{{"k", "assign"},
                                   {"var", pretty(OC->getArg(0))},
                                   {"op", K == OO_Equal ? "=" : "+="},
                                   {"val", expr(OC->getArg(1))}});
        append(Out, calls(OC->getArg(1)));
        return Out;
      }
    }
    if (const auto *CO = dyn_cast<ConditionalOperator>(E)) {
      Out.push_back(json::Object{{"k", "if"},
                                 {"cond", expr(CO->getCond())},
                                 {"then", exprStmt(CO->getTrueExpr())},
                                 {"else", exprStmt(CO->getFalseExpr())}});
      return Out;
    }
    if (const auto *C = dyn_cast<CallExpr>(E))
      if (!isa<CXXOperatorCallExpr>(C))
        return call(C);
    return calls(E);
  }

  // Collect statement-relevant calls nested inside an arbitrary expression.
  json::Array calls(const Stmt *S) {
    json::Array Out;
    if (!S)
      return Out;
    if (const auto *C = dyn_cast<CallExpr>(S)) {
      if (const FunctionDecl *FD = C->getDirectCallee())
        if (isPrimitive(FD))
          return call(C);
    }
    for (const Stmt *Child : S->children())
      append(Out, calls(Child));
    return Out;
  }

  json::Array stmts(const Stmt *S) {
    json::Array Out;
    if (!S)
      return Out;

    if (const auto *CS = dyn_cast<CompoundStmt>(S)) {
      for (const Stmt *Child : CS->body())
        append(Out, stmts(Child));
      return Out;
    }
    if (const auto *DS = dyn_cast<DeclStmt>(S)) {
      for (const Decl *D : DS->decls())
        if (const auto *VD = dyn_cast<VarDecl>(D)) {
          json::Object Let{{"k", "let"}, {"var", VD->getNameAsString()}};
          if (VD->hasInit())
            Let["val"] = expr(VD->getInit());
          Out.push_back(std::move(Let));
          if (VD->hasInit())
            append(Out, calls(VD->getInit()));
        }
      return Out;
    }
    if (const auto *IS = dyn_cast<IfStmt>(S)) {
      Out.push_back(json::Object{{"k", "if"},
                                 {"cond", expr(IS->getCond())},
                                 {"then", stmts(IS->getThen())},
                                 {"else", stmts(IS->getElse())}});
      return Out;
    }
    if (const auto *FS = dyn_cast<ForStmt>(S)) {
      Out.push_back(json::Object{{"k", "for"},
                                 {"init", stmts(FS->getInit())},
                                 {"cond", expr(FS->getCond())},
                                 {"inc", exprStmt(FS->getInc())},
                                 {"body", stmts(FS->getBody())}});
      return Out;
    }
    if (const auto *RS = dyn_cast<CXXForRangeStmt>(S)) {
      Out.push_back(json::Object{{"k", "forrange"},
                                 {"var", RS->getLoopVariable()->getNameAsString()},
                                 {"range", expr(RS->getRangeInit())},
                                 {"body", stmts(RS->getBody())}});
      return Out;
    }
    if (const auto *WS = dyn_cast<WhileStmt>(S)) {
      Out.push_back(json::Object{{"k", "while"},
                                 {"cond", expr(WS->getCond())},
                                 {"body", stmts(WS->getBody())}});
      return Out;
    }
    if (const auto *DS = dyn_cast<DoStmt>(S)) {
      Out.push_back(json::Object{{"k", "while"},
                                 {"cond", expr(DS->getCond())},
                                 {"body", stmts(DS->getBody())},
                                 {"do", true}});
      return Out;
    }
    if (isa<BreakStmt>(S)) {
      Out.push_back(json::Object{{"k", "break"}});
      return Out;
    }
    if (isa<ContinueStmt>(S)) {
      Out.push_back(json::Object{{"k", "continue"}});
      return Out;
    }
    if (isa<ReturnStmt>(S)) {
      Out.push_back(json::Object{{"k", "return"}});
      return Out;
    }
    if (const auto *E = dyn_cast<Expr>(S))
      return exprStmt(E);
    return Out;
  }
};

class HBMVisitor : public RecursiveASTVisitor<HBMVisitor> {
public:
  HBMVisitor(ASTContext &Ctx, const HBMFrontendOptions &Opts,
             std::vector<std::string> &Entries)
      : Ctx(Ctx), Opts(Opts), Entries(Entries) {}

  bool VisitFunctionDecl(FunctionDecl *FD) {
    if (!FD->doesThisDeclarationHaveABody())
      return true;
    std::string Q = FD->getQualifiedNameAsString();
    for (const std::string &E : Opts.Entries) {
      if (Q == E || (Q.size() > E.size() &&
                     Q.compare(Q.size() - E.size(), E.size(), E) == 0 &&
                     Q[Q.size() - E.size() - 1] == ':')) {
        IRBuilder B(Ctx, Opts);
        std::string Out;
        llvm::raw_string_ostream OS(Out);
        OS << B.entry(FD);
        Entries.push_back(OS.str());
      }
    }
    return true;
  }

private:
  ASTContext &Ctx;
  const HBMFrontendOptions &Opts;
  std::vector<std::string> &Entries;
};

class HBMConsumer : public ASTConsumer {
public:
  HBMConsumer(const HBMFrontendOptions &Opts, std::vector<std::string> &Entries)
      : Opts(Opts), Entries(Entries) {}
  void HandleTranslationUnit(ASTContext &Ctx) override {
    HBMVisitor V(Ctx, Opts, Entries);
    V.TraverseDecl(Ctx.getTranslationUnitDecl());
  }

private:
  const HBMFrontendOptions &Opts;
  std::vector<std::string> &Entries;
};

class HBMAction : public ASTFrontendAction {
public:
  HBMAction(const HBMFrontendOptions &Opts, std::vector<std::string> &Entries)
      : Opts(Opts), Entries(Entries) {}
  std::unique_ptr<ASTConsumer> CreateASTConsumer(CompilerInstance &,
                                                 StringRef) override {
    return std::make_unique<HBMConsumer>(Opts, Entries);
  }

private:
  const HBMFrontendOptions &Opts;
  std::vector<std::string> &Entries;
};

class HBMFactory : public tooling::FrontendActionFactory {
public:
  HBMFactory(const HBMFrontendOptions &Opts, std::vector<std::string> &Entries)
      : Opts(Opts), Entries(Entries) {}
  std::unique_ptr<FrontendAction> create() override {
    return std::make_unique<HBMAction>(Opts, Entries);
  }

private:
  const HBMFrontendOptions &Opts;
  std::vector<std::string> &Entries;
};

} // namespace

std::unique_ptr<clang::tooling::FrontendActionFactory>
createHBMPIMActionFactory(const HBMFrontendOptions &Opts,
                          std::vector<std::string> &Entries) {
  return std::make_unique<HBMFactory>(Opts, Entries);
}
