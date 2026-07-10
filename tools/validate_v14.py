#!/usr/bin/env python3
"""Repository-level v14 validation without Flutter/Dart execution.

Checks curriculum invariants, generated content hashes, metadata migration
boundaries, review cue wiring, version/docs, and local imports. This does not
prove Flutter compilation, plugin behavior, device audio, safety, or learning
efficacy.
"""
from __future__ import annotations

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


def validate_content_manifest() -> dict[str, object]:
    rel = "app/assets/curriculum/content_manifest_v14.json"
    path = ROOT / rel
    if not path.exists():
        fail(f"Missing content manifest: {rel}")
    manifest = json.loads(path.read_text(encoding="utf-8"))
    if manifest.get("schema") != "vocal-athlete/curriculum-content-manifest@2":
        fail("Unexpected v14 content manifest schema")
    if manifest.get("version") != "v14" or manifest.get("algorithm") != "sha256":
        fail("v14 content manifest version/algorithm mismatch")
    files = manifest.get("files")
    if not isinstance(files, dict) or len(files) != 25:
        fail(f"v14 content manifest must track 25 files, got {len(files or {})}")
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
        fail(f"Unexpected v14 manifest kind counts: {kinds}")
    proc = subprocess.run(
        [
            sys.executable,
            str(ROOT / "tools/generate_content_manifest.py"),
            "--version",
            "v14",
            "--check",
        ],
        cwd=ROOT,
        text=True,
        capture_output=True,
    )
    if proc.returncode != 0:
        fail(f"Manifest generator check failed: {proc.stdout}{proc.stderr}")
    return {"manifestFiles": len(files), "kinds": kinds, "generatorCheck": "PASS"}


def validate_storage_and_review() -> dict[str, object]:
    required = [
        ".flutter-version",
        ".github/workflows/flutter-validation.yml",
        "app/lib/storage/app_metadata_store.dart",
        "app/lib/lesson/learning_data_management_screen.dart",
        "app/lib/assessment/review_instruction.dart",
        "app/test/app_metadata_store_test.dart",
        "app/test/learning_data_management_screen_test.dart",
        "app/test/review_instruction_test.dart",
        "app/assets/curriculum/content_manifest_v14.json",
        "tools/generate_content_manifest.py",
        "tools/run_flutter_validation.sh",
    ]
    missing = [rel for rel in required if not (ROOT / rel).exists()]
    if missing:
        fail(f"Missing v14 implementation files: {missing}")

    pubspec = (ROOT / "app/pubspec.yaml").read_text(encoding="utf-8")
    if "version: 1.14.0+14" not in pubspec:
        fail("pubspec version is not 1.14.0+14")
    if (ROOT / ".flutter-version").read_text(encoding="utf-8").strip() != "3.44.2":
        fail(".flutter-version is not pinned to 3.44.2")

    storage = (ROOT / "app/lib/storage/app_metadata_store.dart").read_text(
        encoding="utf-8"
    )
    for token in (
        "SharedPreferencesAsyncMetadataBackend",
        "LegacySharedPreferencesMetadataBackend",
        "currentSchemaVersion = 2",
        "migrateKnownKeys",
        "quarantineCorruptValue",
        "class MetadataInventory",
        "clearAllLearningMetadata",
    ):
        if token not in storage:
            fail(f"Metadata store marker missing: {token}")

    direct_imports = []
    for dart in (ROOT / "app/lib").rglob("*.dart"):
        text = dart.read_text(encoding="utf-8")
        if "package:shared_preferences/shared_preferences.dart" in text:
            direct_imports.append(str(dart.relative_to(ROOT)))
    if direct_imports != ["app/lib/storage/app_metadata_store.dart"]:
        fail(f"shared_preferences must be isolated behind metadata store: {direct_imports}")

    main = (ROOT / "app/lib/main.dart").read_text(encoding="utf-8")
    method = re.search(
        r"void _onStartRepertoireApplication\(\)\s*\{(.*?)\n\s*\}",
        main,
        re.S,
    )
    if not method:
        fail("Could not parse repertoire start handler")
    if method.group(1).count("_p!.startRepertoireApplication();") != 1:
        fail("Repertoire start handler must call start exactly once")
    for token in (
        "LearningDataManagementScreen",
        "migrateKnownKeys",
        "settings-learning-data-management",
    ):
        haystack = main + (ROOT / "app/lib/lesson/settings_screen.dart").read_text(encoding="utf-8")
        if token not in haystack:
            fail(f"v14 data-management wiring missing: {token}")

    blueprint = (ROOT / "app/lib/curriculum/lesson_blueprint.dart").read_text(
        encoding="utf-8"
    )
    if "content_manifest_v14.json" not in blueprint:
        fail("Runtime blueprint repository does not use v14 manifest")

    review = (ROOT / "app/lib/assessment/review_instruction.dart").read_text(
        encoding="utf-8"
    )
    for token in (
        "ReviewInstructionResolver",
        "한 단계 낮춰",
        "가이드를 한 단계 줄이기",
        "한 번에 하나",
    ):
        if token not in review:
            fail(f"Card-specific review cue marker missing: {token}")
    if re.search(r"높은 키로 (?:바꾸|올리)|한 단계 높", review):
        fail("Review transfer must not prescribe a higher key")

    workflow = (ROOT / ".github/workflows/flutter-validation.yml").read_text(
        encoding="utf-8"
    )
    for token in (
        "flutter-version: '3.44.2'",
        "python tools/validate_v14.py",
        "dart analyze",
        "flutter test --reporter expanded",
        "flutter build apk --debug",
    ):
        if token not in workflow:
            fail(f"CI workflow marker missing: {token}")

    return {
        "metadataSchema": 2,
        "directSharedPreferencesImports": direct_imports,
        "repertoireStartCalls": 1,
        "flutterPin": "3.44.2",
    }


