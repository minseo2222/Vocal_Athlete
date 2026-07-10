# 백로그 — 안전 게이트 강제 구현 (belt/cover/messa/런 출시 선결조건)

> **상태:** 미착수(BACKLOG). **이슈:** [#1](https://github.com/minseo2222/Vocal_Athlete/issues/1).
> **선후관계:** 전문가 HITL 사인오프(임계 수치 확정) → 본 구현 → 출시.
> **왜:** 독립 리서치 2종([도시에](SAFETY-EVIDENCE-DOSSIER.md))이 *둘 다* "텍스트 cue만으로는
> 사인오프 불가, 캡을 앱이 강제해야 한다"를 결론. 현재 앱은 cue 텍스트만 있고 강제 캡이 없으므로,
> `kSafetySignoff`를 비워 카드를 잠근 현 상태가 옳은 기본값. 본 항목 구현 전엔 belt/cover/messa/런 출시 불가.
> 제품 기준은 [`SAFETY-RELEASE-GATE.md`](SAFETY-RELEASE-GATE.md)를 canonical로 따른다.
>
> ⚠️ **수치 미확정:** 아래 수치는 리서치의 *보수적 추정*이며 임상 검증값이 아니다(안전 dose 문헌
> 부재, ✅Zuim 2023). **전문가가 사인오프에서 확정한 값으로 대체**해야 한다 — AI 자가 수치확정 ❌.

## 구현 항목

### 1. 하드 캡 (코드 강제, 텍스트 안내 ❌)
- 카드별 **음역 상한**(개인 음역 캘리브레이션 기준), **세션당 횟수**, **1회 지속시간**,
  **주간 빈도**, **주간 누적**을 앱이 강제(초과 시 진행 차단/하향).
- belt 절대 상한: 여 C5 / 남 A4 *아래*(✅Bourne&Garnier 2012; 남 A4 단일근거 약함 → 전문가 확정).

### 2. swelling check 게이트 (객관적 자가 모니터링)
- 고부하 카드 진입 전 "아주 작은 고음" 과제를 *기존 피치 곡선*으로 수행 → 평소 mucosal
  ceiling보다 낮아지면 그날 고부하 카드 자동 잠금(○Bastian 1990).

### 3. 다중 stop 신호
- "통증" 단독(초기 부종은 무통일 수 있음) → **통증 / 다음날 쉰목 / 고음역 축소 / 작은 고음
  faltering** 중 하나라도 → 중단·회복. 카드 cue 텍스트도 이에 맞춰 갱신(전문가 확정 후).

### 4. 회복일 강제
- belt/고음 세션 간 24–48h 회복(권고치), 반복 AE 사용자 30일 고부하 잠금.

### 5. 음역 캘리브레이션
- 20–30초 비의학적 range calibration("편한 중음"·"첫 전이/불편 지점") → 모든 음역 상한을
  성별이 아닌 *실제 편한 음역* 기준으로. 캘리브레이션 없으면 고부하는 최저 트랙 기준만 공개.

### 6. (롤아웃) AE 텔레메트리 + kill switch
- 카드/장르/연령군별 completion·stop·pain·다음날 쉰목·cap-hit 수집 + 즉시 끌 kill switch
  (GPT 산출물 PART 2 거버넌스). canary 단계 출시.

### 7. fallback manifest
- pending/high-risk 카드가 제외될 때 코스가 짧아지거나 핵심 학습 맥락이 비지 않도록 안전 대체 카드 슬롯을 지정한다.
- 예: belt → SOVT transfer / low-range speech-like call, cover → neutral vowel shaping, run → low-range slow 3-note pattern.

## 수용 기준 (구현 완료 정의)
- 위 1–5와 fallback manifest가 코드로 강제되고 테스트로 검증(예: 상한 초과 차단, swelling-check 잠금, 다중 stop 잠금, pending 카드 대체).
- 전문가가 확정한 수치가 반영됨(본 문서의 추정치가 아니라).
- 이후에만 `kSafetySignoff` 기입 → `verification-status.json` 동기화 → W5 정합 → 출시 검토.

## 참조
- 근거·합의: [SAFETY-EVIDENCE-DOSSIER.md](SAFETY-EVIDENCE-DOSSIER.md)
- 사인오프 절차: [HITL-SIGNOFF.md](../curriculum/HITL-SIGNOFF.md)
- 상태 단일 소스: [verification-status.json](verification-status.json)
