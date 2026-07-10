# METADATA STORAGE MIGRATION SPEC — v14

## 목적

진행 상태, 학습 기록, 복습 큐, 복습 기록을 하나의 저장소 경계 뒤에서 관리한다. 신규 쓰기는 비캐시 async API를 사용하고, 기존 legacy 키는 최초 접근 또는 앱 시작 migration에서 무손실 이전한다.

## 대상 키

```text
progression_v1
learning_evidence_v1
review_queue_v1
review_evidence_v1
```

## 정책

1. primary async 저장소에 값이 있으면 그것을 사용한다.
2. primary에 없고 legacy에 값이 있으면 primary에 복사한 뒤 legacy 값을 제거한다.
3. 같은 migration을 다시 실행해도 중복 레코드를 만들지 않는다.
4. JSON 파싱 실패 시 값을 삭제하지 않고 `<key>_corrupt_backup_v14`로 격리한 뒤 빈 상태로 폴백한다.
5. schema version과 migration 완료 상태를 기록한다.
6. 사용자 초기화는 위 네 학습 키와 격리 백업만 삭제한다.
7. 녹음 원음은 별도 파일 저장소에 있으며 이 초기화에 포함하지 않는다.

## 데이터 경계

이 저장소에 허용:

- 현재 경로와 streak
- 시도·자기점검 메타데이터
- 복습 예약과 수행 흔적
- take ID 연결
- 콘텐츠 revision

이 저장소에 금지:

- 녹음 원음
- 비밀번호·토큰
- 성대 건강 판정
- 의료정보
- 종합 가창 점수

## 실패 처리

- migration 실패를 실력 데이터 손실로 위장하지 않는다.
- 손상 JSON은 격리 여부를 학습 데이터 관리 화면에서 확인할 수 있다.
- 녹음 파일과 메타데이터는 별도 삭제 경로를 유지한다.
