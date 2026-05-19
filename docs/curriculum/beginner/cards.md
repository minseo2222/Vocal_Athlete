# 초급 13 IN 카드 (ADR-0015 Card 스키마)

> C1 산출물. 소스: `CURRICULUM.md` §5 + 아카이브 커리큘럼 페다고지(절차·안티패턴·중단 cue).
> 규칙: `cue` = 지시문만(왜/동기 없음, ADR-0002). `voicedMicroWin` 필수. `feedback` 비차단.
> **발성안전 검토 대상** — 중단 cue(어지럼·통증 등)는 운동 지시이며 *필수*.
> 변주축: 블록 진행에 따라 확대(ADR-0006 blocked→variable). 곡/멜로디축은 초급 없음.

---

### CARD-01 · 자세 정렬 + Body Mapping  (kind: drill · 블록1)
- cue: ["바닥/의자에 편하게.", "턱·어깨 힘 빼기.", "6점 균형 의식만 — 움직이지 않기."]
- voicedMicroWin: ["끝에 편한 /m/ 3회(각 2–3초)"]
- antiPatterns: ["어깨 들기 ❌", "허리 과신전 ❌", "턱 당겨 누르기 ❌"]
- anatomy: { entry:"가벼운 신체 스캔", main:"6점 정렬 관찰", cooldown:"느린 호흡 3회" } · cooldownSkippable: true
- feedback: { kind: none }
- variableAxes: { sessionPos:["워밍업","본"] }
- 중단 cue: ["어지럼·저림 → 즉시 일어남"]

### CARD-02 · 흉곽-복부 결합 호흡  (kind: drill · 블록1)
- cue: ["코로 천천히 들이쉬고 늑골·배가 같이 부풀게.", "배만으로 ❌, 늑골도.", "내쉴 때 어깨 ❌."]
- voicedMicroWin: ["voiced 한숨 /h→a/ 3회(음정 안 정함)"]
- antiPatterns: ["어깨 올려 들숨 ❌", "배만 부풀리기 ❌", "내쉴 때 가슴 꺼짐 ❌"]
- anatomy: { entry:"무음 호흡 관찰", main:"늑골-복부 결합 호흡", cooldown:"느린 날숨 연장" } · cooldownSkippable: true
- feedback: { kind: none }
- variableAxes: { sessionPos:["워밍업","본"] }
- 중단 cue: ["과호흡·어지럼 → 즉시 일반 호흡으로 복귀"]

### CARD-03 · 턱·혀·목 긴장 해소  (kind: drill · 블록1)
- cue: ["턱을 무겁게 떨어뜨리기.", "혀 뿌리 내려놓기.", "silent ah 후 가벼운 voiced ah."]
- voicedMicroWin: ["가벼운 /a/ 3회(편한 중음)"]
- antiPatterns: ["턱 앞으로 내밀기 ❌", "혀 뒤로 당겨 막기 ❌", "목 앞 힘주기 ❌"]
- anatomy: { entry:"턱·혀 풀기", main:"silent ah → voiced ah", cooldown:"하품-한숨 1회" } · cooldownSkippable: true
- feedback: { kind: none }
- variableAxes: { sessionPos:["워밍업","본"] }
- 중단 cue: ["통증 → 즉시 중단"]

### CARD-04 · 가벼운 첫 소리  (kind: drill · 블록1→2)
- cue: ["치지 말고 숨을 흘려보내듯 /h/.", "/h/에 가볍게 소리 얹기 → /m/.", "크게 ❌, 편하게."]
- voicedMicroWin: ["/h/-led 부드러운 onset 5회"]
- antiPatterns: ["딱 끊어 치는 글로털 onset ❌", "숨만 새는 과기식 ❌", "크게 지르기 ❌"]
- anatomy: { entry:"무성 호기 3회", main:"/h/→/m/ easy onset", cooldown:"가벼운 /m/ 하행" } · cooldownSkippable: true
- feedback: { kind: none }
- variableAxes: { range:["편한 중음","약간 낮게"], sessionPos:["워밍업","본"] }
- 중단 cue: ["어지럼 → 즉시 중단"]

