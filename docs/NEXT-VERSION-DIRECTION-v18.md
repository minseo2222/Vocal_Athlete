# NEXT VERSION DIRECTION — v18

v17 added user curation and release-readiness specs. v18 should avoid more curriculum expansion until the first timbre vertical slice is runnable and observable.

## 1. Real Flutter validation

Run and fix:

```bash
flutter pub get
dart analyze
flutter test --reporter expanded
flutter test integration_test
flutter build apk --debug
```

## 2. Tone Profile curation QA

Verify:

- editing a tag updates the profile;
- excluding a take does not delete recording audio;
- restoring a take re-adds it to day-weighted aggregation;
- deleted recordings disappear from profile;
- excluded and edited counts are understandable;
- users do not interpret the palette as a fixed voice type.

## 3. Teacher master preparation

Do not record every asset yet. First prepare:

- scripts for Day 37, Day 38, Universal Core Day 6;
- teacher consent template;
- reviewer checklist;
- loudness/clipping QA procedure;
- rights JSON template.

## 4. First timbre pilot

Run the v17 pilot protocol with 5–10 beginner users before adding more timbre cards.

## 5. Remaining source verification

Continue R1–R39 verification, prioritizing the 20 pending sources that influence high-risk claims or genre-specific assumptions.

## Excluded from v18

- high-risk advanced technique release;
- automatic timbre score;
- famous singer matching;
- cloud voice upload;
- public sharing;
- large curriculum expansion before runtime QA.
