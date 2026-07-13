#!/usr/bin/env python3
"""Repository-level v18 validation without Flutter/Dart execution.

Checks prior curriculum invariants plus the first timbre vertical slice,
day-weighted Tone Profile, v18 research recheck status, generated content
hashes, version/docs, and local imports. It does not prove Flutter compilation,
plugin/device behavior, vocal safety, rights clearance, user comprehension, or
learning efficacy.
"""
from __future__ import annotations

import csv
import hashlib
import json
import re
import subprocess
import sys
from collections import Counter
from pathlib import Path

import validate_v12 as base

ROOT = Path(__file__).resolve().parents[1]
base.ROOT = ROOT


def fail(message: str) -> None:
    raise AssertionError(message)


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


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
    rel = "app/assets/curriculum/content_manifest_v18.json"
    path = ROOT / rel
    if not path.exists():
        fail(f"Missing content manifest: {rel}")
    manifest = json.loads(path.read_text(encoding="utf-8"))
    if manifest.get("schema") != "vocal-athlete/curriculum-content-manifest@2":
        fail("Unexpected v18 content manifest schema")
    if manifest.get("version") != "v18" or manifest.get("algorithm") != "sha256":
        fail("v18 content manifest version/algorithm mismatch")
    files = manifest.get("files")
    if not isinstance(files, dict) or len(files) != 31:
        fail(f"v18 content manifest must track 31 files, got {len(files or {})}")
    kinds: dict[str, int] = {}
    for asset_path, metadata in files.items():
        full = ROOT / "app" / asset_path
        if not full.exists():
            fail(f"Manifest references missing file: {asset_path}")
        actual = sha256(full)
        if metadata.get("sha256") != actual:
            fail(f"SHA-256 mismatch for {asset_path}")
        kind = str(metadata.get("kind", "unknown"))
        kinds[kind] = kinds.get(kind, 0) + 1
    expected = {
        "blueprint": 3,
        "asset_manifest": 1,
        "rights_record": 3,
        "audio": 24,
    }
    if kinds != expected:
        fail(f"Unexpected v18 manifest kind counts: {kinds}")
    proc = subprocess.run(
        [
            sys.executable,
            str(ROOT / "tools/generate_content_manifest.py"),
            "--version",
            "v18",
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
        "app/lib/timbre/tone_profile_curation.dart",
        "app/lib/lesson/tone_profile_screen.dart",
        "app/test/tone_profile_test.dart",
        "app/test/tone_profile_screen_test.dart",
        "app/test/lesson_blueprint_test.dart",
        "app/test/lesson_screen_widget_test.dart",
    ]
    missing = [rel for rel in required if not (ROOT / rel).exists()]
    if missing:
        fail(f"Missing v18 timbre implementation files: {missing}")

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

    profile = (ROOT / "app/lib/timbre/tone_profile.dart").read_text(encoding="utf-8")
    for token in (
        "practiceDayCount",
        "dayTagContributionCount",
        "undatedTakeCount",
        "excludedTakeCount",
        "editedTakeCount",
        "sameConditionPracticeDayCount",
        "localDateOrdinalFromKey",
        "hasEnoughData => practiceDayCount >= 3",
        "selectedDays",
        "lowComfortDays",
    ):
        if token not in profile:
            fail(f"v18 day-weighted Tone Profile marker missing: {token}")
    if re.search(r"spectral|formant|jitter|shimmer|\bHNR\b|\bCPPS\b", profile, re.I):
        fail("Tone Profile must not derive clinical/acoustic scores")

    curation = (ROOT / "app/lib/timbre/tone_profile_curation.dart").read_text(encoding="utf-8")
    for token in (
        "setToneProfileExcluded",
        "updateToneTags",
        "toneProfileExcluded",
        "toneTagEditedEpochMs",
    ):
        if token not in curation:
            fail(f"v18 Tone Profile curation marker missing: {token}")

    recording = (ROOT / "app/lib/recording/recording_ab.dart").read_text(encoding="utf-8")
    for token in (
        "toneProfileExcluded", "toneTagEditedEpochMs", "toneTagEditMemo",
        "createdLocalDateKey", "localDateKeyForEpochMs", "localDateOrdinalFromKey",
    ):
        if token not in recording:
            fail(f"RecordingTake v18 curation/date metadata missing: {token}")

    screen = (ROOT / "app/lib/lesson/tone_profile_screen.dart").read_text(encoding="utf-8")
    for token in (
        "tone-profile-refresh",
        "서로 다른 학습일",
        "dayTagContributionCount",
        "날짜 미상",
        "tone-profile-curation-disclaimer",
        "팔레트에서 제외",
        "팔레트에 다시 포함",
        "태그 모두 해제",
        "onSetTags",
        "createdLocalDateKey",
    ):
        if token not in screen:
            fail(f"v18 Tone Profile screen marker missing: {token}")

    lesson = (ROOT / "app/lib/lesson/lesson_screen.dart").read_text(encoding="utf-8")
    for token in (
        "LearningStage.beginnerFoundation => 'beginnerFoundation'",
        "blueprintDay == 37 || blueprintDay == 38",
        "LessonBlueprintPanel",
    ):
        if token not in lesson:
            fail(f"Beginner timbre blueprint wiring missing: {token}")

    repository = (ROOT / "app/lib/curriculum/lesson_blueprint.dart").read_text(
        encoding="utf-8"
    )
    for token in (
        "content_manifest_v18.json",
        "beginner_timbre_slice_v16.json",
        "track == 'beginnerFoundation'",
    ):
        if token not in repository:
            fail(f"v18 blueprint repository marker missing: {token}")

    return {
        "toneCards": 13,
        "profileAggregation": "local-day-by-tag",
        "minimumPracticeDays": 3,
        "beginnerBlueprintDays": [37, 38],
    }


def validate_timbre_path() -> dict[str, object]:
    path_text = (ROOT / "app/lib/progression/path.dart").read_text(encoding="utf-8")
    beginner = base.extract_beginner(path_text)
    if beginner[36:38] != ["TONE-02", "TONE-03"]:
        fail(f"Beginner Days 37-38 must be TONE-02/03, got {beginner[36:38]}")
    if any(card.startswith("TONE-") for card in beginner[:30]):
        fail("Beginner must not schedule explicit timbre cards before Day 31")

    universal = base.extract_cycle_cards(path_text, "_universalCoreCycles")
    universal_flat = [card for cycle in universal for card in cycle]
    required_universal = {
        "TONE-02", "TONE-03", "TONE-04", "TONE-05", "TONE-06",
        "TONE-07", "TONE-08", "TONE-09", "TONE-10", "TONE-12",
    }
    missing = sorted(required_universal - set(universal_flat))
    if missing:
        fail(f"Universal timbre spiral missing: {missing}")
    if "TONE-13" in universal_flat:
        fail("TONE-13 genre tone must remain advanced-only")

    repertoire = base.extract_cycle_cards(path_text, "_repertoireApplicationCycles")
    # R5g diversified Projects 2-4 with dedicated RA cards. Projects 5-6
    # retain the explicit tone-transfer anchors documented beside the path.
    expected = {4: "TONE-11", 5: "TONE-12"}
    for project_index, card in expected.items():
        if card not in repertoire[project_index]:
            fail(f"Repertoire Project {project_index + 1} must include {card}")

    return {
        "beginnerTimbreDays": [37, 38],
        "universalToneCards": len({c for c in universal_flat if c.startswith('TONE-')}),
        "repertoireToneProjects": [5, 6],
    }


def _validate_blueprint(
    rel: str,
    *,
    track: str,
    version: str,
    expected_days: list[int],
    expected_cards: list[str],
) -> dict[str, object]:
    data = json.loads((ROOT / rel).read_text(encoding="utf-8"))
    lessons = data.get("lessons", [])
    if data.get("schema") != "vocal-athlete/lesson-blueprint@1":
        fail(f"Unexpected blueprint schema: {rel}")
    if data.get("version") != version or data.get("track") != track or data.get("cycle") != 1:
        fail(f"Blueprint markers mismatch: {rel}")
    if [x.get("day") for x in lessons] != expected_days:
        fail(f"Blueprint days mismatch: {rel}")
    if [x.get("cardId") for x in lessons] != expected_cards:
        fail(f"Blueprint card sequence mismatch: {rel}")
    for lesson in lessons:
        for key in (
            "title", "primarySkill", "secondarySkill", "objective",
            "feedbackPrompt", "recoveryAlternative", "evidence",
        ):
            if not str(lesson.get(key, "")).strip():
                fail(f"Blueprint day {lesson.get('day')} missing {key}: {rel}")
        if len(lesson.get("steps", [])) < 3:
            fail(f"Blueprint day {lesson.get('day')} needs >=3 steps: {rel}")
        attempts = lesson.get("attempts")
        if not isinstance(attempts, int) or not 1 <= attempts <= 4:
            fail(f"Blueprint day {lesson.get('day')} attempts outside 1..4: {rel}")
        if len(lesson.get("selfCheck", [])) < 2:
            fail(f"Blueprint day {lesson.get('day')} needs >=2 self checks: {rel}")
        for cue in lesson.get("audioCues", []):
            path = ROOT / "app" / cue["path"]
            if not path.exists():
                fail(f"Missing blueprint audio cue: {cue['path']}")
            base.validate_wav(path)
    return {"track": track, "version": version, "lessons": len(lessons)}


def _validate_rights_dir(rel: str, expected_names: set[str], peak: float) -> int:
    rights_path = ROOT / rel
    rights = json.loads(rights_path.read_text(encoding="utf-8"))
    if rights.get("prototypePeakFullScale") != peak:
        fail(f"Prototype peak policy mismatch: {rel}")
    if rights.get("thirdPartyAudio") is not False:
        fail(f"Rights must declare no third-party audio: {rel}")
    declared = {item.get("path") for item in rights.get("files", [])}
    actual = {path.name for path in rights_path.parent.glob("*.wav")}
    if declared != expected_names or actual != expected_names:
        fail(f"Rights/WAV inventory mismatch: {rel}")
    for item in rights.get("files", []):
        path = rights_path.parent / item["path"]
        if not path.exists() or sha256(path) != item.get("sha256"):
            fail(f"Rights checksum mismatch: {path}")
        info = base.validate_wav(path)
        if float(info["peakFullScale"]) > peak + 0.001:
            fail(f"WAV exceeds declared prototype peak: {path}")
    return len(declared)


def validate_vertical_slice() -> dict[str, object]:
    path_text = (ROOT / "app/lib/progression/path.dart").read_text(encoding="utf-8")
    beginner = base.extract_beginner(path_text)
    universal = base.extract_cycle_cards(path_text, "_universalCoreCycles")
    repertoire = base.extract_cycle_cards(path_text, "_repertoireApplicationCycles")

    beginner_report = _validate_blueprint(
        "app/assets/curriculum/beginner_timbre_slice_v16.json",
        track="beginnerFoundation",
        version="v16",
        expected_days=[37, 38],
        expected_cards=beginner[36:38],
    )
    universal_report = _validate_blueprint(
        "app/assets/curriculum/universal_core_cycle_01.json",
        track="universalCore",
        version="v16",
        expected_days=list(range(1, 13)),
        expected_cards=universal[0],
    )
    repertoire_report = _validate_blueprint(
        "app/assets/curriculum/repertoire_project_01.json",
        track="repertoireApplication",
        version="v10",
        expected_days=list(range(1, 13)),
        expected_cards=repertoire[0],
    )

    beginner_data = json.loads(
        (ROOT / "app/assets/curriculum/beginner_timbre_slice_v16.json").read_text(encoding="utf-8")
    )
    if any(x.get("attempts") != 2 for x in beginner_data["lessons"]):
        fail("Beginner timbre slice must cap each lesson at two attempts")
    if any("오늘은 발성하지 않는다" not in x.get("recoveryAlternative", "") and
           "발성·속삭임은 하지 않는다" not in x.get("recoveryAlternative", "")
           for x in beginner_data["lessons"]):
        fail("Beginner timbre recovery alternatives must be explicitly no-voice")

    core_data = json.loads(
        (ROOT / "app/assets/curriculum/universal_core_cycle_01.json").read_text(encoding="utf-8")
    )
    day6 = next(x for x in core_data["lessons"] if x["day"] == 6)
    if day6["cardId"] != "TONE-02" or day6["attempts"] != 2:
        fail("Universal Core Day 6 must be a two-attempt TONE-02 slice")

    timbre_names = {
        "hum_to_vowel_low.wav", "hum_to_vowel_mid.wav",
        "vowel_color_low.wav", "vowel_color_mid.wav",
    }
    timbre_audio = _validate_rights_dir(
        "app/assets/training/timbre_v16/rights.json", timbre_names, 0.38
    )
    core_names = {
        "reference_pitch_low.wav", "reference_pitch_mid.wav",
        "three_note_arch_low.wav", "three_note_arch_mid.wav",
        "sovt_contour_low.wav", "sovt_contour_mid.wav", "pulse_72bpm.wav",
        "phrase_4beat_u_low.wav", "phrase_4beat_u_mid.wav",
        "one_note_phrase_low.wav", "one_note_phrase_mid.wav",
    }
    core_audio = _validate_rights_dir(
        "app/assets/training/universal_core_cycle_01/rights.json", core_names, 0.5
    )
    repertoire_names = {
        "guide_hum_low.wav", "guide_hum_mid.wav",
        "guide_melody_piano_low.wav", "guide_melody_piano_mid.wav",
        "guide_melody_slow_low.wav", "guide_melody_slow_mid.wav",
        "backing_track_low.wav", "backing_track_mid.wav", "click_72bpm.wav",
    }
    repertoire_audio = _validate_rights_dir(
        "app/assets/repertoire/neutral_001/rights.json", repertoire_names, 0.5
    )

    pubspec = (ROOT / "app/pubspec.yaml").read_text(encoding="utf-8")
    for entry in (
        "assets/curriculum/",
        "assets/training/universal_core_cycle_01/",
        "assets/training/timbre_v16/",
        "assets/repertoire/neutral_001/",
        "assets/repertoire/neutral_002/",
        "assets/repertoire/korean_001/",
    ):
        if f"- {entry}" not in pubspec:
            fail(f"pubspec missing explicit asset directory: {entry}")

    return {
        "blueprints": [beginner_report, universal_report, repertoire_report],
        "timbrePrototypeWav": timbre_audio,
        "coreCueWav": core_audio,
        "repertoireWav": repertoire_audio,
    }


def validate_research_bundle() -> dict[str, object]:
    root = ROOT / "docs/research/v18"
    required = [
        "README.md",
        "TIMBRE-SOURCE-RECHECK-v18.md",
        "TIMBRE-SOURCE-REGISTER.csv",
        "timbre-source-register.json",
    ]
    missing = [name for name in required if not (root / name).exists()]
    if missing:
        fail(f"Missing v18 research files: {missing}")

    with (root / "TIMBRE-SOURCE-REGISTER.csv").open(
        encoding="utf-8", newline=""
    ) as handle:
        rows = list(csv.DictReader(handle))
    if len(rows) != 39:
        fail(f"Timbre source register must contain 39 sources, got {len(rows)}")
    allowed_classes = {"S", "C", "M", "P", "D"}
    allowed_statuses = {
        "spot_checked_v15",
        "spot_checked_v16",
        "spot_checked_v17",
        "spot_checked_v18",
        "imported_pending_full_recheck",
    }
    ids: list[str] = []
    for row in rows:
        ids.append(row.get("id", ""))
        if row.get("evidenceClass") not in allowed_classes:
            fail(f"Invalid evidence class for {row.get('id')}")
        if row.get("status") not in allowed_statuses:
            fail(f"Invalid source status for {row.get('id')}: {row.get('status')}")
        if not str(row.get("url", "")).startswith("http"):
            fail(f"Missing URL for {row.get('id')}")
    if ids != [f"R{i}" for i in range(1, 40)]:
        fail("Timbre source IDs must be contiguous R1..R39")

    register = json.loads((root / "timbre-source-register.json").read_text(encoding="utf-8"))
    sources = register.get("sources")
    if register.get("version") != "v18" or not isinstance(sources, list):
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

    statuses = Counter(row["status"] for row in rows)
    if statuses["spot_checked_v15"] != 8 or statuses["spot_checked_v16"] != 5 or statuses["spot_checked_v17"] != 6 or statuses["spot_checked_v18"] != 4:
        fail(f"Unexpected v15/v16/v17/v18 source check counts: {dict(statuses)}")
    if statuses["imported_pending_full_recheck"] != 16:
        fail(f"Expected 16 pending sources, got {statuses['imported_pending_full_recheck']}")
    r27 = by_id["R27"]["title"]
    if "Modeling source-filter interaction" not in r27:
        fail("R27 title correction missing")
    return {
        "sources": len(rows),
        "checkedV15": statuses["spot_checked_v15"],
        "checkedV16": statuses["spot_checked_v16"],
        "checkedV17": statuses["spot_checked_v17"],
        "checkedV18": statuses["spot_checked_v18"],
        "pending": statuses["imported_pending_full_recheck"],
    }


def validate_content_and_docs() -> dict[str, object]:
    required = [
        "docs/curriculum/TIMBRE-TRAINING-SPEC.md",
        "docs/curriculum/beginner/TIMBRE-VERTICAL-SLICE-v16.md",
        "docs/app/TONE-PROFILE-SPEC.md",
        "docs/app/TONE-PROFILE-CURATION-SPEC.md",
        "docs/app/TEACHER-GUIDE-MASTER-SPEC.md",
        "docs/content/teacher-guides/v18/README.md",
        "docs/content/teacher-guides/v18/day37-hum-to-vowel-script.md",
        "docs/content/teacher-guides/v18/day38-vowel-color-script.md",
        "docs/content/teacher-guides/v18/universal-core-day6-script.md",
        "docs/content/teacher-guides/v18/teacher-consent-template.md",
        "docs/content/teacher-guides/v18/teacher-review-checklist.md",
        "docs/content/teacher-guides/v18/audio-mastering-qa.md",
        "docs/content/teacher-guides/v18/rights-record-template.json",
        "docs/app/FIRST-TIMBRE-PILOT-RUNBOOK-v18.md",
        "docs/app/FIRST-TIMBRE-PILOT-OBSERVATION-FORM-v18.csv",
        "docs/app/FIRST-TIMBRE-PILOT-PROTOCOL-v17.md",
        "docs/adr/0035-timbre-vertical-slice-day-weighted-profile-v16.md",
        "docs/adr/0036-tone-profile-curation-and-teacher-master-v17.md",
        "docs/adr/0037-tone-profile-multitag-and-teacher-readiness-v18.md",
        "docs/FEEDBACK-UPDATE-2026-06-22-v18.md",
        "docs/UPDATE-VALIDATION-2026-06-22-v18.md",
        "docs/NEXT-VERSION-DIRECTION-v19.md",
        "docs/PATCH-MANIFEST-v18.json",
        "docs/changed-files-v18.txt",
        "app/assets/curriculum/content_manifest_v18.json",
        "app/assets/curriculum/beginner_timbre_slice_v16.json",
        "app/assets/training/timbre_v16/rights.json",
        "tools/flutter_environment_v18.txt",
        "docs/research/v18/README.md",
        "docs/research/v18/TIMBRE-SOURCE-RECHECK-v18.md",
        "docs/research/v18/TIMBRE-SOURCE-REGISTER.csv",
        "docs/research/v18/timbre-source-register.json",
    ]
    missing = [rel for rel in required if not (ROOT / rel).exists()]
    if missing:
        fail(f"Missing v18 docs/files: {missing}")

    adr_numbers: dict[str, list[str]] = {}
    for adr in (ROOT / "docs/adr").glob("[0-9][0-9][0-9][0-9]-*.md"):
        adr_numbers.setdefault(adr.name[:4], []).append(adr.name)
    duplicates = {number: names for number, names in adr_numbers.items() if len(names) > 1}
    if duplicates:
        fail(f"Duplicate ADR numbers: {duplicates}")

    pubspec = (ROOT / "app/pubspec.yaml").read_text(encoding="utf-8")
    if "version: 1.18.0+18" not in pubspec:
        fail("pubspec version is not 1.18.0+18")
    versioning = (ROOT / "docs/VERSIONING.md").read_text(encoding="utf-8")
    if "Current project version: **v18**" not in versioning:
        fail("VERSIONING.md does not identify v18")

    status = json.loads(
        (ROOT / "docs/verification/verification-status.json").read_text(encoding="utf-8")
    )
    if status.get("version") != "v18" or status.get("appVersion") != "1.18.0+18":
        fail("verification-status v18 version mismatch")
    if "toneProfileCurationV18" not in status.get("items", {}):
        fail("verification-status missing toneProfileCurationV18 item")

    patch = json.loads((ROOT / "docs/PATCH-MANIFEST-v18.json").read_text(encoding="utf-8"))
    if patch.get("version") != "v18" or patch.get("target") != "v18 / app 1.18.0+18":
        fail("PATCH-MANIFEST-v18 version/target mismatch")

    workflow = (ROOT / ".github/workflows/flutter-validation.yml").read_text(encoding="utf-8")
    run_script = (ROOT / "tools/run_flutter_validation.sh").read_text(encoding="utf-8")
    for token in (
        "python tools/validate_v18.py",
        "--version v18 --check",
        "flutter analyze --fatal-infos",
        "flutter test --reporter expanded",
        "flutter build apk --debug",
    ):
        if token not in workflow + run_script:
            fail(f"v18 validation pipeline marker missing: {token}")

    blueprint = (ROOT / "app/lib/curriculum/lesson_blueprint.dart").read_text(encoding="utf-8")
    if "content_manifest_v18.json" not in blueprint:
        fail("Runtime blueprint repository does not use v18 manifest")

    return {"requiredDocs": len(required), "version": "v18"}


def main() -> int:
    report = {
        "jsonFiles": base.parse_json_files(),
        "yamlFiles": base.parse_yaml_files(),
        "dartDelimiterFiles": base.scan_dart_delimiters(),
        "localImports": validate_local_package_imports(),
        "curriculum": base.validate_curriculum(),
        "contentManifest": validate_content_manifest(),
        "timbreCode": validate_timbre_code(),
        "timbrePath": validate_timbre_path(),
        "verticalSlice": validate_vertical_slice(),
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