### CARD-05 · 골/공기 전도 자기청취  (kind: drill · 블록1, 블록4 심화)
- cue: ["짧게 소리 내고 멈춰 듣기.", "내 느낌 말고 화면 곡선을 보기.", "(블록4) 균형/과기식/과압착 중 어디로 보이는지 표시."]
- voicedMicroWin: ["편한 음 2–3초 발성 후 시각 곡선 확인 3회"]
- antiPatterns: ["곡선 잘 보이게 더 누르기 ❌", "귀로만 판단 ❌"]
- anatomy: { entry:"짧은 발성", main:"발성→시각 곡선 대조", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: visualPitch }   # 시각 전용(골전도 착각 차단). 블록4: aiClassify 정보 표시(막지 않음)
- variableAxes: { range:["중음","약간 높/낮"], vowel:["a","i","u"] }
- 중단 cue: ["통증 → 즉시 중단"]

### CARD-06 · 빨대 발성  (P3-13 · kind: drill · 블록1 맛보기→블록2 메인)
- cue: ["5–6mm 빨대를 입술 안에 부드럽게.", "이로 물지 마세요.", "빨대로 /u/ 5초, 편한 중음.", "어지러우면 즉시 멈추세요."]
- voicedMicroWin: ["빨대 /u/ sustain 5초 × 3"]
- antiPatterns: ["빨대 이로 물기 ❌", "어깨 들기 ❌", "짜내는 큰 소리 ❌", "음정 크게 흔들기 ❌", "5분 초과 ❌"]
- anatomy: { entry:"무음 빨대 호기 1회", main:"빨대 /u/ sustain 반복", cooldown:"빨대 빼고 /u/ 1회" } · cooldownSkippable: true
- feedback: { kind: visualPitch, nudge: { deviation:"±30c 초과 지속", tip:"음정을 한 곳에 편하게" } }   # 비차단
- variableAxes: { range:["중음","±2도"], vowel:["u","a"] }
- 중단 cue: ["어지럼·시야 흐림 → 즉시 중단", "가슴 통증 → 즉시 중단"]

### CARD-07 · 립 트릴  (P3-17 · kind: drill · 블록2)
- cue: ["입술 힘 빼고 부르르 떨기.", "일정하게 유지.", "편한 음으로 5초."]
- voicedMicroWin: ["립 트릴 sustain 5초 × 3, 가벼운 글라이드 1회"]
- antiPatterns: ["입술 꽉 조이기 ❌", "볼에 과한 힘 ❌", "트릴 끊김 방치 ❌"]
- anatomy: { entry:"무성 입술 트릴", main:"유성 트릴 sustain·글라이드", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: visualPitch, nudge: { deviation:"±30c 초과 지속", tip:"한 음에 편하게 머무르기" } }
- variableAxes: { range:["중음","±2도"], glide:["sustain","작은 5도 글라이드"] }
- 중단 cue: ["어지럼 → 즉시 중단"]

### CARD-08 · 허밍 /m/ · NG-hum /ŋ/  (P3-19/20 · kind: drill · 블록3)
- cue: ["입 다물고 /m/ 콧대 진동 느끼기.", "짜내지 말기.", "/ŋ/로 바꿔 같은 느낌."]
- voicedMicroWin: ["/m/ 5초 × 2, /ŋ/ 5초 × 2"]
- antiPatterns: ["목으로 누르기 ❌", "입술 꽉 다물어 압력 ❌", "비음만 과하게 ❌"]
- anatomy: { entry:"가벼운 /m/", main:"/m/·/ŋ/ sustain·작은 글라이드", cooldown:"하행 허밍" } · cooldownSkippable: true
- feedback: { kind: visualPitch, nudge: { deviation:"±30c 초과 지속", tip:"콧대 진동 유지하며 한 음" } }
- variableAxes: { range:["중음","±3도"], vowel:["m","ŋ"], glide:["sustain","글라이드"] }
- 중단 cue: ["통증·어지럼 → 즉시 중단"]

### CARD-09 · 물저항 빨대  (P3-15 · kind: drill · 블록3 · 선택/회복)
- cue: ["컵 물에 빨대 1–2cm 담그기.", "버블 일정하게.", "약한 강도로 5초."]
- voicedMicroWin: ["물 버블 발성 5초 × 3"]
- antiPatterns: ["빨대 깊게 담가 과저항 ❌", "버블 폭주 ❌", "어깨 들기 ❌"]
- anatomy: { entry:"무음 버블 1회", main:"유성 물 버블 반복", cooldown:"빨대 빼고 /u/ 1회" } · cooldownSkippable: true
- feedback: { kind: visualPitch }
- variableAxes: { range:["중음"], glide:["sustain"] }
- 중단 cue: ["천식·호흡기·어지럼 이력 → 다른 SOVT로 대체", "호흡곤란·쌕쌕거림·어지럼 → 즉시 중단"]

