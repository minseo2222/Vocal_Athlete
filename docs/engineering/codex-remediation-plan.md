# Codex Remediation Plan

Created after a first-pass repository read for a new Codex session. This plan records verified candidates only; it does not change feature code.

## Scope Read

Priority files read or sampled:

- Root context/instructions: `CONTEXT.md`, `CONTEXT-MAP.md`, `CLAUDE.md`
- README files found under `app/`, `docs/app/_archive/`, `docs/curriculum/_archive/`, `prototypes/lesson-ui/`, `prototypes/progression/`, and `app/ios/Runner/Assets.xcassets/LaunchImage.imageset/`
- Flutter config: `app/pubspec.yaml`, `app/analysis_options.yaml`
- CI: `.github/workflows/flutter-ci.yml`
- ADRs: `docs/adr/0001` through `docs/adr/0016`
- App code under `app/lib/`
- Tests under `app/test/`
- Safety/verification docs: `docs/curriculum/HITL-SIGNOFF.md`, `docs/verification/VERIFICATION-STATUS.md`, `docs/verification/verification-status.json`

## Current Status

Last updated: 2026-06-13.

- Complete: P0-1 progression persistence now restores course identity/state with migration-safe fallback tests.
- Complete: P0-2 safety signoff and released genre rollout remain human-controlled; automation did not approve pending/UNVERIFIED state.
- Complete with human follow-up: P0-3 Android release builds no longer use debug signing; local signing credentials are intentionally absent and must be provided by a human before release.
- Complete: P1-1 RecordingPitchSource lifecycle is guarded for duplicate start, repeated stop/dispose, cleanup, and late events.
- Complete: P1-2 LessonScreen defensively handles empty `voicedMicroWin`, while production card invariants still require content.
- Complete: P1-3 target-bearing pitch cards now provide `targetHz`, and tests prevent target-line copy without data.
- Complete: P1-4 Settings genre-change entry now matches the state where genre changes can actually apply.
- Complete: P1-5 README and verification docs now reflect the current app layout and pitch/microphone scope.
- Complete: P2-1 generated/local files are ignored and are not tracked; build output can still reappear locally after builds.
- Complete: P2-2 no `#Uxxxx` broken filenames remain in scanned source/doc paths.
- Complete with residual warning: P2-3 `.gitattributes` normalizes text to LF and `git diff --check` has no whitespace errors, but Git still reports LF normalization warnings for a few touched files.
- Complete: P2-4 CI pins Flutter `3.44.0` and keeps app verification commands in `app/`.

Remaining human/device checks:

- Real Android/iOS microphone behavior still needs device verification before any VERIFIED claim.
- Release signing secrets, keystore custody, and final applicationId ownership confirmation remain human release tasks.
- Safety signoff and genre rollout must remain pending/unreleased until backed by human review artifacts.
- Flutter debug build currently warns that `record_android` and `shared_preferences_android` apply Kotlin Gradle Plugin; plugin upgrades should be checked before relying on future Flutter versions.

## P0

### P0-1. Progression persistence restores the wrong manifest after course entry

- Verified: `Progression.fromJson()` always rebuilds `buildPlaceholderManifest()`. `toJson()` does not persist the active course/manifest identity.
- Risk: a saved intermediate-course or maintenance/course state can restore into the beginner placeholder manifest while preserving unrelated state fields.
- Files likely touched:
  - `app/lib/progression/progression_state.dart`
  - `app/lib/progression/progression_store.dart`
  - `app/test/progression_serialization_test.dart`
  - `app/test/progression_store_test.dart`
  - `app/test/persistence_integration_test.dart`
- Expected tests:
  - Round-trip a released genre course after `chooseGenre()`.
  - Round-trip maintenance state for unreleased genres.
  - Verify stored rollout state does not override `kReleasedGenres`.
- Risk notes: migration must tolerate old saved JSON that has no course identity.

### P0-2. Safety signoff and rollout state must remain human-controlled

