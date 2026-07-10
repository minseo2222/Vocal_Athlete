> v9 note: `CARD-18` remains in the library as a state-driven recovery fallback but is not scheduled in the normal 48-lesson path.
# ADR-0018 — 초급 R2 학습 전이 보강

## 상태

Accepted — 2026-06-16

## 맥락

R1 초급 48레슨은 안전한 발성 루틴, SOVT, 자기청취, self-imitation, 시각 피치 관찰에 강했다. 그러나 “노래 실력 향상 체감”으로 이어지는 중간 다리인 리듬, 청음-발성 연결, 짧은 선율 모양, 한국어 음절 전이가 약했다. 또한 기존 초급 manifest는 modulo 확장으로 표준샘플이 Day 1/24/48 milestone에 고정되지 않았고, CARD-12는 `targetHz`가 비어 있어 문서상 pitch matching과 실제 구현 사이에 간극이 있었다.

## 결정

1. 초급 V1은 여전히 48레슨 고정, 1일 1레슨 cap, 완료 기반 해금을 유지한다.
2. 초급 카드 범위를 `CARD-01~13`에서 `CARD-01~18`로 확장한다.
3. 신규 카드는 모두 저위험 bridge로 한정한다.
   - `CARD-14` 듣고-상상하고-허밍하기
   - `CARD-15` 4박 pulse 리듬 허밍
   - `CARD-16` 2–3음 contour mimic
   - `CARD-17` 한국어 모음·자음 bridge
   - `CARD-18` 목 상태 light-mode
4. 표준샘플 `CARD-13`은 Day 1 / Day 24 / Day 48에만 고정한다.
5. 초급 manifest는 modulo 확장이 아니라 명시 슬롯으로 고정한다.
6. CARD-12는 고정 Hz target이 아니라 세션 초반 voiced F0 median을 이용한 relative target을 사용한다.
7. CARD-12/14/16은 `deferredVisualFeedback=true`로 설정해 수행 중 화면 의존을 줄이고 시도 후 곡선 확인을 기본값으로 한다.
8. 진입 단계에 비진단 목 상태 micro-check를 노출한다. 이는 의료 문진이나 해금 게이트가 아니다.

## 비결정

- 초급에 곡/가사/레퍼토리 훈련을 넣지 않는다.
- 초급에 고음, belt, run, vibrato, passaggio handling을 넣지 않는다.
- 한국어 모음 AI 점수와 3분류 발성 AI 정식 표시는 V1에서 제외한다.
- 리듬·contour 훈련은 점수·랭킹·완료 차단으로 쓰지 않는다.

## 결과

좋은 점:

- 초급이 “발성 준비”에서 “노래로 이어지는 낮은 부하 bridge”까지 포함한다.
- 표준샘플 비교가 Day 1/24/48로 명확해져 성장 체감이 좋아진다.
- CARD-12가 사용자별 편한 기준선으로 동작해 고정 Hz 강요를 피한다.
- 실시간 피드백 의존과 화면맞추기 게임 위험을 줄인다.
- 쉰 목/피로 사용자가 streak 때문에 무리하는 UX를 줄인다.

비용:

- 카드 수가 13→18로 늘어 콘텐츠 제작량이 증가한다.
- 경로가 modulo 확장보다 명시 슬롯 관리가 필요하다.
- relative target과 deferred feedback에 대한 UI/테스트 유지비가 생긴다.

## 구현 변경

- `app/lib/progression/path.dart`: 초급 manifest 명시 슬롯화, Day 1/24/48 표준샘플 고정.
- `app/lib/lesson/card.dart`: `relativePitchTarget`, `deferredVisualFeedback` 필드 추가.
- `app/lib/lesson/card_library.dart`: CARD-14~18 추가, CARD-12 relative/deferred 설정.
- `app/lib/lesson/pitch/pitch_display.dart`: relative target median, deferred reveal 지원.
- `app/lib/lesson/lesson_screen.dart`: entry 단계 목 상태 micro-check UI 추가.
- `app/test/path_test.dart`, `card_library_test.dart`, `pitch_display_widget_test.dart`: R2 회귀 테스트 추가.

## 검증 기준

- `buildPlaceholderManifest()` 길이 48.
- `CARD-13` 위치가 index 0, 23, 47이고 총 3회.
- manifest의 모든 cardId가 `kCardLibrary`에서 resolve.
- CARD-12는 `relativePitchTarget=true`, `deferredVisualFeedback=true`.
- deferred feedback은 reveal 전 target/curve를 노출하지 않고, reveal 후 노출한다.
