# ADR-0035 — First Timbre Vertical Slice and Day-Weighted Tone Profile (v16)

## Status

Accepted for v16 implementation. Flutter runtime, device audio, expert safety, user comprehension, and learning effect remain unverified.

## Context

v15 distributed timbre tasks across the curriculum and added a user-derived Tone Profile. Two gaps remained:

1. Beginner Days 37–38 and Universal Core Cycle 1 had path cards but no complete blueprint/audio/recovery vertical slice.
2. A user could record the same tone many times in one day and dominate the profile despite no evidence of retention across days.

## Decision

1. Add detailed blueprints for Beginner Days 37–38 and refine Universal Core Cycle 1 Day 6.
2. Add deterministic low/mid synthetic prototype cues with explicit rights records and SHA-256 tracking.
3. Prototype cues are functional references only, not release-ready teacher masters or correct/incorrect physiological examples.
4. Each lesson changes one variable, uses at most two attempts, and has a no-voice recovery alternative.
5. Tone Profile keeps raw tagged take counts for transparency but calculates stable tag frequency by `local practice day × tag`.
6. Repeated same-day takes of the same tag contribute once.
7. Conflicting same-day comfort records retain the lower-comfort signal.
8. At least three distinct practice days are required before showing an accumulated palette.
9. Undated legacy takes are excluded from stable frequency but may remain reference takes.
10. No acoustic, laryngeal, clinical, celebrity-match, or aggregate timbre score is introduced.

## Consequences

- The first timbre flow can be tested end-to-end without claiming that a synthetic cue is a teacher-approved vocal model.
- The profile better separates repetition volume from cross-day recurrence.
- Day boundaries rely on local device time; timezone changes and user tag consistency remain limitations.
- The three-day threshold and two-attempt cap are product hypotheses requiring pilot validation.
