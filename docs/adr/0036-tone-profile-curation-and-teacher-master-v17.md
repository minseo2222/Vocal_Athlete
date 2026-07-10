# ADR-0036 — Tone Profile Curation and Teacher-Master Release Path (v17)

Status: Accepted for v17 static implementation. Runtime Flutter, device audio, teacher recording, and user pilot remain unverified.

## Context

v16 introduced a day-weighted Tone Profile. That reduced repeated same-day take bias, but users still had no non-destructive way to correct a mistaken tag or exclude an unusual take from their palette. Deleting the recording was too destructive because the same take may still be useful as a learning artifact.

v16 also relied on deterministic synthetic prototype cues. Those are useful for asset routing and hashing, but they are not final pedagogical guide masters.

## Decision

1. Add curation metadata to `RecordingTake`:
   - `toneProfileExcluded`
   - `toneTagEditedEpochMs`
   - `toneTagEditMemo`
2. Add `ToneProfileCurationService` to update self tags and exclude/restore takes.
3. Update `ToneProfile.fromTakes()` to skip excluded takes from stable palette signals while preserving raw observation count.
4. Add curation UI to `ToneProfileScreen` for recent tone takes.
5. Add teacher guide master spec and first timbre pilot protocol.
6. Add six additional P-class source spot checks.

## Consequences

- Users can correct or withdraw a tag without deleting raw recordings.
- Tone Profile remains a self-report summary, not an AI voice type.
- Synthetic guide assets remain development-only until teacher master, rights, loudness, and device QA are complete.
- More institutional program pages are verified as curriculum-scope anchors, but not as evidence of mobile-app efficacy.

## Non-goals

- No AI timbre score.
- No voice-health diagnosis.
- No famous-singer matching.
- No high-risk technique release.
- No cloud upload.
- No teacher master recording in v17.
