#!/usr/bin/env python3
"""Compare generic static instruction-count results against simulator summary.csv.

The comparison is Q1-only: static dynamic instruction count vs instructions_mean.
No cycle/stall fields are used.
"""
from __future__ import annotations

import argparse
import csv
import json
import math
from pathlib import Path
from typing import Any


def _norm(v: Any) -> str | None:
    if v is None or v == "":
        return None
    try:
        f = float(v)
        if math.isfinite(f) and f.is_integer():
            return str(int(f))
        return str(f)
    except Exception:
        return str(v).strip()


def _float(v):
    if v is None or v == "":
        return None
    try:
        return float(v)
    except Exception:
        return None


def load_static_results(root: Path):
    seen = set()
    for p in sorted(root.rglob("*.json")):
        compact_path = p.with_name("result.json")
        if p.name in {"debug.json", "generic_count.json"} and compact_path.is_file():
            continue
        try:
            d = json.loads(p.read_text())
        except Exception:
            continue
        if not isinstance(d, dict) or "dynamic_instruction_bound" not in d:
            continue
        # Keep result.json compact on disk, but borrow optional matching metadata
        # from its debug sibling for this in-memory comparison.
        if p.name == "result.json" and not d.get("simulator_match"):
            debug_path = p.with_name("debug.json")
            if debug_path.is_file():
                try:
                    debug = json.loads(debug_path.read_text())
                    if debug.get("simulator_match"):
                        d["simulator_match"] = debug["simulator_match"]
                except Exception:
                    pass
        sig = (d.get("benchmark"), d.get("tasklets"), json.dumps(d.get("params", {}), sort_keys=True), json.dumps(d.get("simulator_match", {}), sort_keys=True))
        if sig in seen:
            continue
        seen.add(sig)
        yield p, d


def candidate_rows(sim_rows, d):
    b = d.get("benchmark")
    t = d.get("tasklets")
    meta = d.get("simulator_match") or {}
    out = []
    for r in sim_rows:
        if r.get("benchmark") != b:
            continue
        if _norm(r.get("num_tasklets")) != _norm(t):
            continue
        if meta.get("experiment") is not None and r.get("experiment") != str(meta["experiment"]):
            continue
        if meta.get("num_dpus_configured") is not None and _norm(r.get("num_dpus_configured")) != _norm(meta["num_dpus_configured"]):
            continue
        if meta.get("data_prep_params") is not None and _norm(r.get("data_prep_params")) != _norm(meta["data_prep_params"]):
            continue
        out.append(r)
    return out


def pct(pred, gt):
    return None if pred is None or gt in (None, 0) else 100.0 * (pred - gt) / gt


