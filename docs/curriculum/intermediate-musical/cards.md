# 중급 뮤지컬 분기 IN 카드 (ADR-0015 Card 스키마)

> D-단위 산출물. 소스: `CURRICULUM.md`(블록3·4) + `docs/research/`(part 5·6·6-KR) + `SOURCES.md`.
> 규칙: `cue` = 지시문만(ADR-0002). `feedback` 비차단·시각 전용.
> ⚠️ **안전 S등급**: 벨트·고음·트웽·패사지오 처리 = ADR-0008 명시 위험수용.
>    아래 `[HITL]` 표시 카드는 *발성안전 사인오프 전 출시 금지*(VERIFICATION 참조).
> 선행: 공유 코어(블록1·2) 통과.

---

## 블록3 — 레지스터

### IM-01 · 믹스 (P5-04)  (kind: drill · 블록3)
- cue: ["이 음에서 이 느낌으로(흉성/두성 비율 설명 없이).", "저→고 한 호흡으로 부드럽게.", "갑자기 두꺼워지거나 얇아지지 않게."]
- voicedMicroWin: ["믹스 글라이드 5회"]
- antiPatterns: ["전환부 힘으로 밀기 ❌", "갑자기 흉성 지르기 ❌"]
- anatomy: { entry:"가벼운 사이렌", main:"M1↔M2 연결(경험으로)", cooldown:"하행 글라이드" } · cooldownSkippable: true
- feedback: { kind: visual }  # 믹스 단일정의 ❌(VALA2021) — 경험으로 제시
- variableAxes: { range:["중음","±3도"], style:["M1기반","M2기반"] }
- 중단 cue: ["전환부 통증·반복 삑사리 → 중단"]

### IM-02 · 구강 트웽 (P15-20 oral)  (kind: drill · 블록3)
- cue: ["오리·마녀 소리처럼 입 안을 좁혀 밝게.", "콧소리 ❌(트웽 = 입 안, 비음 아님).", "짧게 시작."]
- voicedMicroWin: ["구강 트웽 발성 5회"]
- antiPatterns: ["콧소리로 새기 ❌", "목 조여 짜내기 ❌"]
- anatomy: { entry:"가벼운 /a/", main:"구강 AES 협착(밝게)", cooldown:"중립 모음 1회" } · cooldownSkippable: true
- feedback: { kind: visual }  # AES 협착 MRI 근거(GIBIAT2024) — 운동 지시로만
- variableAxes: { vowel:["a","e"], range:["중음"] }
- 중단 cue: ["조임·통증 → 중단"]

### IM-03 · 패사지오 처리 (믹스·belt 방향)  [HITL]  (kind: drill · 블록3)
- cue: ["코어에서 관찰한 전이 구간을 사이렌으로 통과.", "없애려 하지 말고 부드럽게 관리.", "고음으로 밀어붙이지 않기."]
- voicedMicroWin: ["전이 구간 사이렌 통과 5회"]
- antiPatterns: ["전이부 힘으로 돌파 ❌", "삑사리 반복 무시 ❌"]
- anatomy: { entry:"중음 사이렌", main:"primo/secondo 전이 *관리*", cooldown:"하행 사이렌" } · cooldownSkippable: true
- feedback: { kind: visual }
- variableAxes: { range:["중음","±4도"], glide:["사이렌","작은 글라이드"] }
- 중단 cue: ["전환부 통증·잦은 삑사리 → 중단(고음 무리 금지)"]

### IM-04 · Bozeman 모음 전환 (P15-18)  (kind: drill · 블록3)
- cue: ["올라가며 모음을 살짝 어둡게 '돌리기'(turning the vowel).", "특정 음에서 울림이 바뀌는 지점 관찰.", "억지로 누르지 않기."]
- voicedMicroWin: ["모음 전환 글라이드 5회"]
- antiPatterns: ["모음 고정으로 비명 ❌", "후두 강제로 누르기 ❌"]
- anatomy: { entry:"편한 모음 1회", main:"H2가 R1 통과 지점 모음 조정", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: visual }  # passaggio 음향 조정(BOZEMAN2013)
- variableAxes: { vowel:["a→ɔ","e→ø"], range:["중고음"] }
- 중단 cue: ["통증·조임 → 중단"]

### IM-05 · call-based 벨트 진입 (천장)  [HITL · S등급]  (kind: drill · 블록3)
- cue: ["'Hey!' 부르듯 짧게.", "밝게 — *크게 아님*.", "짧게 끊어서, 지속하지 않기.", "조금이라도 아프면 즉시 멈춤."]
- voicedMicroWin: ["call-based 'Hey!' 진입 3회(짧게)"]
- antiPatterns: ["크게 지르기 ❌", "지속 벨트 ❌(고급)", "흉성 고음 밀어올리기 ❌"]
- anatomy: { entry:"가벼운 call", main:"call-based belt *진입*만(보수적)", cooldown:"하행 글라이드·가벼운 SOVT" } · cooldownSkippable: true
- feedback: { kind: visual }  # R1:H2·높은 CQ(MCGLASHAN2017 탐색적). 부하·피로 미감지(ADR-0008)
- variableAxes: { range:["진입 음역 한정"] }
- 중단 cue: ["통증·목 잠김·다음날 쉰목 → 즉시 중단·휴식", "지속 벨트 시도 금지(고급 영역)"]

