#!/usr/bin/env python3
"""Repository-level v15 validation without Flutter/Dart execution.

Checks v14 invariants plus timbre research normalization, spiral placement,
bounded A/B/C recording metadata, Tone Profile wiring, version/docs, generated
content hashes, and local imports. It does not prove Flutter compilation,
plugin/device behavior, vocal safety, rights clearance, or learning efficacy.
"""
from __future__ import annotations

import csv
import hashlib
import json
import re
import subprocess
import sys
from pathlib import Path

import validate_v12 as base

ROOT = Path(__file__).resolve().parents[1]
base.ROOT = ROOT


def fail(message: str) -> None:
    raise AssertionError(message)


def validate_local_package_imports() -> int:
    package_root = ROOT / "app/lib"
    checked = 0
    paths = (
        list((ROOT / "app/lib").rglob("*.dart"))
        + list((ROOT / "app/test").rglob("*.dart"))
        + list((ROOT / "app/integration_test").rglob("*.dart"))
    )
    for dart in paths:
        text = dart.read_text(encoding="utf-8")
        for match in re.finditer(r"import\s+'package:vocal_athlete/([^']+)'", text):
            target = package_root / match.group(1)
            if not target.exists():
                fail(
                    f"Missing package import target from {dart.relative_to(ROOT)}: "
                    f"{match.group(1)}"
                )
            checked += 1
        for match in re.finditer(r"import\s+'(\.\.?/[^']+)'", text):
            target = (dart.parent / match.group(1)).resolve()
            if not target.exists():
                fail(
                    f"Missing relative import target from {dart.relative_to(ROOT)}: "
                    f"{match.group(1)}"
                )
            checked += 1
    return checked


def validate_content_manifest() -> dict[str, object]:
    rel = "app/assets/curriculum/content_manifest_v15.json"
    path = ROOT / rel
    if not path.exists():
        fail(f"Missing content manifest: {rel}")
    manifest = json.loads(path.read_text(encoding="utf-8"))
    if manifest.get("schema") != "vocal-athlete/curriculum-content-manifest@2":
        fail("Unexpected v15 content manifest schema")
    if manifest.get("version") != "v15" or manifest.get("algorithm") != "sha256":
        fail("v15 content manifest version/algorithm mismatch")
    files = manifest.get("files")
    if not isinstance(files, dict) or len(files) != 25:
        fail(f"v15 content manifest must track 25 files, got {len(files or {})}")
    kinds: dict[str, int] = {}
    for asset_path, metadata in files.items():
        full = ROOT / "app" / asset_path
        if not full.exists():
            fail(f"Manifest references missing file: {asset_path}")
        actual = hashlib.sha256(full.read_bytes()).hexdigest()
        if metadata.get("sha256") != actual:
            fail(f"SHA-256 mismatch for {asset_path}")
        kind = str(metadata.get("kind", "unknown"))
        kinds[kind] = kinds.get(kind, 0) + 1
    expected = {
        "blueprint": 2,
        "asset_manifest": 1,
        "rights_record": 2,
        "audio": 20,
    }
    if kinds != expected:
        fail(f"Unexpected v15 manifest kind counts: {kinds}")
    proc = subprocess.run(
        [
            sys.executable,
            str(ROOT / "tools/generate_content_manifest.py"),
            "--version",
            "v15",
            "--check",
        ],
        cwd=ROOT,
        text=True,
        capture_output=True,
    )
    if proc.returncode != 0:
        fail(f"Manifest generator check failed: {proc.stdout}{proc.stderr}")
    return {"manifestFiles": len(files), "kinds": kinds, "generatorCheck": "PASS"}


def _card_blocks() -> dict[str, str]:
    text = (ROOT / "app/lib/lesson/card_library.dart").read_text(encoding="utf-8")
    return base.extract_card_blocks(text)


