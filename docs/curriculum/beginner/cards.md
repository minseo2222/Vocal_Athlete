# 초급 18 IN 카드 (ADR-0015 Card 스키마)

> C1/R2 산출물. 소스: `CURRICULUM.md` §5 + 아카이브 커리큘럼 페다고지 + `docs/adr/0018-beginner-learning-transfer-update.md`.
> 규칙: `cue` = 지시문만(왜/동기 없음, ADR-0002). `voicedMicroWin` 필수. `feedback` 비차단.
> **발성안전 검토 대상** — 중단 cue(어지럼·통증 등)는 운동 지시이며 *필수*.
> 변주축: 블록 진행에 따라 확대(ADR-0006 blocked→variable). 곡/레퍼토리는 초급 없음. 단 R2부터 2–3음 contour, 4박 pulse, 한국어 음절 bridge는 낮은 부하 전이 카드로 포함.

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

### CARD-03 · 턱·혀·목 긴장 해소  (kind: drill · 블록1/2)
- cue: ["턱을 무겁게 떨어뜨리기.", "혀 뿌리 내려놓기.", "silent ah 후 가벼운 voiced ah."]
- voicedMicroWin: ["가벼운 /a/ 3회(편한 중음)"]
- antiPatterns: ["턱 앞으로 내밀기 ❌", "혀 뒤로 당겨 막기 ❌", "목 앞 힘주기 ❌"]
- anatomy: { entry:"턱·혀 풀기", main:"silent ah → voiced ah", cooldown:"하품-한숨 1회" } · cooldownSkippable: true
- feedback: { kind: none }
- variableAxes: { sessionPos:["워밍업","본"] }
- 중단 cue: ["통증 → 즉시 중단"]

### CARD-04 · 가벼운 첫 소리  (kind: drill · 블록1/2/4)
- cue: ["치지 말고 숨을 흘려보내듯 /h/.", "/h/에 가볍게 소리 얹기 → /m/.", "크게 ❌, 편하게."]
- voicedMicroWin: ["/h/-led 부드러운 onset 5회"]
- antiPatterns: ["딱 끊어 치는 글로털 onset ❌", "숨만 새는 과기식 ❌", "크게 지르기 ❌"]
- anatomy: { entry:"무성 호기 3회", main:"/h/→/m/ easy onset", cooldown:"가벼운 /m/ 하행" } · cooldownSkippable: true
- feedback: { kind: none }
- variableAxes: { range:["편한 중음","약간 낮게"], sessionPos:["워밍업","본"] }
- 중단 cue: ["어지럼 → 즉시 중단"]

### CARD-05 · 골/공기 전도 자기청취  (kind: drill · 블록1/4)
- cue: ["짧게 소리 내고 멈춰 듣기.", "내 느낌 말고 화면 곡선을 보기.", "(블록4) 균형/과기식/과압착 중 어디로 보이는지 표시."]
- voicedMicroWin: ["편한 음 2–3초 발성 후 시각 곡선 확인 3회"]
- antiPatterns: ["곡선 잘 보이게 더 누르기 ❌", "귀로만 판단 ❌"]
- anatomy: { entry:"짧은 발성", main:"발성→시각 곡선 대조", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: visualPitch } # 시각 전용. 블록4: 정보성 분류 후보, V1 정식 AI 라벨 없음.
- variableAxes: { range:["중음","약간 높/낮"], vowel:["a","i","u"] }
- 중단 cue: ["통증 → 즉시 중단"]

### CARD-06 · 빨대 발성  (kind: drill · 블록1 맛보기→블록2 메인)
- cue: ["5–6mm 빨대를 입술 안에 부드럽게.", "이로 물지 마세요.", "빨대로 /u/ 5초, 편한 중음.", "어지러우면 즉시 멈추세요."]
- voicedMicroWin: ["빨대 /u/ sustain 5초 × 3"]
- antiPatterns: ["빨대 이로 물기 ❌", "어깨 들기 ❌", "짜내는 큰 소리 ❌", "음정 크게 흔들기 ❌", "5분 초과 ❌"]
- anatomy: { entry:"무음 빨대 호기 1회", main:"빨대 /u/ sustain 반복", cooldown:"빨대 빼고 /u/ 1회" } · cooldownSkippable: true
- feedback: { kind: visualPitch, nudge: { deviation:"±30c 초과 지속", tip:"음정을 한 곳에 편하게" } }
- variableAxes: { range:["중음","±2도"], vowel:["u","a"] }
- 중단 cue: ["어지럼·시야 흐림 → 즉시 중단", "가슴 통증 → 즉시 중단"]

