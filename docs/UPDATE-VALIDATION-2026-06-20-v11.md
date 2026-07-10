# v11 업데이트 검증 — 2026-06-20

## 검증 범위

- v10 curriculum/path/asset invariants 유지
- completion과 local practice trace 분리
- 목표 evidence와 실제 달성 evidence 비동일화
- 시도·자기점검·예시 청취·선택 키·녹음·best take·목 상태 기록
- best take 메타데이터 영속화
- 가이드·저장 take·마이크 캡처 interlock
- non-resumed app lifecycle stop/cancel
- 패널 외부 중단 후 UI state 초기화 coordinator
- Flutter `integration_test` scaffold 존재
- JSON/YAML 파싱, Dart delimiter, card/path/fallback, WAV/rights/checksum
- v10 base에 v11 patch 재적용 후 전체 파일 일치

## 정적 검증 결과

`python tools/validate_v11.py`

```text
status: PASS
JSON: 18
YAML: 1
Dart delimiter files: 94
card library: 126
path card IDs: 110
fallback targets: 10

Beginner: 48
Universal Core: 12 cycles / 144 slots
Repertoire Application: 6 projects / 72 slots
Advanced cycles: 각 40 slots

Universal Core Cycle 1 blueprints: 12
Repertoire Project 1 blueprints: 12
Core prototype cue WAV: 11
Repertoire prototype WAV: 9
v11 feature files: 8
Flutter integration-test scaffold: 1
```

추가 확인:

- 모든 local/relative Dart import target 존재
- 임시 파일과 `__pycache__` 미포함
- `AudioSessionCoordinator` event sequence 및 외부 capture cancel UI test 작성
- 학습 기록 삭제는 확인 dialog를 거치며 녹음 파일과 별도임을 안내
- patch overlay를 v10에 적용한 결과 v11 전체 파일과 byte-for-byte 일치
- 전체 ZIP과 패치 ZIP 무결성 검사 통과

## 실행하지 못한 검증

현재 환경에는 Flutter/Dart SDK와 Android/iOS 실기기가 없어 다음은 실행하지 못했다.

```text
dart analyze
flutter test
flutter test integration_test/learning_evidence_flow_test.dart
flutter build apk / iOS build
Android audio focus / 전화 / Bluetooth route interruption
iOS audio interruption / route change
실제 녹음·재생·삭제·앱 재시작 persistence
화면 overflow·접근성
사용자 retention/transfer 학습효과
```

## 판정

v11은 **구조 및 정적 smoke 기준 PASS**다. 그러나 `implemented_unverified` 상태이며 release 승인이 아니다. 목표 E0~E5는 커리큘럼 의도이고, 실제 달성은 지연 재현·전이 과제로 별도 확인해야 한다. 오디오 중단 정책도 실제 플랫폼 audio focus/interruption QA 전에는 VERIFIED로 승급하지 않는다.
