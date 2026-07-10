#!/usr/bin/env python3
"""Repository-level v9 smoke validation that does not require Flutter/Dart.

This validates document/data syntax, card/path references, and the canonical
v9 curriculum invariants. It does not prove Flutter compilation, device audio
behavior, vocal safety, or learning efficacy.
"""
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

try:
    import yaml
except ImportError:  # pragma: no cover - environment guard
    yaml = None

ROOT = Path(__file__).resolve().parents[1]
CARD_PATTERN = r"(?:CARD|UC|IC|TONE|RA|IM|CL|GY|RB|RK|WC)-\d+"


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


def parse_yaml_files() -> int:
    if yaml is None:
        fail("PyYAML is unavailable")
    count = 0
    for path in ROOT.rglob("*.yaml"):
        try:
            yaml.safe_load(path.read_text(encoding="utf-8"))
        except Exception as exc:
            fail(f"Invalid YAML: {path.relative_to(ROOT)}: {exc}")
        count += 1
    return count


def scan_dart_delimiters() -> int:
    """Lightweight string/comment-aware delimiter balance check."""
    pairs = {")": "(", "]": "[", "}": "{"}
    openers = set(pairs.values())
    count = 0
    for path in ROOT.rglob("*.dart"):
        text = path.read_text(encoding="utf-8")
        stack: list[tuple[str, int]] = []
        i = 0
        mode = "code"
        quote = ""
        while i < len(text):
            ch = text[i]
            nxt = text[i + 1] if i + 1 < len(text) else ""
            if mode == "line_comment":
                if ch == "\n":
                    mode = "code"
                i += 1
                continue
            if mode == "block_comment":
                if ch == "*" and nxt == "/":
                    mode = "code"
                    i += 2
                else:
                    i += 1
                continue
            if mode == "string":
                if ch == "\\":
                    i += 2
                    continue
                if ch == quote:
                    mode = "code"
                i += 1
                continue
            if ch == "/" and nxt == "/":
                mode = "line_comment"
                i += 2
                continue
            if ch == "/" and nxt == "*":
                mode = "block_comment"
                i += 2
                continue
            if ch in ("'", '"'):
                mode = "string"
                quote = ch
                i += 1
                continue
            if ch in openers:
                stack.append((ch, i))
            elif ch in pairs:
                if not stack or stack[-1][0] != pairs[ch]:
                    fail(f"Unbalanced Dart delimiter: {path.relative_to(ROOT)} at {i}")
                stack.pop()
            i += 1
        if stack:
            fail(f"Unclosed Dart delimiter: {path.relative_to(ROOT)}: {stack[-1]}")
        count += 1
    return count


def extract_card_library_ids(text: str) -> set[str]:
    return set(re.findall(rf"'({CARD_PATTERN})'\s*:\s*Card\(", text))


def extract_all_card_refs(text: str) -> set[str]:
    return set(re.findall(rf"'({CARD_PATTERN})'", text))


def extract_card_blocks(text: str) -> dict[str, str]:
    """Extract top-level Card(...) source blocks using balanced parentheses."""
    blocks: dict[str, str] = {}
    for match in re.finditer(rf"'({CARD_PATTERN})'\s*:\s*Card\(", text):
        card_id = match.group(1)
        start = match.end() - 1
        depth = 0
        i = start
        mode = "code"
        quote = ""
        while i < len(text):
            ch = text[i]
            nxt = text[i + 1] if i + 1 < len(text) else ""
            if mode == "line_comment":
                if ch == "\n": mode = "code"
                i += 1; continue
            if mode == "block_comment":
                if ch == "*" and nxt == "/": mode = "code"; i += 2
                else: i += 1
                continue
            if mode == "string":
                if ch == "\\": i += 2; continue
                if ch == quote: mode = "code"
                i += 1; continue
            if ch == "/" and nxt == "/": mode = "line_comment"; i += 2; continue
            if ch == "/" and nxt == "*": mode = "block_comment"; i += 2; continue
            if ch in ("'", '"'):
                mode = "string"; quote = ch; i += 1; continue
            if ch == "(": depth += 1
            elif ch == ")":
                depth -= 1
                if depth == 0:
                    blocks[card_id] = text[start:i + 1]
                    break
            i += 1
        else:
            fail(f"Unclosed Card constructor: {card_id}")
    return blocks


def extract_beginner(path_text: str) -> list[str]:
    match = re.search(r"const _beginnerCards = <String>\[(.*?)\];", path_text, re.S)
    if not match:
        fail("Could not parse beginner manifest")
    return re.findall(rf"'({CARD_PATTERN})'", match.group(1))


