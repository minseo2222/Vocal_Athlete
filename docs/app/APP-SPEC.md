# 앱 사양 (APP-SPEC) — 전역 통합

> 옛 `01-A 앱 콘텐츠 사양` + `01-B 온보딩·안전·법무`를 대체(archive 보존). 용어는 루트 `CONTEXT.md`. 근거 `docs/adr/0001–0020`. 커리큘럼 내용은 `docs/curriculum/beginner/CURRICULUM.md`.
>
> 실행 하위 문서: `MVP-SCOPE.md`, `PRODUCT-LOOP-SPEC.md`, `GAMIFICATION-SPEC.md`, `DATA-PRIVACY-SPEC.md`, `METRICS-AND-EXPERIMENTS.md`.

## 1. 정체성·범위

일반 소비자 **일일 보컬 트레이닝 앱**(듀오링고형). 진단·치료·임상 모니터링 ❌. 본 문서 = *앱 동작·콘텐츠 제작 표준·안전/법무*. 유료 교습·강사 매칭·오프라인 수업은 범위 밖.

V1의 제품 명제는 “성인 초보자가 매일 10–15분, 안전한 기초 발성 루틴을 반복하게 만드는 앱”이다. 자세한 출시 범위는 `MVP-SCOPE.md`가 권위다.

## 2. 안전·법무

### 2.1 초급 V1 기본 경고

앱 실행당 1회, 진입 1-탭 확인:

> "통증·어지럼·호흡곤란·각혈이 있으면 즉시 멈추고 의료기관을 방문하세요. 본 앱은 만 18세 이상·변성기 종료 대상이며, 의료·진단 도구가 아닙니다."

- 의료 문진·컨디션 점수·적색신호 12·베이스라인 설문·연령 게이트·의료 동의 플로우·동반자(강사/SLP) 트랙·C(두경부암) 차단·적응형 안전 연장 — **초급 V1에는 없음**(ADR-0001). 단 R2 목 상태 micro-check는 해금 게이트가 아닌 light-mode UX로 허용(ADR-0018). v9 라우팅은 초급→Universal Core→Repertoire Application→Advanced Genre Lab을 따른다(ADR-0019/0020).
- 누구도 별도 차단하지 않음. 모든 의료 판단은 사용자 책임으로 위 문구에 일원화.
- 법무: 면책 문구가 전부. 임상/강사 운영은 제품 외.

### 2.2 중급 공통·고급 고위험 카드 출시 제한

초급 V1의 “앱 실행 경고 하나”는 **초급 범위에만 적용**한다. 고급 장르 Lab의 belt·트웽·패사지오 처리·cover·messa·run·레퍼토리 카드는 별도 안전 게이트를 통과하기 전까지 공개하지 않는다.

출시 조건:

1. 전문가 HITL 사인오프
2. 카드별 강제 캡 구현(음역·횟수·지속·주간·회복)
3. swelling check/다중 stop 신호 구현
4. rollout config 사람 승인

상세 기준은 `docs/verification/SAFETY-RELEASE-GATE.md`와 `docs/verification/backlog-safety-enforcement.md`를 따른다.

## 3. 온보딩

**설문형 온보딩 없음.** 실행 경고 1탭 → 곧장 오늘 레슨. 설문·동의·연령확인·장르질문 ❌(관심 장르 기록은 초급 완료 후 동기/추천용으로만 가능). 시작에 계정 불필요(계정 = 진척 동기화용 선택, 추후).

단, 첫 레슨 내부에는 다음 수준의 **micro-onboarding**을 허용하고, 매 레슨 entry에는 비진단 목 상태 micro-check를 노출할 수 있다.

- 마이크 권한 요청/거부 안내
- 조용한 환경·휴대폰 거리 안내
- “피치 피드백은 정보용이며 해금을 막지 않음” 한 줄
- 저신뢰 구간은 표시하지 않는다는 한 줄

이는 설문형 온보딩이 아니라 과제 수행 안내다. 목 상태 micro-check는 `괜찮음 / 조금 피곤함 / 쉰 느낌` 중 하나를 고르게 하되, 의료 판단·해금 차단·streak 페널티로 쓰지 않는다.

## 4. 진행·리텐션 메커니즘 (제품 전역)

