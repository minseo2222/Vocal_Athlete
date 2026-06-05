# 안전 근거 도시에 (HITL 사인오프 입력 패킷)

> **무엇:** 중급 안전 카드(belt·트웽·cover·messa·런·k-keok)에 대한 *독립 리서치 2종*의
> 교차검증 결과를 발성 전문가 검토용으로 정리한 패킷.
> **무엇이 아님:** 결정·승인이 아니다. AI는 자가 승인하지 않는다(`kSafetySignoff` 빈 채 유지).
> 본 문서는 면허 전문가(이비인후과·음성 SLP·공인 보컬코치)의 직접 진단·사인오프의 *입력*일 뿐이다.
>
> **출처:** ① Claude 심층 리서치, ② GPT 웹 Pro 확장 — 둘 다 2026-06 수행. **둘 다 면허
> 임상의가 아님**(각 산출물에서 명시). 사인오프 절차는 [HITL-SIGNOFF.md](../curriculum/HITL-SIGNOFF.md).

## 근거 재확인 표기 규칙
- **✅재확인(웹 2026-06)** — 본 에이전트가 웹으로 핵심 주장을 교차확인한 출처.
- **○리서치 제공(미재확인)** — 두 리서치가 제시한 출처를 *귀속만* 하고 독립 재확인하지 않음.
- 페이월/초록만 = PARTIAL. 환각 출처 0(없는 논문 인용 안 함).

---

## TL;DR (3줄)

1. **8개 카드 중 5개(트웽·패사지오·cover 진입·messa 기초·런)는 조건부 사인오프 가능, belt
   진입·belt 레퍼토리는 조건부·일반공개 보류, k-keok은 영구 제외 유지** — 두 리서치가 *독립적으로 수렴*(하드 모순 0).
2. **가장 중요한 공통 발견:** 정량적 "안전 vocal dose"는 문헌에 부재(✅재확인 Zuim·Stewart·Titze
   2023). 모든 수치는 임상 검증값이 아니라 **보수적 제품 임계값**.
3. **현 앱은 텍스트 cue만으로는 사인오프 불가** — 둘 다 *하드 캡 + 객관적 자가 모니터링(swelling
   check) + 다중 stop 신호*를 강제 조건으로 요구. → 사인오프 = 전문가 Yes **+** 강제 캡 구현.

---

## 1. 기법 × 도구 교차검증 매트릭스 (8카드)

| # | 카드 | GPT 웹Pro | Claude 심층 | 합의 | 공통 필수 조건 |
|---|---|---|---|---|---|
| 1 | IM-02/GY-04 트웽 | 조건부 Yes | Sign-off | ✅ **가능(조건부)** | 짧게·고음 sustained 금지·압착 오해 방지 |
| 2 | IM-03 패사지오 | 조건부 Yes | Sign-off | ✅ **가능(조건부)** | break=실패 아님·반복 break loop 금지·하행 우선 |
| 3 | IM-05/GY-05 belt 진입 | 조건부·일반공개 보류 | Conditional | ✅ **조건부(공개 보류)** | 음역 상한·횟수/주간 캡·swelling check·성인 beta |
| 4 | IM-12/GY-09 레퍼토리 | 조건부/보류 | Conditional | ✅ **조건부** | 음역 곡 게이트·belt 비중 상한·풀벨트 미출시 |
| 5 | CL-01 cover 진입 | 조건부 Yes | Sign-off | ✅ **가능(조건부)** | 2차 패사지오 직상방 상한·풀 cover 미출시·과압 cue |
| 6 | CL-08 messa 기초 | 조건부 Yes | Sign-off | ✅ **가능(조건부)** | 중음·저강도 한정·고음 풀 messa 금지 |
| 7 | GY-06 런 | 조건부 Yes | Conditional | ✅ **가능(조건부)** | 중음 한정·정확도 게이트·고음역 런 잠금 |
| 8 | k-keok 강한 성문어택 | No | Hold(영구제외) | ✅ **영구 제외 유지** | 무감독 도입 경로 없음 |

**불일치: 하드 모순 없음.** 라벨 차이(Claude "Sign-off" vs GPT "조건부 Yes")는 둘 다 *"캡을
강제하면 가능"* 이라는 같은 의미. 유일한 강조 차이는 belt: GPT가 "일반 공개는 beta 전까지
보류"를 더 명시(Claude도 Conditional이라 방향 동일).

### belt 음역 상한 — 두 각도, 모순 아님
- **Claude:** 생리적 belt 한계 **여 C5(523Hz)/남 A4(440Hz)** — 이 위는 belt 역학 불가
  (R1→2f0 동조 한계). ✅재확인: Bourne & Garnier 2012가 belt에서 R1을 2f0에 **C5까지** 동조한다고 보고.