### CARD-07 · 립 트릴  (kind: drill · 블록2)
- cue: ["입술 힘 빼고 부르르 떨기.", "일정하게 유지.", "편한 음으로 5초."]
- voicedMicroWin: ["립 트릴 sustain 5초 × 3, 가벼운 글라이드 1회"]
- antiPatterns: ["입술 꽉 조이기 ❌", "볼에 과한 힘 ❌", "트릴 끊김 방치 ❌"]
- anatomy: { entry:"무성 입술 트릴", main:"유성 트릴 sustain·글라이드", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: visualPitch, nudge: { deviation:"±30c 초과 지속", tip:"한 음에 편하게 머무르기" } }
- variableAxes: { range:["중음","±2도"], glide:["sustain","작은 5도 글라이드"] }
- 중단 cue: ["어지럼 → 즉시 중단"]

### CARD-08 · 허밍 /m/ · NG-hum /ŋ/  (kind: drill · 블록2/3)
- cue: ["입 다물고 /m/ 콧대 진동 느끼기.", "짜내지 말기.", "/ŋ/로 바꿔 같은 느낌."]
- voicedMicroWin: ["/m/ 5초 × 2, /ŋ/ 5초 × 2"]
- antiPatterns: ["목으로 누르기 ❌", "입술 꽉 다물어 압력 ❌", "비음만 과하게 ❌"]
- anatomy: { entry:"가벼운 /m/", main:"/m/·/ŋ/ sustain·작은 글라이드", cooldown:"하행 허밍" } · cooldownSkippable: true
- feedback: { kind: visualPitch, nudge: { deviation:"±30c 초과 지속", tip:"콧대 진동 유지하며 한 음" } }
- variableAxes: { range:["중음","±3도"], vowel:["m","ŋ"], glide:["sustain","글라이드"] }
- 중단 cue: ["통증·어지럼 → 즉시 중단"]

### CARD-09 · 물저항 빨대  (kind: drill · 블록3 · 선택/회복)
- cue: ["컵 물에 빨대 1–2cm 담그기.", "버블 일정하게.", "약한 강도로 5초."]
- voicedMicroWin: ["물 버블 발성 5초 × 3"]
- antiPatterns: ["빨대 깊게 담가 과저항 ❌", "버블 폭주 ❌", "어깨 들기 ❌"]
- anatomy: { entry:"무음 버블 1회", main:"유성 물 버블 반복", cooldown:"빨대 빼고 /u/ 1회" } · cooldownSkippable: true
- feedback: { kind: visualPitch }
- variableAxes: { range:["중음"], glide:["sustain"] }
- 중단 cue: ["천식·호흡기·어지럼 이력 → 다른 SOVT로 대체", "호흡곤란·쌕쌕거림·어지럼 → 즉시 중단"]

### CARD-10 · 균형 발성 찾기  (kind: drill · 블록4)
- cue: ["숨 너무 새지도(과기식) 꽉 막지도(과압착) 않게.", "그 사이 편한 지점에서 5초.", "짜내지 말기."]
- voicedMicroWin: ["편한 음 sustain 5초 × 4"]
- antiPatterns: ["숨 많이 섞인 과기식 ❌", "강한 어택·압박 과압착 ❌", "음량으로 해결하려 ❌"]
- anatomy: { entry:"가벼운 onset", main:"균형 지점 탐색 sustain", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: visualPitch } # V1: 3분류 발성 AI 정식 표시 없음.
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

