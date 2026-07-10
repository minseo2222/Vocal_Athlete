# ADR 0037 — Multi-tag Tone Profile and Teacher-guide Readiness — v18

## Status

Accepted for v18.

## Context

v17 allowed a user to edit a self-selected tone tag or exclude a take from the palette. The UI showed multiple tags but selecting a new tag replaced the entire list, which conflicted with the product model that a take can be both, for example, `warm` and `comfortable`. Day-weighted aggregation also derived the local calendar day from the epoch at read time, so travel or timezone changes could move a take to another practice day.

The first timbre vertical slice also depended on synthetic prototype cues without an operational package for human teacher recording, rights, review, and pilot observation.

## Decision

1. Tone tags are a user-editable set, not a single class.
2. A chip toggles one tag while preserving all other tags.
3. The user can explicitly clear all tags.
4. New recordings persist `createdLocalDateKey` at capture time.
5. Legacy recordings use epoch fallback and are not silently rewritten.
6. Tone Profile shows edited, excluded, and undated counts without converting them to a score.
7. v18 adds scripts, consent, pedagogy review, mastering QA, rights template, and pilot runbook for the first three timbre lessons.
8. Prototype synthetic cues remain non-release assets.

## Consequences

- Multiple self-descriptions can coexist and be withdrawn.
- Day-weighted aggregation is more stable across timezone changes for new recordings.
- Legacy take behavior remains visible and conservative.
- Human teacher assets have an explicit release path, but no teacher master is claimed to be complete.
- No automatic timbre score, voice type, singer matching, or health diagnosis is introduced.
