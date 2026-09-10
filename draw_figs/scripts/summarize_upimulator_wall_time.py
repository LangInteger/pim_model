#!/usr/bin/env python3
"""Summarize per-configuration uPIMulator wall-clock times from metadata."""

from __future__ import annotations

import argparse
import csv
import statistics
import sys
from collections import defaultdict
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path


IDENTITY_FIELDS = (
    "benchmark",
    "experiment",
    "num_dpus",
    "num_tasklets",
    "data_prep_params",
)


@dataclass(frozen=True)
class TimingRecord:
    benchmark: str
    experiment: str
    num_dpus: int
    num_tasklets: int
    data_prep_params: int
    start_time: str
    end_time: str
    wall_seconds: float
    status: str
    metadata_path: Path

    @property
    def identity(self) -> tuple[str, str, int, int, int]:
        return (
            self.benchmark.upper(),
            self.experiment,
            self.num_dpus,
            self.num_tasklets,
            self.data_prep_params,
        )


def parse_args() -> argparse.Namespace:
    script_dir = Path(__file__).resolve().parent
    draw_figs_root = script_dir.parent
    parser = argparse.ArgumentParser(
        description=(
            "Compute end-to-end uPIMulator invocation time for each "
            "benchmark configuration from metadata start/end timestamps."
        )
    )
    parser.add_argument(
        "--metadata-root",
        type=Path,
        default=draw_figs_root / "simulator_results",
        help="root containing per-configuration metadata.txt files",
    )
    parser.add_argument(
        "--results-root",
        type=Path,
        default=draw_figs_root / "results",
        help="root containing current per-benchmark summary.csv files",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=draw_figs_root / ".work" / "upimulator_wall_times.csv",
        help="per-configuration output CSV",
    )
    parser.add_argument(
        "--all-metadata",
        action="store_true",
        help=(
            "include historical and failed settings instead of selecting the "
            "current evaluation matrix from results/<benchmark>/summary.csv"
        ),
    )
    return parser.parse_args()


def parse_key_values(path: Path) -> dict[str, str]:
    values: dict[str, str] = {}
    for raw_line in path.read_text(encoding="utf-8").splitlines():
        if "=" not in raw_line:
            continue
        key, value = raw_line.split("=", 1)
        values[key.strip()] = value.strip()
    return values


def parse_timestamp(value: str, path: Path, field: str) -> datetime:
    normalized = value[:-1] + "+00:00" if value.endswith("Z") else value
    try:
        return datetime.fromisoformat(normalized)
    except ValueError as error:
        raise ValueError(f"invalid {field} in {path}: {value!r}") from error


def load_metadata_record(path: Path) -> TimingRecord:
    values = parse_key_values(path)
    required = (*IDENTITY_FIELDS, "start_time", "end_time", "status")
    missing = [field for field in required if not values.get(field)]
    if missing:
        raise ValueError(f"missing {', '.join(missing)} in {path}")

    start = parse_timestamp(values["start_time"], path, "start_time")
    end = parse_timestamp(values["end_time"], path, "end_time")
    wall_seconds = (end - start).total_seconds()
    if wall_seconds < 0:
        raise ValueError(f"end_time precedes start_time in {path}")

    return TimingRecord(
        benchmark=values["benchmark"].upper(),
        experiment=values["experiment"],
        num_dpus=int(values["num_dpus"]),
        num_tasklets=int(values["num_tasklets"]),
        data_prep_params=int(values["data_prep_params"]),
        start_time=values["start_time"],
        end_time=values["end_time"],
        wall_seconds=wall_seconds,
        status=values["status"],
        metadata_path=path,
    )


def current_evaluation_identities(
    results_root: Path,
) -> set[tuple[str, str, int, int, int]]:
    identities: set[tuple[str, str, int, int, int]] = set()
    for path in sorted(results_root.glob("*/summary.csv")):
        with path.open(newline="", encoding="utf-8") as input_file:
            for row in csv.DictReader(input_file):
                identities.add(
                    (
                        row["benchmark"].upper(),
                        row["experiment"],
                        int(row["num_dpus"]),
                        int(row["num_tasklets"]),
                        int(row["data_prep_params"]),
                    )
                )
    if not identities:
        raise ValueError(f"no current evaluation settings found below {results_root}")
    return identities


def load_records(metadata_root: Path) -> list[TimingRecord]:
    records: list[TimingRecord] = []
    skipped: list[str] = []
    for path in sorted(metadata_root.rglob("metadata.txt")):
        try:
            records.append(load_metadata_record(path))
        except ValueError as error:
            skipped.append(str(error))
    if not records:
        raise ValueError(f"no metadata.txt files found below {metadata_root}")
    for reason in skipped:
        print(f"WARNING: skipping incomplete metadata: {reason}", file=sys.stderr)
    duplicate_counts: dict[tuple[str, str, int, int, int], int] = defaultdict(int)
    for record in records:
        duplicate_counts[record.identity] += 1
    duplicates = [key for key, count in duplicate_counts.items() if count > 1]
    if duplicates:
        raise ValueError(f"duplicate configuration metadata: {duplicates[:3]}")
    return records


