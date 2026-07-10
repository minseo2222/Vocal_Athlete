# v7 Validation Notes

Performed in this environment:

- Dart delimiter balance static scan.
- JSON parse scan for verification and patch manifest files.
- Manifest card reference smoke test.
- Settings callback/key consistency scan.
- Recording library and Repertoire Application review marker scan.
- ZIP integrity check.

Not performed:

- `dart analyze`
- `flutter test`
- Android/iOS real-device audio QA
- Play Console Data safety submission

Release blockers remain:

- Real microphone permission, capture, playback, delete, restart-persistence QA.
- Privacy policy/Data safety legal review.
- Confirmation that production build performs no background recording and no upload.
