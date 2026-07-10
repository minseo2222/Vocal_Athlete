#!/usr/bin/env python3
"""Repository-level v13 validation without Flutter/Dart execution.

The script validates syntax-like structure, curriculum/path invariants, v13
review/evidence markers, and SHA-256 content-manifest integrity. It does not
prove Flutter compilation, platform-plugin behavior, vocal safety, or learning
efficacy.
"""
from __future__ import annotations

import hashlib
import json
import sys
from pathlib import Path

import validate_v12 as base

ROOT = Path(__file__).resolve().parents[1]
base.ROOT = ROOT


def fail(message: str) -> None:
    raise AssertionError(message)


def validate_content_manifest() -> dict[str, object]:
    rel = "app/assets/curriculum/content_manifest_v13.json"
    manifest_path = ROOT / rel
    if not manifest_path.exists():
        fail(f"Missing content manifest: {rel}")
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    if manifest.get("schema") != "vocal-athlete/curriculum-content-manifest@1":
        fail("Unexpected content manifest schema")
    if manifest.get("version") != "v13" or manifest.get("algorithm") != "sha256":
        fail("Content manifest version/algorithm mismatch")
    files = manifest.get("files", {})
    if len(files) < 4:
        fail("Content manifest should pin at least four first-slice files")
    checked: list[str] = []
    for asset_path, metadata in files.items():
        full = ROOT / "app" / asset_path
        if not full.exists():
            fail(f"Manifest references missing file: {asset_path}")
        expected = metadata.get("sha256")
        actual = hashlib.sha256(full.read_bytes()).hexdigest()
        if expected != actual:
            fail(
                f"SHA-256 mismatch for {asset_path}: expected {expected}, got {actual}"
            )
        checked.append(asset_path)
    return {"manifestFiles": len(checked), "algorithm": "sha256"}


def validate_v13_features() -> dict[str, object]:
    required = [
        "app/lib/assessment/review_evidence.dart",
        "app/lib/lesson/review_practice_screen.dart",
        "app/lib/lesson/review_evidence_screen.dart",
        "app/assets/curriculum/content_manifest_v13.json",
        "app/test/review_evidence_test.dart",
        "app/test/review_practice_screen_test.dart",
        "app/test/review_evidence_screen_test.dart",
        "app/integration_test/review_flow_test.dart",
        "docs/app/TODAY-OPTIONAL-REVIEW-SPEC.md",
        "docs/app/REVIEW-EVIDENCE-SPEC.md",
        "docs/app/CONTENT-REVISION-MANIFEST-SPEC.md",
        "docs/app/FLUTTER-RUNTIME-VALIDATION-SPEC.md",
        "docs/adr/0031-today-review-evidence-content-hash-v13.md",
        "docs/FEEDBACK-UPDATE-2026-06-20-v13.md",
        "docs/UPDATE-VALIDATION-2026-06-20-v13.md",
        "docs/NEXT-VERSION-DIRECTION-v14.md",
        "tools/run_flutter_validation.sh",
        "tools/flutter_environment_v13.txt",
    ]
    missing = [rel for rel in required if not (ROOT / rel).exists()]
    if missing:
        fail(f"Missing v13 files: {missing}")

    pubspec = (ROOT / "app/pubspec.yaml").read_text(encoding="utf-8")
    if "version: 1.13.0+13" not in pubspec:
        fail("pubspec version is not 1.13.0+13")
    if "shared_preferences: ^2.5.5" not in pubspec:
        fail("v13 shared_preferences dependency marker missing")

    home = (ROOT / "app/lib/lesson/home_screen.dart").read_text(encoding="utf-8")
    for token in (
        "today-review-card",
        "today-review-count",
        "today-review-open",
        "진도와 streak에 영향 없음",
    ):
        if token not in home:
            fail(f"Home optional-review marker missing: {token}")

    queue = (ROOT / "app/lib/assessment/review_queue.dart").read_text(
        encoding="utf-8"
    )
    for token in ("findById", "postponeItem", "ReviewQueueScheduler"):
        if token not in queue:
            fail(f"Review queue marker missing: {token}")

    practice = (ROOT / "app/lib/lesson/review_practice_screen.dart").read_text(
        encoding="utf-8"
    )
    for token in (
        "ReviewPracticeScreen",
        "review-voice-",
        "VoiceState.hoarse",
        "review-attempt-add",
        "review-self-check-",
        "review-source-play-",
        "review-finish",
        "voice_state_recovery_no_voiced_review",
    ):
        if token not in practice:
            fail(f"Review practice marker missing: {token}")
    for forbidden in ("AudioSessionAction.recordingPlaybackStopped", "captureStarted"):
        if forbidden in practice:
            fail(f"Invalid audio-session enum marker remains: {forbidden}")

    evidence = (ROOT / "app/lib/assessment/review_evidence.dart").read_text(
        encoding="utf-8"
    )
    for token in (
        "class ReviewEvidenceRecord",
        "playedSourceTakeIds",
        "sourceContentRevision",
        "currentContentRevision",
        "SharedPreferencesAsync",
    ):
        if token not in evidence:
            fail(f"Review evidence marker missing: {token}")
    if "qualityScore" in evidence or "singerScore" in evidence:
        fail("Review evidence must not introduce a quality/singer score")

    blueprint = (ROOT / "app/lib/curriculum/lesson_blueprint.dart").read_text(
        encoding="utf-8"
    )
    for token in (
        "CurriculumContentManifest",
        "sourceSha256",
        "sha256_",
        "content_manifest_v13.json",
    ):
        if token not in blueprint:
            fail(f"Blueprint content-revision marker missing: {token}")

    main = (ROOT / "app/lib/main.dart").read_text(encoding="utf-8")
    for token in (
        "_dueReviewCount",
        "ReviewPracticeScreen",
        "ReviewEvidenceScreen",
        "reviewEvidenceRepository",
    ):
        if token not in main:
            fail(f"App shell v13 marker missing: {token}")

    settings = (ROOT / "app/lib/lesson/settings_screen.dart").read_text(
        encoding="utf-8"
    )
    if "settings-review-evidence" not in settings or "1.13.0" not in settings:
        fail("Settings v13 review evidence/version marker missing")

    return {"requiredFeatureFiles": len(required), "appVersion": "1.13.0+13"}


