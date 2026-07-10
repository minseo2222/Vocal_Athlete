# Recording A/B MVP Spec — v15

## Purpose

Recording A/B exists to make vocal improvement observable. It is not a song production feature, not a public sharing feature, and not a vocal-health diagnostic feature.

## v6 implementation

Implemented in v6:

- `RecordingTake` metadata model with `durationMs` and `fileSizeBytes`.
- `RecordingAbSession` take limit and best-take selection.
- `RecordingRepository` interface and `InMemoryRecordingRepository`.
- `FileRecordingRepository` for local-first metadata persistence.
- `AudioCaptureAdapter` and `AudioPlaybackAdapter` abstractions.
- `RecordAudioCaptureAdapter` for device recording and `AudioplayersPlaybackAdapter` for local playback.
- `RecordingController` as the UI-facing recording seam.
- In-lesson `RecordingAbPanel` with record / stop-save / play / delete behavior when capture/playback adapters are injected.
- `StandardSampleReviewScreen` for Day 1 / 24 / 48 standard sample review.
- Android `RECORD_AUDIO` manifest marker and iOS `NSMicrophoneUsageDescription` permission copy.


## v15 standard-sample namespace rule

`CARD-13` appears on Day 1, Day 24, and Day 48, but the three milestones must not share a take budget or identifier. The lesson runtime fixes one slot per milestone:

```text
Day 1  → baseline   → CARD-13_baseline_take_01
Day 24 → midpoint   → CARD-13_midpoint_take_01
Day 48 → graduation → CARD-13_graduation_take_01
```

The repository may list all `CARD-13` takes, but `RecordingAbPanel` scopes the active session to the fixed milestone slot before applying `maxTakeCount`. This prevents a Day 1 take from blocking or overwriting Day 24/48. Legacy takes without the milestone-qualified ID remain readable according to their stored `slot`.

## User-facing rules

- Show A/B as comparison, not score.
- Limit take count.
- Require same-condition reminder for standard samples.
- Collect tone tag and comfort rating.
- Allow best-take selection.
- Allow replay.
- Allow delete.
- Never show singer-match percentage, timbre score, 성대 접촉률, or 성대 건강 판정.

## Data rules

- Default: local-first.
- Original audio upload: off by default.
- Model training: separate opt-in only.
- Delete must remove local audio and metadata.
- Public sharing is out of scope.
- Expert upload is out of scope until a separate consent/review flow exists.

## Release blockers

v6 is implementation-forward but not release-verified. Before release, run:

1. Android runtime microphone permission QA.
2. Android real-device record/stop/play/delete QA.
3. iOS permission/capture/playback QA if iOS remains in scope.
4. Local storage deletion verification.
5. Google Play Data safety and privacy-policy alignment.
6. No background recording confirmation.
7. No upload/network transfer confirmation.

## Copy rules

Allowed:

- “같은 조건에서 두 take를 들어봅니다.”
- “편안함과 tone tag를 남깁니다.”
- “이전 take와 달라진 점을 들어봅니다.”

Disallowed:

- “AI가 음색을 점수화합니다.”
- “성대가 좋아졌습니다.”
- “가수급 음색입니다.”
- “유명 가수와 70% 일치합니다.”
