# ADR-0024 — v6 Recording Capture and Local Store

## Status
Accepted

## Decision

v6 introduces a real recording/playback seam while preserving testability:

- `RecordAudioCaptureAdapter` uses the Flutter `record` package.
- `AudioplayersPlaybackAdapter` uses the `audioplayers` package.
- `RecordingFilePathResolver` stores files under application support `/recordings`.
- `FileRecordingRepository` stores metadata in a local JSON index and deletes matching audio files on take deletion.
- `RecordingAbPanel` can use real adapters or fall back to preview mode in tests.
- `StandardSampleReviewScreen` lists, plays, and deletes saved Day 1 / Day 24 / Day 48 takes.
- Android and iOS microphone permission declarations are included, but runtime/device QA remains a release blocker.

## Consequences

Android/iOS real-device QA is now required before release. Google Play Data safety declarations must match actual local/cloud behavior.
