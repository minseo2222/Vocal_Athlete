# 'enforced' 단계 안전 집행 — 착수 가능 구현 명세 (2026)

> 무채점·폰(F0·타이밍·자가보고만)·전문가 부재 Flutter 앱에서, 고위험 발성 기법 게이트의
> 'enforced' 단계를 어떻게 구현할지에 대한 buildable 명세. 거버넌스는 `GENRE-RELEASE-SIGNOFF.md`,
> 판정 근거는 `GENRE-GATE-RELEASE-RESEARCH-2026.md`. **모든 임상 수치는 placeholder(SIGN-OFF 대기).**

## TL;DR
- A2 스크리닝·A3 도즈캡·A5 증상잠금·A8 카나리·A9 킬스위치는 기존 VocalLoadLedger/Policy/VFI/회복
  프리미티브를 **하드락으로 승격**해 지금 구현 가능. 임상 수치는 전부 placeholder.
- **A4(저강도 강제)가 본질적 한계**: SPL/EGG/CPPS 없어 강도·충돌응력 측정 불가 →
  "편한 음고로 세게 벨팅" 같은 고강도 시도는 **신뢰성 있게 감지 불가** → impossible로 명시,
  고강도 belt/통성/하드글로탈은 **영구 잠금**(런타임 차단이 아니라 "검증 불가라 아예 안 가르침").
- 포지셔닝: 한국 1차 시장 = **개인용 건강관리(웰니스)**. MFDS 2026 예시#1(스트레스 해소 맞춤 음악/영상/수면
  콘텐츠)이 웰니스로 분류 → 무채점·비진단 보컬 연습은 여기에 매핑. 질병명·진단·이상탐지·"의료급" 주장은 금지.

## 근거 핵심(등급)
- A2 적신호: AAO-HNS Hoarseness CPG(Stachler 2018) — 자유 구현 가능(저작 도구 아님). A.
- 검증 도구 컷오프(placeholder 참조용, 저작권 — 문항 verbatim 복제 금지, 라이선스 필요):
  VFI(Nanjundeswaran 2015, 19문항 3요인, 컷오프 F1≥24/F2≥7/F3≤7, AUC0.91) A–B;
  VHI-10(>11 비정상, Arffa 2012) A; EASE(Phyland 2013/2014, 20문항 4점, 현재상태용) B.
  ※ 컷오프는 인구의존(덴마크 F1≥11.5, 홍콩 Part1≥25 등) → 한국 검증 필요.
- A3 도즈: Titze/Švec/Popolo 2003 — "발성시간 누적만으론 불충분"(F0/SPL 영향), 17분/520m는 진동한계
  비교치이지 트레이닝 캡 아님. SPL 없어 시간·F0가중 프록시만 가능, 보수적 파라미터화 필수. B–C.
- A8/A9: 피처플래그 ring 롤아웃·즉시 킬은 표준 엔지니어링. 무채점 앱의 부작용 신호 = 자가보고 증상·잠금
  발동률(생리적 손상 아님). 등급 면제.
- 회복: 급성 phonotrauma 24h~3일 염증→복구(Rousseau 2017) → 기존 24/72h 설계와 정합.

## 컴포넌트별 구현(데이터모델·규칙·파라미터placeholder·실현성·검증)

### A2 사전 스크리닝 하드락
- 모델: ScreeningItem{id,promptKey,isHardBlock}; ScreeningResult{outcome(pass|softCaution|hardBlock),
  triggeredIds, screenedAt, validUntil, referralAdvised}.
- 적신호 항목(직접 구현, AAO-HNS+표준 ENT): hoarse2w·dysphagia·neck_mass·hemoptysis·otalgia·
  stridor_breath·recent_surg_intub·known_lesion·pain_phonation = hardBlock; lpr_reflux·tobacco·prof_voice = softCaution.
- 규칙: hardBlock 1+ → 잠금 유지+의료 의뢰(비진단 카피), 자가 해제 불가; soft만 → 캡 강화+조기 재스크린;
  전부 음성 → pass(validUntil=now+P_RESCREEN_DAYS). **미응답 hardBlock = 긍정 처리(잠금).**
