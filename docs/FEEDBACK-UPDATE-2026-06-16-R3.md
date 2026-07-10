# FEEDBACK-UPDATE-2026-06-16-R3

## 반영한 피드백

1. 초급 이후 즉시 성악/뮤지컬/가요로 나누지 않는다.
2. 초급 → 중급 Universal Vocal Core → Common Song Builder → 고급 장르 Lab 구조로 변경한다.
3. 고급 장르 Lab은 날짜 제한 없는 반복형 cycle로 둔다. 단, 보컬 안전상 무제한 반복은 허용하지 않는다.
4. 음색 강화 훈련을 초급 일부, 중급 정식 모듈, Song Builder, 고급 장르 Lab에 분산 배치한다.
5. 음색은 점수화하지 않고 녹음 A/B, tone tag, comfort rating 중심으로 설계한다.
6. 업로드된 음색 리서치의 MVP 5종(Tone Snapshot, SOVT Ease Loop, Hum-to-Vowel, Vowel Color Lab, Genre Phrase A/B)을 앱 구조에 맞게 재배치한다.

## 코드 변경

- `path.dart`
  - Beginner Foundation 48 유지.
  - Universal Core 144 추가/정규화.
  - Song Builder 72 추가.
  - Advanced Genre Lab 40-slot 반복 cycle 추가.
  - Gayo/Musical/Classical/R&B-Soul/Rock/CCM/User Song manifests 추가.
- `progression_state.dart`
  - `LearningStage`를 `beginnerFoundation`, `universalCore`, `songBuilder`, `advancedGenre`, `maintenance`로 정리.
  - 초급 완주 후 `startUniversalCore()` CTA, Universal Core 완주 후 `startSongBuilder()` CTA, Song Builder 완주 후 고급 장르 선택으로 라우팅.
  - `kReleasedAdvancedGenres = {}` 기본값 유지. 미출시 고급 장르는 maintenance wait로 이동.
  - 고급 장르 Lab은 완주 후 cycle을 반복한다.
- `card.dart`
  - `timbreTags`, `toneGoal`, `allowsToneAB`, `requiresSameRecordingCondition`, `acousticFeedbackLevel`, `safetyIntensity` metadata 추가.
- `card_library.dart`
  - `UC-01~17`, `SB-01~08`, `TONE-01~13` 추가.
  - `CARD-13` 표준샘플을 tone snapshot seed로 확장.
- `graduation_screen.dart`
  - 초급 완주 후 장르 버튼을 제거하고 `중급 공통 코어 시작` CTA를 표시.
  - Universal Core 완주 후 `Song Builder 시작` CTA를 표시.
  - Song Builder 완주 후 고급 장르 Lab 선택 화면을 표시.
- `main.dart`
  - 단계 전이와 settings의 장르 변경 조건을 R3 라우팅에 맞춤.

## 문서 변경

- `CONTEXT.md`, `CONTEXT-MAP.md`: 전체 경로를 R3 구조로 갱신.
- `docs/app/APP-SPEC.md`, `PRODUCT-LOOP-SPEC.md`, `MVP-SCOPE.md`: 초급 V1과 장기 성장 구조를 분리.
- `docs/curriculum/LONG-TERM-SINGER-PATH.md`: 장기 singer path 추가.
- `docs/curriculum/SINGER-LEVEL-OUTCOMES.md`: 준가수형 성장 결과와 레벨 정의 추가.
- `docs/curriculum/universal-core/CURRICULUM.md`: 중급 공통 코어를 144레슨 구조로 확장.
- `docs/curriculum/SONG-BUILDER-SPEC.md`: 장르 중립 곡 전이 72레슨 구조 추가.
- `docs/curriculum/ADVANCED-LOOP-SPEC.md`: 고급 반복 cycle 설계 추가.
- `docs/curriculum/advanced-*`: 고급 장르 Lab 문서 추가/정리.
- `docs/curriculum/TIMBRE-TRAINING-SPEC.md`: 음색 훈련 정의, 안전 경계, 카드 배치 추가.
- `docs/app/TONE-FEEDBACK-SPEC.md`: 음색 점수화 금지와 A/B 피드백 원칙 추가.
- `docs/research/TIMBRE-RESEARCH-ADDENDUM-2026-06-16.md`: 업로드 음색 리서치 반영 요약 추가.
- `docs/adr/0019-universal-core-advanced-genre-route.md`, `0020-timbre-training-integration.md`: 구조 변경과 음색 통합 결정 고정.

## 아직 release blocker로 남는 항목

- 고급 장르 Lab의 runtime cap/fallback/HITL 사인오프 미완.
- 가이드 보컬, backing track, demo 영상, anti-pattern 등 실제 콘텐츠 자산 미완.
- Flutter/Dart CLI 기반 `dart analyze`, `flutter test` 미실행.
- Android 실기기 마이크/F0/녹음 검증 미완.
