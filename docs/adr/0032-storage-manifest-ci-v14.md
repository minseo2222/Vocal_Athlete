# ADR-0032 — Async metadata boundary, generated content manifest, and CI gate (v14)

## 상태

Accepted — 2026-06-21

## 결정

1. 모든 소형 학습 메타데이터는 `AppMetadataStore` 뒤에서 읽고 쓴다.
2. 신규 primary는 `SharedPreferencesAsync`, 기존 API는 migration source로만 둔다.
3. legacy 값은 idempotent하게 이전하고 손상 JSON은 백업 키로 격리한다.
4. curriculum content manifest는 수동 편집하지 않고 generator로 만든다.
5. blueprint, asset manifest, rights record, 선언 WAV를 SHA-256으로 고정한다.
6. Flutter 3.44.2 stable CI에서 analyze/test/debug build를 release 전 필수 gate로 둔다.
7. 복습 cue는 원 카드의 objective를 사용하고, 조건 전이는 한 번에 하나만 바꾼다.

## 이유

v13까지는 legacy/async 저장소가 혼재했고 manifest 생성이 수동이었다. 또한 정적 Python PASS가 Flutter 컴파일 성공을 보장하지 않았다. v14는 데이터 손실·stale content·실행 불확실성을 줄이는 운영 경계를 만든다.

## 비결정

- `SharedPreferences`를 녹음 원음 저장소로 사용하지 않는다.
- hash 일치를 교육 품질이나 권리 승인으로 해석하지 않는다.
- CI scaffold 존재를 실제 CI 성공으로 표현하지 않는다.
- 조건 전이를 고음 도전으로 바꾸지 않는다.