- 파라미터: P_SURG_WEEKS, P_RESCREEN_DAYS, 쉰목소리 지속(보수적 2주) — SIGN-OFF.
- 실현: 순수 자가보고 가능. 검증: 진리표·날짜경계 단위테스트.

### A3 노출 캡(도즈 집행)
- 프록시(F0+타이밍): sessionPhonationSeconds(보유), repsPerSession, continuousHighPitchSustainSec,
  restIntervalSec, weeklyFrequency, multiDayCumulative, f0WeightedTimeDose(프록시-라벨 approximate).
- ledger 확장: +continuousHighPitchSustainSecMax, +last7DaysPhonationSec(롤링), +f0WeightedTimeDoseMilli.
- policy 추가(soft→hard 승격): evaluateDoseHardLock/evaluateForcedRest/evaluateWeeklyCap →
  LockAction{allow,lowerIntensity,forcedRestLock,weeklyCapLock,doseLock}.
- 규칙: sessionPhonation≥maxDurationSec ∨ sustainMax≥maxSustainSec ∨ reps≥maxReps ∨ takes≥maxTakeCount → doseLock;
  lastHighEpochDay within requiredRestHours → forcedRestLock(회복 윈도우); weeklyFreq≥weeklyCap → weeklyCapLock;
  rep간 restIntervalSec≥P_MIN_REST 강제.
- 파라미터: 위 캡 전부 + P_MIN_REST·P_HIGH_F0·w(F0) — SIGN-OFF(엔지니어는 가장 보수값으로 스테이징만).
- 실현: 시간/반복/휴식/빈도/지속=가능; 진짜 생체역학 도즈=불가(프록시만). 검증: 경계 ledger·다일 시뮬.

### A4 강도/F0 범위 집행 — 가장 제한적, 정직하게
- 가능(F0/타이밍): 음고 상한 P_F0_CEILING, 연속 sustain 상한, 글라이드 폭 P_GLIDE_SEMITONES,
  ramp(semitone/s) 상한, 급격 온셋(하드글로탈 약한 프록시).
- **불가(라벨 impossible)**: SPL·loudness 측정 불가 → "편한 음고 큰소리 벨트" 감지 불가; spectral tilt/CPPS/
  EGG 없어 발성타입 구분 불가. 마이크 게인을 SPL 대용으로 쓰면 안 됨(무보정·거리·기기 의존).
- 귀결: 고강도 belt/통성/하드글로탈 **영구 잠금**(검증 불가라 미교습). 저강도 트왱·메사만 후보 +F0 가드.
- 모델: IntensityGuard{f0CeilingHz,maxSustainSec,maxGlideSemitones,maxRampSemitonesPerSec} → GuardResult.
- 파라미터: 전부 SIGN-OFF. 검증: 합성 F0(steady/glide/overshoot/abrupt) 전이 + **사각지대 테스트(loud-at-mid-pitch
  는 NOT 감지됨을 명시 단언)**.

### A5 증상 기반 하드락(기존 VFC 승격)
- 모델: SymptomState{vfcScore, vfiF1/F2/F3, easeTotal/PRI, painReported, hoarsenessReported,
  lastSymptomEpoch, lockoutUntil} → SymptomLock{none,softReduce,hardLockout,referral}.
- 규칙: VFC>P_VFC_SOFT→강도↓(현행); VFC≥P_VFC_HARD ∨ 통증 ∨ 쉰목소리≥P_HOARSE_DAYS → hardLockout
  (모든 고위험/후보 카드) P_LOCKOUT_HOURS; 주기적 검증도구 컷오프 초과 → hardLockout+재스크린;
  반복 트리거 ≥P_REFERRAL_COUNT → referral. lockout vs 회복 윈도우 = max().
- 파라미터: 컷오프·주기·잠금시간 전부 SIGN-OFF; 도구 라이선스=법무/임상.
- 실현: 가능(자가보고+타이밍). 검증: 상태머신·컷오프 경계·반복→referral·max(lockout,recovery).