### CARD-12 · 상대 목표선 피치 매칭  (kind: drill · 블록5)
- cue: ["기준 허밍을 먼저 2초.", "끝난 뒤 곡선 보기.", "목표선은 오늘의 편한 높이.", "빗나가도 작게 다시."]
- voicedMicroWin: ["기준 허밍 + 목표선 매칭 5회(각 3–5초)"]
- antiPatterns: ["곡선 맞추려 음량 키우기 ❌", "숨 참고 버티기 ❌", "고정 Hz에 몸 맞추기 ❌"]
- anatomy: { entry:"가벼운 글라이드", main:"기준 F0→상대 목표선→확인형 피드백", cooldown:"하행 글라이드 1회" } · cooldownSkippable: true
- feedback: { kind: visualPitch, mode:"deferred", target:"relativeTargetMode", nudge:{ deviation:"±30c 초과 지속", tip:"작게 다시" } }
- variableAxes: { range:["중음","±3도","약간 확장"], vowel:["a","i","u"], glide:["고정음","작은 글라이드"] }
- 중단 cue: ["통증·어지럼 → 즉시 중단"]

### CARD-13 · 표준 샘플 녹음 SOP  (kind: standardSample · 슬롯 Day 1 / Day 24 / Day 48)
- cue: ["조용한 곳에서.", "/a/ /i/ /u/ 각 3초.", "표준 문장 1줄 읽기.", "/a/로 작은 저→고→저 글라이드.", "듣고 tone tag 하나 선택."]
- voicedMicroWin: ["지속 모음 3종 + 글라이드 녹음(전체가 유성)"]
- antiPatterns: ["매번 다른 거리·환경 ❌", "베스트 테이크만 남기기 ❌(평소대로)"]
- anatomy: { entry:"환경 확인", main:"고정 과제 녹음", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: abCompare, namespaces:["baseline","midpoint","graduation"], score:false } # 세 시점은 독립 슬롯·take ID
- variableAxes: { milestone:["Day 1 baseline","Day 24 midpoint","Day 48 graduation"] } # 과제는 고정, 저장 namespace만 분리
- storage: `CARD-13_baseline_take_01`, `CARD-13_midpoint_take_01`, `CARD-13_graduation_take_01` — Day 1 take가 Day 24/48 제한을 소비하지 않는다.
- 중단 cue: ["통증·어지럼 → 즉시 중단"]

### CARD-14 · 듣고-상상하고-허밍하기  (kind: drill · 블록1)
- cue: ["기준음을 듣기.", "2초 조용히 떠올리기.", "입 다물고 /m/으로 따라가기.", "끝난 뒤 곡선 보기."]
- voicedMicroWin: ["듣기→상상→허밍 5회"]
- antiPatterns: ["바로 따라 치기 ❌", "큰 소리로 맞추기 ❌", "화면만 보고 끌어올리기 ❌"]
- anatomy: { entry:"기준음 듣기", main:"청음→내적 상상→허밍 전이", cooldown:"가벼운 /m/ 하행" } · cooldownSkippable: true
- feedback: { kind: visualPitch, mode:"deferred" }
- variableAxes: { range:["편한 중음","약간 낮게"], vowel:["m","u"] }
- 중단 cue: ["목 피로 → 허밍 생략하고 듣기만"]

### CARD-15 · 4박 pulse 리듬 허밍  (kind: drill · 블록2/5)
- cue: ["화면 4박을 보기.", "손가락으로 먼저 탭.", "/m/으로 음-음-쉼-음.", "빨라지면 작게 쉬기."]
- voicedMicroWin: ["4박 pulse에 맞춘 리듬 허밍 5회"]
- antiPatterns: ["tempo 경쟁 ❌", "소리 크게 밀기 ❌", "박자 놓쳤다고 즉시 재시작 집착 ❌"]
- anatomy: { entry:"4박 pulse 보기", main:"tap→/m/ 리듬 허밍", cooldown:"느린 호흡 3회" } · cooldownSkippable: true
- feedback: { kind: rhythmNudge, scoring:false }
- variableAxes: { tempo:["느림","조금 느림"], pattern:["음-음-쉼-음","음-쉼-음-음"] }
- 중단 cue: ["어지럼·호흡 급함 → 탭만 수행"]

