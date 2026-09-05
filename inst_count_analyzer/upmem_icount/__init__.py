"""Generic UPMEM static dynamic-instruction counting.

The expensive LLVM/LP dependencies are imported lazily so setting discovery
and result-processing utilities can run without NumPy/SciPy.
"""

__all__ = ["AnalysisModule", "generic_dynamic_instruction_count"]


def __getattr__(name: str):
    if name == "generic_dynamic_instruction_count":
        from .generic_count import generic_dynamic_instruction_count

        return generic_dynamic_instruction_count
    if name == "AnalysisModule":
        from .runtime import AnalysisModule

        return AnalysisModule
    raise AttributeError(name)