def validate_timbre_code() -> dict[str, object]:
    required = [
        "app/lib/timbre/tone_profile.dart",
        "app/lib/lesson/tone_profile_screen.dart",
        "app/test/tone_profile_test.dart",
        "app/test/tone_profile_screen_test.dart",
    ]
    missing = [rel for rel in required if not (ROOT / rel).exists()]
    if missing:
        fail(f"Missing v15 timbre implementation files: {missing}")

    card_model = (ROOT / "app/lib/lesson/card.dart").read_text(encoding="utf-8")
    for token in ("timbreLayer", "toneTagOptions", "toneSequence"):
        if token not in card_model:
            fail(f"Card timbre metadata missing: {token}")

    blocks = _card_blocks()
    allowed_layers = {"source", "filter", "style", "learningSafety"}
    for i in range(1, 14):
        card_id = f"TONE-{i:02d}"
        block = blocks.get(card_id)
        if block is None:
            fail(f"Missing timbre card {card_id}")
        for field in ("timbreLayer:", "toneTagOptions:", "toneGoal:", "maxTakeCount:"):
            if block.count(field) != 1:
                fail(f"{card_id} must declare {field} exactly once")
        layer = re.search(r"timbreLayer:\s*'([^']+)'", block)
        if not layer or layer.group(1) not in allowed_layers:
            fail(f"{card_id} has invalid timbre layer")
        max_take = re.search(r"maxTakeCount:\s*(\d+)", block)
        if not max_take or not 1 <= int(max_take.group(1)) <= 3:
            fail(f"{card_id} maxTakeCount must be 1..3")

    if "toneSequence: ['bright', 'warm']" not in blocks["TONE-07"]:
        fail("TONE-07 bright/warm sequence missing")
    if "toneSequence: ['clean', 'warm', 'speechLike']" not in blocks["TONE-12"]:
        fail("TONE-12 clean/warm/speechLike sequence missing")
    if "safetyIntensity: 'moderate'" not in blocks["TONE-13"]:
        fail("TONE-13 must remain moderate and advanced-scoped")

    recording = (ROOT / "app/lib/recording/recording_ab.dart").read_text(
        encoding="utf-8"
    )
    for token in (
        "ToneTag.clean",
        "ToneTag.airyFeeling",
        "ToneTag.effortful",
        "toneTagFromName",
    ):
        if token not in recording:
            fail(f"ToneTag mapping marker missing: {token}")

    panel = (ROOT / "app/lib/lesson/recording_ab_panel.dart").read_text(
        encoding="utf-8"
    )
    for token in ("availableToneTags", "takeToneSequence", "tone-take-target"):
        if token not in panel:
            fail(f"Recording A/B tone-sequence marker missing: {token}")

    lesson = (ROOT / "app/lib/lesson/lesson_screen.dart").read_text(encoding="utf-8")
    for token in ("toneTagOptions", "toneSequence", "_toneTagsFromNames"):
        if token not in lesson:
            fail(f"Lesson tone metadata wiring missing: {token}")

    main = (ROOT / "app/lib/main.dart").read_text(encoding="utf-8")
    settings = (ROOT / "app/lib/lesson/settings_screen.dart").read_text(
        encoding="utf-8"
    )
    for token in (
        "ToneProfileScreen",
        "_showToneProfile",
        "onOpenToneProfile",
        "settings-tone-profile",
    ):
        if token not in main + settings:
            fail(f"Tone Profile route marker missing: {token}")

    profile = (ROOT / "app/lib/timbre/tone_profile.dart").read_text(encoding="utf-8")
    for token in (
        "class ToneProfile",
        "comfortableTagCounts",
        "lowComfortTagCounts",
        "referenceTakeIds",
        "fromTakes",
    ):
        if token not in profile:
            fail(f"Tone Profile model marker missing: {token}")
    if re.search(r"spectral|formant|jitter|shimmer|HNR|CPPS", profile, re.I):
        fail("Tone Profile must not derive clinical/acoustic scores")

    return {"toneCards": 13, "maxTakes": 3, "toneProfile": "user-derived"}


