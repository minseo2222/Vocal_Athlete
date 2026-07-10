# v7 Update — Recording Library, Repertoire Phrase Review, QA/Data Safety Drafts

v7 focuses on making recorded vocal-training artifacts reviewable and controllable before expanding more curriculum.

## Implemented

- App version moved to `1.7.0+7`.
- Settings now exposes:
  - `표준샘플 리뷰`
  - `곡 적용 훈련 리뷰`
  - `녹음 관리`
- Added recording library service and screen:
  - summary by recording purpose
  - metadata-only export preview with local file paths redacted
  - clear-all local recording action
- Added Repertoire Application phrase review screen.
- Added tests for recording library, Repertoire Application review, and settings entries.
- Added docs:
  - `docs/app/ANDROID-IOS-AUDIO-QA-CHECKLIST.md`
  - `docs/app/PLAY-DATA-SAFETY-DRAFT.md`
  - `docs/app/RECORDING-LIBRARY-MANAGEMENT-SPEC.md`
  - `docs/app/REPERTOIRE-APPLICATION-TAKE-REVIEW-SPEC.md`
  - `docs/adr/0025-recording-library-data-management-v7.md`

## Not completed

- Real-device Android/iOS audio QA.
- Actual Play Console submission.
- Audio file sharing/export.
- Cloud sync or expert upload.

## Product boundary

Repertoire Application remains a vocal-training stage. It reviews short phrase takes; it does not create, produce, or distribute songs.
