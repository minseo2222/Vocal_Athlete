# Context Map

보컬 트레이닝 앱의 도메인 컨텍스트. 제품 메커니즘(듀오링고형 일일·1일1레슨 캡·완료 기반 진행·무납득 운동 제시·관대 스트릭·앱 실행 경고·레슨 해부)은 *제품 전역*이며 모든 컨텍스트가 상속한다.

> 업데이트: 2026-06-21 v15. 목표를 “초급 루틴 앱”에서 “장기 보컬 성장 플랫폼”으로 확장하되, V1 출시는 초급 Foundation으로 유지한다. 커리큘럼 라우팅은 **초급 → 중급 Universal Core → Repertoire Application → 고급 Genre Labs**로 바꾼다. 장르 선택은 초급 직후가 아니라 Repertoire Application 완주 후 열린다.

## Contexts

- [초급 Foundation](./docs/curriculum/beginner/CURRICULUM.md) — 48레슨. 안전한 입문 루틴, SOVT, 자기청취, 표준샘플, 낮은 부하의 청음·리듬·contour·한국어 bridge. 졸업 = 장르 선택이 아니라 **중급 Universal Core 진입 준비**.
- [중급 Universal Vocal Core](./docs/curriculum/universal-core/CURRICULUM.md) — 144레슨. 12일 microcycle을 12회 순환하며 호흡, 발성, SOVT 전이, 피치/청음, 리듬/타임, 공명·음색, 레지스터, 딕션·프레이즈를 훈련한다. **장르 분기 전 필수 코어**.
- [공통 Repertoire Application](./docs/curriculum/REPERTOIRE-APPLICATION-SPEC.md) — 중급 후속 72레슨. 여섯 개 12일 phrase project에서 자체 제작 neutral phrase/étude에 기술을 전이한다.
- [고급 가요/K-pop Lab](./docs/curriculum/advanced-gayo/CURRICULUM.md) — Repertoire Application 완주 후 열리는 반복형 장르 Lab. 한국어 diction, mic-friendly tone, clean/warm/speech-like tone, mix-safe phrase, hook, 녹음 take.
- [고급 뮤지컬 Lab](./docs/curriculum/advanced-musical/CURRICULUM.md) — text intention, speech-to-song, character tone, legit/mix/belt-safe pathway, 16-bar cut. 고위험 belt/twang는 safety gate 전 잠금.
- [고급 성악 Lab](./docs/curriculum/advanced-classical/CURRICULUM.md) — legato, vowel continuity, classical resonance, diction, passaggio-safe phrase. cover/messa 계열은 HITL + cap 전 잠금.
- [고급 R&B/Soul Lab](./docs/curriculum/advanced-rb-soul/CURRICULUM.md) — warm tone, groove, slow agility, mic/phrase take.
- [고급 Rock/Band Lab](./docs/curriculum/advanced-rock/CURRICULUM.md) — clean edge, mic projection, band phrase, no distortion by default.
- [고급 CCM Lab](./docs/curriculum/advanced-ccm/CURRICULUM.md) — warm worship phrase, mic-friendly tone, chorus energy without pushing.
- [음색 훈련 스펙](./docs/curriculum/TIMBRE-TRAINING-SPEC.md) — 음색을 타고난 목소리 판정이 아니라 source/filter/style/safety 조절 능력으로 정의한다.

## Product Specs

- [MVP 범위](./docs/app/MVP-SCOPE.md) — V1 포함/제외 기능, 출시 체크리스트.
- [제품 학습 루프](./docs/app/PRODUCT-LOOP-SPEC.md) — 앱 실행 → 오늘 레슨 → 피드백 → 완료 → 복귀.
- [게임화 사양](./docs/app/GAMIFICATION-SPEC.md) — 보컬 안전형 XP·streak·mission·badge·nudge.
- [데이터·프라이버시](./docs/app/DATA-PRIVACY-SPEC.md) — 녹음·피치·진도 데이터 저장/삭제/업로드 정책.
- [지표·실험](./docs/app/METRICS-AND-EXPERIMENTS.md) — retention, completion integrity, mic/pitch, safety 지표.
- [톤 피드백 사양](./docs/app/TONE-FEEDBACK-SPEC.md) — 음색 점수 금지, A/B 녹음 비교, tone tag, 사용자 자기평가.
- [Tone Profile 사양](./docs/app/TONE-PROFILE-SPEC.md) — 사용자가 직접 고른 tone tag·편안함·Best take만 집계하는 로컬 음색 팔레트.
- [안전 출시 게이트](./docs/verification/SAFETY-RELEASE-GATE.md) — HITL + 강제 cap + fallback 경로.
- [학습 증거 사양](./docs/app/LEARNING-EVIDENCE-SPEC.md) — completion과 시도·자기점검·녹음 흔적을 분리하며 목표 E0~E5를 자동 달성 판정하지 않는다.
- [오디오 세션 무결성](./docs/app/AUDIO-SESSION-INTEGRITY-SPEC.md) — 가이드·저장 take·마이크 캡처·앱 lifecycle interlock.

## Relationships