- **1일 1레슨 캡**(ADR-0003). 완료 시 다음 해금 — 수행 품질 무관.
- **단일 고정 선형 경로** — 모두 같은 순서, 적응형 분기 없음.
- **완료 기반 진행** — 시험·체크포인트·수행 게이트 없음.
- **관대 스트릭** — 하루 놓쳐도 0 리셋 ❌, streak freeze ❌.
- **복귀 복습** — 7일+ 공백 → 복귀 첫날 = 복습 레슨(그날 1레슨). 7–14일→1일, 그 이상→2일.
- **통합 전이**(ADR-0010, R3/R4 superseded by ADR-0019/0020/0021) — 코스 완주 시: 축하 → 다음 코스 라우팅. v9 권위 경로는 `초급 Foundation → Universal Vocal Core → Repertoire Application → Advanced Genre Lab`이다. 장르 선택은 초급 직후가 아니라 곡 적용 훈련 완주 후에만 열린다. 고급 Lab이 미출시이면 유지 모드로 대기하고, 출시 시 사람 승인 config로 연결한다.
- **자유 연습 모드**: 별개·연기(스트릭/진척 무관, V1 미구현).

## 5. 레슨 해부 (10–15분)

진입/워밍업 ~1–2분(목 상태 micro-check + SOVT 겸함) · 본운동 ~7–11분 · 쿨다운 ~1–2분(권장·스킵 가능). 정상 경로는 유성 마이크로-윈을 포함한다. 피곤/쉰 상태에서는 `CARD-18` 런타임 recovery fallback으로 대체하며 no-voice 듣기·tap·가사 말하기도 완료로 인정한다.

완료 무결성:

- 진입/워밍업 단계에서는 `완료` CTA를 노출하지 않음.
- 최소 본운동 cue를 본 뒤에 완료 경로를 열음.
- 본운동에서는 쿨다운 스킵으로 완료 가능.
- 쿨다운에서는 완료 CTA 노출.
- 시간 강제 게이트나 품질 점수 게이트는 없음.

세부 루프는 `PRODUCT-LOOP-SPEC.md`를 따른다.

## 6. 무납득 + 변주

- 학습자에게 "왜"를 설명·정당화·동기부여 ❌(ADR-0002). 단 *과제 정의 운동 지시 cue*("이로 물지 마세요", "밝게, 크게 아님")는 허용 — rationale 아님.
- 안전 cue는 예외적으로 짧고 명확해야 한다. 예: “아프면 즉시 멈춤”, “고음 지속 금지”.
- 지루함은 **변주**로만 — 같은 레슨 타입 안에서 표면(음역·모음·글라이드·멜로디·세션위치) 변경. blocked→variable는 경로 따라 내부 상승(설명 ❌). 경로는 변주로 갈리지 않음.

## 7. 인-레슨 피드백 (막지 않음)

- 표준샘플 A/B·self-imitation·시각 피치 = *정보·연습 재료*. 해금/졸업 **차단 ❌**. R2 초급 CARD-12/14/16은 실시간 화면맞추기보다 수행 후 곡선 확인을 기본값으로 둔다.
- 크게 빗나가면 *선택형* "다시 해볼까요?" 1개 + 1줄 교정 팁(스킵 자유). 강제 재시도 ❌.
- **신뢰도 낮은 음향 수치(jitter·shimmer·HNR·마이크 민감 지표)는 표시하지 않음** — 한계 설명 필요 자체 제거.
- 자가피드백은 **시각 곡선 전용**(듣고 판단 ❌ → 골전도 착각 차단).
- 상세 분석 사양 → `docs/app/AI-ANALYSIS.md`.

## 8. 보컬형 게임화

게이미피케이션의 목표는 “더 높게·더 크게·더 오래”가 아니라 **안전하게 다시 돌아와 루틴을 완료하는 것**이다.

V1 허용:

- 관대한 streak
- 완료/쿨다운/복귀 XP
- 표준샘플 badge
- nudge log
- 낮은 압박의 mission

V1 금지:

- 리더보드
- 고음/음량/sustain 랭킹
- belt challenge
- 공개 음성 비교
- guilt notification

세부는 `GAMIFICATION-SPEC.md`를 따른다.

## 9. 콘텐츠 제작 표준 (옛 01-A에서 보존·적응)