def validate_local_package_imports() -> int:
    package_root = ROOT / "app/lib"
    checked = 0
    for dart in list((ROOT / "app/lib").rglob("*.dart")) + list((ROOT / "app/test").rglob("*.dart")) + list((ROOT / "app/integration_test").rglob("*.dart")):
        text = dart.read_text(encoding="utf-8")
        for match in re.finditer(r"import\s+'package:vocal_athlete/([^']+)'", text):
            target = package_root / match.group(1)
            if not target.exists():
                fail(f"Missing package import target from {dart.relative_to(ROOT)}: {match.group(1)}")
            checked += 1
        for match in re.finditer(r"import\s+'(\.\.?/[^']+)'", text):
            target = (dart.parent / match.group(1)).resolve()
            if not target.exists():
                fail(f"Missing relative import target from {dart.relative_to(ROOT)}: {match.group(1)}")
            checked += 1
    return checked


def validate_docs() -> dict[str, object]:
    required = [
        "docs/VERSIONING.md",
        "docs/app/METADATA-STORAGE-MIGRATION-SPEC.md",
        "docs/app/CONTENT-REVISION-MANIFEST-SPEC.md",
        "docs/app/FLUTTER-RUNTIME-VALIDATION-SPEC.md",
        "docs/app/FIRST-24-DAY-QA-PLAN.md",
        "docs/adr/0032-storage-manifest-ci-v14.md",
        "docs/FEEDBACK-UPDATE-2026-06-21-v14.md",
        "docs/UPDATE-VALIDATION-2026-06-21-v14.md",
        "docs/NEXT-VERSION-DIRECTION-v15.md",
        "docs/PATCH-MANIFEST-v14.json",
        "docs/changed-files-v14.txt",
        "tools/flutter_environment_v14.txt",
    ]
    missing = [rel for rel in required if not (ROOT / rel).exists()]
    if missing:
        fail(f"Missing v14 docs: {missing}")
    versioning = (ROOT / "docs/VERSIONING.md").read_text(encoding="utf-8")
    if "Current project version: **v14**" not in versioning:
        fail("VERSIONING.md does not identify v14")
    status = json.loads(
        (ROOT / "docs/verification/verification-status.json").read_text(encoding="utf-8")
    )
    if status.get("version") != "v14" or status.get("appVersion") != "1.14.0+14":
        fail("verification-status v14 version mismatch")
    for key in ("metadataStorageMigration", "contentRevisionManifest", "runtimeValidationPipeline"):
        if key not in status.get("items", {}):
            fail(f"verification-status missing v14 item: {key}")
    patch = json.loads((ROOT / "docs/PATCH-MANIFEST-v14.json").read_text(encoding="utf-8"))
    if patch.get("version") != "v14" or patch.get("target") != "v14 / app 1.14.0+14":
        fail("PATCH-MANIFEST-v14 version/target mismatch")
    return {"requiredDocs": len(required), "version": "v14"}


def main() -> int:
    report = {
        "jsonFiles": base.parse_json_files(),
        "yamlFiles": base.parse_yaml_files(),
        "dartDelimiterFiles": base.scan_dart_delimiters(),
        "localImports": validate_local_package_imports(),
        "curriculum": base.validate_curriculum(),
        "verticalSlice": base.validate_vertical_slice(),
        "contentManifest": validate_content_manifest(),
        "storageAndReview": validate_storage_and_review(),
        "docs": validate_docs(),
    }
    print(json.dumps({"status": "PASS", **report}, ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except AssertionError as exc:
        print(json.dumps({"status": "FAIL", "error": str(exc)}, ensure_ascii=False, indent=2))
        raise SystemExit(1)