### CARD-10 · 균형 발성 찾기  (P3-07 · kind: drill · 블록4)
- cue: ["숨 너무 새지도(과기식) 꽉 막지도(과압착) 않게.", "그 사이 편한 지점에서 5초.", "짜내지 말기."]
- voicedMicroWin: ["편한 음 sustain 5초 × 4"]
- antiPatterns: ["숨 많이 섞인 과기식 ❌", "강한 어택·압박 과압착 ❌", "음량으로 해결하려 ❌"]
- anatomy: { entry:"가벼운 onset", main:"균형 지점 탐색 sustain", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: aiClassify }   # 과기식/균형/과압착 정보 표시, 막지 않음(ADR-0002)
- variableAxes: { range:["중음","±3도"], vowel:["a","i","u"] }
- 중단 cue: ["통증 → 즉시 중단"]

### CARD-11 · Self-Imitation Drill  (kind: drill · 블록5)
- cue: ["편한 음 2초 녹음.", "재생을 듣기.", "방금 그 소리를 다시 따라하기.", "5회 반복."]
- voicedMicroWin: ["자기 녹음 모방 발성 5회"]
- antiPatterns: ["원음 무시하고 새 음 ❌", "크게 과장 ❌"]
- anatomy: { entry:"편한 음 1회", main:"녹음→재생→재모방→시각 비교 5회", cooldown:"가벼운 /m/" } · cooldownSkippable: true
- feedback: { kind: selfImitation, nudge: { deviation:"원음 대비 ±50c 초과", tip:"방금 들은 그 높이로" } }
- variableAxes: { range:["중음","±3도"], vowel:["a","u"] }
- 중단 cue: ["피로·어지럼 → 즉시 단순 sustain로 복귀"]

### CARD-12 · 시각 피드백 피치 매칭  (kind: drill · 블록5)
- cue: ["목표선을 보며 그 높이로 소리내기.", "곡선을 목표선에 붙이기.", "빗나가도 계속 — 다음에 가까이."]
- voicedMicroWin: ["목표음 매칭 발성 5회(각 3–5초)"]
- antiPatterns: ["곡선 맞추려 음량 키우기 ❌", "숨 참고 버티기 ❌"]
- anatomy: { entry:"가벼운 글라이드", main:"피아노롤 목표선 매칭", cooldown:"하행 글라이드 1회" } · cooldownSkippable: true
- feedback: { kind: visualPitch, nudge: { deviation:"±30c 초과 지속", tip:"천천히 목표선으로" } }   # 시각 전용·비차단
- variableAxes: { range:["중음","±3도","약간 확장"], vowel:["a","i","u"], glide:["고정음","작은 글라이드"] }
- 중단 cue: ["통증·어지럼 → 즉시 중단"]

### CARD-13 · 표준 샘플 녹음 SOP  (kind: standardSample · 슬롯 #1 / #~25 / #48)
- cue: ["조용한 곳에서.", "/a/ /i/ /u/ 각 5초.", "표준 문장 1줄 읽기.", "/a/로 저→고→저 한 호흡."]
- voicedMicroWin: ["지속 모음 3종 + 글라이드 녹음(전체가 유성)"]
- antiPatterns: ["매번 다른 거리·환경 ❌", "베스트 테이크만 남기기 ❌(평소대로)"]
- anatomy: { entry:"환경 확인", main:"고정 과제 녹음", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: abCompare }   # 전후 시각 A/B(스펙트로그램/피치), 정보 제공·비차단
- variableAxes: { }   # 고정 과제 — 변주 없음(비교 가능성이 핵심)
- 중단 cue: ["통증·어지럼 → 즉시 중단"]

---

## 검토 요청 (HITL — 발성안전)

특히 확인 바랍니다:
1. **중단 cue 충분/정확한가** — CARD-06(빨대: 어지럼·가슴통증), CARD-09(물저항: 천식·호흡기 이력 대체·호흡곤란), CARD-02(과호흡). 누락된 위험 신호?
2. **운동 지시 cue에 정당화 섞이지 않았나** (무납득 ADR-0002 — "왜"가 들어간 문구 있으면 지적).
3. **유성 마이크로윈이 모든 카드에 ≥1** (무성 레슨 0) — OK?
4. CARD-09 물저항을 *블록3 선택/회복*로 둔 것, CARD-06 빨대 *블록1 맛보기→블록2 메인* 분리 — 페다고지상 맞나?
5. 변주축이 블록 따라 과하거나 부족한 곳?
