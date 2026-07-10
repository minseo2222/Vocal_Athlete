# v6 Update — Recording Capture, Local Store, Standard Sample Review

## Scope

v6 continues numeric versioning and focuses on the recording layer that makes vocal improvement observable:

- `record`-based native capture adapter seam.
- `audioplayers`-based local playback adapter seam.
- `path_provider` application support storage resolver.
- File-backed local recording metadata repository.
- Recording A/B panel upgraded from placeholder-only to real capture when adapters are available.
- Standard Sample Review screen for Day 1 / Day 24 / Day 48 takes.
- Settings entry for Standard Sample Review.
- Android `RECORD_AUDIO` and iOS `NSMicrophoneUsageDescription` permission declarations.

## Product rule

The app remains a vocal training app, not a song production app. Recording is used for standard sample comparison, tone A/B, repertoire application phrase takes, and portfolio evidence.

## Privacy rule

Default storage remains local-first. v6 does not add cloud sync or model-training upload.