- Verified: `kSafetySignoff` is empty by design; `kReleasedGenres` is empty by design; verification JSON and tests enforce this.
- Risk: future automation could incorrectly approve safety `pending` cards or release genres without human evidence.
- Files likely touched only with human evidence:
  - `app/lib/safety/safety_signoff.dart`
  - `app/lib/progression/progression_state.dart`
  - `docs/verification/verification-status.json`
  - `docs/verification/VERIFICATION-STATUS.md`
  - `app/test/safety_signoff_test.dart`
  - `app/test/release_config_test.dart`
  - `app/test/verification_harness_test.dart`
- Expected tests:
  - Existing W1/W2/W5 tests must continue to prove code and JSON agree.
- Risk notes: do not change pending/UNVERIFIED to approved/VERIFIED without explicit human-review artifacts.

### P0-3. Android release config is not production-ready

- Verified: `app/android/app/build.gradle.kts` has an applicationId TODO and release signing uses the debug signing config.
- Risk: accidental release builds may be signed with debug keys or carry template TODO configuration.
- Files likely touched:
  - `app/android/app/build.gradle.kts`
  - `app/test/release_config_test.dart`
- Expected tests:
  - Strengthen `release_config_test.dart` to reject debug signing for release.
  - Assert no applicationId TODO remains when production release config is introduced.
- Risk notes: signing credentials must not be committed. Use documented local/CI secret injection.

## P1

### P1-1. RecordingPitchSource lifecycle is under-guarded

- Verified: `RecordingPitchSource.start()` can be called repeatedly without stopping the previous subscription; `dispose()` cancels asynchronously without awaiting cleanup.
- Risk: duplicate byte subscriptions, recorder state races, events after close, or leaked microphone resources.
- Files likely touched:
  - `app/lib/lesson/pitch/recording_pitch_source.dart`
  - new or existing pitch lifecycle tests under `app/test/`
- Expected tests:
  - Fake `AudioRecorder` or an adapter seam for duplicate start.
  - Stop without start.
  - Dispose after start.
  - Events after stop/dispose do not add frames.
- Risk notes: `AudioRecorder` may need an interface wrapper to test lifecycle deterministically.

### P1-2. LessonScreen can crash on empty voicedMicroWin

- Verified: `LessonScreen` renders `card.voicedMicroWin.first` when `card != null`; it does not guard an empty list.
- Risk: a future or malformed card with empty `voicedMicroWin` crashes the lesson screen.
- Files likely touched:
  - `app/lib/lesson/lesson_screen.dart`
  - `app/test/lesson_screen_widget_test.dart`
  - possibly `app/test/card_library_test.dart`
- Expected tests:
  - Widget test with a test-only card/manifest whose `voicedMicroWin` is empty.
  - Existing library invariant test should still require production cards to be non-empty.
- Risk notes: keep ADR-0015's "voiced micro-win required" invariant for real cards; UI guard is defensive.

### P1-3. PitchDisplay target support is wired, but card data lacks targetHz values

- Verified: `PitchDisplay` accepts `targetHz`; `LessonScreen` passes `card?.targetHz`; `Card` has `targetHz`; current card library search found no concrete `targetHz:` assignments.
- Risk: target line and retry nudge are absent for all real cards, so visual pitch matching is weaker than ADR-0014's card-target intent.
- Files likely touched:
  - `app/lib/lesson/card_library.dart`
  - `app/test/card_library_test.dart`
  - `app/test/lesson_screen_widget_test.dart`
  - `app/test/pitch_display_widget_test.dart`
- Expected tests:
  - Cards that require visual target matching have non-null `targetHz`.
  - Lesson screen renders a target line for target-bearing cards.
  - Cards without targets still render absolute-pitch dots without nudges.
- Risk notes: target choices are curriculum/content decisions; do not invent targets without domain review if exact notes matter.

### P1-4. Settings genre-change UX depends on internal graduation/genre state

- Verified: Settings exposes genre change only when `p.genre != null`; `Progression.chooseGenre()` ignores calls before graduation.
- Risk: UX may hide or show genre change in states that do not match product expectations, especially maintenance vs released-course states.
- Files likely touched:
  - `app/lib/main.dart`
  - `app/lib/lesson/settings_screen.dart`
  - `app/test/settings_screen_widget_test.dart`
  - `app/test/graduation_screen_widget_test.dart`
