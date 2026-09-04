"""Generic UPMEM static dynamic-instruction counting."""
from .generic_count import generic_dynamic_instruction_count
from .runtime import AnalysisModule

__all__ = ["AnalysisModule", "generic_dynamic_instruction_count"]