### A8 카나리/단계 출시
- 모델: SafetyFeatureFlag{key, minGateState, rolloutPercent, killSwitch, cohortAllowlist};
  isEnabled = !kill && gate≥minGateState && (allowlist || stableHash(id)<percent).
  **fail-safe: 원격 config 불가 → killSwitch=true(잠금).** 시작 percent≤0.01.
- 부작용 신호(무채점 측정 가능): A5 잠금 발동률·통증/쉰목소리 보고율·referral율·A3 도즈락율·중도이탈율·
  활성화 후 재스크린 실패율. (조직손상 측정 불가 — 정직히 명시.)
- 규칙: ring N→N+1은 P_OBS_DAYS 경과 & 부작용율 ≤ baseline+P_AE_DELTA일 때만; 초과 또는 심각 자가보고 1건 → halt.
- 파라미터: percent·P_OBS_DAYS=엔지니어/제품; "심각 부작용" 정의·P_AE_HALT=SIGN-OFF.
- 검증: 해시 버킷 안정성·fail-safe·부작용 스트림→auto-halt.

### A9 롤백/킬스위치
- 트리거: 심각 자가보고·부작용율 위반·스크리닝 우회/로직오류·컷오프 대량발동 이상 → killSwitch=true(즉시) &
  gate enforced→revoked. 수동 킬(감사 가능). revoke 시 후보 카드 재잠금·세션 graceful 종료·무손실·무점수.
  revoked→enforced는 재사인오프 없이는 불가.
- 모델: GateState{none,pending,signedOff,enforced,released,revoked}; KillSwitchState{global,revokedFlags,since,reason}.

