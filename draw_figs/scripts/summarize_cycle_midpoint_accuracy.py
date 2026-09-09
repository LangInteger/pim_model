#!/usr/bin/env python3
"""Summarize composed-cycle midpoint accuracy across benchmark sweeps."""

from __future__ import annotations

import argparse
import csv
import statistics
from dataclasses import dataclass
from pathlib import Path


DEFAULT_DIAGNOSTIC_EXCLUSIONS = ("bs", "hst-l")
SWEEPS = ("tasklet_sweep", "dpu_sweep")


@dataclass(frozen=True)
class Observation:
    benchmark: str
    sweep: str
    absolute_percentage_error: float


@dataclass(frozen=True)
class Summary:
    configurations: int
    median_ape_pct: float
    mean_ape_pct: float


def parse_args() -> argparse.Namespace:
    script_dir = Path(__file__).resolve().parent
    parser = argparse.ArgumentParser(
        description=(
            "Report the absolute percentage error of the composed-cycle "
            "interval midpoint for all benchmarks and for a diagnostic subset."
        )
    )
    parser.add_argument(
        "--results-root",
        type=Path,
        default=script_dir.parent / "results",
        help="directory containing <benchmark>/<benchmark>_cost_estimates.csv",
    )
    parser.add_argument(
        "--exclude",
        nargs="*",
        default=list(DEFAULT_DIAGNOSTIC_EXCLUSIONS),
        metavar="BENCHMARK",
        help=(
            "benchmarks excluded from the diagnostic subset "
            "(default: BS HST-L); pass --exclude with no values to disable it"
        ),
    )
    parser.add_argument(
        "--format",
        choices=("text", "csv"),
        default="text",
        help="output format (default: text)",
    )
    return parser.parse_args()


def load_observations(results_root: Path) -> list[Observation]:
    observations: list[Observation] = []
    for path in sorted(results_root.glob("*/*_cost_estimates.csv")):
        benchmark = path.name.removesuffix("_cost_estimates.csv").lower()
        with path.open(newline="", encoding="utf-8") as input_file:
            rows = list(csv.DictReader(input_file))
        if not rows:
            raise ValueError(f"no rows found in {path}")

        for row in rows:
            sweep = row["experiment"]
            if sweep not in SWEEPS:
                raise ValueError(f"unsupported experiment {sweep!r} in {path}")
            lower = float(row["composed_cycles_lower"])
            upper = float(row["composed_cycles_upper"])
            measured = float(row["actual_cycles"])
            if measured <= 0 or lower <= 0 or upper < lower:
                raise ValueError(f"invalid composed-cycle values in {path}: {row}")
            midpoint = (lower + upper) / 2.0
            observations.append(
                Observation(
                    benchmark=benchmark,
                    sweep=sweep,
                    absolute_percentage_error=abs(midpoint - measured) / measured,
                )
            )

    if not observations:
        raise ValueError(f"no cost-estimate CSV files found below {results_root}")
    return observations


def summarize(observations: list[Observation]) -> Summary:
    if not observations:
        raise ValueError("cannot summarize an empty set of observations")
    errors = [item.absolute_percentage_error for item in observations]
    return Summary(
        configurations=len(errors),
        median_ape_pct=100.0 * statistics.median(errors),
        mean_ape_pct=100.0 * statistics.mean(errors),
    )


def rows_for_scope(
    observations: list[Observation], excluded: frozenset[str]
) -> list[tuple[str, str, Summary]]:
    selected = [item for item in observations if item.benchmark not in excluded]
    scope = "all" if not excluded else "excluding_" + "_".join(sorted(excluded))
    rows = [
        (
            scope,
            sweep,
            summarize([item for item in selected if item.sweep == sweep]),
        )
        for sweep in SWEEPS
    ]
    rows.append((scope, "combined", summarize(selected)))
    return rows


def print_text(rows: list[tuple[str, str, Summary]]) -> None:
    current_scope: str | None = None
    for scope, sweep, result in rows:
        if scope != current_scope:
            if current_scope is not None:
                print()
            print(f"[{scope}]")
            print(f"{'sweep':<16} {'n':>4} {'median APE':>12} {'MAPE':>10}")
            current_scope = scope
        print(
            f"{sweep:<16} {result.configurations:>4} "
            f"{result.median_ape_pct:>11.1f}% "
            f"{result.mean_ape_pct:>9.1f}%"
        )


def print_csv(rows: list[tuple[str, str, Summary]]) -> None:
    writer = csv.writer(__import__("sys").stdout, lineterminator="\n")
    writer.writerow(
        ("scope", "sweep", "configurations", "median_ape_pct", "mape_pct")
    )
    for scope, sweep, result in rows:
        writer.writerow(
            (
                scope,
                sweep,
                result.configurations,
                f"{result.median_ape_pct:.6f}",
                f"{result.mean_ape_pct:.6f}",
            )
        )


def main() -> int:
    args = parse_args()
    observations = load_observations(args.results_root)
    excluded = frozenset(name.lower() for name in args.exclude)
    known = {item.benchmark for item in observations}
    unknown = sorted(excluded - known)
    if unknown:
        raise ValueError(f"unknown excluded benchmarks: {', '.join(unknown)}")

    rows = rows_for_scope(observations, frozenset())
    if excluded:
        rows.extend(rows_for_scope(observations, excluded))

    if args.format == "csv":
        print_csv(rows)
    else:
        print_text(rows)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
