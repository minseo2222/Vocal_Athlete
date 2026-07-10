# Vocal Athlete

Vocal Athlete is a local-first Flutter app for guided vocal practice. It combines a structured curriculum, microphone-assisted pitch work, recording review, progression tracking, and voice-safety checks. Learning metadata and recordings remain on the device.

## Requirements

- Flutter 3.44.2 (the repository pin is `../.flutter-version`)
- Dart 3.12 or later
- Java 17 or later and an Android SDK

## Run and verify

From this `app/` directory:

```text
flutter pub get
flutter run
flutter analyze --fatal-infos
flutter test
flutter build apk --debug
```

The app version has one release source: `version` in `pubspec.yaml`. Android receives its `versionName` and `versionCode` from Flutter, and the in-app settings screen reads the generated platform metadata.

## Android release readiness

- Application ID and namespace: `com.vocalathlete.vocal_athlete`
- Display name: `Vocal Athlete`
- Target SDK: inherited from the pinned Flutter SDK (API 36 in Flutter 3.44.x)
- Release signing: requires an uncommitted `android/key.properties`; release never falls back to the debug key

Production key creation, local/CI validation, and remaining Play Console work are documented in [`../docs/release/ANDROID-RELEASE-FOUNDATION.md`](../docs/release/ANDROID-RELEASE-FOUNDATION.md).
