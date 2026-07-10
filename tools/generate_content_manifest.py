#!/usr/bin/env python3
"""Generate and verify the current curriculum content manifest.

The manifest pins first-vertical-slice blueprints, asset manifests, rights records,
and every WAV declared by those rights records. The generator fails when a rights
record hash is stale, an audio file is missing, or a blueprint/asset manifest
references audio outside the declared inventory.
"""
from __future__ import annotations

import argparse
import datetime as dt
import hashlib
import json
from pathlib import Path
from typing import Any

ROOT = Path(__file__).resolve().parents[1]
APP = ROOT / "app"

BLUEPRINTS = [
    {
        "path": "assets/curriculum/beginner_timbre_slice_v16.json",
        "bundleVersion": "v16",
        "track": "beginnerFoundation",
        "cycle": 1,
    },
    {
        "path": "assets/curriculum/universal_core_cycle_01.json",
        "bundleVersion": "v16",
        "track": "universalCore",
        "cycle": 1,
    },
    {
        "path": "assets/curriculum/repertoire_project_01.json",
        "bundleVersion": "v10",
        "track": "repertoireApplication",
        "cycle": 1,
    },
]

ASSET_MANIFESTS = [
    {
        "path": "assets/repertoire/neutral_001/manifest.json",
        "bundleVersion": "v10",
        "track": "repertoireApplication",
        "cycle": 1,
    },
]

RIGHTS_RECORDS = [
    {
        "path": "assets/training/timbre_v16/rights.json",
        "bundleVersion": "v16",
        "track": "beginnerFoundation",
        "cycle": 1,
    },
    {
        "path": "assets/training/universal_core_cycle_01/rights.json",
        "bundleVersion": "v10",
        "track": "universalCore",
        "cycle": 1,
    },
    {
        "path": "assets/repertoire/neutral_001/rights.json",
        "bundleVersion": "v10",
        "track": "repertoireApplication",
        "cycle": 1,
    },
]


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def load_json(rel: str) -> Any:
    path = APP / rel
    if not path.exists():
        raise SystemExit(f"missing asset: {rel}")
    return json.loads(path.read_text(encoding="utf-8"))


def add_file(
    files: dict[str, dict[str, Any]],
    rel: str,
    *,
    kind: str,
    bundle_version: str,
    track: str,
    cycle: int,
    rights_record: str | None = None,
) -> None:
    path = APP / rel
    if not path.exists():
        raise SystemExit(f"manifest input does not exist: {rel}")
    item: dict[str, Any] = {
        "sha256": sha256(path),
        "kind": kind,
        "bundleVersion": bundle_version,
        "track": track,
        "cycle": cycle,
    }
    if rights_record is not None:
        item["rightsRecord"] = rights_record
    files[rel] = item


def declared_audio_inventory() -> tuple[dict[str, dict[str, Any]], set[str]]:
    inventory: dict[str, dict[str, Any]] = {}
    rights_paths: set[str] = set()
    for spec in RIGHTS_RECORDS:
        rights_rel = spec["path"]
        rights_paths.add(rights_rel)
        rights = load_json(rights_rel)
        base = str(Path(rights_rel).parent).replace("\\", "/")
        declared = rights.get("files")
        if not isinstance(declared, list) or not declared:
            raise SystemExit(f"rights record has no files: {rights_rel}")
        for row in declared:
            name = row.get("path")
            expected = row.get("sha256")
            if not isinstance(name, str) or not isinstance(expected, str):
                raise SystemExit(f"invalid rights row in {rights_rel}: {row!r}")
            rel = f"{base}/{name}"
            actual_path = APP / rel
            if not actual_path.exists():
                raise SystemExit(f"rights record references missing audio: {rel}")
            actual = sha256(actual_path)
            if actual != expected:
                raise SystemExit(
                    f"rights SHA mismatch for {rel}: expected {expected}, got {actual}"
                )
            inventory[rel] = {
                "bundleVersion": spec["bundleVersion"],
                "track": spec["track"],
                "cycle": spec["cycle"],
                "rightsRecord": rights_rel,
            }

        actual_wavs = {
            str(path.relative_to(APP)).replace("\\", "/")
            for path in (APP / base).glob("*.wav")
        }
        declared_wavs = {
            rel for rel in inventory if rel.startswith(f"{base}/")
        }
        extra = sorted(actual_wavs - declared_wavs)
        if extra:
            raise SystemExit(
                f"untracked WAV files beside {rights_rel}: {', '.join(extra)}"
            )
    return inventory, rights_paths


