# 임상 사인오프 패킷 (2026) — enforced 안전 파라미터 후보값·한국 경로·규제 카피

> 본 문서는 **최종 임상 자문이 아니다.** 모든 후보값은 후두과 전문의 + 음성 SLP(≥2인)의
> `☐confirm/☐adjust` 전제이며, 확정 전까지 `lib/safety/safety_params.dart`의 값은 placeholder다.
> 충돌 시 가장 보수적(노출↓·잠금↑) 해석을 채택한다. **고강도 belt/통성/hard glottal은 영구 잠금**
> (해제·근사 금지). 후보는 **저강도 트왱·메사 디 보체 크레셴도**에만 적용.
> 근거 출처는 원문(영어) 보존. 전체 리서치 원본: 본 문서 §4 출처 + GPT Pro/Claude 심층리서치 2건.
>
> 근거 등급: A=권위 가이드라인/규제 정의 직접 / B=검증도구·임상연구 비교적 직접 / C=피어리뷰이나 앱 적용 간접 /
> D=생리학적·동물 간접 / E=관행·합의 / F=직접근거 없음(보수 placeholder).

## 1. 파라미터 사인오프 표 (safety_params.dart 1:1 매핑)

각 행: 현재 placeholder(코드값) → 리서치 후보값/범위 → 근거·등급 → 한국적용 → 확정자 → ☐.

| safety_params 상수 | 현재값 | 리서치 후보값/범위 | 근거(저자·연도, 등급) | 한국 적용 | 확정자 | ☐ |
|---|---|---|---|---|---|---|
| `kScreenHoarsenessPersistDays` | 14 | **28일(4주)**=가이드라인; 더 짧게(14~21일)는 보수적 정당 | Stachler 2018 AAO-HNS (A; 4주=사실, 더 짧음=보수외삽) | 외국 기준, 한국 confirm | 후두과 | ☐ |
| `kScreenSurgeryLookbackWeeks` | 6 | **8~12주**(갑상선·경부수술·지속증상 시 24주). 현재 6은 다소 짧음 → 상향 검토 | Stachler 2018 (개념 A, 주수 F) | 한국 confirm | 후두과 | ☐ |
| `kScreenRescreenDays` | 30 | 직접근거 없음(엔지니어 제안 가능) | — (F) | — | 엔지니어+SLP | ☐ |
| (적신호 hardBlock 항목) | 12항목 | 객혈·stridor/호흡곤란·경부종괴·연하곤란·진행성 애성·통증·수술/삽관 = 즉시 차단·의뢰 | Stachler 2018 (A/B) | 한국 문구는 "진단" 아닌 "중지+진료권고" | 후두과 | ☐ |
| `kGuardMaxSustainSec` | 3 | **rep당 연속 voiced ≤5초**(현재 3은 더 보수적—OK) | 직접근거 없음, Titze 2003 개념 외삽 (F) | 없음 | 음성 SLP | ☐ |
| `kDoseMinRestSec` | 10 | **≥15초 또는 발성:휴식 ≥1:2~1:3** → 현재 10은 짧음, 상향 검토 | "최소 침묵 회복구간 미확립"(Titze/Hunter/Švec 2007) (F) | 없음 | 음성 SLP | ☐ |
| `kDoseHighF0Hz` | 440 | 절대Hz ship 금지 — **개인 편안음역 상단**(comfort median +6 semitone) 권고 | 직접근거 없음 (F) | 없음 | singing SLP | ☐ |
| (세션당 발성 총량) | 카드 maxDurationSec | **세션당 active phonation ≤5분**, take 1~3분, 증상 시 0 | Titze 2003(≈17분 말하기·무휴식 외삽)보다 보수 (C/F) | 없음 | 음성 SLP+후두과 | ☐ |
| (주당 빈도) | 카드 weeklyCap | **주 3~4회 이하, 비연속일**, 동일기법 48h 간격 | Rousseau 2017(토끼 24h~3일)·Carroll dosimetry 외삽 (C/D) | 없음 | 후두과 | ☐ |
| (세션 간 휴식) | 카드 requiredRestHours | **고부하 후 ≥24h**(4~6h내 90%·12~18h 완전회복) | Hunter & Titze 2009 (C~D, 말하기 외삽) | 없음 | 후두과 | ☐ |
| (반복/ full-take) | 카드 maxReps/maxTakeCount | 세트당 ≤6 reps·세션당 ≤2세트; full-take ≤30초/1일1회/주2회 | 직접근거 없음 (F) | 없음 | 음성 SLP | ☐ |
| `kGuardF0CeilingHz` | 523 | **기본값 없음** — 성종별 천장은 임상가 개별평가 후만 | 직접근거 없음 (F) | 없음 | 후두과+singing SLP만 | ☐ |
| `kGuardMaxGlideSemitones` | 5 | ≤5 semitone/rep (현재 일치) | 직접근거 없음 (F) | 없음 | 음성 SLP | ☐ |
| `kGuardMaxRampSemitonesPerSec` | 12 | **≤1 semitone/sec**, leap >3/sec 금지 → **현재 12는 과대, 하향 강력 검토** | 직접근거 없음 (F) | 없음 | 음성 SLP | ☐ |
| `kSymptomVfcSoft` / `kSymptomVfcHard` | 5 / 8 | 경량 self-check은 보조; **검증 컷오프(VFI/VHI)를 주 게이트로** | — (경량은 F, VFI/VHI는 B) | 한국 confirm | 음성 SLP | ☐ |
| `kVfiFactor1/2/3Cutoff` (vocal_recovery) | 24/7/7 | **F1≥24·F2≥7·F3≤7**(AUC0.91, 90%/90%) | Nanjundeswaran 2015 (B). **K-VFI 존재**(Kang 2017) | K-VFI 한국 컷오프 confirm + 라이선스 | 음성 SLP | ☐ |
| (VHI-10 게이트) | 미사용 | **>11 비정상**(위음성 27% 주의→ 민감하게) | Arffa 2012 (B); 위음성 Nemr 2021. **K-VHI-10 존재**(Yoon 2008) | 한국 컷오프 confirm + 라이선스 | 음성 SLP | ☐ |
| `kSymptomHoarseDays` | 3 | **새 쉰목소리/통증/작열감 1개라도 → 즉시 잠금** | SOVT sensation 합의 (E) | confirm | 음성 SLP | ☐ |
| `kSymptomLockoutHours` | 24 | **48~72h**(증상 해소까지+) → **현재 24는 짧음, 상향 검토** | Carroll dosimetry·수술후 음성휴식 RCT 외삽 (C/F) | 없음 | 후두과 | ☐ |
| `kSymptomReferralCount` | 3 | **14일 내 2회 또는 90일 내 3회 → 의무 의뢰** | 직접근거 없음 (F) | 없음 | 후두과+SLP | ☐ |
| `kCanaryAdverseHaltRate` | 0.05 | **SAE 1건→즉시 전면 halt**; lock율 rolling 7/14일 >5% 또는 AE/세션 >1% → release hold | SAE 정의 FDA 21 CFR 312.32 (A); halt율 F | 한국 보고의무 별도 | 규제+임상패널 | ☐ |
| (EASE 도입 시) | 미사용 | 컷오프 12.5(네덜란드판 75%/74%) — **한국어 검증판 부재** | D'haeseleer 2022 (C, 외국판). EASE 원판 Phyland 2014 | **한국 검증·IRB 필요** | 음성 SLP | ☐ |