- Expected tests:
  - Graduated with genre selected can re-pick.
  - Not graduated cannot choose.
  - Released-course and maintenance states show the intended entry point.
- Risk notes: keep ADR-0010's non-binding, changeable genre selection.

### P1-5. app README is stale

- Verified: `app/README.md` still says "pYIN V1" and references `lib/spike/pitch_naive.dart`, but ADR-0014 now accepts Dart autocorrelation and `app/lib/spike/` is absent.
- Risk: new agents or humans follow obsolete verification and architecture notes.
- Files likely touched:
  - `app/README.md`
  - possibly `docs/verification/NEW-SESSION-REVERIFY.md`
- Expected tests:
  - Documentation-only change; run `flutter test` if examples or claims depend on current behavior.
- Risk notes: update README to match ADR-0014 without altering ADR meaning.

## P2

### P2-1. Generated and local files exist in the working tree

- Verified ignored paths exist: `app/.dart_tool/`, `app/build/`, `app/android/.gradle/`, `app/android/local.properties`, `app/ios/Flutter/Generated.xcconfig`, `app/ios/Flutter/flutter_export_environment.sh`, `app/ios/Flutter/ephemeral/`.
- Verified `git ls-files` did not report these candidate paths as tracked.
- Risk: noisy searches, accidental edits, large local state, confusing reviews.
- Files likely touched:
  - none for feature work
  - possibly `.gitignore` in a separate cleanup goal, but it is already modified in the working tree and should be handled carefully
- Expected tests:
  - `git status --short --ignored` before/after cleanup.
- Risk notes: deletion should be a separate explicit cleanup goal.

### P2-2. Korean `#Uxxxx` broken filenames were not found in source/doc paths

- Verified: search under `app`, `docs`, and `.github` found no filenames matching `#U[0-9A-Fa-f]{4}`.
- Risk: low for source/docs; build output still contains opaque generated filenames and should be ignored.
- Files likely touched:
  - none unless a later search finds actual broken filenames.
- Expected tests:
  - Filename scan command in cleanup goal.

### P2-3. Line endings are mixed by file group but not mixed within scanned priority files

- Verified: `CONTEXT.md`, `CONTEXT-MAP.md`, `.github/workflows/flutter-ci.yml`, and `app/README.md` use LF; `app/pubspec.yaml` and `app/analysis_options.yaml` use CRLF; scanned Dart files are internally consistent. No trailing whitespace was detected in the priority scan.
- Risk: future broad formatting can create noisy diffs.
- Files likely touched:
  - `.gitattributes` only if the team wants a repo-wide policy.
- Expected tests:
  - `git diff --check`
  - targeted line-ending scan.
- Risk notes: do not normalize the whole repo as part of feature work.

### P2-4. CI pins Flutter channel, not exact version

- Verified: `.github/workflows/flutter-ci.yml` uses `subosito/flutter-action@v2` with `channel: stable` only.
- Risk: upstream stable changes can alter analyzer/test results.
- Files likely touched:
  - `.github/workflows/flutter-ci.yml`
  - possibly `app/pubspec.lock` only through normal dependency workflows.
- Expected tests:
  - CI dry run or local `flutter --version` documentation.
  - Existing `flutter pub get`, `flutter analyze`, `flutter test`.
- Risk notes: exact Flutter version pinning is a project policy decision.

## Recommended Order

1. Cleanup-only goal for ignored generated/local files, with no feature edits.
2. Fix documentation drift in `app/README.md`.
3. Fix progression persistence/course restoration with tests.
4. Add defensive LessonScreen empty-list guard with tests.
5. Harden RecordingPitchSource lifecycle with tests or a recorder adapter seam.
6. Decide card targetHz content policy, then wire target-bearing cards and tests.
7. Address Android release signing/applicationId TODO with a non-secret signing plan.
8. Decide whether CI should pin a specific Flutter version.

## Verification Commands

Run from `app/` for app changes:

```sh
flutter pub get
flutter analyze
flutter test
```
