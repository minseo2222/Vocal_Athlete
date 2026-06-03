# 중급 코어 IN 카드 (ADR-0015 Card 스키마)

> C-단위 산출물. 소스: `CURRICULUM.md`(블록1·2) + `docs/research/`(part 3·4·5) + `SOURCES.md`.
> 규칙: `cue` = 지시문만(왜/동기 없음, ADR-0002). `voicedMicroWin` 필수. `feedback` 비차단·시각 전용.
> 안전 cue(어지럼·호흡곤란 등)는 운동 지시이며 *필수*. **발성안전 검토 대상**(VERIFICATION 참조).
> 변주축: blocked→variable 내부 상승(ADR-0006). belt/cover/곡은 코어 밖(분기).

---

### IC-01 · 균형 발성 (P3-07)  (kind: drill · 블록1)
- cue: ["짜내지도 새지도 않게.", "그 사이 편한 지점에서 5초.", "화면 곡선으로 확인."]
- voicedMicroWin: ["균형 지점 sustain 5초 × 4"]
- antiPatterns: ["목 조여 짜내기(과압착) ❌", "숨 새며 흐릿하게(과기식) ❌"]
- anatomy: { entry:"가벼운 onset", main:"과기식↔균형↔과압착 탐색", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: visual }  # 3분류 정보 표시, 막지 않음(KOR_KIM2025)
- variableAxes: { range:["중음","±2도"], vowel:["a","i","u"] }
- 중단 cue: ["통증·이물감 → 즉시 중단"]

### IC-02 · SOVT 세트 (빨대/립트릴/허밍·NG/물저항)  (kind: drill · 블록1)
- cue: ["빨대로 /u/ 또는 립 트릴 5초.", "이로 물지 마세요.", "일정한 굵기 유지.", "어지러우면 즉시 멈추세요."]
- voicedMicroWin: ["SOVT sustain 5초 × 3"]
- antiPatterns: ["이로 물기 ❌", "짜내기 ❌", "과호기로 어지럼 ❌"]
- anatomy: { entry:"무음 호기 1회", main:"SOVT sustain·가벼운 글라이드", cooldown:"빨대 빼고 /u/ 1회" } · cooldownSkippable: true
- feedback: { kind: none }
- variableAxes: { range:["중음","±3도"], glide:["sustain","작은 글라이드"] }
- 중단 cue: ["어지럼·시야흐림·가슴통증 → 즉시 중단", "천식·호흡기 이력 시 물저항 대신 다른 SOVT"]

### IC-03 · VFE 4과제 (P3-08~12, Stemple)  (kind: drill · 블록1)
- cue: ["① 가장 편한 음 최대한 길게(knoll sustain).", "② /o/로 저→고 부드럽게.", "③ 고→저 부드럽게.", "④ 음별 최대 지속 — 짜내지 않게."]
- voicedMicroWin: ["VFE 4과제 각 1회(저충격)"]
- antiPatterns: ["크게·세게 ❌(저충격 우선)", "지속시간 욕심으로 짜내기 ❌"]
- anatomy: { entry:"편한 음 1회", main:"knoll→글라이드→지속 4과제", cooldown:"가벼운 /m/" } · cooldownSkippable: true
- feedback: { kind: none }  # 지구력 토대(STEMPLE_VFE RCT)
- variableAxes: { range:["편한 중음","약간 확장"] }
- 중단 cue: ["통증·피로 누적 → 중단"]

### IC-04 · 온셋 유형 (P3-01~05)  (kind: drill · 블록1)
- cue: ["/h/로 숨 흘려보내듯 시작.", "/h/에 가볍게 소리 얹기.", "치지 말고 — 단 균형 onset이 유일 정답은 아님(편하게 탐색)."]
- voicedMicroWin: ["easy onset 5회"]
- antiPatterns: ["딱딱한 글로탈 어택 습관화 ❌(스타일 의도 외)", "과한 기식 ❌"]
- anatomy: { entry:"무성 호기 3회", main:"hard/balanced/breathy 대조", cooldown:"가벼운 /m/ 하행" } · cooldownSkippable: true
- feedback: { kind: visual }
- variableAxes: { onset:["balanced","breathy"], range:["중음"] }
- 중단 cue: ["성대 피로감 → 중단"]

### IC-05 · Appoggio 정교화 (§4.3)  (kind: drill · 블록1)
- cue: ["들숨 자세(흉곽 확장)를 노래하는 동안 유지.", "내쉴 때 한꺼번에 무너뜨리지 않기."]
- voicedMicroWin: ["흡기자세 유지 발성 5초 × 3"]
- antiPatterns: ["들숨 후 즉시 흉곽 붕괴 ❌", "배에 과도한 힘 ❌"]
- anatomy: { entry:"늑골 확장 인지", main:"흡기자세 유지 호기 antagonism", cooldown:"느린 날숨 연장" } · cooldownSkippable: true
- feedback: { kind: none }  # 초급서 미룬 길항 균형(MILLER1996)
- variableAxes: { range:["중음","±2도"] }
- 중단 cue: ["과호흡·어지럼 → 일반 호흡으로 복귀"]

