# ADR-0023 — numeric versioning + Recording A/B + Vocal Load Budget v5

## Status

Accepted — 2026-06-16.

## Context

The project previously used feedback labels such as R2/R3/R4. From this point forward, updates should use numeric version labels (`v5`, `v6`, ...). The current backlog also required the first executable slice for Recording A/B, vocal-load management, and Repertoire Application assets.

## Decision

1. Use `v5` as the next version label.
2. Set app package version to `1.5.0+5`.
3. Add Recording A/B domain model and in-lesson panel.
4. Add Vocal Load Budget domain policy.
5. Add Repertoire Application phrase manifest scaffolds under app assets.
6. Add portfolio readiness rubric model.

## Consequences

- The project now has a concrete path from lesson completion to recording-based evidence.
- The project still needs a native audio capture/playback adapter before the Recording A/B feature is production-ready.
- High-risk advanced genre cards remain unreleased until safety signoff, caps, fallback, and device QA are complete.