### CARD-16 · 2–3음 contour mimic  (kind: drill · 블록3/5)
- cue: ["세 음 모양 듣기.", "낮음→높음→낮음 모양만 따라가기.", "/m/ 또는 /u/로 작게.", "음 이름은 보지 않기."]
- voicedMicroWin: ["2–3음 contour 허밍 5회"]
- antiPatterns: ["정확한 도레미 맞히기 집착 ❌", "고음으로 끌어올리기 ❌", "큰 소리로 보정 ❌"]
- anatomy: { entry:"세 음 모양 듣기", main:"짧은 선율 모양 허밍", cooldown:"가벼운 하행 허밍" } · cooldownSkippable: true
- feedback: { kind: visualPitch, mode:"deferred", target:"contourShape" }
- variableAxes: { contour:["저-고-저","같-고-같","고-저-같"], vowel:["m","u"] }
- 중단 cue: ["목 피로 → 한 음 허밍으로 축소"]

### CARD-17 · 한국어 모음·자음 bridge  (kind: drill · 블록4/5)
- cue: ["/마-미-무/ 천천히.", "자음은 부드럽게.", "모음은 크게 벌리지 않기.", "같은 높이 느낌 유지."]
- voicedMicroWin: ["한국어 3음절 bridge 5회"]
- antiPatterns: ["자음 세게 치기 ❌", "모음 과장 ❌", "가사처럼 빠르게 처리 ❌"]
- anatomy: { entry:"가벼운 /m/ 준비", main:"한국어 모음·자음 저부하 전이", cooldown:"입 다문 허밍 1회" } · cooldownSkippable: true
- feedback: { kind: none } # V1: 한국어 모음 AI 점수 없음.
- variableAxes: { syllable:["마-미-무","나-네-노","음-아","무-아"], range:["편한 중음","약간 낮게"] }
- 중단 cue: ["턱·혀 긴장 → CARD-03으로 축소"]

### CARD-18 · 목 상태 recovery fallback  (kind: safetyRoutine · 정상 경로 미배치)
- cue: ["오늘 목 상태를 하나 고르기.", "정상 진도 카드가 아닌 회복 대체 루틴.", "피곤하면 낮은 부하만.", "쉰 느낌이면 듣기·호흡만."]
- voicedMicroWin: ["목이 편하면 가벼운 /m/ 2회, 아니면 무성 호흡 3회"]
- antiPatterns: ["streak 때문에 무리하기 ❌", "쉰 느낌에서 큰 소리 ❌", "통증 숨기기 ❌"]
- anatomy: { entry:"목 상태 1탭 선택", main:"상태별 light-mode 선택", cooldown:"느린 호흡 3회" } · cooldownSkippable: true
- feedback: { kind: safetyNudge, diagnosis:false }
- variableAxes: { mode:["낮은 부하","SOVT-only","듣기·호흡"] }
- 중단 cue: ["통증·쉰 느낌 지속·말하기 어려움 → 앱 중단 및 전문가 상담 권고"]

---

## 검토 요청 (HITL — 발성안전)

특히 확인 바랍니다:
1. **중단 cue 충분/정확한가** — CARD-06(빨대: 어지럼·가슴통증), CARD-09(물저항: 천식·호흡기 이력 대체·호흡곤란), CARD-02(과호흡), CARD-18(쉰 느낌·목 피로).
2. **운동 지시 cue에 정당화 섞이지 않았나** (무납득 ADR-0002 — "왜"가 들어간 문구 있으면 지적).
3. **정상 경로의 유성 마이크로윈과 회복 예외** — CARD-18이 정상 path가 아닌 런타임 대체로만 호출되는가?
4. CARD-14/15/16/17을 초급 후반이 아니라 중반부터 낮은 부하로 넣는 배치가 페다고지상 맞나?
5. CARD-12의 relative target + deferred feedback이 초보자에게 충분히 명확한가?
