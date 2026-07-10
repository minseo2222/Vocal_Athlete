#!/usr/bin/env python3
"""Repository-level v11 smoke validation that does not require Flutter/Dart.

This validates document/data syntax, card/path references, and the canonical
v11 curriculum and first vertical-slice invariants. It does not prove Flutter compilation, device audio
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
    required_v10_ids = {
        *(f"UC-{i:02d}" for i in range(18, 26)),
        "RA-09", "RA-10",
        *(f"RB-{i:02d}" for i in range(1, 7)),
        *(f"RK-{i:02d}" for i in range(1, 7)),
        *(f"WC-{i:02d}" for i in range(1, 7)),
    }
    if not required_v10_ids <= library_ids:
        fail(f"Missing v10 cards: {sorted(required_v10_ids - library_ids)}")

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


def sha256(path: Path) -> str:
    import hashlib
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def validate_wav(path: Path) -> dict[str, object]:
    import array
    import wave
    with wave.open(str(path), "rb") as wf:
        channels = wf.getnchannels()
        sample_rate = wf.getframerate()
        frames = wf.getnframes()
        sample_width = wf.getsampwidth()
        raw = wf.readframes(frames)
    if channels != 1:
        fail(f"Training WAV must be mono: {path.relative_to(ROOT)}")
    if sample_rate != 24000:
        fail(f"Unexpected sample rate {sample_rate}: {path.relative_to(ROOT)}")
    if frames <= 0:
        fail(f"Empty WAV: {path.relative_to(ROOT)}")
    if sample_width != 2:
        fail(f"Training WAV must be 16-bit PCM: {path.relative_to(ROOT)}")
    samples = array.array("h")
    samples.frombytes(raw)
    peak = max((abs(x) for x in samples), default=0) / 32767.0
    if peak > 0.55:
        fail(f"Prototype training WAV peak too high ({peak:.3f}): {path.relative_to(ROOT)}")
    return {
        "sampleRate": sample_rate,
        "channels": channels,
        "frames": frames,
        "peakFullScale": round(peak, 4),
    }


def validate_vertical_slice() -> dict[str, object]:
    path_text = (ROOT / "app/lib/progression/path.dart").read_text(encoding="utf-8")
    universal = extract_cycle_cards(path_text, "_universalCoreCycles")
    repertoire = extract_cycle_cards(path_text, "_repertoireApplicationCycles")

    blueprint_specs = [
        ("app/assets/curriculum/universal_core_cycle_01.json", "universalCore", universal[0]),
        ("app/assets/curriculum/repertoire_project_01.json", "repertoireApplication", repertoire[0]),
    ]
    blueprint_report: dict[str, object] = {}
    for rel, track, expected_cards in blueprint_specs:
        data = json.loads((ROOT / rel).read_text(encoding="utf-8"))
        lessons = data.get("lessons", [])
        if data.get("schema") != "vocal-athlete/lesson-blueprint@1":
            fail(f"Unexpected blueprint schema: {rel}")
        if data.get("version") != "v10" or data.get("track") != track or data.get("cycle") != 1:
            fail(f"Blueprint markers mismatch: {rel}")
        if len(lessons) != 12:
            fail(f"Blueprint must contain 12 lessons: {rel}")
        if [x.get("day") for x in lessons] != list(range(1, 13)):
            fail(f"Blueprint days must be 1..12: {rel}")
        if [x.get("cardId") for x in lessons] != expected_cards:
            fail(f"Blueprint card sequence differs from path: {rel}")
        for lesson in lessons:
            for key in ("title", "primarySkill", "secondarySkill", "objective", "feedbackPrompt", "recoveryAlternative", "evidence"):
                if not str(lesson.get(key, "")).strip():
                    fail(f"Blueprint day {lesson.get('day')} missing {key}: {rel}")
            steps = lesson.get("steps", [])
            if len(steps) < 3:
                fail(f"Blueprint day {lesson.get('day')} needs >=3 steps: {rel}")
            attempts = lesson.get("attempts")
            if not isinstance(attempts, int) or not 1 <= attempts <= 4:
                fail(f"Blueprint day {lesson.get('day')} attempts outside 1..4: {rel}")
            if len(lesson.get("selfCheck", [])) < 2:
                fail(f"Blueprint day {lesson.get('day')} needs >=2 self checks: {rel}")
            for cue in lesson.get("audioCues", []):
                asset_path = ROOT / "app" / cue["path"]
                if not asset_path.exists():
                    fail(f"Missing blueprint audio cue: {cue['path']}")
        blueprint_report[track] = len(lessons)

    ra = json.loads((ROOT / "app/assets/curriculum/repertoire_project_01.json").read_text(encoding="utf-8"))
    if any(x.get("assetId") != "neutral_001" for x in ra["lessons"]):
        fail("Repertoire Project 1 must consistently reference neutral_001")
    if ra["lessons"][0].get("guideState") != "full" or ra["lessons"][-1].get("guideState") != "transfer":
        fail("Repertoire guide fade must begin full and end with backing-only transfer")

    manifest_path = ROOT / "app/assets/repertoire/neutral_001/manifest.json"
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    if manifest.get("assetStatus") != "prototype_audio_ready":
        fail("neutral_001 assetStatus must be prototype_audio_ready")
    if manifest.get("bars") != 4 or manifest.get("tempoBpm") != 72 or manifest.get("countInBeats") != 4:
        fail("neutral_001 timing metadata mismatch")
    audio_assets = manifest.get("audioAssets", {})
    if manifest.get("recommendedKeys") != ["low", "mid"]:
        fail("neutral_001 must expose low/mid comfortable-key choices")
    expected_roles = {
        "guideHumLow", "guideHumMid",
        "guideMelodyPianoLow", "guideMelodyPianoMid",
        "guideMelodySlowLow", "guideMelodySlowMid",
        "backingTrackLow", "backingTrackMid", "click",
    }
    if set(audio_assets) != expected_roles:
        fail(f"neutral_001 roles mismatch: {sorted(audio_assets)}")
    wav_report: dict[str, object] = {}
    for role, rel in audio_assets.items():
        path = ROOT / "app" / rel
        if not path.exists():
            fail(f"Missing neutral_001 asset: {rel}")
        wav_report[role] = validate_wav(path)

    rights_path = ROOT / "app" / manifest.get("rightsRecord", "")
    if not rights_path.exists():
        fail("neutral_001 rights record missing")
    rights = json.loads(rights_path.read_text(encoding="utf-8"))
    if rights.get("prototypePeakFullScale") != 0.5:
        fail("neutral_001 prototype peak policy must be 0.5 full scale")
    if rights.get("thirdPartyAudio") is not False or rights.get("humanVocalRecording") is not False:
        fail("v10 prototype rights flags must declare no third-party/human recording")
    rights_names = {item.get("path") for item in rights.get("files", [])}
    actual_names = {path.name for path in rights_path.parent.glob("*.wav")}
    if rights_names != actual_names:
        fail(f"neutral_001 rights/WAV inventory mismatch: rights={sorted(rights_names)} actual={sorted(actual_names)}")
    for item in rights.get("files", []):
        path = rights_path.parent / item["path"]
        if not path.exists() or sha256(path) != item.get("sha256"):
            fail(f"neutral_001 checksum mismatch: {item.get('path')}")

    core_rights_path = ROOT / "app/assets/training/universal_core_cycle_01/rights.json"
    core_rights = json.loads(core_rights_path.read_text(encoding="utf-8"))
    if core_rights.get("prototypePeakFullScale") != 0.5:
        fail("Core cue prototype peak policy must be 0.5 full scale")
    if core_rights.get("thirdPartyAudio") is not False:
        fail("Core cue rights must declare no third-party audio")
    expected_core_names = {
        "reference_pitch_low.wav", "reference_pitch_mid.wav",
        "three_note_arch_low.wav", "three_note_arch_mid.wav",
        "sovt_contour_low.wav", "sovt_contour_mid.wav",
        "pulse_72bpm.wav",
        "phrase_4beat_u_low.wav", "phrase_4beat_u_mid.wav",
        "one_note_phrase_low.wav", "one_note_phrase_mid.wav",
    }
    core_rights_names = {item.get("path") for item in core_rights.get("files", [])}
    core_actual_names = {path.name for path in core_rights_path.parent.glob("*.wav")}
    if core_rights_names != expected_core_names or core_actual_names != expected_core_names:
        fail("Core cue low/mid inventory mismatch")
    for item in core_rights.get("files", []):
        path = core_rights_path.parent / item["path"]
        if not path.exists() or sha256(path) != item.get("sha256"):
            fail(f"Core cue checksum mismatch: {item.get('path')}")
        validate_wav(path)

    pubspec = (ROOT / "app/pubspec.yaml").read_text(encoding="utf-8")
    required_asset_dirs = [
        "assets/curriculum/",
        "assets/training/universal_core_cycle_01/",
        "assets/repertoire/neutral_001/",
        "assets/repertoire/neutral_002/",
        "assets/repertoire/korean_001/",
    ]
    for entry in required_asset_dirs:
        if f"- {entry}" not in pubspec:
            fail(f"pubspec missing explicit nested asset directory: {entry}")

    lesson_screen = (ROOT / "app/lib/lesson/lesson_screen.dart").read_text(encoding="utf-8")
    for marker in ("LessonBlueprintPanel", "RepertoirePracticePanel", "trainingAudioPlaybackAdapter", "lesson-sheet-scroll"):
        if marker not in lesson_screen:
            fail(f"LessonScreen missing v10 marker: {marker}")

    return {
        "blueprints": blueprint_report,
        "repertoireAudioRoles": sorted(audio_assets),
        "coreCueFiles": len(core_rights.get("files", [])),
        "repertoireWav": wav_report,
    }


def validate_v11_features() -> dict[str, object]:
    required = [
        "app/lib/assessment/learning_evidence.dart",
        "app/lib/recording/audio_session_coordinator.dart",
        "app/lib/lesson/learning_evidence_review_screen.dart",
        "app/integration_test/learning_evidence_flow_test.dart",
        "docs/app/LEARNING-EVIDENCE-SPEC.md",
        "docs/app/AUDIO-SESSION-INTEGRITY-SPEC.md",
        "docs/NEXT-VERSION-DIRECTION-v12.md",
        "docs/adr/0029-learning-evidence-audio-interlock-v11.md",
    ]
    missing = [rel for rel in required if not (ROOT / rel).exists()]
    if missing:
        fail(f"Missing v11 feature files: {missing}")

    evidence = (ROOT / "app/lib/assessment/learning_evidence.dart").read_text(encoding="utf-8")
    for marker in (
        "enum LearningEvidenceLevel",
        "class LessonPracticeSnapshot",
        "class LearningEvidenceRecord",
        "class SharedPreferencesLearningEvidenceRepository",
        "targetEvidence",
    ):
        if marker not in evidence:
            fail(f"Learning evidence model missing marker: {marker}")

    lesson_screen = (ROOT / "app/lib/lesson/lesson_screen.dart").read_text(encoding="utf-8")
    for marker in (
        "_saveLearningEvidence",
        "_prepareTrainingAudio",
        "_prepareRecording",
        "onTakeSaved",
        "onBestTakeSelected",
        "evidenceRepository",
    ):
        if marker not in lesson_screen:
            fail(f"LessonScreen missing v11 marker: {marker}")

    coordinator = (ROOT / "app/lib/recording/audio_session_coordinator.dart").read_text(encoding="utf-8")
    for marker in ("enum AudioSessionAction", "class AudioSessionCoordinator", "notifyListeners"):
        if marker not in coordinator:
            fail(f"Audio session coordinator missing marker: {marker}")

    main_text = (ROOT / "app/lib/main.dart").read_text(encoding="utf-8")
    for marker in (
        "with WidgetsBindingObserver",
        "didChangeAppLifecycleState",
        "_recordingCaptureAdapter?.cancel()",
        "LearningEvidenceReviewScreen",
    ):
        if marker not in main_text:
            fail(f"AppShell missing lifecycle/evidence marker: {marker}")

    recording = (ROOT / "app/lib/recording/recording_ab.dart").read_text(encoding="utf-8")
    if "final bool isBest;" not in recording or "'isBest': isBest" not in recording:
        fail("RecordingTake best-take persistence is incomplete")

    panel = (ROOT / "app/lib/lesson/recording_ab_panel.dart").read_text(encoding="utf-8")
    for marker in ("onBeforeCapture", "onBeforePlayback", "_markBestTake", "take.copyWith(isBest:"):
        if marker not in panel:
            fail(f"Recording panel missing interlock/best marker: {marker}")

    pubspec = (ROOT / "app/pubspec.yaml").read_text(encoding="utf-8")
    if "integration_test:" not in pubspec or "sdk: flutter" not in pubspec:
        fail("pubspec missing Flutter integration_test dependency")
    if any(ROOT.rglob("*.tmp")):
        fail("Temporary files remain in repository")

    return {
        "requiredFeatureFiles": len(required),
        "integrationTests": len(list((ROOT / "app/integration_test").glob("*_test.dart"))),
    }


def validate_docs_and_version() -> dict[str, object]:
    required = [
        "docs/curriculum/CURRICULUM-REVIEW.md",
        "docs/curriculum/universal-core/CYCLE-01-DETAILED.md",
        "docs/curriculum/repertoire-application/PROJECT-01-DETAILED.md",
        "docs/app/TRAINING-AUDIO-ASSET-SPEC.md",
        "docs/app/LEARNING-EVIDENCE-SPEC.md",
        "docs/app/AUDIO-SESSION-INTEGRITY-SPEC.md",
        "docs/NEXT-VERSION-DIRECTION-v12.md",
        "docs/adr/0029-learning-evidence-audio-interlock-v11.md",
        "docs/FEEDBACK-UPDATE-2026-06-20-v11.md",
        "docs/UPDATE-VALIDATION-2026-06-20-v11.md",
        "docs/PATCH-MANIFEST-v11.json",
    ]
    missing = [p for p in required if not (ROOT / p).exists()]
    if missing:
        fail(f"Missing v11 documents: {missing}")

    pubspec = (ROOT / "app/pubspec.yaml").read_text(encoding="utf-8")
    if "version: 1.11.0+11" not in pubspec:
        fail("pubspec version is not 1.11.0+11")
    verification = json.loads((ROOT / "docs/verification/verification-status.json").read_text(encoding="utf-8"))
    if verification.get("version") != "v11" or verification.get("appVersion") != "1.11.0+11":
        fail("verification version markers do not match v11")
    if "learningEvidence" not in verification.get("items", {}) or "audioSessionIntegrity" not in verification.get("items", {}):
        fail("verification-status missing v11 evidence/audio items")
    versioning = (ROOT / "docs/VERSIONING.md").read_text(encoding="utf-8")
    if "Current project version: **v11**" not in versioning:
        fail("VERSIONING.md does not identify v11")
    patch_manifest = json.loads((ROOT / "docs/PATCH-MANIFEST-v11.json").read_text(encoding="utf-8"))
    if patch_manifest.get("version") != "v11" or patch_manifest.get("target") != "v11 / app 1.11.0+11":
        fail("PATCH-MANIFEST-v11.json markers mismatch")
    return {"requiredDocs": len(required), "version": "v11", "appVersion": "1.11.0+11"}


def main() -> int:
    report = {
        "jsonFiles": parse_json_files(),
        "yamlFiles": parse_yaml_files(),
        "dartDelimiterFiles": scan_dart_delimiters(),
        "curriculum": validate_curriculum(),
        "verticalSlice": validate_vertical_slice(),
        "v11Features": validate_v11_features(),
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
