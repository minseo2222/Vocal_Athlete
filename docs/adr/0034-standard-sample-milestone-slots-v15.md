# ADR-0034 — Standard Sample Milestone Slots (v15)

## Status

Accepted — 2026-06-21. Flutter compilation, persistence migration, and real-device audio behavior remain unverified.

## Context

`CARD-13` is scheduled at Beginner Day 1, Day 24, and Day 48. Before v15, all three appearances could share a single recording slot and a one-take cap. A Day 1 recording could therefore consume the allowance and prevent the midpoint or graduation sample from being added.

## Decision

1. The three appearances keep the shared curriculum card ID `CARD-13` but use independent recording slots:
   - Day 1 → `baseline`
   - Day 24 → `midpoint`
   - Day 48 → `graduation`
2. The one-take cap is evaluated inside the active milestone slot, not across all `CARD-13` recordings.
3. Take IDs include the milestone slot so each sample remains independently addressable.
4. The review screen groups and labels the three milestones separately.
5. Comparison remains descriptive: replay, user-selected tone tags, comfort, and same-condition confirmation. No automatic timbre score or vocal-health conclusion is produced.

## Consequences

- Users can retain one baseline, one midpoint, and one graduation sample.
- Day 1/24/48 comparison is technically possible without weakening the per-session take cap.
- Existing pre-v15 records without a milestone-qualified ID require compatibility handling and real upgrade testing.
- The change does not itself prove recording-condition equivalence or learning effect.
