# Android Release Foundation

## Confirmed identity

- Application ID: `com.vocalathlete.vocal_athlete`
- Gradle namespace: `com.vocalathlete.vocal_athlete`
- Kotlin entry point: `app/android/app/src/main/kotlin/com/vocalathlete/vocal_athlete/MainActivity.kt`
- User-visible label: `Vocal Athlete`

The existing public application ID was retained because no verified error or Play Console migration decision justified changing this permanent identifier.

## Source-control baseline

On July 10, 2026, the project root contained an empty `.git` directory. A read-only recovery search found a healthy sibling checkout with the same `Vocal_Athlete` remote, 130 commits on `main`, and the older `pro v new` checkout in its ancestry. `git fsck --full` passed, and the metadata had no shallow-clone, alternate-object, or extra-worktree dependency. After explicit user approval, that metadata was copied into the empty project `.git`; the existing history was recovered rather than replaced with a new repository. The recovered head was `8461661`.

The current tree is the verified Android release baseline layered on that history. The root `.gitignore` excludes local build/cache, IDE, signing, environment, and service-account material while retaining product source, tests, documentation, curriculum JSON, production audio assets, and app icons. The existing remote is preserved, but publishing or changing that remote remains a user action.

Baseline commit `be480f7` changed 643 paths and includes removal of the prior iOS project scaffold, `.agents`, `.claude`, and the former root `AGENTS.md`. This release foundation is Android-first. Whether to restore or regenerate the iOS project is a separate product decision; this Android reproducibility fix neither restores nor ratifies those removals and does not rewrite the baseline commit.

## Release signing structure

`app/android/app/build.gradle.kts` loads four values from the ignored file `app/android/key.properties`:

```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=upload
storeFile=C:\\absolute\\path\\outside-repository\\vocal-athlete-upload.jks
```

Release tasks stop with a clear configuration error if the file, a required value, or the keystore is missing. Debug builds remain usable. The release build type only selects the `release` signing config and has no debug-key fallback.

The repository ignores `key.properties`, `*.jks`, and `*.keystore`. Never commit the keystore, passwords, tokens, Play service-account JSON, or a populated properties file.

## Local verification

From the repository root:

```text
python tools/verify_android_release_foundation.py
cd app
flutter pub get
flutter analyze --fatal-infos
flutter test
flutter build apk --debug
cd android
./gradlew signingReport
cd ..
flutter build appbundle --release
```

On Windows, use `gradlew.bat signingReport` if the wrapper is present. Before configuring signing, `flutter build appbundle --release` is expected to fail with `Release signing is not configured`; that failure proves it did not silently use the debug key.

Flutter 3.44.x supplies target SDK 36. This exceeds Google Play's current requirement that new apps and updates target API 35 or later: <https://developer.android.com/google/play/requirements/target-sdk>.

CI pins Flutter 3.44.2, matching `.flutter-version`. It runs the static release-foundation verifier, all Flutter checks, a debug APK build, then creates a disposable CI-only key outside the checkout and builds a signed release App Bundle. That disposable certificate is only a configuration test and must never be uploaded to Play.

## Upload key creation (user-only)

When the release owner is ready, create the real upload key outside this repository using Android Studio or `keytool`, back it up securely, and put only its local path and credentials in `app/android/key.properties`. Use a unique strong password. Do not reuse the disposable CI values. Then run `signingReport` and the release App Bundle build above and verify that the release certificate is not the Android debug certificate.

## Remaining external blockers

- The release owner must create and securely back up the production upload key.
- A Play Console owner must confirm or create the app for `com.vocalathlete.vocal_athlete`, enroll in Play App Signing, and register the upload certificate.
- A verified Android developer identity will be required under Google's 2026 developer-verification rollout; account verification is external to this repository: <https://developer.android.com/developer-verification>.
- Store listing, privacy/data-safety declarations, content rating, testing tracks, and final release approval remain Play Console work.
