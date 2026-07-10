# TEACHER GUIDE MASTER SPEC — v18

This document defines the human guide audio/video replacement path for the current synthetic prototype cues.

## Purpose

Synthetic WAV files in v10–v16 are engineering prototypes. They prove asset routing, manifest hashing, playback, and lesson blueprint wiring. They are not final teacher guide masters.

v18 therefore requires a separate teacher-master pipeline before release:

1. script approval;
2. teacher recording;
3. vocal-pedagogy safety review;
4. loudness and clipping QA;
5. rights consent;
6. content manifest regeneration;
7. device playback smoke test.

## v18 preparation package

The first production package is in `docs/content/teacher-guides/v18/`. It contains three lesson scripts, performer-consent and rights templates, a pedagogy checklist, and audio/device QA. These documents prepare recording; they do not constitute approval or a completed master.

## Required guide types

| Asset group | Required master | Scope |
|---|---|---|
| Beginner timbre Day 37 | hum-to-vowel low/mid guide | Gentle /m/ → /ma/ and /u/ transitions in comfortable range |
| Beginner timbre Day 38 | vowel-color low/mid guide | Same comfortable pitch, vowel color contrast without pushing |
| Universal Core Cycle 1 | pitch/rhythm/SOVT transfer guide | Low and middle options, no high-note target |
| Repertoire Application Project 1 | hum guide, melody guide, backing | 4-bar neutral phrase transfer |

## Recording constraints

- Record at conservative loudness; never demonstrate belt, rasp, growl, scream, or pressed onset.
- Each guide should include low and middle options rather than gender labels.
- Anti-pattern examples are spoken/listening-only explanations unless reviewed separately.
- Every guide must have a no-voice recovery instruction paired in the lesson blueprint.
- Peaks must be normalized for playback QA, but peak values alone do not prove safe listening level on user devices.

## Required metadata

Each master asset needs:

```json
{
  "path": "assets/.../file.wav",
  "performerConsent": true,
  "teacherReviewer": "name or reviewer id",
  "reviewDate": "YYYY-MM-DD",
  "approvedUse": "guide-only / demonstration / backing",
  "highRiskTechnique": false,
  "sha256": "...",
  "license": "work-made-for-hire or explicit license"
}
```

## Release gate

A synthetic prototype may be bundled in development builds. Release builds require:

- master asset present;
- rights record present;
- sha256 manifest fresh;
- teacher reviewer signoff;
- Android/iOS playback smoke test;
- no unresolved clipping/loudness issues.

## Explicit exclusions

The teacher guide pipeline does not unlock high-risk techniques. Belt, high mix, high-speed run, strong twang, rasp, growl, scream, and classical messa/cover remain behind separate expert review and runtime caps.
