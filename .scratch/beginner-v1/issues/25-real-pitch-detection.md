# A1 — 실제 F0 검출 → U4 stub 교체

Status: ready-for-agent

## What to build

**pYIN 온디바이스**(C via FFI, ADR-0014) 실시간 F0 검출 구현, U4의 stub 피치 소스를 실제 마이크 기반 pYIN으로 교체(인터페이스는 U4에서 분리됨 — 후일 CREPE-tiny V2 교체 seam 유지). 온디바이스, 시각 전용. 저신뢰 음향 지표(jitter/shimmer/HNR/AVQI 등) 계속 비표시(AI-ANALYSIS.md 정직 한계).

## Acceptance criteria

- [ ] 실제 마이크 F0 검출(pYIN, C FFI)로 stub 대체
- [ ] U4 시각 곡선이 실제 피치로 동작
- [ ] 저신뢰 지표 비표시 유지, 시각 전용
- [ ] 검출 정확도·지연 기본 측정 기록

## Blocked by

- 14-pitch-approach-decision (A0)
- 21-pitch-feedback-stub (U4)
