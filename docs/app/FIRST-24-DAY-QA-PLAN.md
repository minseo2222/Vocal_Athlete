# FIRST 24-DAY QA PLAN — v14

## 범위

```text
Universal Core Cycle 1 Day 1 / 6 / 12
Repertoire Application Project 1 Day 1 / 11 / 12
D+1 retention
D+3 transfer
녹음 A/B와 Best take
쉰 느낌 no-voice 복습
legacy metadata upgrade
```

## 기능 QA

- 첫 실행 경고 이후 홈 진입
- 레슨 cue·음원·시도 상한 표시
- 녹음 시작/중지/재생/삭제
- 재생과 녹음 동시 실행 방지
- 정규 완료 후 evidence 저장
- D+1/D+3 복습 예약
- Today 복습 카드와 넘기기
- 원 take는 첫 기억 재현 이후에만 재생
- 회복 모드에서 유성 녹음 차단
- 콘텐츠 revision mismatch 안내

## 저장소 upgrade QA

1. v13 앱 데이터 생성
2. v14로 앱 upgrade
3. progression/evidence/review queue/review evidence 보존 확인
4. legacy 키가 async primary로 이전되는지 확인
5. 앱 재실행 시 중복 migration이 없는지 확인
6. 손상 JSON 샘플의 격리와 안전 폴백 확인
7. 학습 메타데이터 초기화가 녹음 원음을 삭제하지 않는지 확인

## 사용성 관찰

- 정규 레슨과 선택 복습을 구분하는가
- 핵심 cue 하나를 이해하는가
- 조건 전이에서 한 가지만 바꾸는가
- 녹음이 수행보다 더 큰 부담이 되지 않는가
- 쉰 상태에서 실제로 소리를 멈추는가
- 화면 overflow, 작은 터치 영역, 스크린리더 label 문제가 없는가

## 판정 제한

이 QA는 앱 흐름과 이해도를 확인한다. 24일 QA만으로 음정·음색·가창 능력 향상을 입증하지 않는다.
