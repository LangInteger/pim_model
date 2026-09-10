#!/usr/bin/env python3
"""Join PIMSA and uPIMulator wall-clock times by benchmark configuration."""

from __future__ import annotations

import argparse
import csv
import math
import statistics
from dataclasses import dataclass
from pathlib import Path


IDENTITY_FIELDS = (
    "benchmark",
    "experiment",
    "num_dpus",
    "num_tasklets",
    "data_prep_params",
)


@dataclass(frozen=True)
class PimsaTiming:
    identity: tuple[str, str, int, int, int]
    seconds: float
    result_path: str


def parse_args() -> argparse.Namespace:
    script_dir = Path(__file__).resolve().parent
    repository_root = script_dir.parents[1]
    draw_figs_root = script_dir.parent
    parser = argparse.ArgumentParser(
        description=(
            "Extract PIMSA instruction-count analysis times and match them "
            "with per-configuration uPIMulator wall-clock times."
        )
    )
    parser.add_argument(
        "--pimsa-results-root",
        type=Path,
        default=repository_root / "inst_count_analyzer" / "results",
        help="root containing <benchmark>/instruction_counts.csv files",
    )
    parser.add_argument(
        "--upimulator-times",
        type=Path,
        default=draw_figs_root / ".work" / "upimulator_wall_times.csv",
        help="CSV produced by summarize_upimulator_wall_time.py",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=draw_figs_root / ".work" / "wall_time_comparison.csv",
        help="joined per-configuration output CSV",
    )
    return parser.parse_args()


def row_identity(row: dict[str, str]) -> tuple[str, str, int, int, int]:
    return (
        row["benchmark"].upper(),
        row["experiment"],
        int(row["num_dpus"]),
        int(row["num_tasklets"]),
        int(row["data_prep_params"]),
    )


def load_pimsa_times(root: Path) -> dict[tuple[str, str, int, int, int], PimsaTiming]:
    timings: dict[tuple[str, str, int, int, int], PimsaTiming] = {}
    paths = sorted(root.glob("*/instruction_counts.csv"))
    if not paths:
        raise ValueError(f"no instruction_counts.csv files found below {root}")

    for path in paths:
        with path.open(newline="", encoding="utf-8") as input_file:
            for row in csv.DictReader(input_file):
                identity = row_identity(row)
                raw_seconds = row.get("analysis_wall_seconds", "").strip()
                if not raw_seconds:
                    raise ValueError(
                        f"missing analysis_wall_seconds for {identity} in {path}"
                    )
                seconds = float(raw_seconds)
                if seconds <= 0:
                    raise ValueError(
                        f"non-positive analysis_wall_seconds for {identity} in {path}"
                    )
                if identity in timings:
                    raise ValueError(f"duplicate PIMSA timing for {identity}")
                timings[identity] = PimsaTiming(
                    identity=identity,
                    seconds=seconds,
                    result_path=row.get("result_path", ""),
                )
    return timings


def load_upimulator_rows(
    path: Path,
) -> dict[tuple[str, str, int, int, int], dict[str, str]]:
    rows: dict[tuple[str, str, int, int, int], dict[str, str]] = {}
    with path.open(newline="", encoding="utf-8") as input_file:
        for row in csv.DictReader(input_file):
            identity = row_identity(row)
            if identity in rows:
                raise ValueError(f"duplicate uPIMulator timing for {identity}")
            rows[identity] = row
    if not rows:
        raise ValueError(f"no uPIMulator timings found in {path}")
    return rows


def write_comparison(
    path: Path,
    pimsa: dict[tuple[str, str, int, int, int], PimsaTiming],
    upimulator: dict[tuple[str, str, int, int, int], dict[str, str]],
) -> list[tuple[float, float]]:
    missing_pimsa = sorted(set(upimulator) - set(pimsa))
    missing_upimulator = sorted(set(pimsa) - set(upimulator))
    if missing_pimsa or missing_upimulator:
        raise ValueError(
            "timing matrices do not match: "
            f"missing PIMSA={missing_pimsa[:3]}, "
            f"missing uPIMulator={missing_upimulator[:3]}"
        )

    fields = (
        *IDENTITY_FIELDS,
        "pimsa_wall_seconds",
        "upimulator_wall_seconds",
        "upimulator_over_pimsa",
        "pimsa_result_path",
        "upimulator_metadata_path",
    )
    path.parent.mkdir(parents=True, exist_ok=True)
    paired_times: list[tuple[float, float]] = []
    with path.open("w", newline="", encoding="utf-8") as output_file:
        writer = csv.DictWriter(output_file, fieldnames=fields, lineterminator="\n")
        writer.writeheader()
        for identity in sorted(upimulator):
            benchmark, experiment, num_dpus, num_tasklets, data_size = identity
            pimsa_seconds = pimsa[identity].seconds
            upimulator_seconds = float(upimulator[identity]["wall_seconds"])
            if upimulator_seconds <= 0:
                raise ValueError(f"non-positive uPIMulator time for {identity}")
            paired_times.append((pimsa_seconds, upimulator_seconds))
            writer.writerow(
                {
                    "benchmark": benchmark,
                    "experiment": experiment,
                    "num_dpus": num_dpus,
                    "num_tasklets": num_tasklets,
                    "data_prep_params": data_size,
                    "pimsa_wall_seconds": f"{pimsa_seconds:.6f}",
                    "upimulator_wall_seconds": f"{upimulator_seconds:.6f}",
                    "upimulator_over_pimsa": (
                        f"{upimulator_seconds / pimsa_seconds:.6f}"
                    ),
                    "pimsa_result_path": pimsa[identity].result_path,
                    "upimulator_metadata_path": upimulator[identity].get(
                        "metadata_path", ""
                    ),
                }
            )
    return paired_times


def print_summary(pairs: list[tuple[float, float]]) -> None:
    pimsa = [pair[0] for pair in pairs]
    upimulator = [pair[1] for pair in pairs]
    ratios = [up / analysis for analysis, up in pairs]
    geometric_mean = math.exp(statistics.mean(math.log(value) for value in ratios))
    print(
        f"PIMSA: total={sum(pimsa):.3f}s, mean={statistics.mean(pimsa):.3f}s, "
        f"median={statistics.median(pimsa):.3f}s"
    )
    print(
        f"uPIMulator: total={sum(upimulator):.3f}s, "
        f"mean={statistics.mean(upimulator):.3f}s, "
        f"median={statistics.median(upimulator):.3f}s"
    )
    print(
        "uPIMulator/PIMSA per-configuration ratio: "
        f"geomean={geometric_mean:.2f}x, median={statistics.median(ratios):.2f}x"
    )


def main() -> int:
    args = parse_args()
    pimsa = load_pimsa_times(args.pimsa_results_root)
    upimulator = load_upimulator_rows(args.upimulator_times)
    pairs = write_comparison(args.output, pimsa, upimulator)
    print(f"Wrote {len(pairs)} matched configurations to {args.output}")
    print_summary(pairs)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