### IC-06 · SOVT→개모음 전이 (P4-05)  (kind: drill · 블록2)
- cue: ["빨대 /u/ 5초.", "빨대 빼고 같은 음 개모음(/a/)으로 이어가기.", "느낌 유지(carryover)."]
- voicedMicroWin: ["SOVT→개모음 carryover 5회"]
- antiPatterns: ["빨대 뗀 순간 짜내기 ❌"]
- anatomy: { entry:"빨대 /u/ 1회", main:"SOVT→개모음 전이 반복", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: visual }
- variableAxes: { vowel:["a","o","e"], range:["중음","±2도"] }
- 중단 cue: ["이물감·통증 → 중단"]

### IC-07 · 모음조정·포먼트튜닝 기초 (P4-09/10)  (kind: drill · 블록2)
- cue: ["같은 음에서 모음을 /i/↔/a/↔/u/로 천천히 바꾸기.", "밝기·울림 변화를 화면으로 관찰.", "(고소프라노 조정·belt 방향은 여기서 안 함)."]
- voicedMicroWin: ["모음 전환 sustain 5회"]
- antiPatterns: ["모음마다 후두 들썩임 ❌"]
- anatomy: { entry:"편한 음 1회", main:"R1:f0 관계 *기초* 관찰", cooldown:"하행 글라이드" } · cooldownSkippable: true
- feedback: { kind: visual }  # 포먼트 기초 개념(BOZEMAN2013)
- variableAxes: { vowel:["i","a","u"], range:["중음","±2도"] }
- 중단 cue: ["통증 → 중단"]

### IC-08 · 명료도↔효율 policy 개념 (P4-13)  (kind: concept · 블록2)
- cue: ["같은 문장을 또렷하게 vs 편하게 두 번.", "차이를 화면·감각으로 관찰.", "정답은 장르·증폭에 따라 다름 — 지금은 *관찰만*."]
- voicedMicroWin: ["명료/효율 대조 발성 각 3회"]
- antiPatterns: ["과한 자음 타격으로 후두 긴장 ❌"]
- anatomy: { entry:"편한 발성", main:"명료도↔효율 대조 관찰", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: visual }
- variableAxes: { sessionPos:["워밍업","본"] }
- 중단 cue: ["성대 피로 → 중단"]

### IC-09 · 후두 높이 인지 (P4-07)  (kind: concept · 블록2)
- cue: ["삼킬 때(후두↑)와 하품 시작(후두↓) 느낌 비교.", "노래는 그 *사이* 편한 높이.", "(클래식 저·CCM 고 타깃은 분기에서)."]
- voicedMicroWin: ["중립 후두높이 sustain 5초 × 3"]
- antiPatterns: ["후두 강제로 누르기 ❌", "강제로 들기 ❌"]
- anatomy: { entry:"후두 높이 인지", main:"중립 높이 통제변수 관찰", cooldown:"느린 호흡" } · cooldownSkippable: true
- feedback: { kind: none }
- variableAxes: { range:["중음"] }
- 중단 cue: ["조임·통증 → 중단"]

### IC-10 · 비음 분리 (P4-12)  (kind: drill · 블록2)
- cue: ["/m/ 후 /a/로 — 비음이 빠지는지 관찰.", "트웽 = 입 안 좁힘(밝게), 콧소리 ❌.", "의도 nasality와 비의도 nasalization 구분."]
- voicedMicroWin: ["/m/→/a/ 비음 분리 5회"]
- antiPatterns: ["모든 모음에 콧소리 새기 ❌"]
- anatomy: { entry:"가벼운 /m/", main:"비음 ↔ 비비음 대조", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: visual }  # 트웽 협착 구조(GIBIAT2024) — 운동 지시로만
- variableAxes: { vowel:["m","a","i"], range:["중음"] }
- 중단 cue: ["통증 → 중단"]

### IC-11 · 패사지오 인지 (P5-03/06)  (kind: concept · 블록2)
- cue: ["저음→고음 사이렌으로 천천히.", "소리 질감이 바뀌는 *구간*을 관찰(없애려 하지 않기).", "(믹스·belt·cover 처리는 분기에서)."]
- voicedMicroWin: ["사이렌 글라이드 3회"]
- antiPatterns: ["전환 구간에서 힘으로 밀어붙이기 ❌"]
- anatomy: { entry:"가벼운 글라이드", main:"primo/secondo passaggio 존재·관찰", cooldown:"하행 사이렌 1회" } · cooldownSkippable: true
- feedback: { kind: visual }  # M0–M3 메커니즘(ROUBEAU2009) — 인지 수준만
- variableAxes: { range:["중음","±3도","약간 확장"], glide:["사이렌","작은 글라이드"] }
- 중단 cue: ["전환부 통증·삑사리 반복 → 중단"]
