#!/usr/bin/env python3
"""Repository-level v8 smoke validation that does not require Flutter/Dart."""
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def fail(message: str) -> None:
    raise AssertionError(message)


def parse_json_files() -> int:
    count = 0
    for path in ROOT.rglob("*.json"):
        try:
            json.loads(path.read_text(encoding="utf-8"))
        except Exception as exc:
            fail(f"Invalid JSON: {path.relative_to(ROOT)}: {exc}")
        count += 1
    return count


def quoted_ids(text: str) -> set[str]:
    return set(re.findall(r"'((?:CARD|UC|IC|TONE|RA|IM|CL|GY)-\d+)'", text))


def validate_cards_and_paths() -> dict[str, int]:
    path_text = (ROOT / "app/lib/progression/path.dart").read_text(encoding="utf-8")
    library_text = (ROOT / "app/lib/lesson/card_library.dart").read_text(encoding="utf-8")
    library_ids = set(re.findall(r"'((?:CARD|UC|IC|TONE|RA|IM|CL|GY)-\d+)'\s*:\s*Card\(", library_text))
    used_ids = quoted_ids(path_text)
    dangling = sorted(used_ids - library_ids)
    if dangling:
        fail(f"Path references unknown cards: {dangling}")

    beginner_match = re.search(r"const _beginnerCards = <String>\[(.*?)\];", path_text, re.S)
    if not beginner_match:
        fail("Could not parse beginner manifest")
    beginner = re.findall(r"'([^']+)'", beginner_match.group(1))
    if len(beginner) != 48:
        fail(f"Beginner length {len(beginner)} != 48")
    sample_days = [i + 1 for i, card in enumerate(beginner) if card == "CARD-13"]
    if sample_days != [1, 24, 48]:
        fail(f"Standard sample days mismatch: {sample_days}")

    constants = {
        key: int(value)
        for key, value in re.findall(
            r"const int (pathLength|universalCoreLength|repertoireApplicationLength|advancedCycleLength) = (\d+);",
            path_text,
        )
    }
    expected = {
        "pathLength": 48,
        "universalCoreLength": 144,
        "repertoireApplicationLength": 72,
        "advancedCycleLength": 40,
    }
    if constants != expected:
        fail(f"Length constants mismatch: {constants}")

    if path_text.count("'UC-17'") != 4:
        fail("UC-17 should occur once in each spiral block definition")

    fallbacks = re.findall(r"fallbackCardId:\s*'([^']+)'", library_text)
    missing_fallbacks = sorted(set(fallbacks) - library_ids)
    if missing_fallbacks:
        fail(f"Fallback targets missing: {missing_fallbacks}")

    return {
        "card_library": len(library_ids),
        "path_card_ids": len(used_ids),
        "fallbacks": len(fallbacks),
    }


def validate_research() -> dict[str, int]:
    bundle = ROOT / "docs/research/v8/source-bundle"
    docs = sorted(bundle.glob("*.md"))
    if len(docs) != 21:
        fail(f"Research bundle count {len(docs)} != 21")
    ref_lists = [re.findall(r"turn\d+\w+\d+", p.read_text(encoding="utf-8")) for p in docs[:5]]
    occurrences = sum(len(x) for x in ref_lists)
    distinct_by_document = sum(len(set(x)) for x in ref_lists)
    globally_unique = len(set().union(*(set(x) for x in ref_lists)))
    status = json.loads((ROOT / "docs/research/v8/import-status.json").read_text(encoding="utf-8"))
    declared = sum(v.get("turn_refs", 0) for v in status.values() if v.get("status") == "SOURCE_RECOVERY_REQUIRED")
    if (occurrences, distinct_by_document, globally_unique, declared) != (725, 195, 176, 195):
        fail(f"Unresolved citation count mismatch: occurrences={occurrences}, per_doc_unique={distinct_by_document}, global_unique={globally_unique}, declared={declared}")
    required = [
        "EVIDENCE-TAXONOMY.md",
        "EVIDENCE-MATRIX.md",
        "SOURCE-STATUS-MATRIX.md",
        "SOURCE-RECOVERY-BACKLOG.md",
        "RHYTHM-TIME-RESEARCH-GAP.md",
        "VERIFIED-ANCHOR-SOURCES.md",
        "RHYTHM-TIME-INTERIM-REVIEW.md",
        "SOVT-TRANSFER-INTERIM-REVIEW.md",
    ]
    for name in required:
        if not (ROOT / "docs/research/v8" / name).exists():
            fail(f"Missing v8 research artifact: {name}")
    return {"documents": len(docs), "turn_ref_occurrences": occurrences, "turn_ref_distinct_by_document": distinct_by_document, "turn_ref_globally_unique": globally_unique}


def validate_version() -> None:
    pubspec = (ROOT / "app/pubspec.yaml").read_text(encoding="utf-8")
    if "version: 1.8.0+8" not in pubspec:
        fail("pubspec version is not 1.8.0+8")
    verification = json.loads((ROOT / "docs/verification/verification-status.json").read_text(encoding="utf-8"))
    if verification.get("version") != "v8" or verification.get("appVersion") != "1.8.0+8":
        fail("verification version markers do not match v8")


def main() -> int:
    report = {
        "json_files": parse_json_files(),
        "cards": validate_cards_and_paths(),
        "research": validate_research(),
    }
    validate_version()
    print(json.dumps({"status": "PASS", **report}, ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except AssertionError as exc:
        print(f"FAIL: {exc}", file=sys.stderr)
        raise SystemExit(1)
