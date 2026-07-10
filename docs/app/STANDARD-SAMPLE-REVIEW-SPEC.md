# Standard Sample Review Spec — v15

## Purpose

The standard sample review turns Day 1 / Day 24 / Day 48 recordings into growth evidence. It is not an exam and does not grade the voice.

## User-facing behavior

- Show saved baseline / midpoint / graduation recordings.
- Allow replay.
- Allow delete.
- Display tone tags, comfort rating, duration, and same-condition reminder.
- Keep the copy focused on before/after listening, not numerical scoring.

## Milestone isolation

- Day 1, Day 24, and Day 48 use separate `baseline`, `midpoint`, and `graduation` slots.
- Their canonical take IDs are milestone-qualified.
- Each milestone has its own one-take cap; deleting one does not change another milestone.
- A standard-sample take may contribute to the local Tone Profile only through the user-selected tone tag and comfort rating. It is never converted into an automatic timbre or health score.

## Implementation

- `app/lib/lesson/standard_sample_review_screen.dart`
- Requires `RecordingRepository` and optional `AudioPlaybackAdapter` injection.
- Settings CTA: `표준샘플 리뷰`.
- Home CTA remains optional; settings is the v6 canonical entry point.

## Release blockers

- The review screen is useful only after actual record/play/delete is verified on device.
- If local audio is deleted, metadata must be removed too.
- Cloud sync and expert upload require new consent and release gate.