def validate_docs_and_version() -> dict[str, object]:
    required = [
        "docs/VERSIONING.md",
        "docs/app/REVIEW-QUEUE-SPEC.md",
        "docs/app/LEARNING-EVIDENCE-SPEC.md",
        "docs/app/DATA-PRIVACY-SPEC.md",
        "docs/app/TODAY-OPTIONAL-REVIEW-SPEC.md",
        "docs/app/REVIEW-EVIDENCE-SPEC.md",
        "docs/app/CONTENT-REVISION-MANIFEST-SPEC.md",
        "docs/app/FLUTTER-RUNTIME-VALIDATION-SPEC.md",
        "docs/adr/0031-today-review-evidence-content-hash-v13.md",
        "docs/FEEDBACK-UPDATE-2026-06-20-v13.md",
        "docs/UPDATE-VALIDATION-2026-06-20-v13.md",
        "docs/NEXT-VERSION-DIRECTION-v14.md",
        "docs/PATCH-MANIFEST-v13.json",
        "docs/changed-files-v13.txt",
    ]
    missing = [rel for rel in required if not (ROOT / rel).exists()]
    if missing:
        fail(f"Missing v13 docs: {missing}")

    versioning = (ROOT / "docs/VERSIONING.md").read_text(encoding="utf-8")
    if "Current project version: **v13**" not in versioning:
        fail("VERSIONING.md does not identify v13")

    verification = json.loads(
        (ROOT / "docs/verification/verification-status.json").read_text(
            encoding="utf-8"
        )
    )
    if verification.get("version") != "v13":
        fail("verification-status version is not v13")
    if verification.get("appVersion") != "1.13.0+13":
        fail("verification-status appVersion mismatch")
    required_items = {
        "delayedReviewQueue",
        "reviewEvidence",
        "todayOptionalReview",
        "contentRevisionManifest",
        "runtimeValidationPipeline",
    }
    if not required_items <= set(verification.get("items", {})):
        fail("verification-status missing v13 items")

    patch_manifest = json.loads(
        (ROOT / "docs/PATCH-MANIFEST-v13.json").read_text(encoding="utf-8")
    )
    if patch_manifest.get("version") != "v13":
        fail("PATCH-MANIFEST-v13.json version mismatch")
    if patch_manifest.get("target") != "v13 / app 1.13.0+13":
        fail("PATCH-MANIFEST-v13.json target mismatch")

    return {"requiredDocs": len(required), "version": "v13"}


def main() -> int:
    report = {
        "jsonFiles": base.parse_json_files(),
        "yamlFiles": base.parse_yaml_files(),
        "dartDelimiterFiles": base.scan_dart_delimiters(),
        "curriculum": base.validate_curriculum(),
        "verticalSlice": base.validate_vertical_slice(),
        "contentManifest": validate_content_manifest(),
        "v13Features": validate_v13_features(),
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
