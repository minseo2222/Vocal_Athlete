# Review Queue Spec — v13

## 목적

레슨 직후의 수행 흔적을 바탕으로 시간이 지난 뒤 같은 핵심 cue를 재현하거나 한 조건만 바꾸어 전이해 보는 선택 복습을 제공한다. 시험, 품질 점수, 해금 게이트가 아니다.

## 예약

| 조건 | 예약 |
|---|---|
| E0 또는 recovery completion | 없음 |
| E1 이상 normal/reduced | D+1 retention(E2 목표) |
| 곡 적용 / best take / E3 이상 | D+1 retention + D+3 transfer(E3 목표) |

## 발견

- due item이 있으면 Today 화면에 선택 카드 표시
- 설정 → 복습 큐에서도 전체 pending item 확인
- 미래 task는 `내일`, `N일 후`로 표시

## 수행

- `복습 시작`은 task를 즉시 완료하지 않고 Review Practice로 이동
- 정상: 최대 2회
- 조금 피곤함: 최대 1회
- 쉰 느낌: voiced attempt 없이 명시적 no-voice 행동 기록 후 다음 날 재예약
- 이전 take는 정상/축소 모드에서 첫 기억 재현 이후에만 재생 가능

## 오늘 넘기기

- 다음 날로 postpone
- dismiss/실패 아님
- streak와 정규 진도 불이익 없음

## 완료와 증거

- queue status completed
- 별도 `ReviewEvidenceRecord` 저장
- E2/E3 자동 달성 판정 없음
- content revision mismatch면 직접 전후 점수 비교 없음

## 아직 하지 않는 것

- push notification
- 복습 강제
- 자동 음정·리듬·음색 달성 판정
- 고급 기술 해금
- 클라우드 동기화
