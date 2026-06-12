# Release Checklist

This checklist is for release readiness. Do not record secrets in this document.

## Android Identity

- Current `applicationId`: `com.vocalathlete.vocal_athlete`
- Before public store release, product ownership must confirm this ID is final.
- Do not replace it with an invented ID during cleanup or automation work.

## Android Signing

- Debug signing must not be used for release builds.
- Local release signing uses `app/android/key.properties`, based on
  `app/android/key.properties.example`.
- Required local keys:
  - `storeFile`
  - `storePassword`
  - `keyAlias`
  - `keyPassword`
- `app/android/key.properties`, `*.jks`, and `*.keystore` must remain ignored.
- CI/release automation should inject equivalent signing values through secrets;
  never commit keystores or passwords.

## Microphone Permissions

- Android must declare `android.permission.RECORD_AUDIO`.
- iOS must declare `NSMicrophoneUsageDescription`.
- Permission copy should match the app's visual pitch-feedback scope and safety
  warnings. Do not claim diagnosis, medical assessment, or guaranteed vocal
  outcomes.

## Verification Before Release

Run from `app/`:

```sh
flutter pub get
flutter analyze
flutter test
flutter build apk --debug
```

Release build verification requires local signing:

```sh
flutter build apk --release
flutter build appbundle --release
```

If signing values are absent, release builds are expected to fail with the
configured Gradle signing error. That is not a product verification pass; it
means release credentials still need human/CI setup.

## Human-Gated Status

- Safety signoff remains controlled by `kSafetySignoff`.
- Genre rollout remains controlled by `kReleasedGenres`.
- Device microphone verification remains controlled by
  `docs/verification/device-results.md`.
- Do not mark any pending or UNVERIFIED item as approved without human evidence.
