# 중급 가요 분기 IN 카드 (ADR-0015 Card 스키마)

> F-단위 산출물. 소스: `CURRICULUM.md`(블록3·4) + `docs/research/`(part 5·6-KR·9-KR) + `SOURCES.md`.
> 규칙: `cue` = 지시문만(ADR-0002). `feedback` 비차단·시각 전용. *마이크 증폭 전제*.
> ⚠️ `[HITL]` 카드(belt·트웽·런)는 발성안전 사인오프 전 출시 금지(VERIFICATION 참조).
> **k-keok 강한 글로털 어택은 결절·출혈 위험으로 카드 미포함**. 선행: 공유 코어 통과.

---

## 블록3 — 스타일·레지스터

### GY-01 · 스피치라이크  (kind: drill · 블록3)
- cue: ["말하듯 편한 위치에서 시작.", "그대로 노래로 이어가기.", "지르지 않기(마이크가 음량 보완)."]
- voicedMicroWin: ["말→노래 전이 5회"]
- antiPatterns: ["클래식처럼 과하게 울리기 ❌", "hard glottal 어택 습관 ❌"]
- anatomy: { entry:"문장 말하기", main:"말소리 위치→노래 carryover", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: visual }
- variableAxes: { range:["중음","±2도"], sessionPos:["워밍업","본"] }
- 중단 cue: ["성대 피로 → 중단"]

### GY-02 · 믹스  (kind: drill · 블록3)
- cue: ["이 음에서 이 느낌으로(비율 설명 없이).", "저→고 부드럽게.", "갑자기 두꺼워지거나 얇아지지 않게."]
- voicedMicroWin: ["믹스 글라이드 5회"]
- antiPatterns: ["전환부 힘으로 밀기 ❌", "흉성 지르기 ❌"]
- anatomy: { entry:"가벼운 사이렌", main:"M1↔M2 연결(경험으로)", cooldown:"하행 글라이드" } · cooldownSkippable: true
- feedback: { kind: visual }  # 믹스 단일정의 ❌(VALA2021)
- variableAxes: { range:["중음","±3도"], style:["M1기반","M2기반"] }
- 중단 cue: ["전환부 통증·반복 삑사리 → 중단"]

### GY-03 · K-pop SOVT 워밍업 (lip bubble/siren/kkook)  (kind: drill · 블록3)
- cue: ["립버블(=립 트릴) 일정한 굵기로 5초.", "사이렌(글라이드) 저→고→저 부드럽게.", "kkook = 짧고 단단하되 짜내지 않기(균형)."]
- voicedMicroWin: ["립버블·사이렌 각 3회"]
- antiPatterns: ["이로 물기 ❌", "kkook을 압착으로 변질 ❌", "과호기 어지럼 ❌"]
- anatomy: { entry:"무음 호기 1회", main:"산업명↔SOVT 워밍업(같은 운동)", cooldown:"빨대 빼고 /u/" } · cooldownSkippable: true
- feedback: { kind: none }  # K-pop 명명↔SOVT 매핑(part 9-KR), 같은 운동
- variableAxes: { range:["중음","±3도"], glide:["사이렌","sustain"] }
- 중단 cue: ["어지럼·시야흐림 → 중단"]

### GY-04 · 트웽/꽥  [HITL]  (kind: drill · 블록3)
- cue: ["마녀 웃음·오리 소리처럼 입 안을 좁혀 밝게.", "콧소리 ❌(구강, 비음 아님).", "짧게 — 고음 지속 ❌."]
- voicedMicroWin: ["구강 트웽 발성 5회"]
- antiPatterns: ["콧소리로 새기 ❌", "고음 지속 트웽 ❌", "목 조여 짜내기 ❌"]
- anatomy: { entry:"가벼운 /a/", main:"구강 AES 협착(밝게)", cooldown:"중립 모음 1회" } · cooldownSkippable: true
- feedback: { kind: visual }  # AES 협착(GIBIAT2024). neutral 컨트라스트(JVOICE2025KPOP)
- variableAxes: { vowel:["a","e"], range:["중음"] }
- 중단 cue: ["조임·통증·고음 피로 → 중단"]

