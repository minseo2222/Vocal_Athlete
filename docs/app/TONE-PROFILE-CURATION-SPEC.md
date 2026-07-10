# TONE PROFILE CURATION SPEC — v18

Tone Profile curation protects user agency. It edits self-report metadata and never claims to correct the user's voice.

## Policy

- A take may have zero, one, or several self-selected tone tags.
- Toggling one tag must preserve every other tag.
- Users may explicitly clear all tags.
- Users may exclude a take from stable palette aggregation without deleting audio.
- Excluded takes remain visible and can be restored.
- Editing/exclusion timestamps are disclosed as user actions, not AI corrections.
- New takes store the recording-time local calendar date for stable day-weighted aggregation.
- Legacy takes use epoch fallback and are not silently rewritten.

## Data fields

- `toneProfileExcluded`
- `toneTagEditedEpochMs`
- `toneTagEditMemo`
- `createdLocalDateKey`

## Aggregation

`ToneProfile.fromTakes()` counts tagged takes as raw observations. Excluded takes are omitted from stable palette signals. Same-day repeated take volume does not increase a tag more than once per practice day.

The screen discloses:

- edited takes;
- excluded takes;
- undated legacy takes;
- unique practice days;
- same-condition practice days.

## UX copy

Use:

- `태그 모두 해제`
- `팔레트에서 제외`
- `팔레트에 다시 포함`
- `자기 태그 메타데이터`
- `기록일`

Avoid:

- `AI가 수정함`
- `오답 태그`
- `나쁜 음색`
- `성대 상태`
- `음색 등급`

## Limitations

- local date storage improves future stability but does not reconstruct a definitive original timezone for legacy recordings;
- multi-tag understanding requires usability testing;
- curation does not validate vocal learning or acoustic accuracy;
- recording deletion remains a separate operation.
