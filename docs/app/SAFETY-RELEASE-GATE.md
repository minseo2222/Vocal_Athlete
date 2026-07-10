# 안전 출시 게이트 — 위치 안내

> 이 문서는 이전 위치 호환용 포인터다. Canonical 문서는 `../verification/SAFETY-RELEASE-GATE.md`이다.

중급 이상 고위험 카드(belt·트웽·패사지오 처리·cover·messa·run·고부하 레퍼토리)는 다음이 모두 충족될 때만 공개한다.

1. 전문가 HITL 사인오프.
2. `app/lib/safety/safety_signoff.dart`의 유효한 검토자·일자·근거 기록.
3. 앱 강제 cap 구현: 음역·반복·지속·주간 노출·휴식·stop signal·fallback.
4. rollout config 사람 승인.
5. `verification-status.json`과 라이브 코드 정합.

상세 상태 모델, 필수 필드, 런타임 동작, QA 수용 기준은 `../verification/SAFETY-RELEASE-GATE.md`를 따른다.
