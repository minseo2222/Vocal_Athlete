# U4 — 시각 피치 피드백 (피치 stub)

Status: ready-for-agent

## What to build

하단 시트 안 실시간 시각 피치 피드백: 피아노롤/목표선 + 학습자 곡선 + ±편차 색상 밴드(±10/±30 cents 류). **피치 소스는 stub**(가짜/합성 신호 — 실제 F0는 A1에서 교체). **시각 전용**(듣고 판단 ❌, 골전도 착각 차단). 신뢰도 낮은 음향 수치(jitter 등) 비표시.

## Acceptance criteria

- [ ] 피아노롤+곡선+±색상 밴드 렌더(stub 신호)
- [ ] 시각 전용, 저신뢰 수치 미표시
- [ ] stub↔실제 교체 가능한 피치 소스 인터페이스 분리
- [ ] 렌더 테스트

## Blocked by

- 18-lesson-screen-D (U1)