def referenced_audio_paths() -> set[str]:
    referenced: set[str] = set()
    for spec in BLUEPRINTS:
        data = load_json(spec["path"])
        for lesson in data.get("lessons", []):
            for cue in lesson.get("audioCues", []):
                path = cue.get("path")
                if isinstance(path, str) and path.endswith(".wav"):
                    referenced.add(path)
    for spec in ASSET_MANIFESTS:
        data = load_json(spec["path"])
        for path in (data.get("audioAssets") or {}).values():
            if isinstance(path, str) and path.endswith(".wav"):
                referenced.add(path)
    return referenced


def generate(version: str, generated_at: str) -> dict[str, Any]:
    files: dict[str, dict[str, Any]] = {}
    for spec in BLUEPRINTS:
        add_file(files, spec["path"], kind="blueprint", bundle_version=spec["bundleVersion"], track=spec["track"], cycle=spec["cycle"])
    for spec in ASSET_MANIFESTS:
        add_file(files, spec["path"], kind="asset_manifest", bundle_version=spec["bundleVersion"], track=spec["track"], cycle=spec["cycle"])
    for spec in RIGHTS_RECORDS:
        add_file(files, spec["path"], kind="rights_record", bundle_version=spec["bundleVersion"], track=spec["track"], cycle=spec["cycle"])

    audio_inventory, _ = declared_audio_inventory()
    for rel, metadata in audio_inventory.items():
        add_file(
            files,
            rel,
            kind="audio",
            bundle_version=metadata["bundleVersion"],
            track=metadata["track"],
            cycle=metadata["cycle"],
            rights_record=metadata["rightsRecord"],
        )

    referenced = referenced_audio_paths()
    undeclared = sorted(referenced - set(audio_inventory))
    if undeclared:
        raise SystemExit(
            "audio referenced by curriculum but absent from rights inventory: "
            + ", ".join(undeclared)
        )

    return {
        "schema": "vocal-athlete/curriculum-content-manifest@2",
        "version": version,
        "generatedAt": generated_at,
        "algorithm": "sha256",
        "generator": "tools/generate_content_manifest.py",
        "files": dict(sorted(files.items())),
        "summary": {
            "blueprints": len(BLUEPRINTS),
            "assetManifests": len(ASSET_MANIFESTS),
            "rightsRecords": len(RIGHTS_RECORDS),
            "audioFiles": len(audio_inventory),
            "referencedAudioFiles": len(referenced),
        },
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--version", default="v18")
    parser.add_argument("--date", default=dt.date.today().isoformat())
    parser.add_argument(
        "--output",
        default="app/assets/curriculum/content_manifest_v18.json",
    )
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()

    manifest = generate(args.version, args.date)
    output = ROOT / args.output
    serialized = json.dumps(manifest, ensure_ascii=False, indent=2) + "\n"
    if args.check:
        if not output.exists():
            raise SystemExit(f"manifest missing: {output.relative_to(ROOT)}")
        existing = json.loads(output.read_text(encoding="utf-8"))
        # generatedAt is metadata; all integrity-bearing fields must match.
        left = dict(existing)
        right = dict(manifest)
        left.pop("generatedAt", None)
        right.pop("generatedAt", None)
        if left != right:
            raise SystemExit("content manifest is stale; run generator")
        print(f"PASS: {output.relative_to(ROOT)} is current")
        return 0

    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(serialized, encoding="utf-8")
    print(f"WROTE: {output.relative_to(ROOT)} ({len(manifest['files'])} files)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
