# A0 — 피치 검출 방식 결정

Status: done — 결정: **pYIN V1 + CREPE-tiny V2경로** (ADR-0014)

## Decision

V1 = pYIN 온디바이스(C via FFI, Flutter). CREPE-tiny = 문서화된 V2 업그레이드 경로. 피치 소스 인터페이스 분리(교체 seam). 정직 한계: F0·sustain만, 저신뢰 지표 비표시, 시각 전용. 근거·대안·리스크 = `docs/adr/0014-pitch-detection-pyin-v1.md`.

---


## What to build

실시간 F0(피치) 검출 방식을 *결정*한다. 후보: CREPE(딥러닝) / YIN(고전) / 하이브리드(CREPE+YIN 백업). 평가축: 온디바이스 모델 크기·지연·정확도, 라이선스, F0 정확도(목표 ≤ ±5 cents 수준 지향), 컨슈머 마이크 신뢰도(AI-ANALYSIS.md: F0·sustain은 신뢰 가능, jitter/shimmer/HNR/AVQI는 *비표시* — 정직 한계). 결과를 ADR로 기록. 구현은 A1.

## Acceptance criteria

- [ ] 방식 1개 확정 + 근거 ADR 기록
- [ ] 온디바이스 지연/크기/정확도 트레이드오프 명시
- [ ] 비표시 지표(저신뢰) 목록 확정(AI-ANALYSIS.md 정합)
- [ ] 시각 전용 피드백 원칙 재확인(청각 자가판정 ❌)

## Blocked by

- 01-stack-scaffold-decision (F0)