def main():
    ap = argparse.ArgumentParser(description="Compare Q1 static instruction counts with simulator instructions_mean")
    ap.add_argument("--static-dir", required=True)
    ap.add_argument("--simulator", required=True, help="simulator summary.csv")
    ap.add_argument("-o", "--output", required=True)
    args = ap.parse_args()

    with open(args.simulator, newline="") as f:
        sim_rows = list(csv.DictReader(f))

    rows = []
    for path, d in load_static_results(Path(args.static_dir)):
        bnd = d.get("dynamic_instruction_bound") or {}
        lo = _float(bnd.get("lower"))
        hi = _float(bnd.get("upper"))
        exact = bool(bnd.get("exact")) and lo is not None and hi is not None
        matches = candidate_rows(sim_rows, d)
        callees = set(d.get("unexpanded_callees") or [])
        def collect_calls(obj):
            if isinstance(obj, dict):
                c=obj.get("callee")
                reason=obj.get("reason", "")
                if c and ("external" in reason or "runtime" in reason or "not defined" in reason):
                    callees.add(c)
                for k,v in obj.items():
                    if k in ("unexpanded_calls", "callee_unexpanded_calls"):
                        collect_calls(v)
                    elif k == "expanded_calls":
                        collect_calls(v)
            elif isinstance(obj, list):
                for x in obj: collect_calls(x)
        for pt in (d.get("per_tasklet") or []):
            collect_calls(pt.get("unexpanded_calls") or [])
            collect_calls(pt.get("expanded_calls") or [])
        callees = sorted(callees)
        base = {
            "benchmark": d.get("benchmark"),
            "tasklets": d.get("tasklets"),
            "static_lower": lo,
            "static_upper": hi,
            "static_exact": exact,
            "static_result": str(path),
            "match_count": len(matches),
            "has_unexpanded_calls": bool(callees),
            "unexpanded_callees": ";".join(callees),
        }
        if len(matches) != 1:
            base.update({
                "status": "unmatched" if not matches else "ambiguous",
                "experiment": "", "num_dpus_configured": "", "data_prep_params": "",
                "sim_instructions_mean": "", "sim_instructions_min": "", "sim_instructions_max": "",
                "exact_error_pct": "", "midpoint_error_pct": "", "distance_to_interval_pct": "",
                "sim_inside_static_interval": "", "static_interval_width_pct_of_sim": "",
            })
            rows.append(base)
            continue

        r = matches[0]
        gt = _float(r.get("instructions_mean"))
        midpoint = None if lo is None or hi is None else (lo + hi) / 2.0
        inside = None if gt is None or lo is None or hi is None else (lo <= gt <= hi)
        if gt in (None, 0) or lo is None or hi is None:
            dist = None
            width = None
        else:
            if gt < lo:
                dist = 100.0 * (lo - gt) / gt
            elif gt > hi:
                dist = 100.0 * (gt - hi) / gt
            else:
                dist = 0.0
            width = 100.0 * (hi - lo) / gt
        base.update({
            "status": "matched",
            "experiment": r.get("experiment", ""),
            "num_dpus_configured": r.get("num_dpus_configured", ""),
            "data_prep_params": r.get("data_prep_params", ""),
            "sim_instructions_mean": gt,
            "sim_instructions_min": _float(r.get("instructions_min")),
            "sim_instructions_max": _float(r.get("instructions_max")),
            "exact_error_pct": pct(lo, gt) if exact else "",
            "midpoint_error_pct": pct(midpoint, gt) if midpoint is not None else "",
            "distance_to_interval_pct": dist,
            "sim_inside_static_interval": inside,
            "static_interval_width_pct_of_sim": width,
        })
        rows.append(base)

    out = Path(args.output)
    out.parent.mkdir(parents=True, exist_ok=True)
    fields = [
        "benchmark", "experiment", "num_dpus_configured", "tasklets", "data_prep_params",
        "static_lower", "static_upper", "static_exact", "sim_instructions_mean",
        "sim_instructions_min", "sim_instructions_max", "exact_error_pct", "midpoint_error_pct",
        "distance_to_interval_pct", "sim_inside_static_interval", "static_interval_width_pct_of_sim",
        "has_unexpanded_calls", "unexpanded_callees", "status", "match_count", "static_result",
    ]
    with out.open("w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=fields)
        w.writeheader(); w.writerows(rows)

    matched = [r for r in rows if r["status"] == "matched"]
    exact_rows = [r for r in matched if r["exact_error_pct"] not in ("", None)]
    bounded_rows = [r for r in matched if r["static_lower"] is not None and r["static_upper"] is not None]
    exact_mape = (sum(abs(float(r["exact_error_pct"])) for r in exact_rows) / len(exact_rows)) if exact_rows else None
    coverage = (sum(bool(r["sim_inside_static_interval"]) for r in bounded_rows) / len(bounded_rows)) if bounded_rows else None
    mean_dist = (sum(float(r["distance_to_interval_pct"]) for r in bounded_rows if r["distance_to_interval_pct"] is not None) / len(bounded_rows)) if bounded_rows else None
    summary = {
        "static_results": len(rows),
        "matched": len(matched),
        "unmatched": sum(r["status"] == "unmatched" for r in rows),
        "ambiguous": sum(r["status"] == "ambiguous" for r in rows),
        "exact_matched": len(exact_rows),
        "exact_MAPE_pct": exact_mape,
        "bounded_matched": len(bounded_rows),
        "simulator_mean_inside_static_interval_fraction": coverage,
        "mean_distance_to_static_interval_pct": mean_dist,
        "results_with_unexpanded_calls": sum(bool(r.get("has_unexpanded_calls")) for r in matched),
        "note": "Q1 only: comparison uses instructions_mean and does not use simulator cycle/stall fields. Internal benchmark calls are recursively expanded. Results with remaining unexpanded external/runtime calls still have a scope mismatch against whole-execution simulator instruction counts.",
    }
    out.with_suffix(".summary.json").write_text(json.dumps(summary, indent=2) + "\n")
    print(json.dumps(summary, indent=2))


if __name__ == "__main__":
    main()