def extract_cycle_cards(path_text: str, const_name: str) -> list[list[str]]:
    match = re.search(rf"const {re.escape(const_name)} = <_Cycle>\[(.*?)\n\];", path_text, re.S)
    if not match:
        fail(f"Could not parse {const_name}")
    body = match.group(1)
    cycles = []
    for cycle_match in re.finditer(r"_Cycle\([^\[]*\[(.*?)\]\s*,\s*[0-9.]+\s*,\s*VariationLevel\.[a-zA-Z]+\s*\)", body, re.S):
        cards = re.findall(rf"'({CARD_PATTERN})'", cycle_match.group(1))
        cycles.append(cards)
    return cycles


def extract_block_cards(path_text: str, const_name: str) -> list[tuple[int, list[str]]]:
    match = re.search(rf"const {re.escape(const_name)} = <_Block>\[(.*?)\n\];", path_text, re.S)
    if not match:
        fail(f"Could not parse {const_name}")
    result: list[tuple[int, list[str]]] = []
    for m in re.finditer(r"_Block\(\s*\d+\s*,\s*(\d+)\s*,\s*\[(.*?)\]", match.group(1), re.S):
        result.append((int(m.group(1)), re.findall(rf"'({CARD_PATTERN})'", m.group(2))))
    return result


def expand_blocks(blocks: list[tuple[int, list[str]]]) -> list[str]:
    out: list[str] = []
    prev = 0
    for end, cards in blocks:
        if not cards or end <= prev:
            fail(f"Invalid block definition: end={end}, prev={prev}, cards={cards}")
        for lesson in range(prev + 1, end + 1):
            out.append(cards[(lesson - prev - 1) % len(cards)])
        prev = end
    return out


def validate_curriculum() -> dict[str, object]:
    path_text = (ROOT / "app/lib/progression/path.dart").read_text(encoding="utf-8")
    library_text = (ROOT / "app/lib/lesson/card_library.dart").read_text(encoding="utf-8")
    library_ids = extract_card_library_ids(library_text)
    if len(library_ids) != len(re.findall(rf"'({CARD_PATTERN})'\s*:\s*Card\(", library_text)):
        fail("Duplicate card ID detected")
    blocks = extract_card_blocks(library_text)
    if set(blocks) != library_ids:
        fail("Card block extraction mismatch")
    required_fields = ("cue:", "voicedMicroWin:", "anatomyEntry:", "anatomyMain:", "anatomyCooldown:")
    for card_id, block in blocks.items():
        missing_fields = [field for field in required_fields if field not in block]
        if missing_fields:
            fail(f"{card_id} missing required content fields: {missing_fields}")
    for token in ("왜", "이유", "때문", "위해서", "효과"):
        if token in library_text:
            fail(f"Card library contains rationale token prohibited by ADR-0002: {token}")
    required_v9_ids = {
        *(f"UC-{i:02d}" for i in range(18, 26)),
        "RA-09", "RA-10",
        *(f"RB-{i:02d}" for i in range(1, 7)),
        *(f"RK-{i:02d}" for i in range(1, 7)),
        *(f"WC-{i:02d}" for i in range(1, 7)),
    }
    if not required_v9_ids <= library_ids:
        fail(f"Missing v9 cards: {sorted(required_v9_ids - library_ids)}")

    used_ids = extract_all_card_refs(path_text)
    missing = sorted(used_ids - library_ids)
    if missing:
        fail(f"Path references unknown cards: {missing}")

    beginner = extract_beginner(path_text)
    if len(beginner) != 48:
        fail(f"Beginner length {len(beginner)} != 48")
    if [i + 1 for i, c in enumerate(beginner) if c == "CARD-13"] != [1, 24, 48]:
        fail("Beginner standard sample is not Day 1/24/48")
    if "CARD-18" in beginner:
        fail("Recovery card CARD-18 must not be in normal Beginner path")
    if beginner.count("CARD-14") < 3:
        fail("Beginner listen-imagine-hum exposure should be at least 3")

    universal = extract_cycle_cards(path_text, "_universalCoreCycles")
    if len(universal) != 12 or any(len(c) != 12 for c in universal):
        fail(f"Universal Core must be 12 cycles x 12; got {[len(c) for c in universal]}")
    universal_flat = [c for cycle in universal for c in cycle]
    if len(universal_flat) != 144:
        fail("Universal Core length != 144")
    if [i + 1 for i, c in enumerate(universal_flat) if c == "UC-17"] != [36, 72, 108, 144]:
        fail("UC-17 formal checkpoints must be Day 36/72/108/144")
    if "CARD-18" in universal_flat:
        fail("Recovery card CARD-18 must not be in Universal Core path")
    pitch_cards = {"CARD-12", "CARD-14", "UC-05", "UC-06", "UC-07", "UC-19"}
    rhythm_cards = {"CARD-15", "UC-08", "UC-09", "UC-20"}
    phrase_cards = {"UC-16", "UC-18", "UC-23"}
    review_cards = {"UC-17", "UC-25"}
    for idx, cycle in enumerate(universal, start=1):
        if not set(cycle) & pitch_cards:
            fail(f"Universal cycle {idx} lacks pitch/ear work")
        if not set(cycle) & rhythm_cards:
            fail(f"Universal cycle {idx} lacks rhythm/time work")
        if not set(cycle) & phrase_cards:
            fail(f"Universal cycle {idx} lacks phrase work")
        if not set(cycle) & review_cards:
            fail(f"Universal cycle {idx} lacks review/retrieval work")

    repertoire = extract_cycle_cards(path_text, "_repertoireApplicationCycles")
    if len(repertoire) != 6 or any(len(c) != 12 for c in repertoire):
        fail(f"Repertoire must be 6 projects x 12; got {[len(c) for c in repertoire]}")
    repertoire_flat = [c for cycle in repertoire for c in cycle]
    for idx, project in enumerate(repertoire, start=1):
        if project[0] != "RA-09" or project[-1] != "RA-10":
            fail(f"Repertoire project {idx} must begin RA-09 and end RA-10")
    if set(repertoire_flat) & {"CARD-18", "IC-12"}:
        fail("Recovery/legacy standard sample must not be scheduled in Repertoire path")

    advanced_names = [
        "_advancedGayoBlocks", "_advancedMusicalBlocks", "_advancedClassicalBlocks",
        "_advancedRbSoulBlocks", "_advancedRockBlocks", "_advancedCcmBlocks",
        "_advancedUserSongBlocks",
    ]
    advanced: dict[str, list[str]] = {}
    for name in advanced_names:
        expanded = expand_blocks(extract_block_cards(path_text, name))
        if len(expanded) != 40:
            fail(f"{name} length {len(expanded)} != 40")
        if "CARD-18" in expanded:
            fail(f"{name} schedules recovery card CARD-18")
        advanced[name] = expanded
    for name, prefix in [
        ("_advancedRbSoulBlocks", "RB-"),
        ("_advancedRockBlocks", "RK-"),
        ("_advancedCcmBlocks", "WC-"),
    ]:
        if not any(card.startswith(prefix) for card in advanced[name]):
            fail(f"{name} lacks dedicated {prefix} cards")

    fallbacks = re.findall(rf"fallbackCardId:\s*'({CARD_PATTERN})'", library_text)
    missing_fallbacks = sorted(set(fallbacks) - library_ids)
    if missing_fallbacks:
        fail(f"Fallback targets missing: {missing_fallbacks}")

    if re.search(r"id:\s*'UC-04'.*?label:\s*['\"][^'\"]*pressed[^'\"]*['\"]", library_text, re.S | re.I):
        fail("UC-04 may not ask the learner to produce pressed phonation")
    if "pressed_listening_only" not in library_text:
        fail("UC-04 pressed example must be listening-only")

    return {
        "cardLibrary": len(library_ids),
        "pathCardIds": len(used_ids),
        "fallbackTargets": len(fallbacks),
        "beginner": len(beginner),
        "universalCycles": len(universal),
        "universalSlots": len(universal_flat),
        "repertoireProjects": len(repertoire),
        "repertoireSlots": len(repertoire_flat),
        "advancedCycles": {k: len(v) for k, v in advanced.items()},
    }