> **불일치(클리닉 주목)**: 현재 placeholder가 리서치 보수 방향과 어긋나는 3곳 — `kGuardMaxRampSemitonesPerSec`(12 vs ≤1), `kSymptomLockoutHours`(24 vs 48~72), `kScreenSurgeryLookbackWeeks`(6 vs 8~12). 사인오프 시 우선 조정 대상. (단 전부 잠긴 상태라 현재 사용자 영향 0.)

## 2. 한국 사인오프 경로 (체크리스트)

| # | 단계 | 기관/절차 | 링크 (as of 2026 · 확인 필요) |
|---|---|---|---|
| 1 | 후두과 검토자 | 대한후두음성언어의학회 사무국 | kslpl.org / secretary@kslpl.org |
| 2 | 음성 SLP 검토자 | 한국언어청각임상학회(KASA) / 음성장애 경험 언어재활사 | kasa1986.or.kr ("KSHA"=한국언어치료학회와 혼동 주의) |
| 3 | 대학병원 음성센터 | 연세 음성언어의학연구소; 서울대·분당서울대·서울아산·삼성서울 이비인후과 음성클리닉 | 각 병원 이비인후과 음성클리닉 |
| 4 | SLP 자격 | 언어재활사 1/2급(국시원, 장애인복지법 근거) | kuksiwon.or.kr |
| 5 | 도구 라이선스 | K-VFI(Kang 2017)·K-VHI-10(Yoon 2008)·K-SVHI(Lee&Sim 2013) 저자/KASA 허가; EASE는 한국어판 부재 | kjorl.org / e-csd.org |
| 6 | IRB/윤리 | 검증·데이터 수집 시 병원/공용 IRB **사전** 심의(생명윤리법). 민감(건강)정보는 면제 불가 | irb.or.kr / nibp.kr |
| 7 | 규제 분류 | MFDS 웰니스 판단기준(2026-02-12 개정) + 디지털의료제품법 classification memo | mfds.go.kr (원문 직접확인 불가 시 명시) |
| 8 | 책임/보험 | 면책·위험인수, 전문가 자문계약(범위·금지claim·AE escalation·이해상충), PL/E&O/사이버 보험 | pipc.go.kr |