- **영상**: 1920×1080 60fps, 카드당 30–90초 마이크로 클립, 정면/측면/클로즈업, 자막(한/영), 단색 배경. 시연자 = 자격 보컬 교사. 음소거로도 절차 이해 가능.
- **오디오**: 가이드 톤 차분·중립(동기부여 톤 ❌). 가이드/카운트/참조음 분리 토글.
- **Anti-pattern 클립**: 카드당 흔한 오류 3–5종, 5–10초, 빨간 X + 1줄 *지시형* 자막(정당화 ❌).
- **참조 음원**: balanced / light-airy A·B. pressed 예시는 listening-only 안전 자료로만 제공하고 사용자에게 모방시키지 않는다.
- 카드 페다고지 디테일은 `CURRICULUM.md` §5. v9 기준 초급 정상 경로는 `CARD-01~17`, `CARD-18`은 동적 recovery fallback이다.

## 10. 데이터·개인정보

- 로컬 우선.
- 녹음 업로드 기본값 아님.
- 표준샘플은 사용자 동의 후 저장.
- self-imitation 녹음은 기본 세션 내 사용.
- 마이크 거부 시 레슨 진행 가능, 피치 표시만 꺼짐.

세부는 `DATA-PRIVACY-SPEC.md`를 따른다.

## 11. 명시 제거 (옛 문서에서 폐기)

게이미피케이션 동기 시스템의 *학술 정당화*·1주차 교육 마이크로강의·페이즈/주차/체크포인트 UI·적응형 진도 로직·환경분석 모듈을 게이트로·동료 커뮤니티(V1)·웨어러블·무대공포 모듈.



## v9 long-term curriculum routing

- 앱의 장기 경로는 `Beginner Foundation → Universal Vocal Core → Repertoire Application → Advanced Genre Labs → Portfolio`다.
- 초급 완주 직후 장르를 고르지 않는다. 사용자는 `중급 공통 코어 시작`으로 이동한다.
- Universal Core는 12일 microcycle 12개로 기술을 재등장시키며, 완주 후 Repertoire Application을 거친다. 장르 선택은 곡 적용 훈련 완주 후 고급 Lab에서만 열린다.
- 고급 Lab은 날짜 제한 없는 반복형 cycle이지만, 고위험 technique은 safety cap과 HITL 전까지 잠금이다.
- 음색 훈련은 전체 경로의 핵심 축이지만, 음색 점수·유명 가수 매칭률·성대 건강 판정은 금지한다.


## v9 learning-method policy

- 기본 루프는 `모델 → 첫 시도 → 자기판단 → 선택형 피드백 → 한 가지 수정 → 재시도 → delayed retention → transfer`다.
- 실시간 피드백은 timing처럼 즉시성이 필요한 경우에 제한하고, pitch·timbre는 수행 후 확인을 기본으로 한다.
- 도움은 단계가 올라갈수록 줄인다. 고급은 정답 애니메이션보다 녹음 산출물과 프로젝트 리뷰를 우선한다.
- 임시 인용 또는 제품 가설에서 나온 정확한 반복 수·cap은 사용자에게 과학적으로 확정된 안전선처럼 표시하지 않는다.

- Repertoire Application은 12일 phrase project 6개다. 각 project는 whole-phrase baseline으로 시작하고 delayed whole-phrase review로 끝난다.
- formal Core checkpoint는 Day 36/72/108/144 네 번만 사용하며, 나머지 cycle은 자기 코칭 retrieval로 마무리한다.

## v15 Timbre Integration

- 음색은 독립 12주 코스가 아니라 Beginner → Universal Core → Repertoire Application → Advanced Labs에 나선형으로 배치한다.
- Beginner는 Hum-to-Vowel·모음 색채 관찰과 Day 1/24/48 자기태그까지만 다룬다.
- Universal Core는 source 결과·모음/filter·레지스터·딕션·프레이즈를 한 변수씩 조절하고 지연 재현한다.
- Repertoire Application은 같은 프레이즈의 bright/warm A/B 및 clean/warm/speech-like A/B/C를 최대 2–3 take로 제한한다.
- `내 음색 팔레트`는 사용자가 직접 고른 tag·편안함·Best take만 집계한다. AI 음색 유형, 성대 상태, 유명 가수 유사도는 생성하지 않는다.
- `TONE-08/09/13`은 moderate load이며, 피곤함에는 축소하고 쉰 느낌에는 no-voice 대체한다.
