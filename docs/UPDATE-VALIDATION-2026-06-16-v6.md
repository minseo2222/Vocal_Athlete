# v6 Validation Notes

## Automated checks performed in this environment

- Dart delimiter balance scan.
- JSON parse scan.
- `verification-status.json` parse.
- Manifest card reference smoke test.
- v6 new file marker check.
- `StandardSampleReviewScreen` constructor/test interface marker check.
- Android/iOS microphone permission declaration marker check.
- ZIP integrity check.

## Not performed

This environment still lacks Dart/Flutter CLI and Android devices, so these remain local QA blockers:

- `dart analyze`
- `flutter test`
- Android runtime `RECORD_AUDIO` permission flow
- Android/iOS real-device microphone capture
- local playback with `audioplayers`
- recording file persistence/deletion on Android/iOS storage