def validate_timbre_path() -> dict[str, object]:
    path_text = (ROOT / "app/lib/progression/path.dart").read_text(encoding="utf-8")
    beginner = base.extract_beginner(path_text)
    if beginner[36:38] != ["TONE-02", "TONE-03"]:
        fail(f"Beginner Days 37-38 must be TONE-02/03, got {beginner[36:38]}")
    if any(card.startswith("TONE-") for card in beginner[:30]):
        fail("Beginner must not schedule explicit timbre cards before Day 31")

    universal = base.extract_cycle_cards(path_text, "_universalCoreCycles")
    universal_flat = [card for cycle in universal for card in cycle]
    for card in ("TONE-02", "TONE-03", "TONE-04", "TONE-05", "TONE-06", "TONE-07", "TONE-08", "TONE-09", "TONE-10", "TONE-12"):
        if card not in universal_flat:
            fail(f"Universal timbre spiral missing {card}")
    if "TONE-13" in universal_flat:
        fail("TONE-13 genre tone must remain advanced-only")

    repertoire = base.extract_cycle_cards(path_text, "_repertoireApplicationCycles")
    if "TONE-06" not in repertoire[1]:
        fail("Repertoire Project 2 must include vowel/tone transfer")
    if "TONE-07" not in repertoire[3]:
        fail("Repertoire Project 4 must include bright/warm A/B")
    if "TONE-11" not in repertoire[4]:
        fail("Repertoire Project 5 must include mic condition A/B")
    if "TONE-12" not in repertoire[5]:
        fail("Repertoire Project 6 must include three-tone reproduction")

    return {
        "beginnerTimbreDays": [37, 38],
        "universalToneCards": len({c for c in universal_flat if c.startswith("TONE-")}),
        "repertoireToneProjects": [2, 4, 5, 6],
    }


def validate_research_bundle() -> dict[str, object]:
    root = ROOT / "docs/research/v15"
    required = [
        "README.md",
        "TIMBRE-INTEGRATED-RESEARCH.md",
        "TIMBRE-SOURCE-REGISTER.csv",
        "timbre-source-register.json",
        "TIMBRE-EVIDENCE-APPLICATION-MATRIX.md",
        "VERIFIED-ANCHOR-SOURCES.md",
    ]
    missing = [name for name in required if not (root / name).exists()]
    if missing:
        fail(f"Missing v15 research files: {missing}")

    with (root / "TIMBRE-SOURCE-REGISTER.csv").open(
        encoding="utf-8", newline=""
    ) as handle:
        rows = list(csv.DictReader(handle))
    if len(rows) != 39:
        fail(f"Timbre source register must contain 39 sources, got {len(rows)}")
    allowed_classes = {"S", "C", "M", "P", "D"}
    allowed_statuses = {"spot_checked_v15", "imported_pending_full_recheck"}
    ids = []
    for row in rows:
        ids.append(row.get("id", ""))
        if row.get("evidenceClass") not in allowed_classes:
            fail(f"Invalid evidence class for {row.get('id')}: {row.get('evidenceClass')}")
        if row.get("status") not in allowed_statuses:
            fail(f"Invalid source status for {row.get('id')}: {row.get('status')}")
        if not str(row.get("url", "")).startswith("http"):
            fail(f"Missing URL for {row.get('id')}")
    if ids != [f"R{i}" for i in range(1, 40)]:
        fail("Timbre source IDs must be contiguous R1..R39")

    register = json.loads((root / "timbre-source-register.json").read_text(encoding="utf-8"))
    sources = register.get("sources")
    if register.get("version") != "v15" or not isinstance(sources, list):
        fail("Timbre JSON register markers mismatch")
    if len(sources) != len(rows):
        fail("CSV/JSON timbre source count mismatch")
    by_id = {row["id"]: row for row in rows}
    for source in sources:
        row = by_id.get(source.get("id"))
        if row is None:
            fail(f"JSON source missing from CSV: {source.get('id')}")
        for key in ("title", "url", "evidenceClass", "status"):
            if str(source.get(key)) != str(row.get(key)):
                fail(f"CSV/JSON source mismatch {source.get('id')} field {key}")

    checked = sum(1 for row in rows if row["status"] == "spot_checked_v15")
    if checked < 8:
        fail("At least eight anchor sources must be spot-checked in v15")
    return {"sources": len(rows), "spotChecked": checked, "pending": len(rows) - checked}


