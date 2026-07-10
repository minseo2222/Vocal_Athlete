# v12 Feedback Update — Delayed Review Queue

## 완료 항목

- 지연 복습 큐 도메인 모델 추가
- SharedPreferences/InMemory review queue repository 추가
- 레슨 완료 시 retention/transfer task 예약
- recovery mode에서는 유성 복습 예약 제외
- 학습 기록에 contentRevision 추가
- 학습 기록에 recordedTakeIds / bestTakeId 연결
- 설정 화면에 복습 큐 진입점 추가
- 복습 큐 화면 추가
- Flutter 실행 검증 스크립트 추가

## 핵심 의도

v12는 학습을 “오늘 완료했다”에서 끝내지 않고, 다음날 또는 며칠 뒤 같은 기술을 다시 확인하는 구조를 만든다. 다만 복습은 시험이 아니며, 정규 진도와 streak를 막지 않는다.

## 미완료

- due 복습을 Today 화면에 자동 삽입
- 푸시 알림
- 실제 Flutter SDK 실행 검증
- 실기기 마이크/녹음/재생 QA
- 콘텐츠 revision hash를 암호학적 hash로 고정
