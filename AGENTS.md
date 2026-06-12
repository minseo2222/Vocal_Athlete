# Codex Project Instructions

This repository contains a Flutter app under `app/`. Treat the repository root as the documentation and planning workspace, and treat `app/` as the Flutter project root.

## Working Directory

- Run Flutter commands from `app/` by default.
- Use these verification commands for app changes:
  - `flutter pub get`
  - `flutter analyze`
  - `flutter test`
- Do not run full-repository auto-formatting unless the user explicitly asks for it.
- Do not commit unless the user explicitly asks for a commit.
- Do not modify `.git/`.

## Files To Avoid Editing

Generated artifacts, caches, and local environment files are cleanup targets, not feature-edit targets. Do not make functional changes inside:

- `app/build/`
- `app/.dart_tool/`
- `app/android/.gradle/`
- `app/android/local.properties`
- `app/ios/Flutter/Generated.xcconfig`
- `app/ios/Flutter/flutter_export_environment.sh`
- `app/ios/Flutter/ephemeral/`
- APKs, `.dill`, `.so`, `kernel_blob.bin`, and similar build outputs

If these files appear in the working tree, report them and plan a separate cleanup goal instead of editing them in place.

## Domain Constraints

- Safety and curriculum documents are source-of-truth materials. Do not casually rewrite their meaning.
- ADRs in `docs/adr/`, `CONTEXT.md`, and `CONTEXT-MAP.md` define product rules. Read the relevant parts before changing behavior.
- Do not change safety `pending`, `UNVERIFIED`, or signoff state to approved/verified without real human-review evidence.
- AI must not populate `kSafetySignoff` or release genres in `kReleasedGenres` on its own.
- Public behavior changes must update the related tests and documentation.

## High-Risk Areas

Before changing any of these areas, write a short plan and add or update focused tests:

- `Progression` and progression persistence
- calendar/day cap behavior
- pitch detection, pitch display, or microphone lifecycle
- safety gates, signoff, rollout, or verification status
- curriculum/card/path manifests

For these areas, prefer a narrow red/green loop: first add a failing characterization or regression test, then implement the smallest behavior change, then run `flutter analyze` and `flutter test`.