## 블록4 — 텍스트·딕션·캐릭터·곡

### IM-06 · 자음 에너지 / 배우-스피치 브리지 (P6-08)  (kind: drill · 블록4)
- cue: ["문장을 보통/뭉갬/정밀 3가지로.", "정밀 버전 채택.", "말하듯(chant) → 노래로 이어가기."]
- voicedMicroWin: ["chant→sing 전이 3회"]
- antiPatterns: ["자음 과타격으로 후두 긴장 ❌"]
- anatomy: { entry:"문장 말하기", main:"3조건 대조→정밀 채택→chant→sing", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: visual }
- variableAxes: { sessionPos:["워밍업","본"] }
- 중단 cue: ["성대 피로 → 중단"]

### IM-07 · 텍스트 해체-재구성 (P6-09, Rodenburg)  (kind: drill · 블록4)
- cue: ["테크닉 1분 미만.", "새 호흡.", "텍스트를 *말로* 전달.", "같은 텍스트를 음정과 함께.", "3회 반복."]
- voicedMicroWin: ["텍스트 말→노래 루프 3회"]
- antiPatterns: ["발성 위에 가사 얹기 ❌(순서 반대)", "의미 없이 음만 ❌"]
- anatomy: { entry:"짧은 테크닉", main:"말 전달→음정 전달 루프", cooldown:"느린 호흡" } · cooldownSkippable: true
- feedback: { kind: none }  # 캐릭터는 상위 프레임, P6-09 단계 아님
- variableAxes: { sessionPos:["본"] }
- 중단 cue: ["피로 → 중단"]

### IM-08 · 명료도 블라인드 (P6-10)  (kind: drill · 블록4)
- cue: ["녹음 후 가사가 또렷한지 화면·구조로 확인.", "듣고 판단하지 말고 시각/체크로."]
- voicedMicroWin: ["명료도 점검 발성 3회"]
- antiPatterns: ["과한 자음으로 후두 긴장 ❌"]
- anatomy: { entry:"문장 1회", main:"명료도 시각/구조 피드백", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: visual }  # 듣고 판단 ❌(ADR-0014)
- variableAxes: { sessionPos:["본"] }
- 중단 cue: ["피로 → 중단"]

### IM-09 · 한국어 딕션 (P6KR-01~09, 교차 스트림)  (kind: drill · 블록4)
- cue: ["평·경·격음 구분 — 경음은 과압 주의(짜내지 않기).", "종성 7대표음 또렷이.", "연음·비음화 자연스럽게.", "곡과 함께(고립 ❌)."]
- voicedMicroWin: ["딕션 적용 구절 3회"]
- antiPatterns: ["경음 과압착 ❌", "콧소리식 오역 ❌", "딕션만 따로 떼어 연습 ❌"]
- anatomy: { entry:"문장 말하기", main:"VOT·종성·연음 적용(곡 안)", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: visual }  # 텍스트 전달 위해서만(교차 스트림)
- variableAxes: { sessionPos:["본"] }
- 중단 cue: ["경음 반복 과압 → 중단"]

### IM-10 · 패터 (P6-07)  (kind: drill · 블록4)
- cue: ["짧은 구절을 느리게 → 점점 빠르게.", "또렷함 유지되는 최대 템포까지만.", "무너지면 한 단계 늦춤."]
- voicedMicroWin: ["패터 템포 램프 3단계"]
- antiPatterns: ["또렷함 깨진 채 속도만 ❌", "턱 과긴장 ❌"]
- anatomy: { entry:"느린 구절", main:"조음 템포 램프", cooldown:"턱 풀기" } · cooldownSkippable: true
- feedback: { kind: visual }
- variableAxes: { tempo:["느림","중간","빠름"] }
- 중단 cue: ["턱·혀 경직 → 중단"]

### IM-11 · 영어 딕션 (P6-14)  (kind: drill · 블록4)
- cue: ["이중모음은 첫 모음 길게·끝 모음 짧게.", "r은 곡 스타일대로(미·영).", "또렷하되 과하지 않게."]
- voicedMicroWin: ["영어 구절 딕션 3회"]
- antiPatterns: ["이중모음 뭉개기 ❌", "r 과장 ❌"]
- anatomy: { entry:"구절 말하기", main:"이중모음/r 정책 적용", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: visual }
- variableAxes: { sessionPos:["본"] }
- 중단 cue: ["피로 → 중단"]

### IM-12 · 레퍼토리 (legit + 라이트 벨트-진입)  [HITL]  (kind: song · 블록4)
- cue: ["legit 구절은 맑게.", "벨트-진입 구절은 짧고 밝게(크게 아님).", "풀 벨트로 끌지 않기(고급)."]
- voicedMicroWin: ["곡 구절 적용 1회(legit 또는 라이트 belt-진입)"]
- antiPatterns: ["풀 벨트 레퍼토리 ❌(고급)", "고음 무리 ❌"]
- anatomy: { entry:"테크닉 1분", main:"legit→라이트 belt-진입 구절", cooldown:"하행 글라이드·SOVT" } · cooldownSkippable: true
- feedback: { kind: visual }
- variableAxes: { difficulty:["legit","라이트 belt-진입"] }
- 중단 cue: ["통증·다음날 쉰목 → 중단·휴식"]
