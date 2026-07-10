# UPDATE VALIDATION — v17 — 2026-06-21

## Static validation

Command:

```bash
python -B tools/validate_v17.py
```

Result:

```text
PASS

JSON: 34
YAML: 1
Dart delimiter: 118
local/package imports: 247

Card library: 126
Path-referenced cards: 110
Missing path cards: 0
Missing fallback targets: 0

Beginner Foundation: 48
Universal Vocal Core: 144
Repertoire Application: 72
Advanced Genre Lab cycles: 40 each

Content manifest: 31 files
- blueprints: 3
- rights records: 3
- asset manifest: 1
- audio: 24
Manifest generator check: PASS

Timbre source register:
- total: 39
- checked v15: 8
- checked v16: 5
- checked v17: 6
- pending: 20
```

## v17-specific static checks

The validator checks:

- `RecordingTake` curation fields exist;
- `ToneProfileCurationService` can update self-tags and exclude/restore takes;
- `ToneProfile.fromTakes()` tracks `excludedTakeCount` and skips excluded takes from stable palette signals;
- `ToneProfileScreen` contains curation UI markers;
- `content_manifest_v17.json` is fresh;
- `lesson_blueprint.dart` loads the v17 manifest;
- v17 docs and ADR are present;
- v17 source statuses are CSV/JSON synchronized.

## Flutter validation status

Command:

```bash
./tools/run_flutter_validation.sh
```

Result:

```text
exit code: 127
BLOCKED: flutter is not installed or not on PATH. Expected Flutter 3.44.x stable.
```

Therefore this update is static-validated only. It does not prove Flutter compilation, plugin behavior, Android/iOS audio, screen overflow, accessibility, or learning effect.

## Manual runtime QA target

Tone Profile curation must be checked in Flutter/Android:

1. Create two tone A/B takes.
2. Open `내 음색 팔레트`.
3. Change one tone tag.
4. Exclude one take from the palette.
5. Confirm the original recording remains in the recording library.
6. Restore the take.
7. Confirm the palette summary updates.
8. Confirm a hoarse/recovery state does not encourage voiced timbre experimentation.
