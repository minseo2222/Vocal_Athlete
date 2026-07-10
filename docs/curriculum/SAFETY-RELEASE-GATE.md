# 안전 출시 게이트 — 커리큘럼 브리지

> 이 문서는 커리큘럼 폴더용 포인터다. Canonical 문서는 `../verification/SAFETY-RELEASE-GATE.md`이다.

고위험 발성 카드(belt, cover, messa, run, 지속 twang, 고강도 레퍼토리)는 `HITL-SIGNOFF.md`의 전문가 검토만으로 공개하지 않는다. 실제 사용자 공개 조건은 다음 문서를 따른다.

- 제품 출시 상태와 release gate: `../verification/SAFETY-RELEASE-GATE.md`
- 전문가 검토 패킷: `HITL-SIGNOFF.md`
- cap 구현 백로그: `../verification/backlog-safety-enforcement.md`
- 검증 상태 단일 소스: `../verification/verification-status.json`

요약:

1. 전문가 HITL 사인오프 필요.
2. 전문가가 확정한 음역·횟수·지속·주간 cap을 코드가 강제해야 함.
3. stop signal과 fallback card가 있어야 함.
4. 실기기 마이크/피치 검증과 release flag가 통과되어야 함.
5. 위 조건 전에는 중급 고위험 카드는 일반 공개 금지.