def select_current_records(
    records: list[TimingRecord],
    identities: set[tuple[str, str, int, int, int]],
) -> list[TimingRecord]:
    by_identity = {record.identity: record for record in records}
    missing = sorted(identities - set(by_identity))
    if missing:
        raise ValueError(
            f"metadata is missing for {len(missing)} current configurations: "
            f"{missing[:3]}"
        )
    return [by_identity[identity] for identity in sorted(identities)]


def write_csv(path: Path, records: list[TimingRecord], root: Path) -> None:
    fields = (
        *IDENTITY_FIELDS,
        "start_time",
        "end_time",
        "wall_seconds",
        "status",
        "metadata_path",
    )
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="", encoding="utf-8") as output_file:
        writer = csv.DictWriter(output_file, fieldnames=fields, lineterminator="\n")
        writer.writeheader()
        for record in sorted(
            records,
            key=lambda item: (
                item.benchmark,
                item.experiment,
                item.num_dpus,
                item.num_tasklets,
                item.data_prep_params,
            ),
        ):
            try:
                metadata_path = record.metadata_path.relative_to(root)
            except ValueError:
                metadata_path = record.metadata_path
            writer.writerow(
                {
                    "benchmark": record.benchmark,
                    "experiment": record.experiment,
                    "num_dpus": record.num_dpus,
                    "num_tasklets": record.num_tasklets,
                    "data_prep_params": record.data_prep_params,
                    "start_time": record.start_time,
                    "end_time": record.end_time,
                    "wall_seconds": f"{record.wall_seconds:.6f}",
                    "status": record.status,
                    "metadata_path": str(metadata_path),
                }
            )


def format_duration(seconds: float) -> str:
    if seconds < 60:
        return f"{seconds:.1f}s"
    minutes, remainder = divmod(seconds, 60)
    if minutes < 60:
        return f"{int(minutes)}m {remainder:04.1f}s"
    hours, minutes = divmod(int(minutes), 60)
    return f"{hours}h {minutes:02d}m"


def print_group_summary(
    label: str, grouped: dict[str, list[float]], total_label: str
) -> None:
    print(f"\n{label}")
    print(f"{'group':<18} {'n':>4} {'total':>10} {'mean':>10} {'median':>10}")
    for group in sorted(grouped):
        values = grouped[group]
        print(
            f"{group:<18} {len(values):>4} "
            f"{format_duration(sum(values)):>10} "
            f"{format_duration(statistics.mean(values)):>10} "
            f"{format_duration(statistics.median(values)):>10}"
        )
    all_values = [value for values in grouped.values() for value in values]
    print(
        f"{total_label:<18} {len(all_values):>4} "
        f"{format_duration(sum(all_values)):>10} "
        f"{format_duration(statistics.mean(all_values)):>10} "
        f"{format_duration(statistics.median(all_values)):>10}"
    )


def print_summary(records: list[TimingRecord]) -> None:
    successful = [record for record in records if record.status == "success"]
    unsuccessful = [record for record in records if record.status != "success"]
    if not successful:
        raise ValueError("no successful metadata records to summarize")

    by_benchmark: dict[str, list[float]] = defaultdict(list)
    by_sweep: dict[str, list[float]] = defaultdict(list)
    for record in successful:
        by_benchmark[record.benchmark].append(record.wall_seconds)
        by_sweep[record.experiment].append(record.wall_seconds)

    print_group_summary("By benchmark", by_benchmark, "ALL")
    print_group_summary("By sweep", by_sweep, "ALL")

    print("\nSlowest configurations")
    print(
        f"{'benchmark':<10} {'sweep':<16} {'DPUs':>5} "
        f"{'tasklets':>8} {'wall time':>10}"
    )
    for record in sorted(
        successful, key=lambda item: item.wall_seconds, reverse=True
    )[:10]:
        print(
            f"{record.benchmark:<10} {record.experiment:<16} "
            f"{record.num_dpus:>5} {record.num_tasklets:>8} "
            f"{format_duration(record.wall_seconds):>10}"
        )

    if unsuccessful:
        statuses: dict[str, int] = defaultdict(int)
        for record in unsuccessful:
            statuses[record.status] += 1
        details = ", ".join(f"{key}={value}" for key, value in sorted(statuses.items()))
        print(f"\nNon-successful records included in CSV but excluded from summary: {details}")


def main() -> int:
    args = parse_args()
    records = load_records(args.metadata_root)
    if not args.all_metadata:
        records = select_current_records(
            records, current_evaluation_identities(args.results_root)
        )
    write_csv(args.output, records, args.metadata_root)
    scope = "all metadata" if args.all_metadata else "current evaluation matrix"
    print(f"Scope: {scope}; {len(records)} configurations")
    print(f"Per-configuration CSV: {args.output}")
    print_summary(records)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