def validate_docs_and_version() -> dict[str, object]:
    required = [
        "docs/curriculum/CURRICULUM-REVIEW.md",
        "docs/curriculum/CURRICULUM-QUALITY-GATES.md",
        "docs/curriculum/LEARNING-METHODOLOGY-SPEC.md",
        "docs/curriculum/REPERTOIRE-APPLICATION-SPEC.md",
        "docs/curriculum/universal-core/CURRICULUM.md",
        "docs/research/v9/CURRICULUM-RECHECK.md",
        "docs/research/v9/VERIFIED-SOURCES.md",
        "docs/adr/0027-curriculum-microcycles-and-phrase-projects-v9.md",
    ]
    missing = [p for p in required if not (ROOT / p).exists()]
    if missing:
        fail(f"Missing v9 documents: {missing}")

    pubspec = (ROOT / "app/pubspec.yaml").read_text(encoding="utf-8")
    if "version: 1.9.0+9" not in pubspec:
        fail("pubspec version is not 1.9.0+9")
    verification = json.loads((ROOT / "docs/verification/verification-status.json").read_text(encoding="utf-8"))
    if verification.get("version") != "v9" or verification.get("appVersion") != "1.9.0+9":
        fail("verification version markers do not match v9")
    return {"requiredDocs": len(required), "version": "v9", "appVersion": "1.9.0+9"}


def main() -> int:
    report = {
        "jsonFiles": parse_json_files(),
        "yamlFiles": parse_yaml_files(),
        "dartDelimiterFiles": scan_dart_delimiters(),
        "curriculum": validate_curriculum(),
        "docs": validate_docs_and_version(),
    }
    print(json.dumps({"status": "PASS", **report}, ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except AssertionError as exc:
        print(f"FAIL: {exc}", file=sys.stderr)
        raise SystemExit(1)
