# ADR-0025 — v7 Recording Library and Data Management

## Status

Accepted.

## Context

v6 added actual recording/playback adapter seams and a standard sample review screen. A vocal-training app that stores user voice takes must also provide visible management controls before more recording-heavy flows are added.

## Decision

v7 adds:

- Recording library summary.
- Metadata-only export preview with local file paths redacted.
- Clear-all local recording action.
- Repertoire Application phrase take review.
- Audio QA checklist and Play Data safety draft.

## Non-goals

- Audio file sharing.
- Cloud sync.
- Expert upload.
- Public community posting.
- Song production.
- Singer-match scoring or voiceprint export.

## Consequences

The app can now accumulate vocal-training takes while keeping user control visible. Release remains blocked until real-device audio QA and privacy disclosure checks pass.