**라이선스 전 운영**: 검증도구 문항 verbatim 탑재는 라이선스 전까지 금지. 저작권성 낮은 단순 안전 문진("오늘 목 통증?", "새 쉰목소리?", "숨/삼킴 문제?", "최근 수술/삽관?")만 사용 → 현재 앱의 경량 self-check·A2 적신호가 여기 해당.

## 3. 규제 카피 규칙 (웰니스 유지 — copy lint)

**유지 조건**: 무채점·비진단, 사용목적="일반 성인 저강도 보컬 연습·휴식·자기점검", 출력=연습 보조(점수·진단·위험도 ❌), 안전 gate="진단" 아닌 "오늘은 쉬고 전문가 상담" 형태, 18세+·적신호 차단, 고강도 영구 잠금.

**❌ 금지(의료기기 전환 트리거):** 진단·감지·검출·선별·치료·재활·회복·예방·"의학적으로 입증"·성대 건강 점수·성대질환 위험도·성대결절 예방·쉰목소리 치료·후두질환 모니터링·"병원 갈 필요 없음"·전문가 대체·medical-grade·성대 상태 분석/측정·F0를 질환 위험도로 환산.

**✅ 허용:** 일반 보컬 연습·저강도 연습·오늘의 컨디션 체크·휴식 권고·전문가 상담 권장·무리하지 않기·자기관리 참고 정보·연습 기록.

> 디지털의료제품법 '디지털의료·건강지원기기' 자율신고/자율성능인증은 선택지이나 초기 지정범주(심박·SpO2·체성분·걸음)가 보컬/F0와 달라 **"해당 없음/개별 질의 필요"**로 두는 것이 안전.

## 4. 핵심 근거 출처 (원문)
- Stachler RJ et al. (2018). *Clinical Practice Guideline: Hoarseness (Dysphonia) (Update).* Otolaryngol Head Neck Surg 158(1S):S1–S42. DOI:10.1177/0194599817751030 — **A**.
- Titze IR, Švec JG, Popolo PS (2003). *Vocal Dose Measures.* J Speech Lang Hear Res 46(4):919–932. DOI:10.1044/1092-4388(2003/072) (PMC3158591) — 도즈·≈17분 외삽.
- Hunter EJ & Titze IR (2009). *Quantifying Vocal Fatigue Recovery.* Ann Otol Rhinol Laryngol 118(6):449–460. DOI:10.1177/000348940911800608 — 회복곡선.
- Rousseau B et al. (2017). *Recovery of Vocal Fold Epithelium after Acute Phonotrauma.* Cells Tissues Organs 204(2):93–104. DOI:10.1159/000472251 (PMID:28647731) — 24h~3일(토끼).
- Nanjundeswaran C et al. (2015). *Vocal Fatigue Index (VFI).* J Voice 29(4):433–440. DOI:10.1016/j.jvoice.2014.09.012 — 컷오프 24/7/7.
- Arffa RE et al. (2012). *Normative Values for the VHI-10.* J Voice 26(4):462–465 — >11. 위음성: Nemr et al. (2021) J Voice (PMID:33451893).
- D'haeseleer E et al. (2022). *EASE-NL.* J Voice (PMID:36372673) — 12.5. 원판 Phyland DJ et al. (2014) Folia Phoniatr Logop 66(3):100–108.
- Kang YA, Chang JW, Koo BS (2017). *K-VFI.* Korean J Otorhinolaryngol-Head Neck Surg 60(5):232–242. kjorl.org/journal/view.php?number=7816.
- Yoon YS, Kim HH, Sohn YI, Choi HS (2008). *K-VHI/K-VHI-10.* Korean J Communication Disorders 13:216–241.
- Lee AR & Sim HS (2013). *K-SVHI.* Comm Sci Disord 18(2):194–202.
- FDA. *What is a Serious Adverse Event?* 21 CFR 312.32. fda.gov/safety/reporting-serious-problems-fda/what-serious-adverse-event — **A**.
- MFDS 「의료기기와 개인용 건강관리(웰니스) 제품 판단기준」(2026-02-12 개정) — **원문 직접 확인 불가, 최신 검증 가능 버전 기준**. mfds.go.kr.
- 디지털의료제품법(2024-01-23 공포, 2025-01-24 시행). law.go.kr lsiSeq=259299.

## 5. 종합 (정직한 비대칭)
**측정 가능한 임상 신호(증상·이력 기반 의뢰)**는 강한 근거(A~B): A2 적신호·4주 의뢰, A5 검증도구 컷오프, A8 SAE 정의.
**운동 처방(강도·시간·빈도·F0·ramp)**은 가창 직접근거 거의 없음(F, 보수 외삽뿐).
→ 설계 원칙: **증상/이력은 검증 컷오프로, 운동 처방은 가장 보수적 잠금으로.** F0만으론 강도 검증 불가(SPL 없음) → 고강도 영구 잠금 유지, 통증·작열감 주관 신호를 즉시 잠금 트리거로.
