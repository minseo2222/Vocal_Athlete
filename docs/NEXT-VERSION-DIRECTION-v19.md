# NEXT VERSION DIRECTION — v19

v18 corrected Tone Profile semantics and prepared teacher/pilot operations. The project should now prioritize executable validation and a tightly scoped real-user slice rather than more curriculum volume.

## 1. Real Flutter validation and compile repair

Run in the pinned stable environment:

```bash
flutter pub get
flutter analyze --fatal-infos
flutter test --reporter expanded
flutter test integration_test
flutter build apk --debug
```

Fix every package API, analyzer, widget overflow, and test failure before new learning features.

## 2. Android first-device audio QA

Validate:

- microphone permission allow/deny/retry;
- guide playback, recording, stop, replay, delete;
- audio-session interlock;
- pause/resume and interruption;
- wired/Bluetooth route changes;
- local persistence after restart;
- low-volume guide instruction;
- Day 37/38 and Universal Core Day 6 end-to-end.

## 3. Legacy date and metadata migration

For pre-v18 takes:

- keep epoch fallback transparent;
- optionally let the user confirm or correct a date rather than guessing;
- do not rewrite original metadata silently;
- test duplicate-safe migration and corrupted-data quarantine.

## 4. Teacher master production for only three lessons

Record and review the prepared Day 37, Day 38, and Universal Core Day 6 assets. Do not record the entire curriculum yet. Complete consent, rights, teacher review, mastering QA, manifest regeneration, and device playback checks.

## 5. First timbre usability pilot

Run 5–10 beginner sessions only after the executable app and teacher assets are stable. Measure comprehension and safe behavior, not vocal improvement. Resolve critical misunderstandings before broader content expansion.

## 6. Research recheck

Prioritize the remaining 16 sources that influence mobile acoustic feedback, high-intensity methods, Korean/K-pop assumptions, and dose claims.

## Excluded from v19

- advanced genre rollout;
- belt, high-speed run, strong twang, rasp, growl, scream;
- automatic timbre or singer score;
- famous-singer matching;
- cloud voice upload or public sharing;
- large curriculum expansion before runtime and pilot evidence.
