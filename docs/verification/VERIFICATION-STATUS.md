# 인간 게이트 검증 상태

> 기계용 단일 소스는 `verification-status.json`이다. 기능이 구현됐다는 이유만으로 안전성·학습효과·기기 동작을 VERIFIED로 올리지 않는다.

## 최신 스냅샷 — 2026-07 (v18 이후 후속 작업 반영)

> **남은 작업 단일 인덱스: [`../REMAINING-WORK.md`](../REMAINING-WORK.md).** 아래 v11 표는 과거 기준이며, 최신 항목·주체는 `verification-status.json`(2026-07-01 갱신)과 REMAINING-WORK.md를 본다.

- 호스트 검증: Flutter 테스트 **382 green** · `analyze --fatal-infos` 0 · `build apk --debug` 성공.
- v18 이후 추가(모두 UNVERIFIED/BLOCKED — 실기기·임상 사인오프·법무 대기):
  - 안전 시스템 3기능: 음정 허용오차(F1)·vocal dose 피드백(F2)·상대 공명 추세(F3) — 레슨에 배선·동작.
  - **고위험 게이트 enforced Stage 0**: 기계적 안전장치(스크리닝·도즈/증상 하드락·강도 가드·피처플래그·킬스위치) — **도메인+테스트만, 런타임 미연결(dormant)**, 임상 수치 전부 placeholder(`SIGN-OFF REQUIRED`). 방어심층 = `test/manifest_safety_invariant_test.dart`.
  - **임상 사인오프 패킷** [`CLINICAL-SIGNOFF-PACKET-2026.md`](CLINICAL-SIGNOFF-PACKET-2026.md): 파라미터 후보값·한국 경로·규제 카피. 확정은 후두과+SLP.
  - A2 적신호 스크리닝(→비차단 의뢰 배너), 가요 차별화 안전 카드(GY-11~16, 게이트 잠금 하 편성), UI 토큰 단일화(Sun)·접근성·카피 lint.
- 불변: `kSafetySignoff`={} (전 고위험 카드 잠금), `kReleasedAdvancedGenres`={} (전 고급 장르 미출시). W5 하네스가 JSON↔코드 정합 강제.

## (과거) 현재 상태 — 2026-06-20

| 항목 | 상태 | 해제 조건 |
|---|---|---|
| 고위험 카드 HITL | UNVERIFIED | 전문가 검토 + runtime cap + fallback + rollout 승인 |
| Advanced rollout | UNVERIFIED | 장르 자산·전문가 검수·device QA |
| 마이크/F0/timing | UNVERIFIED | Android/iOS 실기기 매트릭스 |
| 녹음·재생·삭제 | UNVERIFIED | 권한·파일·재시작 persistence QA |
| 오디오 세션 무결성 | UNVERIFIED | Android audio focus·iOS interruption·전화/route change 실기기 QA |
| 학습 기록 | UNVERIFIED | content revision + delayed review + 사용자 이해도/retention 검증 |
| v8 research bundle | UNVERIFIED | 01–05 임시 인용 복구 + 링크 일괄 검증 |
| v11 curriculum vertical slice | UNVERIFIED | Flutter tests + 실기기 음원 QA + 전문가 검수 + retention/transfer 결과 |
| 평가 루브릭 | UNVERIFIED | 평가자간 신뢰도와 사용자 이해도 |
| 개인정보 | UNVERIFIED | 실제 출시 동작과 Play Data safety/정책 정합 |

## v11에서 정적으로 확인할 수 있는 설계

- v10 경로·blueprint·WAV·권리 inventory 정합성 유지
- 시도·자기점검·예시 청취·키·녹음 수·best 선택·목 상태의 local practice trace
- target evidence와 achieved evidence를 자동으로 동일시하지 않는 모델
- 학습 기록 설정 화면과 전체 삭제 seam
- 가이드 재생 전 녹음 take/capture 중단
- 녹음 시작 전 가이드와 저장 take 재생 중단
- 본운동 이탈·완료·non-resumed lifecycle에서 stop/cancel
- best take `isBest` 메타데이터 영속화
- Flutter `integration_test` 실행 파일 존재

이는 코드·문서 구조의 확인이지 학습효과, 오디오 focus, 플랫폼 동작 또는 안전성 검증이 아니다.

## 상태 갱신 규칙

1. 코드, JSON, 사람용 문서를 함께 갱신한다.
2. 고위험 카드는 전문가·날짜·근거·cap·fallback을 모두 기록한다.
3. 기기 검증은 실제 결과 파일을 남긴다.
4. 연구 출처는 제목·저자·연도·DOI/URL과 주장 연결을 남긴다.
5. 학습효과는 delayed retention과 transfer를 포함한다.
6. target evidence는 실제 achieved evidence로 자동 승격하지 않는다.
7. `flutter test`, integration test, `dart analyze`, device QA 전 adapter와 interlock은 `implemented_unverified`다.
