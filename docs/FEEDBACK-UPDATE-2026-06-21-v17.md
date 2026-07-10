# FEEDBACK UPDATE — v17 — 2026-06-21

## Accepted feedback

Continue from v16, but do not unlock high-risk advanced techniques. Prioritize:

1. Tone Profile stability and user agency.
2. Teacher-guide replacement path for synthetic prototype cues.
3. First timbre vertical-slice pilot readiness.
4. More source recheck.

## Implemented

### Tone Profile curation

Added non-destructive curation metadata to `RecordingTake`:

- `toneProfileExcluded`
- `toneTagEditedEpochMs`
- `toneTagEditMemo`

Added `ToneProfileCurationService`.

Users can now:

- correct a self-selected tone tag;
- exclude a take from Tone Profile aggregation;
- restore an excluded take;
- keep the original recording file intact.

`ToneProfile.fromTakes()` still counts excluded takes as raw tagged observations, but excludes them from day-weighted stable palette signals.

### Tone Profile screen

`ToneProfileScreen` now includes a recent-take curation section:

- tag chip edit;
- `팔레트에서 제외`;
- `팔레트에 다시 포함`;
- explanatory copy that this changes metadata only, not audio files.

### Teacher guide master spec

Added `docs/app/TEACHER-GUIDE-MASTER-SPEC.md`.

The current synthetic prototype WAVs remain development assets. Release builds require human teacher master recording, rights consent, pedagogical review, content manifest regeneration, and device playback QA.

### First timbre pilot protocol

Added `docs/app/FIRST-TIMBRE-PILOT-PROTOCOL-v17.md`.

The pilot checks whether beginners understand tone tags as self-reports, can follow the two-take cap, avoid pushing volume or pitch, and use no-voice recovery when hoarse.

### Source recheck

Added `docs/research/v17/` and rechecked six additional P-class institutional sources:

- R2 Berklee voice performance
- R5 Juilliard Vocal Arts
- R6 USC Thornton Vocal Arts & Opera
- R7 Manhattan School of Music Vocal Arts
- R8 Royal College of Music Vocal & Opera
- R9 Guildhall Vocal Studies

Total checked sources: 19/39. Pending: 20/39.

## Still not done

- Flutter compilation and widget/integration test execution.
- Android/iOS device audio QA.
- Human teacher guide master recording.
- User pilot.
- Full source verification.
- Advanced/high-risk technique release.
