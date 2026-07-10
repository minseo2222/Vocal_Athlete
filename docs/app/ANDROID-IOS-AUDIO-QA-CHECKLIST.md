# Android/iOS Audio QA Checklist — v7

Purpose: verify that Recording A/B, standard sample review, and Repertoire Application phrase review work on real devices before release.

## Release status

- Status: **UNVERIFIED / release blocker**.
- v7 adds the checklist and app-side management screens.
- Passing this checklist requires real Android devices; iOS is required only if iOS remains in the release scope.

## Device matrix

Minimum Android matrix:

| Group | Requirement |
|---|---|
| OS | Android 10, 12, 14, current target OS |
| Device class | low-end, mid-range, flagship |
| Mic path | built-in mic, wired headset mic, USB-C headset if supported |
| Environment | quiet room, normal room noise |
| Distance | 20 cm, 30 cm, 50 cm |
| Voice | low / middle / high comfortable phonation |

## Permission QA

1. Fresh install.
2. Open app and confirm launch warning.
3. Enter a recording-enabled card.
4. Tap record.
5. Confirm OS microphone permission prompt appears only from explicit user action.
6. Deny permission.
7. Confirm app shows fallback/error copy and does not crash.
8. Grant permission from OS settings or reinstall and grant.
9. Confirm recording starts only after grant.

## Capture/playback QA

For each device:

1. Record a 3–5 second take.
2. Stop recording.
3. Confirm take row appears.
4. Play take.
5. Confirm audible local playback.
6. Delete take.
7. Confirm metadata row disappears.
8. Restart app.
9. Confirm deleted take does not return.
10. Record again and confirm persistence after app restart.

## Standard sample QA

- Day 1/Baseline slot records and appears in Standard Sample Review.
- Day 24/Midpoint slot records and appears in Standard Sample Review.
- Day 48/Graduation slot records and appears in Standard Sample Review.
- Delete in review removes metadata and local file.

## Repertoire Application phrase QA

- RA phrase take uses `RecordingPurpose.repertoirePhrase`.
- Saved phrase take appears in 곡 적용 훈련 리뷰.
- Playback and delete work.
- Copy must not imply song creation or production.

## Safety/privacy QA

- No background recording.
- No auto-start recording.
- No server upload.
- No public sharing.
- No singer-match scoring.
- No vocal-health diagnosis.
- Local clear-all removes all app-managed recording metadata and local files.

## Result log template

| Date | Device | OS | Mic | Permission | Record | Playback | Delete | Restart persistence | Notes | Pass |
|---|---|---|---|---|---|---|---|---|---|---|
|  |  |  |  |  |  |  |  |  |  |  |