- **GPT:** 보수적 *진입* 캡(트랙별 초기 C4~G4) — Claude의 생리 한계보다 훨씬 아래.
- **종합:** 진입은 생리 한계보다 한참 낮게, 절대 상한은 C5/A4 아래. ⚠️ **남 A4는 단일·약한
  근거**(Claude 산출물 자체가 "consensus 값, 단일 1차 verbatim 미검증"으로 표기) → 전문가 확정 필요.

---

## 2. 두 모델이 독립적으로 수렴한 공통 결론 (고신뢰)

1. **정량적 "안전 dose" 부재.** ✅재확인 — Zuim, Stewart & Titze 2023(*J Voice*, PMID 37951817)
   결론부: *"Researchers have yet to establish a safe baseline vocal dose for singers."*
   → 제시된 횟수·주당·지속 수치는 전부 **보수적 추정**(임상 검증 아님).
2. **텍스트 stop-cue("통증 시 중단")만으로는 불충분.** 초기 부종은 무통일 수 있음. 둘 다
   **다중 신호(다음날 쉰목·고음역 축소·작은 고음 faltering) + 객관적 자가 모니터링** 권고.
   Claude는 ○Bastian 1990 **swelling check**(아주 작은 고음 staccato faltering으로 점막 부종
   조기탐지)를 피치 곡선으로 구현하라 제안.
3. **피치 곡선 ≠ 부하 센서.** belt/shout/pressed yell을 구분 못 함 → 강도·압착 무신호. 둘 다 최대 한계로 지목.
4. **belt + belt 레퍼토리가 최고 위험.** 일반 공개 사인오프 불가에 가깝고, 성인 opt-in beta·하드캡·
   AE 모니터링·kill switch 선행 필요. 곡 맥락(감정 몰입)에서 노출량 초과·stop 무시 위험 가중.
5. **k-keok 영구 제외 정당.** ✅재확인 — Andrade 외 2000(*J Voice*, S0892-1997(00)80032-6):
   hard glottal attack 빈도가 MTD·편측/양측 양성병변군에서 건강 대조군보다 높음(147명).
   Claude는 *반대 논거*(편측 성대마비 보상치료의 감독 하 치료적 사용)까지 검토 후, 무감독 앱엔
   도입 경로 없음으로 제외 지지.
6. **K-pop/가요 전용 코호트 부재 → 서구 데이터 외삽.** 더 보수화 + "외삽" 명시 경고 필요.

---

## 3. 카드별 권고 임계값 요약 (보수적 추정 — 전문가 확정 대상)

> ⚠️ 아래 수치는 두 리서치의 *보수적 권고*이며 임상 검증값이 아니다. 앱에 박기 전 전문가가
> 확정해야 한다(본 도시에는 그 입력일 뿐). 피치 표기는 과학적 음높이(C4≈261Hz).

| 카드 | 음역 상한(권고) | 노출/빈도(권고) | 중단·게이트(권고) |
|---|---|---|---|
| 트웽 IM-02/GY-04 | 전이지점 +단3도 이내·고음 sustained 금지 | 단발 ≤2–3초·짧은 phrase 위주 | swelling check·압착 오해 모니터 |
| 패사지오 IM-03 | 2차 패사지오 직상방까지·push 금지 | 짧은 siren·하행 우선·약강도 | 반복 break 3회↑/다음날 쉰목→중단 |
| belt IM-05/GY-05 | 진입 캡(트랙별 C4~G4 초기)·절대상한 여C5/남A4 아래 | call ≤1–2초·세션 제한·주 2–3회·세션간 24–48h | swelling check 게이트·다중 stop·성인 beta |
| 레퍼토리 IM-12/GY-09 | belt음이 IM-05 캡 이내인 곡만 | belt phrase 비중 상한(소수)·주 1회↓ | 음역 기반 곡 난이도 잠금·풀벨트 곡 제외 |
| cover CL-01 | 2차 패사지오 직상방까지·풀 cover 미출시 | 짧은 slide·고음 체류 최소 | "누르면 즉시 낮추기"·swelling check |
| messa CL-08 | 편안 중음 1음·패사지오 근처/위 금지 | 약→조금강→약·다이내믹 폭 제한·짧게 | pitch drift 반복 시 하향·고음 풀 messa 금지 |
| 런 GY-06 | 중음 한정·고음역 런 잠금 | 느린 속도 우선 | 정확도 게이트(미달 시 속도단계 잠금) |
| k-keok | — | **0회(영구 제외)** | 데모/예시 코퍼스에서도 강한 onset 제거 |

(수치 상세·근거는 §6 출처표 및 원 리서치 산출물 참조.)

---

## 4. 📄 전문가 검토용 1페이지 요약

