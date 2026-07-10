# FEEDBACK-UPDATE-2026-06-16-v5

## Summary

v5 starts numeric versioning and turns the previous R4 backlog into executable product slices.

Implemented in v5:

1. Numeric version policy (`docs/VERSIONING.md`) and app package version `1.5.0+5`.
2. Recording A/B domain model and in-lesson A/B panel.
3. Vocal Load Budget domain policy.
4. Repertoire Application asset scaffold with three 4-bar training phrase manifests.
5. Portfolio readiness rubric model.
6. Repertoire assets registered in `app/pubspec.yaml`.

## Scope boundary

v5 is still a **vocal training** version, not a song production feature. Repertoire Application uses short training phrases as transfer material for breath, phonation, pitch, rhythm, timbre, diction, and recording review.

## New code

- `app/lib/recording/recording_ab.dart`
- `app/lib/lesson/recording_ab_panel.dart`
- `app/lib/safety/vocal_load_budget.dart`
- `app/lib/assessment/assessment_rubric.dart`

## Updated code

- `app/lib/lesson/lesson_screen.dart`
  - Shows Recording A/B panel on cards that allow tone A/B or same-condition recording.
  - Shows vocal-load notices when the policy recommends reduced/recovery/blocked mode.
- `app/pubspec.yaml`
  - version `1.5.0+5`
  - adds `assets/repertoire/`.

## New assets

- `app/assets/repertoire/neutral_001/manifest.json`
- `app/assets/repertoire/neutral_002/manifest.json`
- `app/assets/repertoire/korean_001/manifest.json`

These are metadata scaffolds only. Guide vocal, guide melody, backing track, and click files are named placeholders and must be produced before release.

## Safety note

v5 keeps vocal safety first. Hoarse voice state should continue to route to recovery/listening-only behavior. Vocal Load Budget formalizes daily point budget, high-intensity count, gated count, and full-take limits.

## Remaining blockers

- Native audio capture adapter and file permission QA.
- Playback adapter.
- Persistent local storage for real audio files.
- Android device mic/F0 validation.
- Actual guide vocal/backing track assets.
- Expert signoff for high-risk advanced genre cards.