### GY-05 · 라이트 belt 진입  [HITL · S등급]  (kind: drill · 블록3)
- cue: ["부르듯 짧게(call-based).", "밝게 — *크게 아님*.", "끊어서, 지속하지 않기.", "조금이라도 아프면 즉시 멈춤."]
- voicedMicroWin: ["call-based 진입 3회(짧게)"]
- antiPatterns: ["크게 지르기 ❌", "지속/풀 belt ❌(고급)", "흉성 고음 밀어올리기 ❌"]
- anatomy: { entry:"가벼운 call", main:"라이트 belt *진입*만(보수적)", cooldown:"하행 글라이드·SOVT" } · cooldownSkippable: true
- feedback: { kind: visual }  # 부하·피로 미감지(ADR-0008). K-pop 손상 사례 다수
- variableAxes: { range:["진입 음역 한정"] }
- 중단 cue: ["통증·목 잠김·다음날 쉰목 → 즉시 중단·휴식", "풀 belt 시도 금지(고급)"]

### GY-06 · 꺽기/런 기초  [HITL]  (kind: drill · 블록3)
- cue: ["음을 느리게 정확히 굴리기.", "정확도 먼저, 속도는 나중.", "고음역 무리 런 ❌."]
- voicedMicroWin: ["느린 런 패턴 3회"]
- antiPatterns: ["정확도 없이 속도만 ❌", "고음역 무리 ❌"]
- anatomy: { entry:"느린 3음 패턴", main:"런 기초 정확도→템포", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: visual }
- variableAxes: { tempo:["느림","중간"], range:["중음"] }
- 중단 cue: ["피로·삑사리 반복 → 중단"]

## 블록4 — 한국어 딕션·곡

### GY-07 · 한국어 가창 딕션  (kind: drill · 블록4)
- cue: ["평·경·격음 구분 — 경음은 과압 주의(짜내지 않기).", "종성 7대표음 또렷이.", "연음·비음화 자연스럽게.", "곡과 함께(고립 ❌)."]
- voicedMicroWin: ["딕션 적용 구절 3회"]
- antiPatterns: ["경음 과압착 ❌", "콧소리식 오역 ❌", "딕션만 따로 연습 ❌"]
- anatomy: { entry:"문장 말하기", main:"VOT·종성·연음 적용(곡 안)", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: visual }
- variableAxes: { sessionPos:["본"] }
- 중단 cue: ["경음 반복 과압 → 중단"]

### GY-08 · 마이크 전제 명료도  (kind: concept · 블록4)
- cue: ["마이크가 음량 보완 — 과한 자음 타격 불필요.", "또렷하되 편하게.", "모니터·컴프레션 환경 인지."]
- voicedMicroWin: ["증폭 전제 발성 3회"]
- antiPatterns: ["비증폭처럼 과한 프로젝션 ❌", "자음 과타격 후두 긴장 ❌"]
- anatomy: { entry:"편한 발성", main:"증폭 전제 명료도↔효율", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: visual }
- variableAxes: { sessionPos:["본"] }
- 중단 cue: ["성대 피로 → 중단"]

### GY-09 · 레퍼토리 (가요 구절)  [HITL]  (kind: song · 블록4)
- cue: ["스피치라이크 구절 편하게.", "belt-진입 구절은 짧고 밝게(크게 ❌).", "풀 belt·고난도 런·고음 지속 구절 ❌(고급)."]
- voicedMicroWin: ["가요 구절 적용 1회(스피치라이크 또는 라이트 belt)"]
- antiPatterns: ["풀 belt 가요 ❌(고급)", "고음 무리 ❌", "고난도 런 무리 ❌"]
- anatomy: { entry:"테크닉 1분", main:"스피치라이크→라이트 belt 구절", cooldown:"하행 글라이드·SOVT" } · cooldownSkippable: true
- feedback: { kind: visual }
- variableAxes: { difficulty:["스피치라이크","라이트 belt-진입"] }
- 중단 cue: ["통증·다음날 쉰목 → 중단·휴식"]
