# ADR-0033 — Timbre Spiral and User-Derived Tone Profile (v15)

## Status

Accepted for v15 implementation. Learning effect and device behavior remain unverified.

## Context

The uploaded research proposed a substantial timbre curriculum. A standalone 12-week course would duplicate breath, phonation, resonance, registration, diction, and repertoire work already present in the canonical route. It could also imply that timbre is an isolated aesthetic score.

## Decision

1. Timbre is integrated spirally across the existing route.
2. Beginner covers observation, Hum-to-Vowel, vowel contrast, and self-tagging only.
3. Universal Core covers contrast, comfortable choice, same-task reproduction, one-condition variation, and phrase transfer.
4. Repertoire Application uses bounded same-phrase A/B or A/B/C takes.
5. Advanced Labs may apply genre aesthetics, but `TONE-13` remains moderate and advanced-scoped.
6. Cards declare `timbreLayer`, `toneTagOptions`, and optional `toneSequence`.
7. Recording UI proposes, but does not automatically infer, the next user tag.
8. Tone Profile is derived only from saved user-selected tags, comfort, same-condition confirmation, and Best/standard-sample status.
9. No aggregate timbre score, laryngeal-state inference, celebrity match, or clinical acoustic score is generated.
10. A/B is capped at two takes; A/B/C is capped at three. Moderate cards retain load/fallback rules.

## Consequences

- The curriculum gains a clearer progression from observation to reproducible tone choice.
- User autonomy and recording evidence improve without pretending that the phone can diagnose timbre production.
- Tone Profile remains dependent on the quality and consistency of self-report; it is not a validated assessment.
- Additional expert review, device QA, and user studies are required before release claims.