```
[Vocal_Athlete 중급 안전카드 — HITL 사인오프 검토 요약]
독립 리서치 2종(Claude 심층 / GPT 웹Pro, 2026-06) 교차검증. 하드 모순 0건, 강한 수렴.
※ 둘 다 면허 임상의 아님 — 본 요약은 전문가 결정의 입력일 뿐, 사인오프 대체 ❌.

■ 합의 판정
 · 영구 제외 유지: k-keok(강한 성문 어택) — 결절/육아종/MTD 연관, 무감독 도입 경로 없음
 · 조건부 가능(캡 강제 시): 트웽, 패사지오, cover 진입, messa 기초, 런
 · 조건부·일반공개 보류: belt 진입, belt 레퍼토리 — 성인 beta + 하드캡 선행

■ 결정적 공통 경고 (전문가 판단 요청)
 1) 안전 dose 임계값은 문헌 부재 → 제시 수치는 보수적 추정. 동의/조정?
 2) 현 앱은 텍스트 cue만 + 부하 미감지 + 피치곡선=강도 무판정.
    → "캡 코드 강제 + swelling check + 다중 stop"이 사인오프의 전제조건인가?
 3) belt 절대 상한 여 C5 / 남 A4 — 동의? (남 A4는 단일 1차근거 약함, 검증 필요)
 4) belt 주간 누적 캡(주 2–3회·세션간 24–48h 회복) 필요 여부·수치?
 5) K-pop/가요 belt·트웽 서구 외삽 — 더 보수화 / 경고 강화 동의?

■ 전문가가 직접 봐야 할 잔여(리서치가 못 푸는 것)
 데모 오디오 실제 발성 품질 · 한국어 cue 오해율 · 음역 캘리브레이션 품질 ·
 미성년 적용 · 기존 음성질환 self-exclusion 문구 · AE 판정 기준 ·
 관할권별 의료기기/웰니스/광고/개인정보 규제 분류

■ 사인오프: 카드별 ✅승인 / ✏️수정요청 / ❌보류 + 코멘트(검토자·일자·근거)
  → HITL-SIGNOFF.md 결정칸에 기입. 승인+강제캡 구현 후에만 kSafetySignoff 기입.
```

---

## 5. 사인오프 선결조건 (둘 다 강제 요구)

belt/cover/messa/런을 켜려면 **전문가 Yes 단독으로 부족**. 둘 다 다음을 *앱이 강제*하는 것을 전제로 함:

1. **하드 캡** — 음역 상한·세션당 횟수·1회 지속·주간 빈도·주간 누적을 코드가 강제(텍스트 안내 ❌).
2. **swelling check 게이트** — 고부하 카드 진입 전 "아주 작은 고음" 과제(피치 곡선)로 점막 부종
   조기 탐지, 평소보다 낮아지면 그날 고부하 잠금.
3. **다중 stop 신호** — 통증 + 다음날 쉰목 + 고음역 축소 + 작은 고음 faltering 중 하나라도 → 중단·회복.
4. **회복일 강제** — belt/고음 세션 간 24–48h, 반복 AE 사용자 30일 고부하 잠금.

> ⚠️ 위 캡의 *구체 수치 확정*과 *구현*은 전문가 사인오프 후의 별도 개발 슬라이스다(자가 수치확정 ❌).
> 현재 앱이 이를 강제하지 못하므로, **`kSafetySignoff`를 비워 카드를 잠근 현 상태가 정확히 옳은
> 기본값**이다. 백로그: [D4 강제캡/swelling check 이슈](backlog-safety-enforcement.md).

---

## 6. 근거·출처 표 (귀속 + 재확인 표기)

