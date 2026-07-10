# FEEDBACK UPDATE — v18 — 2026-06-22

## Accepted direction

Continue from v17 while prioritizing runtime readiness, Tone Profile correctness, teacher-guide preparation, and research cleanup. Do not expand high-risk advanced techniques.

## Implemented

### Multi-tag Tone Profile curation

The editing UI now toggles individual tags and preserves the rest. Users can also remove all tags explicitly. Edit and exclusion operations are guarded against repeated taps and show success/failure feedback.

### Stable practice-date metadata

New `RecordingTake` objects store `createdLocalDateKey` in `yyyy-MM-dd` form at recording time. Tone Profile uses this key first and falls back to the epoch for legacy takes. This reduces day-bucket changes caused by later timezone changes.

### Profile transparency

Tone Profile now reports:

- observed tagged takes;
- unique practice days;
- day×tag contributions;
- edited takes;
- excluded takes;
- undated legacy takes;
- same-condition practice days;
- reference/Best takes.

These remain self-record metadata, not quality or health scores.

### Teacher-guide preparation package

Added human-guide scripts and operations material for:

- Beginner Day 37 Hum-to-Vowel;
- Beginner Day 38 Vowel Color Taste;
- Universal Core Cycle 1 Day 6 transfer;
- performer consent;
- pedagogy review;
- mastering/device QA;
- rights metadata.

### Pilot operations

Added a v18 pilot runbook and observation CSV. No pilot participant result is claimed.

### Research recheck

Spot-checked R3, R12, R25, and R26. Checked total is now 23/39; 16 remain pending full recheck. Clinical CPP evidence remains prohibited as a consumer timbre/health score.

## Still blocked or unverified

- Flutter compilation and tests;
- Android/iOS build and audio QA;
- human teacher master recording;
- participant pilot;
- final rights/legal review;
- full source verification;
- vocal-learning efficacy;
- advanced/high-risk technique release.
