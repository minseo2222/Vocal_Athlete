# 피드백 반영 업데이트 R2 — 2026-06-16

## 요청

다음 업데이트 전에 리서치 결과 및 커리큘럼을 다시 점검하고, 실제 학습에 도움이 되는지와 추가 훈련이 필요한지를 반영한다.

## 반영 요약

1. 초급 V1은 48레슨을 유지하되 카드 범위를 13개에서 18개로 확장.
2. 표준샘플을 Day 1 / Day 24 / Day 48 milestone으로 고정.
3. 신규 저위험 bridge 카드 추가.
   - CARD-14 듣고-상상하고-허밍하기
   - CARD-15 4박 pulse 리듬 허밍
   - CARD-16 2–3음 contour mimic
   - CARD-17 한국어 모음·자음 bridge
   - CARD-18 목 상태 light-mode
4. CARD-12를 고정 `targetHz` 방식에서 `relativePitchTarget` 방식으로 변경.
5. CARD-12/14/16은 `deferredVisualFeedback`으로 수행 후 곡선 확인을 기본값으로 변경.
6. 레슨 entry 단계에 비진단 목 상태 micro-check UI 추가.
7. 리서치 보강 문서와 ADR-0018 추가.
8. R2 회귀 테스트 추가.

## 변경 파일

### 코드

- `app/lib/progression/path.dart`
- `app/lib/lesson/card.dart`
- `app/lib/lesson/card_library.dart`
- `app/lib/lesson/pitch/pitch_display.dart`
- `app/lib/lesson/lesson_screen.dart`

### 테스트

- `app/test/path_test.dart`
- `app/test/card_library_test.dart`
- `app/test/pitch_display_widget_test.dart`
- `app/test/lesson_screen_widget_test.dart`
- `app/test/home_screen_widget_test.dart`
- `app/test/today_hero_widget_test.dart`
- `app/test/lesson_instance_test.dart`

### 문서

- `docs/curriculum/beginner/CURRICULUM.md`
- `docs/curriculum/beginner/cards.md`
- `docs/app/MVP-SCOPE.md`
- `docs/app/PRODUCT-LOOP-SPEC.md`
- `docs/app/AI-ANALYSIS.md`
- `docs/app/METRICS-AND-EXPERIMENTS.md`
- `docs/research/LEARNING-EFFECT-ADDENDUM-2026-06-16.md`
- `docs/research/PRODUCT-RESEARCH-ADDENDUM-2026-06-16.md`
- `docs/adr/0018-beginner-learning-transfer-update.md`
- `docs/app/FEEDBACK-UPDATE-2026-06-16-R2.md`
- `docs/UPDATE-VALIDATION-2026-06-16-R2.md`
- `CONTEXT.md`
- `REVIEW-BUNDLE.md`
- `docs/curriculum/CURRICULUM-REVIEW.md`
- `docs/curriculum/RESEARCH-INDEX.md`
- `docs/curriculum/beginner/VERIFICATION.md`
- `docs/curriculum/intermediate-core/CURRICULUM.md`
- superseded ADR notes: `0005`, `0006`, `0015`

## 의도적으로 하지 않은 것

- 초급에 곡/레퍼토리/고음/belt/run을 넣지 않음.
- 리듬·contour를 점수화하지 않음.
- 한국어 모음 AI 점수를 V1에 넣지 않음.
- 3분류 발성 AI를 정식 사용자 표시로 승격하지 않음.
- 중급 고위험 카드 release gate를 완화하지 않음.

## 추가 검증 필요

- Flutter/Dart CLI 환경에서 `flutter test`.
- `dart analyze`.
- Android 실기기에서 relative target 생성과 저신뢰 null UX 확인.
- 상세 static validation: `docs/UPDATE-VALIDATION-2026-06-16-R2.md`.
- 초보자 5–10명 대상 CARD-14/15/16/17 이해도 테스트.