| 출처 | 주장 | 재확인 |
|---|---|---|
| Bourne & Garnier 2012, *JASA* 131(2):1586–1594, DOI 10.1121/1.3675010 | belt에서 R1을 2f0에 **C5까지** 동조; belt는 legit보다 고SPL·고closed quotient | ✅재확인(웹) |
| Zuim, Stewart & Titze 2023, *J Voice*, PMID 37951817 | **"안전 baseline vocal dose 미확립"**(가수) | ✅재확인(웹) |
| Andrade 외 2000, *J Voice*, S0892-1997(00)80032-6 | hard glottal attack 빈도가 MTD·양성병변군>건강대조군(147명) | ✅재확인(웹) |
| Bourne, Garnier & Samson 2016, *JASA*, DOI 10.1121/1.4954751 | 남성 belt도 legit과 EGG contact quotient·SPL 등에서 상이 | ○리서치 제공 |
| Echternach 외 2017, *PLOS ONE*, DOI 10.1371/journal.pone.0175865 | 전문 소프라노도 passaggio에서 불안정 transition | ○리서치 제공 |
| Roubeau 외 2009, *J Voice*, DOI 10.1016/j.jvoice.2007.10.014 | laryngeal vibratory mechanism·register 전환 생리 | ○리서치 제공 |
| Yanagisawa 외 1989, *J Voice*, DOI 10.1016/S0892-1997(89)80057-8 | twang·belt에서 AES narrowing 관찰 | ○리서치 제공 |
| Jelinger 외 2024, *J Voice*, DOI 10.1016/j.jvoice.2024.06.014 | MRI: twang 시 oropharyngeal/AES narrowing | ○리서치 제공(PARTIAL) |
| Hunter & Titze 2009, *Ann Otol Rhinol Laryngol*, DOI 10.1177/000348940911800608 | 2h 부하 후 단기 피로 90% 회복 4–6h·완전 12–18h | ○리서치 제공 |
| Titze, Švec & Popolo 2003, *JSLHR*, DOI 10.1044/1092-4388(2003/072) | vocal dose(distance) 개념·산업 외삽 | ○리서치 제공 |
| Kirsch 외 2025, *PLOS ONE*, DOI 10.1371/journal.pone.0314457 | untrained도 B2/B3 중음 messa 수행 가능 | ○리서치 제공 |
| Köberlein 외 2025, *PLOS ONE*, DOI 10.1371/journal.pone.0325284 | messa di voce는 안정 pitch에서 SPL 조절 난과제 | ○리서치 제공 |
| Echternach, Traser & Richter 2014, *J Voice*, DOI 10.1016/j.jvoice.2013.10.009 | 테너 passaggio vowel별 성도 형상(rt-MRI) | ○리서치 제공 |
| Bastian, Keidar & Verdolini-Marston 1990, *J Voice* 4(2):172–183 | "swelling check"로 점막 부종 조기 탐지 | ○리서치 제공 |
| Ruotsalainen 외, *Cochrane* 2007/2010, CD006372 | 음성위생/훈련 단독의 예방 효능 근거 약함 | ○리서치 제공 |
| Pestana 외 2017, *J Voice*, PMID 28342677 | 가수 자가보고 dysphonia 유병률 ~46% | ○리서치 제공 |
| Jiang & Titze 1994, *J Voice* 8:132–144 | 강도·성문하압·내전↑ → 충돌/충격 응력↑ | ○리서치 제공 |

> 그 외 출처(DeJonckere&Lebacq 2022, Ibarra 2021, Garnier 2010, Neumann 2005, McDonnell 2011,
> Welch 1989, Noson 2002, Stepp 2011, Lin 1991, Ranjbar 2023 등)는 원 리서치 산출물에 귀속돼
> 있으며 본 도시에에서 독립 재확인하지 않았다(○리서치 제공). 규제 출처(FDA general wellness,
> FTC health claims/COPPA, IMDRF SaMD, 한국 식약처 웰니스 기준, Google SRE canary)는 GPT 산출물
> PART 2에 귀속.

---

## 7. 한계 (정직 고지)

1. **두 리서치 모두 면허 임상의가 아님.** 본 도시에는 전문가 결정의 입력이며 의학적 책임을 지지 않음.
2. **가장 결정적 한계: belt·노래의 안전 dose 정량 임계값이 문헌에 사실상 부재**(✅재확인). 모든
   횟수·주당·지속 수치는 보수적 추정.
3. **무선별 일반인(layperson) belt·트웽 직접 안전 연구 전무.** 거의 모든 belt 연구가 숙련자/학생 표본.
4. **K-pop/가요 전용 코호트 부재** — 서구 데이터 외삽, 언어·스타일 차이 미검증.
5. **남성 belt A4 상한은 단일·약한 근거**(consensus 값) — 전문가 검증 필요.
6. hard glottal attack–병변 근거는 대부분 단면·후향(인과 longitudinal 제한) — 단 보수적 제외엔 충분.
7. **○리서치 제공 출처는 본 에이전트가 독립 재확인하지 않았다.** ✅ 3건(belt 상한·dose 부재·HGA)만
   웹 교차확인. 일부 원문 페이월(PARTIAL).
8. 본 도시에는 *보컬 안전*에 한정. 청력·자세·호흡기·심리 등은 다루지 않음.

---

## 8. 사인오프 후 반영 절차 (사람)
전문가가 카드별로 ✅승인하고 **강제 캡이 구현된 뒤에만**: ① `kSafetySignoff`에 검토자·일자·근거
기입 → ② `verification-status.json` 동기화 → ③ `flutter test`(W5) 정합 확인 → 커밋. (자가 승인 ❌)
세부: [VERIFICATION-STATUS.md](VERIFICATION-STATUS.md) §갱신 규칙.