- **초급 → 중급 공통 → Repertoire Application → 고급 장르**: 초급 48일은 전체 커리큘럼의 제약이 아니라 첫 단계다. 초급 완주 후 장르를 고르지 않고 Universal Core로 진입한다. Universal Core 완주 후 Repertoire Application을 거치고, 장르 선택은 Repertoire Application 완주 후 고급 Lab에서 열린다.
- **중급의 역할**: 중급은 “32일 브리지”가 아니라 144레슨 공통 보컬 엔진이다. 기술을 블록 한 번으로 끝내지 않고 12일 microcycle마다 다시 불러와 유지·변형·전이를 확인한다.
- **곡 경계**: 초급에는 곡 없음. Universal Core 말미에 곡 적용 훈련 진입을 준비하고, 별도 72레슨 Repertoire Application에서 장르 중립 곡 적용을 진행한다. 장르별 레퍼토리와 고위험 기법은 고급 Lab에서 다룬다.
- **고급 무한 진행**: 고급은 무작위 무한 피드가 아니라 반복 가능한 cycle이다. 목표 설정 → 기술 훈련 → phrase loop → 녹음 A/B → 회복/유지로 순환한다.
- **음색 훈련**: 초급은 표준샘플·Hum-to-Vowel·모음 색채 관찰, 중급은 조절·재현, Repertoire Application은 동일 프레이즈 A/B/C, 고급은 장르 미학으로 단계화한다. 사용자가 고른 tag는 Tone Profile에 누적하지만 자동 음색 판정은 하지 않는다.
- **안전 게이트**: belt·cover·messa·run·강한 twang·distortion 등은 고급에서도 전문가 HITL + 앱 강제 cap + fallback + verification 동기화가 모두 충족되어야 공개된다.

## Current course lengths (code authority)

- 초급 Foundation: 48 lessons (`buildPlaceholderManifest`).
- 중급 Universal Vocal Core: 144 lessons (`buildUniversalCoreManifest` / `buildCoreManifest` alias).
- 공통 Repertoire Application: 72 lessons (`buildRepertoireApplicationManifest`).
- 고급 가요 Lab: 40-slot repeatable cycle (`buildAdvancedGayoManifest` / `buildGayoManifest` alias).
- 고급 뮤지컬 Lab: 40-slot repeatable cycle (`buildAdvancedMusicalManifest` / `buildMusicalManifest` alias).
- 고급 성악 Lab: 40-slot repeatable cycle (`buildAdvancedClassicalManifest` / `buildClassicalManifest` alias).
- 고급 R&B/Soul · Rock/Band · CCM Lab: 각 40-slot repeatable cycle.
- 고급 장르 Lab rollout: `kReleasedAdvancedGenres = {}` 기본값(`kReleasedGenres`는 하위 호환 alias). 안전 cap/fallback/HITL 전까지 일반 공개하지 않는다.


## v9 research and curriculum integration

- 업로드된 20개 심층 리서치와 기존 음색 리서치 1개는 `docs/research/v8/source-bundle/`에 정규화했다.
- `S/C/M/P/D` 근거 태그로 건강한 가수 직접 연구, 임상 근거, 운동학습 간접 근거, 전문가 합의, 제품 가설을 구분한다.
- 초기 5개 문서의 임시 인용은 복구 전까지 검증 완료 근거로 승급하지 않는다.
- v9 재점검과 출처는 `docs/research/v9/`, 설계 품질 게이트는 `CURRICULUM-QUALITY-GATES.md`를 따른다.

## v10 first learning vertical slice

- Universal Core 첫 12일과 Repertoire Application 첫 12일을 `app/assets/curriculum/`의 날짜별 blueprint로 구현했다.
- 첫 Core cycle은 낮은/중간 기준 cue 11개, 첫 phrase project는 낮은/중간 guide·backing과 click 9개를 사용한다.
- 사용자는 최대 음역이나 원키가 아니라 두 예시 중 편한 키를 선택하며, 둘 다 불편하면 듣기-only로 전환한다.
- 합성 자산은 full scale peak 0.50으로 제한한 기능 검증용 prototype이다. 실제 기기 음량·전문가 음역 검수·사용자 학습효과는 미검증이다.
- 권위 문서: `docs/curriculum/universal-core/CYCLE-01-DETAILED.md`, `docs/curriculum/repertoire-application/PROJECT-01-DETAILED.md`, `docs/app/TRAINING-AUDIO-ASSET-SPEC.md`.


## v11 learning evidence and audio-session integrity

- 첫 24일 vertical slice에서 시도·자기점검·예시 청취·선택 키·녹음 산출물·회복 모드를 local-first 수행 기록으로 남긴다.
- 기록은 가창 품질 점수나 E1~E5 달성 인증이 아니다. 실제 retention/transfer는 후속 checkpoint가 필요하다.
- 훈련 음원, 저장 take 재생, 마이크 녹음은 동시에 실행하지 않으며 앱이 resumed가 아니면 모두 중단/취소한다.
- 다음 권위 로드맵은 `docs/NEXT-VERSION-DIRECTION-v12.md`다.


## v15 timbre research integration

- 업로드된 음색 통합 리서치와 R1–R39 출처를 `docs/research/v15/`에 보존·분류했다.
- 12주 독립 코스는 만들지 않고 기존 초급–공통 코어–곡 적용–고급 구조에 나선형으로 병합했다.
- 카드 메타데이터 `timbreLayer`, `toneTagOptions`, `toneSequence`가 실제 녹음 A/B UI와 연결된다.
- `내 음색 팔레트`는 사용자 선택 데이터만 집계하며 진단·점수·가수 매칭을 하지 않는다.
- 공식/원문 spot-check가 끝나지 않은 출처는 출시 근거로 승급하지 않는다.
