# vocal_athlete Flutter app

This directory is the Flutter project root. The repository root contains planning,
ADR, safety, and verification documents.

## Common Commands

Run from `app/`:

```sh
flutter pub get
flutter analyze
flutter test
flutter run
```

Useful targeted checks:

```sh
flutter test test/platform_config_test.dart
flutter test test/pitch_display_widget_test.dart test/recording_pitch_source_test.dart
flutter build apk --debug
```

Do not commit generated outputs or local environment files such as `build/`,
`.dart_tool/`, `.gradle/`, `android/local.properties`, APK/AAB files, Dart
kernel files, keystores, or signing property files.

## App Scope

The app currently implements the beginner lesson flow, progression persistence,
genre selection gates, visual pitch display, and microphone-backed pitch capture
through `RecordingPitchSource`.

Pitch detection is an in-app Dart autocorrelation implementation. The display is
visual guidance only: voiced readings may render a curve/current dot, cards with
`targetHz` may render a target line and retry nudge, and low-confidence/unvoiced
input is shown honestly by omitting the dot.

Real-device microphone behavior is still human-verification gated. See
`../docs/verification/DEVICE-MIC-VERIFICATION.md` and
`../docs/verification/device-results.md`.

## Safety And Rollout

Safety signoff and genre rollout are human-controlled gates:

- Do not populate `kSafetySignoff` without human review evidence.
- Do not populate `kReleasedGenres` without a rollout/safety decision.
- Do not mark pending, UNVERIFIED, or signoff state as approved without evidence.

Related checks are covered by `flutter test`, including verification harness and
release config tests.

## Android Release Signing

Debug builds use the normal debug key. Release builds must not use debug signing.

For a local release build:

1. Create a keystore outside source control.
2. Copy `android/key.properties.example` to `android/key.properties`.
3. Fill in local values for `storeFile`, `storePassword`, `keyAlias`, and
   `keyPassword`.
4. Run `flutter build apk --release` or `flutter build appbundle --release`.

`android/key.properties`, `*.jks`, and `*.keystore` are ignored and must not be
committed. If release signing is missing, the Gradle release task fails with a
message pointing to `key.properties.example`.

The current Android application ID is `com.vocalathlete.vocal_athlete`. Before a
public store release, product ownership should confirm this ID in the release
checklist rather than changing it casually.

## CI

GitHub Actions runs from `app/` and pins Flutter `3.44.0`:

```sh
flutter pub get
flutter analyze
flutter test
```
