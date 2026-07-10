# v11 피드백 반영 업데이트 — 2026-06-20

## 목표

v10의 첫 24일 콘텐츠·음원 vertical slice 위에 다음 두 가지를 연결했다.

1. completion과 실제 수행 흔적을 분리하는 local-first 학습 기록
2. 가이드·녹음 재생·마이크 캡처·앱 생명주기 사이의 오디오 중단 정책

## 구현

- `LearningEvidenceLevel`, `LessonPracticeSnapshot`, `LearningEvidenceRecord`
- in-memory 및 SharedPreferences repository
- 시도 횟수, 자기점검, 예시 청취, 선택 키, 녹음 수, best take 기록
- 설정의 `학습 기록` 리뷰·전체 삭제 화면
- 메타데이터 저장 실패가 completion을 막지 않는 정책
- 훈련 음원 재생 전 캡처 취소
- 녹음 시작 전 훈련 음원·저장 take 재생 중단
- 본운동 이탈·완료·앱 백그라운드에서 재생 중단과 캡처 취소
- best take의 `RecordingTake.isBest` 영속화
- Flutter `integration_test` flow scaffold

## 명시적 한계

- 목표 E0~E5는 실제 달성 판정이 아니다.
- self-check는 사용자의 자기기록이며 정확도 인증이 아니다.
- real Android/iOS audio focus와 interruption은 미검증이다.
- Flutter SDK가 없어 analyze/test/integration test를 실행하지 못했다.
- 학습효과와 retention/transfer는 사용자 시험 전까지 미검증이다.

## 추가 무결성 보강

인터록이 adapter를 중단하더라도 하위 패널이 계속 “재생 중/녹음 중”으로 보일 수 있는 상태 불일치를 재점검했다. 이를 막기 위해 `AudioSessionCoordinator`를 추가했다.

- 새 가이드 재생 전 기존 가이드·take 재생·캡처를 모두 중단
- 녹음 시작 시 가이드 패널의 재생 표시 초기화
- 가이드 시작·앱 pause·레슨 단계 이탈 시 녹음 패널을 idle로 복구
- 외부 중단된 녹음은 take로 저장하지 않음
- 패널 dispose 시 listener를 제거하고 해당 세션을 중단