### 횡단
- A6 동의/위험인수: 평이한 위험설명→명시적 동의(사전체크 ❌)→A2 스크리닝→버전 동의기록. 비의료 카피. 중과실은 면책 불가.
- A7 비의료기기 포지셔닝(카피 lint):
  금지(기기로 전환): 질병명, 진단/이상·병리 라벨, 위험예측, "의료급/임상정확", 치료·약물 권고, 임상 임계 모방 점수.
  안전: 웰니스·연습·기록·코칭·동기, 추세/베이스라인, "전문가 상담" 권유는 질병명·이상라벨·임상임계 없을 때만.
  · 한국 MFDS(최우선, 2026-02-12 개정 지침): intended use(진단/치료/예방=의료기기) × 위해도 2축. 무채점·비진단
    스트레스관리/신체기능향상 콘텐츠는 웰니스(예시#1). 전환 트리거: 질병명·진단·환자맞춤 진단/치료,
    "구체 약물조절/치료법 피드백", 5위해도(생체적합성·침습·오작동위해·위급상황탐지·기기제어). 디지털의료제품법
    (2025-01-24 시행) 비진단 트랙=디지털의료·건강지원기기(자율신고/자율성능인증) 선택지.
  · FDA 2026 일반웰니스(2026-01-06): 질병참조·진단/예측·의료용어·"의료급"·임상임계 → 기기. WHOOP BP 경고(2025-07)
    후 카피 수정으로 closeout(2026-06) — 기술이 아니라 표현 문제.
  · EU MDR/MDCG 2019-11(Rev.1 2025-06): intended purpose가 질병 진단/치료면 MDSW. lifestyle/well-being 제외.
- 텔레메트리: 온디바이스 우선(원격 불가여도 fail-safe 잠금 동작). 외부 전송 시 건강 자가보고=특수범주(GDPR Art9/
  한국 PIPA) → 명시·세분·철회가능 동의, 원자료 음성 전송 금지, 익명 카운터만.

## C. F0/타이밍/자가보고로 본질적 불가(영구 잠금 근거)
1. 강도/loudness(SPL): 무보정 마이크+거리미상 → 불가. 편한 음고 벨트 감지 불가.
2. 충돌응력/임팩트 도즈: SPL+생체역학 필요 → 불가.
3. 내전력/발성타입(breathy·pressed·belt) 음향 구분: tilt/CPPS/EGG 필요 → 불가.
4. 성대 조직상태/실제 손상: 후두경 필요 → 불가(앱은 안전 확인·손상 감지 영구 불가).
5. 자가보고 진실성: 과소보고 무방비, 객관 override 없음.
6. "안전한 고음" vs "무리해서 도달" 구분: F0만으론 불가.

## D. 테스트 골격(손상 데이터 불필요)
A2: hardBlock1+→hardBlock+referral / soft-only→softCaution / 미응답→잠금 / validUntil 만료→재스크린.
A3: phonation==maxDuration→doseLock(경계) / sustain>maxSustain→doseLock / requiredRest 내→forcedRestLock,
   이후 allow / weeklyFreq==weeklyCap→weeklyCapLock.
A4: ceiling 초과 grace 후→pause / 사각지대: loud-at-mid-pitch는 NOT 감지(문서화).
A5: VFC≥P_VFC_HARD→hardLockout / 통증→즉시 lockout+재스크린 / VFI F1≥24·F2≥7·F3≤7 placeholder 교차→lockout /
   반복→referral / lockout vs recovery=max.
A8: 해시 버킷 안정·≤1% / config 불가→잠금 / 부작용율>halt→auto-halt.
A9: 심각 자가보고→kill+revoked / revoke가 후보 전부 재잠금·세션 graceful.
GLOBAL: belt/통성/하드글로탈은 어떤 상태에서도 unlock 안 됨.

## E. 파라미터 — 엔지니어 결정 vs 임상 사인오프
엔지니어: 피처플래그 키·ring·해시버킷, fail-safe=locked, 시작≤1%·관찰윈도(제안), 데이터모델/누적기 구조,
  재스크린 주기(초안), hardBlock 항목(가이드라인 초안), lockout 구조, AE halt(제안).
임상 사인오프: P_SURG_WEEKS, 쉰목소리 지속, hardBlock 확정, maxDuration/maxSustain/maxReps/maxTakeCount,
  weeklyCap/requiredRestHours/P_MIN_REST, P_HIGH_F0/w(F0), P_F0_CEILING/GLIDE/RAMP/GRACE,
  P_VFC_SOFT/HARD, VFI/EASE/VHI 컷오프·주기, P_LOCKOUT_HOURS 값, "심각 부작용" 정의, AE halt 임계 동의, 도구 라이선스.

## 단계 계획
- Stage 0(지금, 사인오프 불필요): GateState 가드·피처플래그(fail-safe 잠금·≤1% 카나리·킬·revoke)·ledger/policy/VFC
  하드락 승격·A2 차단 스크린·A4 디텍터·전체 테스트. **임상수치는 SafetyParams 파일에 // SIGN-OFF REQUIRED placeholder.
  전부 잠근 채 출시.**
- Stage 1(사인오프 게이트): SLP/후두과가 적신호 세트·도즈캡·증상 컷오프/주기/잠금시간·심각AE 정의 검토 후에만
  후보 2카드 kSafetySignoff 설정.
- Stage 2(enforced 카나리): 저강도 트왱+메사를 ≤1% 코호트에 플래그로, 부작용 자가보고율 P_OBS_DAYS 관찰,
  baseline+P_AE_DELTA 이내일 때만 승급.
- Stage 3: 심각 자가보고·율 위반에 auto-revoke 상시 연결.

## 구현 가능 Top5 / 잔여 위험 Top3
Top5: A2 적신호 하드락 · A3 시간/반복/휴식/빈도/지속 캡+회복 · A5 증상 하드락 · A8/A9 fail-closed 카나리·킬 ·
  A4 F0 가드(후보 2카드, 부분).
잔여 위험 Top3: SPL 부재→고강도 감지 불가 · 자가보고 의존(과소보고) · 조직상태 불가시→belt/통성/하드글로탈 영구 잠금.

## Caveats
임상수치 미발명(전부 placeholder). 17분/520m는 진동비교치이지 캡 아님. VFI 컷오프 인구의존(한국 검증 필요).
SPL 사각지대는 버그 아닌 본질적 한계(고강도 잠금의 핵심 이유). 규제는 정보 제공이며 법적 자문 아님 —
2026-02-12 MFDS 지침 원문·디지털의료·건강지원기기 지정 경로는 한국 규제 자문 확인 필요.
