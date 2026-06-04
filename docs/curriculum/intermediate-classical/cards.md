# 중급 성악 분기 IN 카드 (ADR-0015 Card 스키마)

> E-단위 산출물. 소스: `CURRICULUM.md`(블록3·4) + `docs/research/`(part 4·5·6) + `SOURCES.md`.
> 규칙: `cue` = 지시문만(ADR-0002). `feedback` 비차단·시각 전용.
> ⚠️ `[HITL]` 카드(고음·지속)는 발성안전 사인오프 전 출시 금지(VERIFICATION 참조).
> 선행: 공유 코어(블록1·2) 통과. 비증폭(어쿠스틱) 전제.

---

## 블록3 — 레지스터

### CL-01 · cover/voce chiusa 진입  [HITL]  (kind: drill · 블록3)
- cue: ["올라가며 모음을 살짝 어둡게·둥글게.", "후두 누르기 ❌(모음·공간 조정만).", "진입까지만 — 고음 무리하지 않기."]
- voicedMicroWin: ["cover 진입 글라이드 5회"]
- antiPatterns: ["후두 강제 하강(과압) ❌", "belt식 밝게 지르기 ❌", "고음 밀어붙이기 ❌"]
- anatomy: { entry:"중음 사이렌", main:"패사지오 위 모음 둥글게(진입)", cooldown:"하행 사이렌·SOVT" } · cooldownSkippable: true
- feedback: { kind: visual }  # secondo passaggio 처리(MILLER1996)
- variableAxes: { range:["중고음(진입 한정)"], glide:["사이렌"] }
- 중단 cue: ["전환부 통증·잦은 삑사리 → 중단", "고음 무리 금지(완전 cover=고급)"]

### CL-02 · aggiustamento (모음 조정)  (kind: drill · 블록3)
- cue: ["올라갈수록 /a/를 /ɔ/ 쪽으로 살짝.", "모음 고정한 채 비명 ❌.", "저음에선 과한 조정 ❌."]
- voicedMicroWin: ["모음 조정 글라이드 5회"]
- antiPatterns: ["고음에서 모음 고정 비명 ❌", "저음 과조정 ❌"]
- anatomy: { entry:"편한 모음 1회", main:"f0 상승 시 모음 중립화", cooldown:"하행 글라이드" } · cooldownSkippable: true
- feedback: { kind: visual }  # 소프라노 aggiustamento 실증(CHAN_DO2021)
- variableAxes: { vowel:["a→ɔ","e→ø"], range:["중고음"] }
- 중단 cue: ["통증·조임 → 중단"]

### CL-03 · chiaroscuro (밝음·어둠 균형)  (kind: drill · 블록3)
- cue: ["밝되 먹먹하지 않게.", "둥글되 날카롭지 않게.", "두 느낌을 *동시에*."]
- voicedMicroWin: ["chiaroscuro 균형 sustain 5초 × 3"]
- antiPatterns: ["어둡게만(먹먹) ❌", "밝게만(날카로움) ❌"]
- anatomy: { entry:"편한 음 1회", main:"ring+공간 동시 균형 탐색", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: visual }
- variableAxes: { vowel:["a","o","e"], range:["중음","±2도"] }
- 중단 cue: ["조임·통증 → 중단"]

### CL-04 · singer's formant 인지 (P4-06)  (kind: concept · 블록3)
- cue: ["울림이 모이는 지점을 화면으로 관찰.", "2.8–3.2kHz ring 맛보기.", "placement(어디에 둔다) 식 은유 ❌."]
- voicedMicroWin: ["ring 인지 sustain 5초 × 3"]
- antiPatterns: ["밝게만 짜내 날카로움 ❌", "마이크 전제로 ring 강요 ❌"]
- anatomy: { entry:"편한 음 1회", main:"singer's formant 인지·맛보기", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: visual }  # 비증폭 투과력(SUNDBERG1987)
- variableAxes: { range:["중음","±2도"] }
- 중단 cue: ["조임·통증 → 중단"]

## 블록4 — 텍스트·딕션·곡

### CL-05 · legato  (kind: drill · 블록4)
- cue: ["음과 음 사이 끊김 없이.", "자음으로 라인 끊지 않기.", "한 호흡 안에서 흐르게."]
- voicedMicroWin: ["legato 라인 구절 3회"]
- antiPatterns: ["음마다 새 onset(끊김) ❌", "자음 과타격 ❌"]
- anatomy: { entry:"5음 글라이드", main:"끊김 없는 라인(자음 흐름)", cooldown:"하행 글라이드" } · cooldownSkippable: true
- feedback: { kind: visual }
- variableAxes: { range:["중음","±3도"] }
- 중단 cue: ["피로 → 중단"]

### CL-06 · 이탈리아어 딕션  (kind: drill · 블록4)
- cue: ["순수 5모음(a·e·i·o·u) 또렷이.", "이중자음 길게.", "곡과 함께(고립 ❌)."]
- voicedMicroWin: ["이탈리아어 구절 딕션 3회"]
- antiPatterns: ["한국어식 모음 치환 ❌", "딕션만 따로 연습 ❌"]
- anatomy: { entry:"모음 말하기", main:"순수모음·이중자음 적용(곡 안)", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: visual }
- variableAxes: { sessionPos:["본"] }
- 중단 cue: ["피로 → 중단"]

### CL-07 · 독일어 딕션  (kind: drill · 블록4)
- cue: ["움라우트(ü·ö) 입모양 정확히.", "자음군·종성 또렷이.", "곡과 함께."]
- voicedMicroWin: ["독일어 구절 딕션 3회"]
- antiPatterns: ["움라우트 단순모음 치환 ❌", "자음군 뭉개기 ❌"]
- anatomy: { entry:"모음 말하기", main:"움라우트·자음군 적용(곡 안)", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: visual }
- variableAxes: { sessionPos:["본"] }
- 중단 cue: ["피로 → 중단"]

### CL-08 · messa di voce 기초  [HITL]  (kind: drill · 블록4)
- cue: ["한 음에서 천천히 부풀렸다(약→강) 줄이기(강→약).", "*기초*만 — 무리한 강세 ❌.", "편한 중음역에서."]
- voicedMicroWin: ["messa di voce 기초 곡선 3회"]
- antiPatterns: ["고음에서 풀 강세 ❌(고급)", "급격한 크레셴도로 짜내기 ❌"]
- anatomy: { entry:"편한 음 sustain", main:"약→강→약 다이내믹 기초", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: visual }  # 호흡·성대 정밀 제어(MILLER1996)
- variableAxes: { range:["편한 중음(기초 한정)"] }
- 중단 cue: ["통증·압박감 → 중단", "고음 풀 messa 시도 금지(고급)"]

### CL-09 · 레퍼토리 (아리아/리트 구절)  (kind: song · 블록4)
- cue: ["legit 클래식 구절 맑게·둥글게.", "legato 유지.", "풀 covered 고음·풀 messa 구절 ❌(고급)."]
- voicedMicroWin: ["아리아/리트 구절 적용 1회"]
- antiPatterns: ["고난도 고음 아리아 무리 ❌(고급)", "벨트식 밝게 ❌"]
- anatomy: { entry:"테크닉 1분", main:"legit 클래식 구절 적용", cooldown:"하행 글라이드·SOVT" } · cooldownSkippable: true
- feedback: { kind: visual }
- variableAxes: { difficulty:["리트 구절","쉬운 아리아 구절"] }
- 중단 cue: ["통증·다음날 쉰목 → 중단·휴식"]
