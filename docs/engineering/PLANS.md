# Engineering Plan Template

Use this template before large or risky changes, especially changes touching progression, persistence, pitch, safety, or curriculum behavior.

## Title

Short name for the change.

## Goal

What user-visible or repo-visible problem this change solves.

## Non-Goals

What this plan explicitly will not change.

## Current Evidence

- Relevant docs/ADRs read:
- Relevant source files read:
- Relevant tests read:
- Observed current behavior:

## Proposed Change

- Files to modify:
- Behavior to change:
- Data/schema changes:
- Documentation changes:

## Safety And Curriculum Impact

- Does this alter safety wording, safety gates, signoff state, or rollout state?
- Does this alter curriculum meaning, card ordering, card contents, or course boundaries?
- Human approval required:

## Test Plan

- Tests to add or update:
- Existing tests expected to cover the change:
- Manual/device verification, if any:
- Commands:
  - `cd app`
  - `flutter pub get`
  - `flutter analyze`
  - `flutter test`

## Risks

- Behavioral regression risks:
- Persistence/migration risks:
- User-facing UX risks:
- Rollback plan:

## Acceptance Criteria

- [ ] Implementation matches this plan.
- [ ] Public behavior tests are updated.
- [ ] Documentation is updated where behavior changed.
- [ ] Verification commands pass or failures are documented.
