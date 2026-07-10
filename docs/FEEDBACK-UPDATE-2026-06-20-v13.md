# Feedback Update — v13 — 2026-06-20

## 반영한 피드백

v12 이후 우선순위였던 Today 복습 연결, 복습 수행 증거, 콘텐츠 revision 강화, 실행 검증 파이프라인 정리를 반영했다.

## 제품 변경

- Today 화면의 선택 복습 카드
- 오늘 넘기기 = 다음 날 재예약
- 실제 복습 수행 화면
- 목 상태별 2회/1회/무성 복습 정책
- 원 학습 take를 첫 시도 후 선택 재생
- 별도 복습 기록 화면
- 복습 task와 source evidence 연결

## 데이터 변경

- `ReviewEvidenceRecord`
- `playedSourceTakeIds`
- `findById` repository seam
- content revision SHA-256 suffix
- curriculum content manifest

## 검증 변경

- `tools/validate_v13.py`
- `tools/run_flutter_validation.sh` 로그/환경 확인
- widget/unit/integration test scaffold 추가

## 제한

- 자동 실력 판정 없음
- 복습 강제 없음
- 고급 장르 rollout 없음
- 클라우드 음성 업로드 없음
- Flutter/Dart/실기기 실행 결과 없음


## 최종 안전 보정

- 정상 복습 중 남긴 시도·녹음 흔적은 사용자가 이후 `쉰 느낌`을 선택했을 때 회복 복습 완료 근거로 재사용하지 않는다.
- 쉰 느낌에서는 이전 take 듣기 또는 소리 없는 자기점검을 명시적으로 남겨야 하며, 과제는 완료 처리 대신 다음 날로 재예약된다.
- Flutter 실행 검증 스크립트는 실제 실행했으나 SDK 부재로 exit 127에서 차단됐다.
