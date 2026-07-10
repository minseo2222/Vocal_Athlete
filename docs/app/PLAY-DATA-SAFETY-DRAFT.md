# Google Play Data Safety Draft — v7

Purpose: create a product/legal checklist for the current local-first audio recording behavior. This is a draft, not legal advice.

## Current v7 behavior to disclose accurately

- The app requests microphone access only for explicit user-started vocal recordings and pitch feedback.
- Recording A/B, standard samples, Repertoire Application phrase takes, and future portfolio takes are local-first.
- v7 does not implement cloud sync, public sharing, expert upload, or model-training upload.
- v7 does not perform speaker identification, voiceprint matching, singer similarity scoring, or vocal-health diagnosis.
- Users can delete stored local recording metadata and app-managed audio files.

## Data categories likely relevant

| Data | Current handling | Notes |
|---|---|---|
| Audio recordings | Collected locally by explicit user action | Must be disclosed if the release build stores them. |
| App activity/progress | Stored locally | Sync/analytics would require updated disclosure. |
| Diagnostics/crash logs | 확인 필요 | Add only if implemented. |
| Personal info/account | Not implemented in v7 | Add if accounts/subscriptions are added. |

## Product commitments

- No recording without visible user action.
- No background recording.
- No upload unless a future opt-in feature is explicitly added.
- No use of recordings for model training without separate opt-in.
- No public sharing by default.
- Delete controls must remain available from settings.

## Open release questions

- Will the production build include analytics SDKs?
- Will subscription/account login be added before launch?
- Will crash reporting include device identifiers?
- Will cloud backup or expert review upload be added?
- Will minors be allowed to use recording features?

## Required before Play submission

1. Compare this draft with actual release behavior.
2. Complete Play Console Data safety form.
3. Align privacy policy wording with Data safety answers.
4. Test local delete and clear-all.
5. Re-check any SDK that may collect data independently.