def validate_content_and_docs() -> dict[str, object]:
    required = [
        "docs/curriculum/TIMBRE-TRAINING-SPEC.md",
        "docs/app/TONE-FEEDBACK-SPEC.md",
        "docs/app/TONE-PROFILE-SPEC.md",
        "docs/adr/0033-timbre-spiral-tone-profile-v15.md",
        "docs/adr/0034-standard-sample-milestone-slots-v15.md",
        "docs/FEEDBACK-UPDATE-2026-06-21-v15.md",
        "docs/UPDATE-VALIDATION-2026-06-21-v15.md",
        "docs/NEXT-VERSION-DIRECTION-v16.md",
        "docs/PATCH-MANIFEST-v15.json",
        "docs/changed-files-v15.txt",
        "app/assets/curriculum/content_manifest_v15.json",
    ]
    missing = [rel for rel in required if not (ROOT / rel).exists()]
    if missing:
        fail(f"Missing v15 docs: {missing}")

    adr_numbers: dict[str, list[str]] = {}
    for adr in (ROOT / "docs/adr").glob("[0-9][0-9][0-9][0-9]-*.md"):
        adr_numbers.setdefault(adr.name[:4], []).append(adr.name)
    duplicates = {number: names for number, names in adr_numbers.items() if len(names) > 1}
    if duplicates:
        fail(f"Duplicate ADR numbers: {duplicates}")

    pubspec = (ROOT / "app/pubspec.yaml").read_text(encoding="utf-8")
    if "version: 1.15.0+15" not in pubspec:
        fail("pubspec version is not 1.15.0+15")
    versioning = (ROOT / "docs/VERSIONING.md").read_text(encoding="utf-8")
    if "Current project version: **v15**" not in versioning:
        fail("VERSIONING.md does not identify v15")

    status = json.loads(
        (ROOT / "docs/verification/verification-status.json").read_text(encoding="utf-8")
    )
    if status.get("version") != "v15" or status.get("appVersion") != "1.15.0+15":
        fail("verification-status v15 version mismatch")
    if "timbreTraining" not in status.get("items", {}):
        fail("verification-status missing timbreTraining item")

    patch = json.loads((ROOT / "docs/PATCH-MANIFEST-v15.json").read_text(encoding="utf-8"))
    if patch.get("version") != "v15" or patch.get("target") != "v15 / app 1.15.0+15":
        fail("PATCH-MANIFEST-v15 version/target mismatch")

    workflow = (ROOT / ".github/workflows/flutter-validation.yml").read_text(
        encoding="utf-8"
    )
    run_script = (ROOT / "tools/run_flutter_validation.sh").read_text(
        encoding="utf-8"
    )
    for token in (
        "python tools/validate_v15.py",
        "--version v15 --check",
        "dart analyze",
        "flutter test --reporter expanded",
        "flutter build apk --debug",
    ):
        if token not in workflow + run_script:
            fail(f"v15 validation pipeline marker missing: {token}")

    blueprint = (ROOT / "app/lib/curriculum/lesson_blueprint.dart").read_text(
        encoding="utf-8"
    )
    if "content_manifest_v15.json" not in blueprint:
        fail("Runtime blueprint repository does not use v15 manifest")

    return {"requiredDocs": len(required), "version": "v15"}


def main() -> int:
    report = {
        "jsonFiles": base.parse_json_files(),
        "yamlFiles": base.parse_yaml_files(),
        "dartDelimiterFiles": base.scan_dart_delimiters(),
        "localImports": validate_local_package_imports(),
        "curriculum": base.validate_curriculum(),
        "verticalSlice": base.validate_vertical_slice(),
        "contentManifest": validate_content_manifest(),
        "timbreCode": validate_timbre_code(),
        "timbrePath": validate_timbre_path(),
        "research": validate_research_bundle(),
        "docs": validate_content_and_docs(),
    }
    print(json.dumps({"status": "PASS", **report}, ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except AssertionError as exc:
        print(json.dumps({"status": "FAIL", "error": str(exc)}, ensure_ascii=False, indent=2))
        raise SystemExit(1)
