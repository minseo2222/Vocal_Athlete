# 콘텐츠 스키마 = 정규화 (Card 템플릿 + PathManifest → LessonInstance 도출)

> Superseded note: 이 ADR은 R1 기준 이력이다. 현재 초급 canonical 범위와 경로는 `ADR-0018-beginner-learning-transfer-update.md`를 따른다.


레슨/카드 콘텐츠 스키마를 **정규화 형태**로 확정한다. 잠긴 결정(단일 고정 선형 경로 + 변주는 카드 타입 *안* 표면 변경 + blocked→variable 내부 상승[ADR-0006] + 무납득[ADR-0002] + 매 레슨 유성 마이크로윈)을 *구조로* 표현하는 유일안.

```
Card { id, kind: drill|standardSample,
       cue: string[]                 // 지시문만. rationale/why/동기 필드 없음(ADR-0002)
       voicedMicroWin: VoicedElem[]  // 필수, 비어있을 수 없음(타입 강제)
       antiPatterns: Clip[]          // 5–10초, 1줄 지시 자막
       anatomy: { entry, main, cooldown }, cooldownSkippable: true
       feedback: { kind: visualPitch|aiClassify|abCompare|selfImitation|none,
                   nudge?: { deviation, tip } }   // 비차단(gate 필드 없음)
       variableAxes: { range?:[], vowel?:[], glide?:[], melody?:[], sessionPos?:[] } }

PathManifest = PathSlot[]            // 배열 순서 = 단일 고정 선형 경로
PathSlot { index, cardId, block:1..5, bodyVoicedRatio, variationLevel }

LessonInstance = resolve(Card, PathSlot, day)   // 런타임 도출, 비저장
```

피치 피드백은 ADR-0014 인터페이스(온디바이스 자기상관 V1 + 신뢰 게이트) 경유. 표준샘플 SOP = `kind:standardSample` 카드를 특정 슬롯(#1/#~25/#48)에 배치.

## Considered Options

- **(채택) A 정규화** — 13카드 + manifest, 레슨 도출. 변주=축 선언+스케줄, 무납득·유성필수를 구조 강제. 경로 재튜닝=manifest만
- **(기각) B 평면(48 레슨 명시)** — 변주·blocked→variable이 박혀 재튜닝 불가, 잠긴 결정과 충돌
- **(기각) C 하이브리드** — 절충이나 두 군데 관리·A와 중복 소지

## Consequences

- C1(16) = R1 13 IN 카드. R2 현재는 ADR-0018에 따라 18 IN 카드가 같은 Card 스키마를 사용
- C2(17) = PathManifest 작성 + `resolve(Card,PathSlot,day)` 리졸버 구현
- C3(26) = 변주 엔진이 `variableAxes` + `PathSlot.variationLevel` 소비
- 무납득은 *스키마에 rationale 필드 부재*로 1차 강제(텍스트 검증은 C1/C2)
- 리졸버 정확성이 도출 모델의 핵심 — 단위테스트 필수
