# Next Version Direction — v14

## 전체 재점검 결론

v13까지 첫 vertical slice는 `정규 레슨 → 학습 흔적 → 지연 복습 → 복습 흔적`으로 연결됐다. 현재 가장 큰 리스크는 기능 부족보다 실제 Flutter 컴파일·플랫폼 플러그인·실기기 오디오가 검증되지 않았다는 점이다.

## 1순위 — 실제 실행 검증과 오류 수정

- Flutter stable 고정 환경에서 `pub get`, analyze, unit/widget test
- Android emulator/device integration test
- 실제 녹음·재생·삭제
- Today → 복습 → 기록 end-to-end
- lifecycle, 전화/알림, Bluetooth 경로 전환
- 화면 overflow·접근성

실행 실패가 발견되면 새 커리큘럼 확장보다 먼저 수정한다.

## 2순위 — 저장소 migration

v13의 새 복습 기록은 `SharedPreferencesAsync`를 사용하지만, progression/evidence/review queue 일부는 legacy API를 사용한다.

- repository별 schema version
- legacy → async 무손실 migration
- migration idempotency test
- 손상 JSON fallback과 사용자 삭제 정책
- 학습 메타데이터는 중요한 원음/계정 저장소로 사용하지 않음

## 3순위 — content manifest 자동 생성

- blueprint/rights/오디오 inventory 자동 해시
- manifest 생성 스크립트
- 변경 파일 누락 검출
- CI에서 validator 실행
- 실제 오디오 파일 hash와 rights record 연결

## 4순위 — 복습 콘텐츠 UX

- retention용 최소 가이드 cue
- transfer에서 바꿀 조건을 하나만 명시
- 원 take와 새 take A/B 리뷰
- review evidence에서 source/new take 연결 탐색
- revision mismatch 사용자 문구 이해도 검증

## 5순위 — 첫 24일 사용성 시험

- Universal Core Day 1/6/12
- 곡 적용 Day 1/11/12
- D+1 retention / D+3 transfer
- 과제 이해도, 녹음 부담, 복습 발견성, 목 상태 UX

## v14에서 제외

- 고급 장르 공개
- belt/run/rasp/growl/scream 해금
- 종합 가수 점수
- 유명 가수 매칭
- 클라우드 음성 업로드
- 공개 커뮤니티
- 첫 vertical slice 검증 전 대규모 콘텐츠 확장
