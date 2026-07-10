> 2026-06-20 v11 업데이트: 이 파일은 과거 리뷰 스냅샷이며 최신 canonical 문서·코드 묶음이 아니다. 최신 상태는 `docs/FEEDBACK-UPDATE-2026-06-20-v11.md`, `docs/app/LEARNING-EVIDENCE-SPEC.md`, `docs/app/AUDIO-SESSION-INTEGRITY-SPEC.md`, `docs/NEXT-VERSION-DIRECTION-v12.md`, `docs/verification/VERIFICATION-STATUS.md`를 우선한다.

# Vocal Athlete — 전체 리뷰 번들 (REVIEW BUNDLE)

> **읽는 AI에게:** GitHub에 접근하지 마라. 이 한 파일에 프로젝트의 핵심 문서·전체 앱
> 소스(app/lib)·전체 테스트(app/test)가 `===== FILE: <경로> =====` 구분자로 **인라인**
> 되어 있다. 아래 내용만으로 리뷰하라. (커리큘럼의 일부 대용량 보조 문서 SOURCES.md 등은
> 생략됐을 수 있음 — 그건 `확인 필요`로 표기.)

## 너의 역할·산출물
시니어 모바일/프로덕트 엔지니어 + 발성·안전 도메인 검토자로서, 아래 전체를 꼼꼼히 읽고
다음을 한국어로, **근거 파일 경로를 인용하며** 작성하라:

A. **현황 요약** — 아키텍처·코드 품질·테스트 커버리지·제품 완성도·커리큘럼/안전 상태.
   각 1~2문단, 과대평가 금지(강점·약점 모두). 이제 소스·테스트가 다 있으니 코드 품질·
   커버리지도 *실제로* 평가하라.
B. **남은 작업 로드맵(P0/P1/P2)** — 각 항목: 무엇/왜/어떻게/의존성/리스크/대략 규모.
   특히 *출시까지의 임계 경로*를 명확히. 초급-only 선출시 트랙도 검토.
C. **수정/개선 제안** — 코드(구조·테스트·접근성·성능)·제품(UX·빈 상태)·커리큘럼(G1~G5)·
   인프라(CI·릴리스). 구체적으로, 파일·함수 단위로.
D. **사람 게이트 처리 방향** — 안전 HITL 사인오프 + 강제 캡(이슈 #1) + 장르 롤아웃 +
   기기 마이크 검증 + 고급/periodization. 누가·무엇을·순서.
E. **리스크·블로커 Top 5** — 출시·안전·규제(웰니스 vs 의료기기) 관점.

## 프로젝트 본질 (맥락)
- Flutter 스마트폰 앱: 듀오링고식 *하루 1레슨* 발성 트레이닝 + 연구근거 커리큘럼.
- 독특한 제약(반드시 이해): **무납득 설계(ADR-0002, 동기·설명 카피 없음)**, **시각 전용
  피치 피드백(ADR-0014)**, **1일1레슨·완료기반·시간게이트 없음(ADR-0003/0016)**,
  **안전 게이트**(belt/cover/messa/run은 전문가 HITL 사인오프 전까지 코드에서 잠금;
  k-keok 영구 제외; 중급 장르 코스는 구현됐으나 미출시), **세션-독립 검증 하네스**
  (인간 게이트를 git 산출물+자동 테스트로 검증; AI 자가 승인 금지).
- 과거 스냅샷 작성 당시 테스트 상태를 적은 문구다. v9 현재 환경에서는 `flutter test`를 실행해 재검증해야 하며, 이 파일의 수치를 현재 사실로 사용하지 않는다.

## 경계
- ADR·안전 규칙을 임의로 깨는 제안 금지(약점은 "재검토 제안"으로 분리). 안전 사인오프·
  장르 출시는 사람 결정 — 코드 자가 승인 제안 ❌. 근거 없는 단정 금지(확인 못 한 건
  "확인 필요"). 실제로 본 코드·문서만 근거로.

---

# 인라인 파일 모음

(아래부터 각 파일이 `===== FILE: 경로 =====` 헤더와 함께 이어집니다.)


############################################################
# ADRs (docs/adr)
############################################################


===== FILE: docs/adr/0001-safety-positioning-to-general-consumer.md =====

# 안전 포지셔닝 폐기 → 일반 소비자 앱 + 앱 실행 경고

원안 커리큘럼·앱 사양은 "음성과학 기반 보수적 자가 모니터링 안전 도구"를 핵심 차별점으로, 컨디션 게이트(5분)·적색신호 12개 A/B/C 3분기·발성 모듈 잠금·동반자(강사·SLP) 트랙·C 사용자 제외를 전제로 설계됐다. 이를 전면 폐기하고, 본 제품을 **일반 소비자 보컬 연습 앱 + 면책**으로 재정의한다. 안전 장치는 **앱 실행당 1회, 1-탭 확인하는 실행 경고**(하드-스톱 4신호: 통증·어지럼·호흡곤란·각혈 + "의료·진단 도구 아님") *하나로 일원화*한다.

## Considered Options

- **(기각) 동반자 트랙 + 적색신호 게이트 유지** — 안전 보수성·정직성 차별화는 강하나 제품 복잡도·운영 부담이 크고 일반 소비자 도달을 막음
- **(기각) 게이트는 없애되 C 사용자만 온보딩 1문항으로 차단** — "왜 C만? A/B는?" 일관성 붕괴, 정체성과 상충
- **(채택) 전면 폐기 + 실행 경고 일원화** — 단순성·일반 소비자 도달 우선, 모든 의료 판단을 사용자 책임으로 면책

## Consequences

- 커리큘럼 §3(컨디션 게이트 전체), §1 졸업목표 1(컨디션 점검)·5(적색신호 12개 이해), §2 적응형 안전 연장, §7 평가의 자가주도/동반자 분기는 **삭제·재서술 대상**
- 마케팅(`01-C`)의 "정직한 안전 차별화 vs Yousician" 포지셔닝 무효 — 별도 포지셔닝 필요
- "트랙"은 장르 축 전용, 지도 모드는 자가주도 단일값 (관련: [[CONTEXT.md]])

## 정정 (정합 검수, 2026-05)

- 하드-스톱 4신호(통증·어지럼·호흡곤란·각혈)는 **임상 적색신호 목록(AAO-HNSF/NIDCD) 그 자체가 아니다.** 통증·호흡곤란·각혈(≈혈담)은 그 목록과 정합하나, **어지럼**은 임상 dysphonia 적색신호가 아니라 *SOVT 과호흡 정지 cue*(아카이브 커리큘럼 빨대/호흡 카드 근거)다. 임상 목록의 "급격 음역 상실·애성 악화"·지속증상 4주 의뢰는 *의도적으로 제외*(본 ADR 일반소비자 피벗). 즉 4신호 = *소비자 앱 즉시중단 셋*이지 임상 목록이 아님 — 문서에서 그렇게 포장하지 말 것.
- AAO-HNSF/NIDCD는 CITATIONS.md 미등록(SRC-AAOHNS/SRC-NIDCD 플레이스홀더). 안전 문구를 임상 인용으로 제시 ❌.


===== FILE: docs/adr/0002-no-rationale-delivery-variation-only.md =====

# 무납득 운동 제시 + 변주 단일화 (과학 교육 페다고지 폐기)

원안 커리큘럼은 §8.5·§12·§13.6에서 "*반복의 학술 정당화를 학습자가 이해하면 지루함이 동기로 전환된다*"는 페다고지를 핵심 원칙으로 반복 강조했다(Fitts & Posner 3단계 설명, OPERA 가설, "과학 교육으로 동기"). 이를 폐기한다. 타깃 사용자(도파민 환경의 일반 소비자)에게 *납득 단계는 마찰*이라고 판단, 제품을 **운동 제시 → 사용자 수행**의 무납득 루프로 정의하고, 지루함은 *설명이 아니라 매일의 변주*(변이 5축 표면 변경)로만 해소한다.

## Considered Options

- **(기각) 학술 정당화 교육 유지** — 내재 동기·이탈 방지에 이론적 강점이나, 타깃 사용자층에 납득 과정이 진입 마찰로 작용
- **(채택) 무납득 제시 + 변주** — 마찰 최소화, 지루함은 경험 변화로 흡수

## Consequences

- 졸업목표 6(운동학습 3단계 언어 설명) 제거, 졸업은 4개 핵심 발성 스킬로 축소 (관련: [[CONTEXT.md]])
- §6.6 무대공포 7-Step Centering 모듈(졸업목표 8) 통째 삭제 — 앱 범위 외 + 자체 의료 의뢰 트리거가 ADR-0001(안전기계 제거)과 모순
- §12 학습자용 Fitts&Posner·OPERA 설명, §13.5 페이즈별 "학습자 메시지", §13.6 첫주 교육 메시지 = **삭제 대상**
- §13.1 Schmidt&Lee 등 학술 근거는 *내부 설계 근거로만* 잔존 — 학습자에게 노출 ❌

## Amendment (경계 정의 — 2026-05)

belt/twang 정확성 검토(전수 조사) 결과, "무납득"의 경계를 명확화한다:

- **금지 유지**: 동기부여·학술 정당화·"왜 효과 있나" 설명.
- **허용**: *과제를 정의하는 운동 지시 cue*는 rationale이 아니라 프롬프트다 — 예: "밝게(크게 아님)", "트웽 = 입 안 좁힘, 콧소리 ❌", 초급 "빨대를 이로 물지 마세요"와 동일 층위. 정당화 없이 *지시*만.
- **설명이 필요했을 위험은 설계로 제거**(설명하지 않음): ① 신뢰도 낮은 음향 수치(jitter·마이크 민감 지표)는 *애초에 표시 안 함* → 한계 설명 불필요. ② 자가피드백은 *듣고 판단*이 아니라 *시각 피치 곡선* 전용 → 골전도 착각이 개입할 여지 없음 → 설명 불필요.

→ ADR-0002 정신(무납득) 유지, belt/twang 정확성 모순(#3)을 재오픈 없이 해소.


===== FILE: docs/adr/0003-one-lesson-per-day-cap.md =====

# 일일 1레슨 캡 (듀오링고 무제한에서 의도적 이탈)

완료 기반 진행 + 듀오링고형 경로는 기본적으로 하루에 레슨을 무제한 연달아 할 수 있다. 그러나 소스 커리큘럼의 핵심 도메인 제약(운동학습·청각운동 매핑·점막 회복은 *시간 의존적*이며 빈도↑로 단축 불가)과 정면 충돌한다. **해금용 레슨을 1일 1개로 제한**한다 — 경로 레슨 수가 곧 졸업 최소 일수가 되어, 며칠 만에 졸업해 준비 안 된 채 중급(장르 코스)으로 가는 것을 막는다.

## Considered Options

- **(기각) 무제한 (순수 듀오링고)** — 참여 최대화에 유리하나 졸업·중급 진입 품질을 무의미화, 도메인 시간 의존성 무시
- **(채택) 1일 1레슨 캡** — 도메인 정합 + 듀오링고의 실제 가치(몰아치기 아닌 *매일 스트릭*)와도 더 일치

## Consequences

- 경로 길이 설계가 곧 졸업 소요 기간 설계가 됨 (관련: [[CONTEXT.md]])
- 더 하고 싶은 사용자를 위한 *해금·스트릭·졸업과 무관한 자유 연습 모드* 여부는 별도 미결


===== FILE: docs/adr/0004-hybrid-beginner-bar-6-8-weeks.md =====

# 하이브리드 초급 — 졸업 바를 낮추고 적응은 중급으로 연속 (6–8주)

소스 커리큘럼은 전제조건 적응이 *시간 의존적*이라 권장 20–32주가 필요하다고 못박았다. 그러나 일일 보컬 트레이닝 소비자 앱에서 "노래 한 곡 부르기 전 140일 기초"는 치명적 이탈을 부른다(도메인 충실 ↔ 소비자 현실 충돌). **하이브리드**를 택한다: 초급 졸업 바를 *적응 완성*이 아니라 **"노래 연습을 시작해도 안전·유효한 최소 입문 토대"**로 낮추고(초급 경로 ≈ 6–8주, 1일 1레슨 ≈ 40–56레슨), 시간 의존적 *완성*은 부정하지 않되 **장르 트랙(중급)에서 곡과 함께 연속**시킨다.

## Considered Options

- **(기각) A 도메인 충실(~140레슨/20주)** — 토대는 완벽하나 소비자 앱 이탈 치명적
- **(기각) B 압축** — 빠르나 토대 부실, ADR-0003(시간 의존성 보호) 정신 위배
- **(채택) C 하이브리드** — 초급은 *시작점*, 적응 완성은 초급+중급에 걸침. 도메인 진실과 소비자 현실 양립, ADR-0003(1일 1레슨 캡) 유지

## Consequences

- 커리큘럼 "초급 24주" 전면 재해석 — §4·§5·§6 콘텐츠를 6–8주 경로로 압축 재배열 (관련: [[CONTEXT.md]])
- 시간 의존 적응의 *완성 책임*이 중급 코스(본 문서 범위 밖)로 이전됨 — 중급 설계 시 명시 필요
- 졸업이 "숙련 증명"이 아님을 사용자 기대치에서도 관리해야 함(과대약속 금지)


===== FILE: docs/adr/0005-beginner-card-scope-split.md =====

# 초급 경로 카드 범위 — 13개 IN, 나머지 중급/컷

6–8주(≈40–56레슨, ADR-0004) 초급 경로의 척추를 졸업 4스킬 + 전제조건(호흡·신체) + 유성 마이크로-윈 기준으로 확정한다. **IN(13)**: §4.1 자세·Body Mapping, §4.2 흉곽-복부 호흡, §4.4 턱·혀·목 긴장해소, §4.5 가벼운 첫 소리, §4.6 골/공기 전도 자기청취, §5.1 빨대, §5.2 립 트릴, §5.3 허밍/NG-hum, §5.4 물저항 빨대, §5.5 균형 발성, §5.6 self-imitation, §5.7 시각 피드백, 표준 샘플 녹음 SOP. **OUT(중급/장르 또는 컷)**: §4.3 Appoggio 정교화, §5.8 VFE 심화, §5.9 자기 곡, §6.1·6.2 모음 정밀·전환, §6.3 placement(⚫ 측정변수 없음), §6.4·6.5 적용곡·레퍼토리, §6.6 무대공포(ADR-0002로 기 컷).

## Considered Options

- **(기각) 커리큘럼 20개 카드 전부 초급 유지** — 6–8주(ADR-0004)에 불가, 장르 갈림 기교를 초급에 섞음
- **(채택) 졸업 4스킬+전제조건 기준 13 IN, 나머지 명시적 OUT** — 척추 명확, "장르 갈림 기교 = 중급" 경계와 정합

## Consequences

- 명시적 OUT 목록 = 중급 코스 backlog의 일부로 누적 (관련: [[CONTEXT.md]] 중급 코스 항)
- 경계 카드(§4.3 Appoggio, §6.1 모음)는 의견 갈릴 수 있으나 초급은 *최소 입문 토대* 원칙으로 OUT 처리
- 중급 커리큘럼 문서는 아직 미작성 — 누적 backlog를 받을 별도 문서 필요(장르별 분기)


===== FILE: docs/adr/0006-beginner-macro-sequence.md =====

# 초급 매크로 시퀀스 — 13 IN 카드의 선형 배치

초급 경로(≈48레슨, 40–56 범위, ADR-0004/0005)의 콘텐츠 척추를 5개 내부 설계 블록으로 확정한다. 블록은 *설계 전용*이며 사용자에게 노출하지 않는다(ADR-0002). 비중 곡선 = 신체·호흡:유성을 70:30 → 20:80으로 점진 역전, 무성 레슨 0개(유성 마이크로-윈).

| 블록 | 레슨 | 신체·호흡:유성 | IN 카드 | 졸업 | 변주 |
|---|---|---|---|---|---|
| 1 토대 진입 | 1–8 | 70:30 | §4.1 자세·BodyMap, §4.2 호흡, §4.4 턱·혀·목 이완, §4.5 가벼운 첫 소리, §4.6 자기청취, 표준샘플#1(베이스라인) | ②④ 토대 | blocked, 변주 0 |
| 2 SOVT 도입 | 9–20 | 50:50 | §5.1 빨대(메인), §5.2 립트릴 | ① | blocked, 음역 1축 |
| 3 SOVT 확장 | 21–30 | 40:60 | §5.3 허밍/NG, §5.4 물저항 빨대 → SOVT 4종 완성, 표준샘플#2(A/B 1차) | ①③ | 음역+모음 2축 |
| 4 균형·자기청취 | 31–40 | 30:70 | §5.5 균형 발성 + §4.6 심화(과기식/균형/과압착) | ② | 3축 |
| 5 자기모방·시각피드백 | 41–48 | 20:80 | §5.6 self-imitation, §5.7 시각 피드백, 표준샘플#3(졸업 A/B) | ④③ | variable↑ |
| 졸업 | ~48 | — | 4스킬 완주 → 장르 트랙 선택 해금 | ①②③④ | — |

빨대(§5.1)는 블록1에서 *맛보기(micro-win)*로만 등장, *메인*은 블록2(레슨~9)부터 — 호흡 기초 선행. 표준샘플은 단발 카드가 아니라 3회 주기 레슨(베이스라인/중간/졸업)으로 졸업③ A/B 재료.

## Considered Options

- **(기각) 빨대 메인을 레슨~3로 조기 투입** — 도파민 윈은 강하나 호흡 기초 없이 SOVT 효과 반감
- **(채택) 호흡 토대 → SOVT 4종 → 균형·자기청취·자기모방 순, 맛보기로 조기 유성 윈** — 생리적 순서 + 조기 윈 양립

## Consequences

- 커리큘럼 §4·§5 콘텐츠를 이 블록 순서로 재배열·압축 작성해야 함(별도 작업)
- 블록 경계·레슨 수는 40–56 범위 내 조정 가능, 순서·비중 곡선은 고정 (관련: [[CONTEXT.md]])


===== FILE: docs/adr/0007-mt-intermediate-belt-entry-vs-full-belt.md =====

# 뮤지컬 중급 = 벨트 *진입*까지, 풀 벨트는 고급으로 분리

전수 조사(part 5/12/13/14/15/16, HP/QI 등) 결과: 뮤지컬은 전 장르 중 성대 병변 1위(3년 종단 39%, 클래식 22%·CCM 27%, Bretl 2023, 지연 발현), 벨트는 최대 부하(성문하압 말하기의 2–3배, CQ 상한 0.70), belt/twang 근거는 탐색적(RCT 부재). 코퍼스 자체 레벨표(part 15 §4)는 belt-safe-stage·디스토션을 **고급/전공**에, 중급은 모음조정·패사지오·믹스·*구강* 트웽 1단계에 둔다. 따라서 잠금 결정 "중급 = belt 포함"을 **벨트 *진입*(call-based·짧게·보수적·'밝게'를 중급 천장)** 으로 한정하고, **지속/풀 벨트·벨트-믹스 확장·디스토션·고부하 레퍼토리는 별도 고급 뮤지컬 컨텍스트**(미생성)로 분리한다. 뮤지컬 중급 척추 확정: 브리지(균형발성/SOVT 적응 완성) → 공명·모음조정 → 믹스+구강 트웽+패사지오+벨트 진입 → 텍스트→캐릭터→곡.

## Considered Options

- **(기각) 풀 벨트를 중급 유지 + 위험 명시 수용** — 잠금 결정과 단순하나 부상 데이터·코퍼스 레벨선과 정면 충돌, 자가 무코치 제품에서 무리
- **(채택) 벨트 진입/풀 벨트 분리** — "중급 = belt/mix/legit/twang/passaggio + 곡" 방향 유지(진입으로 충족), 부하 대폭↓, ADR-0004 하이브리드 정신과 동일(중급도 완성점 아님)

## Consequences

- 별도 **고급 뮤지컬 컨텍스트** 필요(미생성) — 풀 벨트·디스토션·고부하 레퍼토리 수용처
- 중급 곡 = legit + 라이트 벨트-진입 구절(풀 벨트 레퍼토리 ❌)
- 부하↓로 안전 모순 완화되나 *해소는 아님* — ADR-0001(안전 스캐폴딩 삭제)·ADR-0002(무납득)와 belt/twang 안전 cue 충돌은 미해결, 후속 그릴 (관련: [[CONTEXT.md]] intermediate-musical)

## 정정 (정합 검수, 2026-05)

- **part 15 §4는 중급에 belt를 *전혀* 두지 않는다.** 검증된 부분: 중급 = 모음조정·패사지오·믹스·*구강* 트웽 1단계·Bozeman / 고급 = belt-safe-stage(P15-19)·디스토션(P15-22). **"벨트 *진입* = 중급 천장"은 코퍼스 레벨링이 아니라 본 ADR의 보수적 *narrowing 결정*이다.** ADR-0008(위험 명시 수용)의 정당성은 이것이 *우리 선택*임에 달려 있으므로 명시.
- 벨트 음향 수치(R1:H2·CQ~0.5–0.6·Psub 1.5–2.5 kPa≈말하기 2–3배·"밝게 크게 아님")의 출처는 part 5/15가 아니라 **part 14 + part QI + part 4**다(part 5/15엔 belt 정량 정의 없음). 수치 자체는 정확.


===== FILE: docs/adr/0008-accepted-risk-mt-belt-no-load-monitoring.md =====

# 명시적 위험 수용 — 뮤지컬 중급 belt를 부하 모니터링 없이 가르침

전수 조사가 명확히 경고했다: 뮤지컬은 전 장르 중 성대 병변 1위(3년 종단 39%, *지연 발현* — 1년차 무증상 ≠ 안전, Bretl 2023), 코퍼스의 모든 안전 경로는 컨디션 게이트·EASE/VAS 일일 로그·적·황색 분기·belt 전 후두 평가를 *고부하 도입의 운영 전제*로 본다. 본 제품은 ADR-0001(일반 소비자 피벗)·ADR-0002(무납득)와의 *일관성·단순성*을 우선해 이 스캐폴딩을 belt 진입 맥락에서도 **복원하지 않는다**. 구조적 dosing 안전(belt-heavy 연속일 금지·24–48h 회복 자동 배치)조차 두지 않는다. 안전 장치는 **앱 실행 경고(하드-스톱 4신호 + 면책 + 18+) 하나뿐**이며, 그 외 누적·익일 피로·지연발현은 *제품이 감지하지 않는다*. 이 잔여 위험을 **명시적으로 수용**한다(침묵이 아니라 기록된 결정).

## Considered Options

- **(기각) B 구조적 dosing 안전** — 문진 0·무납득 유지하며 경로 설계로 위험 밀도 제거. 안전상 우수하나 제품 단순성·일관성보다 무겁다고 판단
- **(기각) C belt 전 readiness 체크** — ADR-0001 부분 위배
- **(채택) A 실행 경고만 + 위험 명시 수용** — ADR-0001/0002 완전 정합, 단순성 최우선, 잔여 부상 위험은 사용자 책임·면책으로 일원화

## Consequences

- 제품은 *최고 부상률 장르*의 belt 진입을 부하·피로 모니터링 없이 제공함을 *알고도* 진행 — 임상/리뷰어가 반드시 의문 제기할 지점, 그래서 명시 기록
- 향후 사고·법무·스토어 심사 시 본 ADR이 *의식적 트레이드오프였음*의 근거
- intermediate-musical 컨텍스트의 안전 미해결 항목은 *해소가 아니라 수용*으로 종결 (관련: [[CONTEXT.md]])
- belt-진입 한정(ADR-0007)이 부하를 낮춘 것이 이 수용의 *유일한* 완화 요인 — 풀 벨트가 고급으로 분리돼 있어야 본 결정이 성립


===== FILE: docs/adr/0009-mt-intermediate-macro-sequence.md =====

# 뮤지컬 중급 매크로 시퀀스·길이·한국어 딕션 배치

뮤지컬 중급 경로를 4개 설계 블록으로 확정한다(블록 = 설계 전용·비노출, ADR-0002). 길이 **약 10–14주(1일 1레슨 ≈ 70–98레슨)** — 초급(6–8주)보다 길다(초급이 미룬 시간 의존 적응 완성[ADR-0004 브리지] + 신규 레지스터 + 곡·캐릭터 부피). 완주 → **고급 뮤지컬** 해금(미생성 — Q21처럼 *장르 의향 수집 + 유지 모드*로 보류). 전수 조사가 드러낸 누락인 **한국어 딕션**(평·경·격음 VOT·종성 7대표음·연음·번역 뮤지컬 운율)은 *독립 기둥이 아니라* 텍스트→캐릭터→곡 단계의 **교차 스트림**으로 배치(딕션은 텍스트 전달을 위해서만 의미 — 고립 블록은 전이되지 않음, 코퍼스 원칙).

| 블록 | 비중 | 내용 |
|---|---|---|
| 1 브리지 | — | 초급 4스킬·SOVT 안정화 → 곡/레지스터 부하 직전까지 적응 완성 |
| 2 공명·모음조정 | — | part4: R1/포먼트, 모음조정 policy, 트웽 전 음향 토대 |
| 3 레지스터 | escalating | 믹스 → 구강 트웽 → 패사지오 내비게이션 → 벨트 진입(블록 말, 짧게·보수적, "밝게") |
| 4 텍스트→딕션→캐릭터→곡 | — | (한국어 딕션 미니 도입) → 텍스트 말로 전달 → 캐릭터 → legit + 라이트 벨트-진입 곡 구절 |

연구 part 3→4→5→6 핸드오프와 일치. 벨트 진입은 블록3 후반에만(ADR-0007), 곡은 legit 중심 + 라이트 벨트(풀 벨트 ❌ = 고급).

## Considered Options

- **(기각) 한국어 딕션을 독립 5번째 블록** — 고립 딕션 드릴은 텍스트/무대로 전이 안 됨(part 6 원칙)
- **(기각) 초급과 같은 6–8주** — 적응 완성+레지스터+곡 부피를 담기엔 짧음
- **(채택) 4블록 + 딕션 교차 스트림 + 10–14주** — 연구 핸드오프 체인·전이 원칙과 정합

## Consequences

- 고급 뮤지컬 컨텍스트(미생성)가 졸업 후 수용처 — Q21 졸업→전이 UX 미결이 여기에도 적용
- part 6-KR 한국어 딕션 카드(평경격음·종성·연음·번역운율)를 블록4 곡 작업에 직조 (관련: [[CONTEXT.md]] intermediate-musical)
- 블록 경계·레슨 수는 70–98 범위 내 조정 가능, 순서·딕션 위치는 고정


===== FILE: docs/adr/0010-unified-graduation-transition-retention.md =====

# 통합 졸업 전이·리텐션 모델 (모든 코스 경계 공통)

졸업이 "끝 = 이탈"이 되는 절벽 문제(초급→장르중급, 중급→고급 *양쪽*에 동일)를 단일 모델로 해소한다. **모든 코스 완주 시**: ① 축하 → ② 다음 코스 라우팅(초급 졸업 → 장르 트랙 선택[성악/뮤지컬/가요]; 중급 졸업 → 해당 장르 고급) → ③ 다음 코스가 있으면 진입, 없으면(성악·가요·고급 미작성) **유지 모드** 진입 + 장르 의향 기록 → 그 코스 출시 시 자동 연결. 제품 전역(모든 컨텍스트 상속).

정밀 결정:
- **장르 선택 비구속·변경 가능** — 메뉴에서 언제든 다른 장르로. 시작한 트랙은 별도 진척으로 유지(페널티 없음).
- **유지 모드 = V1 필수** — V1에 초급 졸업자가 반드시 생기는데 장르 중급이 미출시일 수 있어 이탈 방지 그물이 V1에 있어야 함. 연기된 "자유 연습 모드"(Q11)와 *별개* — 유지 모드는 스트릭 유지·1일1레슨 캡 적용·신규 해금 없음.
- **유지 모드 콘텐츠 = 직전 완주 코스 스킬만 얇게 반복**(초급졸업 → 4스킬 / 뮤지컬중급졸업 → 중급 스킬). 신규 ❌.

## Considered Options

- **(기각) 졸업 = 종료 화면** — 최대 이탈
- **(기각) 장르 선택 + "준비중" 대기** — 대기 중 이탈
- **(채택) 통합: 라우팅 or 유지 모드 + 자동 연결** — 졸업이 절벽이 아니라 전이, V1만으로도 무한 리텐션

## Consequences

- 유지 모드는 V1 스코프에 포함(자유 연습 모드와 구분해 구현)
- 장르 의향 데이터가 중급 트랙 출시 우선순위 신호가 됨
- 초급→중급, 중급→고급 모두 동일 코드 경로 (관련: [[CONTEXT-MAP]])

## 보강 (프로토타입 검증, 2026-05)

진행 상태머신 프로토(`prototypes/progression/`)가 드러낸 점: 졸업 레슨(경로 마지막 과)은 *그날 치 1레슨*이므로, 같은 날 장르 선택 후 다음 코스를 시작하려 하면 1일1레슨 캡(ADR-0003)이 막는다 — 규칙은 정확하나 밋밋한 "이미 했음" 에러가 *데드엔드*로 느껴진다. **결정(옵션 1, 메시징만, ADR-0003 불변)**: 졸업/전이 순간은 에러가 아니라 *전이 화면*으로 표현한다 — 졸업·장르 미선택 시 "🎉 경로 완주! 오늘은 여기까지 — 장르 고르고 내일부터", 장르 선택한 같은 날 시도 시 "🎉 전이 완료 — 내일 [다음 코스] 1과부터". 다음날 정상 진행. (구현 힌트: 코스 전이 발생일 `transition_day` 1필드.)


===== FILE: docs/adr/0011-shared-intermediate-core-genre-branch.md =====

# 중급 = 공유 코어 + 장르 분기 (분기점 = 블록3 레지스터)

성악(클래식)과 뮤지컬을 완전 분리할지 결합할지의 문제. 전수 조사 근거: 두 장르는 *전이 목표 자체가 반대*(클래식 cover/voce chiusa/copertura ↔ MT 증폭·speech-like·belt), 싱어즈 포먼트(클래식 필수 ↔ 증폭 MT 부적절), 후두높이·비브라토·레퍼토리·언어가 갈린다 → **완전 결합 시 한 커리큘럼이 모순 지시**. 그러나 브리지(P3-07 균형발성·SOVT·VFE·Appoggio 적응 완성)와 모음/포먼트 기초·패사지오의 *존재*는 genre-neutral이며 연구도 "Part 3 안정 → 장르 선택" 구조. 따라서 **C: 공유 코어 + 장르 분기**를 채택한다. 분기점 = **블록3 레지스터 시작**: 블록1 브리지 + 블록2 공명·모음조정 = *중급 공유 코어*(성악·뮤지컬 공통), 블록3 레지스터부터 장르별 분기(뮤지컬: 믹스·구강트웽·패사지오·벨트진입·텍스트/캐릭터/딕션/곡 / 성악: cover·voce chiusa·aggiustamento·아트송 — 추후).

## Considered Options

- **(기각) A 완전 분리** — 근거 정합 높으나 공유 브리지/공명을 장르마다 중복 제작
- **(기각) B 완전 결합** — 전이 목표가 정반대(cover ↔ belt)라 단일 커리큘럼이 모순 지시, 근거상 불가
- **(채택) C 공유 코어 + 블록3 분기** — 연구 "베이스→장르선택" 구조와 일치, 중복 제거 + 분기 지점만 장르별

## Consequences

- ADR-0009 매크로 시퀀스 정밀화: 블록1·2 = 공유 코어 컨텍스트, 블록3·4 = 뮤지컬 분기 컨텍스트 (ADR-0007 belt-진입 천장 불변, 분기 안에 위치)
- 신규 컨텍스트 `intermediate-core` 생성, `intermediate-musical`은 *분기*로 재정의 (관련: [[CONTEXT-MAP]])
- 성악 중급 = 동일 공유 코어에서 분기하는 별도 컨텍스트(미작성)
- 초급 졸업 → 장르 선택 → *공유 코어* → 블록3에서 장르 분기 (전이는 ADR-0010 통합 모델 그대로)
- ADR-0011(IN/OUT, 예정)은 코어-IN(블록1·2) vs 뮤지컬-분기-IN(블록3·4)으로 나눠 작성 → 번호 ADR-0012로


===== FILE: docs/adr/0012-intermediate-core-vs-mt-branch-card-scope.md =====

# 중급 카드 범위 — 공유 코어 IN vs 뮤지컬 분기 IN, OUT 분류

ADR-0011(공유 코어 + 블록3 분기)에 따라 중급 드릴을 코어/분기로 분할 확정한다.

**공유 코어 IN (블록1·2, genre-neutral):** P3-07 균형발성 · SOVT(straw P3-13·트릴·hum P3-19/20·WRT **P3-15**) · VFE 4과제 P3-08~12 · 온셋 유형 P3-01~05 · §4.3 Appoggio 정교화(*아카이브 커리큘럼 §4.3 — research ID 아님*) · P4-05 SOVT→개모음 전이 · P4-09/10 모음조정·포먼트튜닝 *기초* · P4-13 명료도↔효율 policy *개념* · P4-07 후두높이 *통제변수 인지* · P4-12 의도/비의도 비음 분리(트웽≠비음 cue 근거 = part5 L32) · 패사지오 *인지*(P5-03/06 인지 수준).

**뮤지컬 분기 IN (블록3·4):** P5-04 믹스 · 구강 트웽(P15-20 oral만) · 패사지오 *처리*(믹스·belt 방향) · P15-18 Bozeman 모음전환 · call-based 벨트 진입(천장) · P6-08 자음에너지 · P6-09 Rodenburg 텍스트 루프 · P6-10 명료도 블라인드 · 한국어 딕션 P6KR-01~09 · P6-07 패터 · P6-14 영어 딕션.

**OUT 분류:**
- → **고급 뮤지컬**: 풀/지속 벨트·Belt→Mix 확장·/æ,e/ 확장·디스토션 (ADR-0007). 요들은 원본(part5 L198)상 *중급~고급* — 우리는 보수적으로 고급에 둠(원본 그대로 아님)
- → **성악 분기 소관**(컷 아님, 미작성): cover/voce chiusa/copertura, aggiustamento(고소프라노 클래식 적용), **P4-06 Singer's Formant/vocal ring**(클래식·측정가능 — 정합검수에서 P4-06이 placement 은유 아님이 확인됨)
- **컷**: placement 은유(**P4-02/P4-04**, ⚫ 측정변수 없음 — *P4-06 아님*), CVT 풀 모드 시스템(상용·자체 10–15분 잠식), 판소리 시김새→애드립(가요/CCM 소관·안전근거 부족)

핵심 분할: P4-09/10/13은 *genre-neutral 기초·개념* = 코어, *MT 적용*(명료도 우선·belt 방향 모음) = 분기. aggiustamento의 클래식 고소프라노 적용 = 성악 분기.

## Considered Options

- **(기각) 단일 뮤지컬 IN 목록(코어 미분리)** — ADR-0011 공유 코어 구조와 불일치, 성악과 중복
- **(채택) 코어/분기 분할 + OUT을 고급/타분기/컷 3분류** — 중복 제거, "컷 ≠ 타 장르 소관" 구분으로 성악 분기 자산 보존

## Consequences

- VFE·Appoggio는 초급(ADR-0005)에서 미뤄져 *공유 코어 브리지*에 착지 — 모든 장르 공유
- 코어 IN은 성악·가요 분기도 그대로 상속(재제작 없음)
- 분기 카드 다수가 탐색적 근거(belt/twang) — ADR-0008 위험 수용 범위 내 (관련: [[CONTEXT-MAP]])


===== FILE: docs/adr/0013-mobile-stack-flutter.md =====

# V1 모바일 스택 = Flutter

V1은 그린필드 스마트폰 앱이며, 진짜 기술 리스크는 UI가 아니라 *저지연 마이크 → 온디바이스 F0 → 60fps 피치 곡선*(차별점 핵심: U4·A1)이다. 단일 개발자 유지비와 이 핵심 리스크를 함께 본 결과 **Flutter**를 채택한다. 단일 코드베이스, 60fps 커스텀 페인팅(CustomPainter — 피치 곡선에 RN보다 명백히 강함), 실시간 오디오는 stream 패키지 + C FFI(YIN) / `tflite_flutter`(CREPE)로 workable, 핫리로드·1커맨드·CI 용이.

## Considered Options

- **(기각) React Native(Expo)** — 이 앱 핵심(실시간 오디오)이 RN 최약점. 결국 네이티브 모듈 자작 → RN 복잡도 + 네이티브 작업 둘 다
- **(기각) 네이티브 2종(Swift+Kotlin)** — 오디오·ML 최상이나 단일 개발자에 2코드베이스 = 유지비 ~2배
- **(차선/폴백) 네이티브 1종 우선** — Flutter 오디오 지연이 실측 불충족 시 전환 경로
- **(채택) Flutter** — 유지비 ↔ 핵심 리스크 최선 절충

## Consequences

- **조건부 채택**: F1(스캐폴드)에 *마이크→F0→화면 지연 스파이크*를 끼워 본격 진행 전 실측. 지연 불충족 시 폴백 = 네이티브 1종 우선
- A0(피치 방식)는 Flutter 제약 안에서: YIN = C FFI, CREPE = `tflite_flutter`. A0 결정 시 이 경로 전제
- 실시간 오디오 패키지가 커뮤니티 의존 — 최저지연은 플랫폼 채널 필요할 수 있음(RN보다 적음)
- issue 01(F0) 해소; 02(F1)에 오디오 지연 스파이크 수용기준 추가


===== FILE: docs/adr/0014-pitch-detection-pyin-v1.md =====

# V1 피치 검출 = pYIN (온디바이스), CREPE-tiny는 V2 경로

실시간 시각 피치 피드백(U4·A1)의 결정 축: 저지연·컨슈머 마이크·비기너(음정 불안정 = 타깃)·Flutter 경로(ADR-0013)·단일 개발자. **V1 = pYIN 온디바이스(C via FFI)**. CREPE-tiny는 *문서화된 V2 업그레이드 경로*(견고성). 피치 소스는 교체 가능한 인터페이스로 분리(U4 수용기준)해 후일 pYIN→CREPE 교체를 저비용으로.

정직 한계(AI-ANALYSIS.md): F0·sustain만 표시, jitter/shimmer/HNR/AVQI 등 저신뢰 지표 비표시, 시각 전용(청각 자가판정 ❌).

> ⚠️ 근거 교체(CITATION-AUDIT R3, 2026-06): 종전 "컨슈머 마이크 정확도 한계" 근거였던
> MANFREDI2017은 오귀속(실제 Grillo 2016)에 프레이밍도 상충 → *폐기*. 정정된 실제 근거:
> 모바일 기기는 **F0는 robust하나 jitter·shimmer·HNR은 device bias·variability 큼**
> (J Voice 2022 "Comparison of Acoustic Voice Features Derived From Mobile Devices vs Studio
> Microphone Recordings" S0892199722003125; JSLHR 2024 10.1044/2024_JSLHR-23-00759;
> 스마트폰 임상 음성 정확도 체계적 리뷰·메타 pubmed 41037430. *1저자는 인용 전 확인 권장*).
> → 본 ADR의 "F0(시각 곡선)는 표시 / 저신뢰 perturbation·quality 지표 비표시"가 *이 증거와
> 정합*(F0=robust라 보여줌, jitter/shimmer/HNR=device bias라 숨김). 추가 근거: 골전도 자가청취
> 착각 차단(시각 전용). 시각전용 결론·설계 불변.

## Considered Options

- **(채택) pYIN V1 + CREPE V2 경로** — 저지연·무모델·결정적·유지 최소. 비차단 피드백(ADR-0002)이라 완벽 F0가 V1 게이트 아님
- **(기각) CREPE-tiny 우선** — 타깃(음정 불안정)에 견고성 우위는 실재하나 TFLite 파이프라인·지연·용량·배터리·유지비
- **(기각) 하이브리드** — 정확도/지연 최선이나 단일 개발자에 엔지니어링 최복잡

## Consequences

- **알려진 리스크(정직)**: 타깃=음정 부정확 비기너 = YIN계 최약 입력. 완화: 인-레슨 피드백은 *막지 않음*(ADR-0002) + 피치 인터페이스 분리로 V2 CREPE 교체 경로 확보
- F1 오디오 지연 스파이크는 *실제 pYIN 경로*로 수행해 본 결정 조기 검증
- A1(issue 25) = pYIN 구현으로 구체화; U4(issue 21) 인터페이스 = 교체 seam
- SOVT 버즈(립트릴·빨대) F0 정확도 저하 가능 — 해당 운동은 호흡·감각 위주라 V1 치명 아님


===== FILE: docs/adr/0015-content-schema-normalized.md =====

# 콘텐츠 스키마 = 정규화 (Card 템플릿 + PathManifest → LessonInstance 도출)

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

피치 피드백은 ADR-0014 인터페이스(pYIN V1) 경유. 표준샘플 SOP = `kind:standardSample` 카드를 특정 슬롯(#1/#~25/#48)에 배치.

## Considered Options

- **(채택) A 정규화** — 13카드 + manifest, 레슨 도출. 변주=축 선언+스케줄, 무납득·유성필수를 구조 강제. 경로 재튜닝=manifest만
- **(기각) B 평면(48 레슨 명시)** — 변주·blocked→variable이 박혀 재튜닝 불가, 잠긴 결정과 충돌
- **(기각) C 하이브리드** — 절충이나 두 군데 관리·A와 중복 소지

## Consequences

- C1(16) = 13 IN 카드를 이 Card 스키마로 작성(발성안전 검토)
- C2(17) = PathManifest 작성 + `resolve(Card,PathSlot,day)` 리졸버 구현
- C3(26) = 변주 엔진이 `variableAxes` + `PathSlot.variationLevel` 소비
- 무납득은 *스키마에 rationale 필드 부재*로 1차 강제(텍스트 검증은 C1/C2)
- 리졸버 정확성이 도출 모델의 핵심 — 단위테스트 필수


===== FILE: docs/adr/0016-trust-based-completion-no-time-gate.md =====

# 신뢰 기반 완료 — 본운동 시간 게이트 없음

라이브 테스트 중 드러난 설계 공백("본운동 정해진 시간 지나야 넘어가나?")을 명시 결정으로 박는다. 본운동에는 *시간/타이머 게이트가 없다*. 완료 = 사용자의 약속. 어기면 자기 손해, 앱은 막지 않는다(완료 기반·무납득·저마찰 원칙의 명시화).

1일1레슨 캡(ADR-0003)이 *유일한 rate-limit*. 듀오링고식 "운동 자체가 시간을 먹는" 가이드 시퀀스(C 옵션)는 *기각*(데이터/UI 재설계 비용 큼) — 단, 향후 cards.md의 voicedMicroWin·anatomy를 마이크로 스텝으로 풀어내고 싶다면 별도 슬라이스로 가능.

## Considered Options

- **(채택) A 신뢰 기반** — 완료 = 탭. ADR-0001·0002·0003·P2 정신과 정합. 마찰 0
- **(기각) B 강제 타이머** — 마찰 강함, "앉아만 있어도 통과" 실효 낮음
- **(기각) C 가이드 시퀀스(듀오링고)** — 정합 최고나 데이터·UI 큰 재설계, V1 범위 초과(향후 별도 슬라이스 가능)

## Consequences

- 본운동 7–11분은 *목표/UX 가이드*일 뿐 게이트 아님 (CURRICULUM 레슨 해부와 무모순)
- 캡 무반응 UX는 U5(넛지)로 보완 — *"오늘 끝"* 명시
- "다음날로 못 감" UX 공백은 별도 슬라이스(실 캘린더 바인딩)로 — 그 전엔 dev `다음날` 버튼 임시 사용


############################################################
# Root / Context
############################################################


===== FILE: CLAUDE.md =====

# CLAUDE.md

Behavioral guidelines to reduce common LLM coding mistakes. Merge with project-specific instructions as needed.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

---

**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.

## Agent skills

### Issue tracker

Issues live in GitHub Issues at `minseo2222/Vocal_Athlete` via the `gh` CLI. See `docs/agents/issue-tracker.md`.

### Triage labels

Canonical defaults: `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`. See `docs/agents/triage-labels.md`.

### Domain docs

Single-context: `CONTEXT.md` and `docs/adr/` at the repo root. See `docs/agents/domain.md`.


===== FILE: CONTEXT.md =====

# 초급 보컬 커리큘럼 — 도메인 용어집

일일 보컬 트레이닝 앱(듀오링고형 습관 루프)의 **초급 커리큘럼** 도메인 언어. 초급은 노래의 전제조건(호흡·발성·신체)을 만드는 장르-무관 단계이며, 수료 후 장르 트랙을 골라 중급 코스로 간다. 구현·앱 사양은 여기 두지 않는다(글로서리 전용).

## Language

### 학습 운영

**자가주도 (Self-Directed)**:
본 제품의 *유일한* 학습 운영 방식. 학습자가 도구·평가를 모두 스스로 수행하며, 앱은 추정치·연습 보조 신호만 제공한다. 일반 소비자 보컬 연습 앱이며 진단·치료·임상 안전 모니터링 도구가 아니다.
_Avoid_: 자가주도 "트랙"(트랙은 장르 축 전용), "동반자 트랙", "강사 트랙", "보수적 안전 도구"(폐기된 포지셔닝)

**지도 모드 (Supervision Mode)**:
누가 학습을 감독하는가의 축. 본 제품에서는 값이 **자가주도 하나로 고정**(강사 동반·임상 동반 모드는 제품에서 제거됨, 외부 의뢰로만 안내).
_Avoid_: "트랙"

**장르 트랙 (Genre Track)**:
학습자가 지향하는 음악 장르 축(성악/뮤지컬/가요 등). **초급 수료 후** 학습자가 선택하며, 어떤 중급 코스로 갈지를 가른다. 초급 커리큘럼 자체는 *장르 트랙 무관(공통)*.
_Avoid_: "스타일", "트랙"을 감독 의미로 쓰는 것

**초급 커리큘럼 (Beginner Curriculum)**:
노래를 하기 위한 *전제조건*(호흡·발성·신체·자기 청취)을 만드는 장르-무관 단계. 본 제품/문서의 범위. 초급을 마쳐야 장르 트랙·중급에 진입할 수 있다.
_Avoid_: "노래 강습"(초급은 곡 학습이 아니라 토대 만들기)

**중급 코스 (Intermediate Course)**:
초급 수료 + 장르 트랙 선택 *이후* 진입하는 장르별 과정. 본 문서 범위 **밖**(별도 커리큘럼, *아직 미작성*). 초급에서 미뤄진 backlog가 여기로 누적된다 — **파사지오·비브라토·댐핑·레지스터/믹스·벨트·고음**(장르 갈림) + §4.3 Appoggio 정교화 + §5.8 VFE 심화 + §5.9 자기 곡 + §6.1·6.2 모음 정밀·전환 + §6.4·6.5 적용곡·레퍼토리 + 시간 의존 적응 *완성*(ADR-0004).
_Avoid_: 초급과 묶어 다루는 것, 초급에서 이 backlog를 다루는 것

**전제조건 경계 (Prerequisite Boundary)**:
초급은 *노래의 전제조건(균형 발성·호흡·신체·자기청취)* 만 만든다. "장르마다 정반대로 갈리는 기교"는 초급이 아니다 — 초급의 역할은 그것들이 *배울 수 있게 되는 몸 상태*를 만드는 것뿐. 비브라토는 초급에서 *훈련도 억제도 언급도 안 함*(균형 발성에서 후일 창발).
_Avoid_: 초급에 파사지오/비브라토/댐핑/벨트/고음/음역확장을 넣는 것

### 안전

**하드-스톱 신호 (Hard-Stop Signal)**:
즉시 중단하고 의료기관을 방문해야 하는 4개 신호: **통증 · 어지럼 · 호흡곤란 · 각혈**. 앱 실행 경고에 명시된다. 게이트·점수·잠금·분기·문진 없음.
_Avoid_: "적색 신호 12개", "컨디션 게이트", "A/B/C 분기", "제외 기준"(전부 폐기됨)

**앱 실행 경고 (Launch Warning)**:
앱 실행당 1회, 진입 시 표시되는 1-탭 확인 문구. 하드-스톱 4신호 + "의료·진단 도구 아님" 면책 + **"만 18세 이상·변성기 종료 대상" 1줄**. 이것이 본 제품 안전 장치이자 *유일한 관문*이다. 누구도(두경부암 병력자·미성년 포함) 별도 차단·문진하지 않으며, 모든 판단은 사용자 책임으로 이 문구에 일원화된다.
_Avoid_: "온보딩 의료 동의 플로우", "연령 게이트", "적응형 안전 연장", "세션당 경고"(앱 실행당이 맞음)

**온보딩 (Onboarding)**:
*없음.* 실행 경고 1탭 → 곧장 레슨 1. 의료동의·설문·연령 게이트·장르 질문 일체 없음(장르는 졸업 후). **시작에 계정 불필요** — 계정은 진척 동기화용 선택사항(추후).
_Avoid_: "베이스라인 설문", "온보딩 플로우", 시작 시 계정 강제

### 학습 경험

**운동 제시 루프 (Exercise-Delivery Loop)**:
본 제품의 핵심 상호작용. *운동을 제시 → 사용자가 수행*. 그 사이에 "왜 이렇게 하는가"를 납득시키는 교육/정당화 단계가 **없다**. 단 *과제를 정의하는 운동 지시 cue*("밝게, 크게 아님", "트웽=입 안, 콧소리 ❌", "이로 물지 마세요")는 rationale이 아니라 프롬프트 — 허용. 마찰 최소화가 원칙.
_Avoid_: "학술 정당화", "과학 교육으로 동기", "반복의 정당화 마이크로 강의", "납득 과정"; 운동 지시 cue를 "설명/교육"으로 오해하는 것

**관대 스트릭 (Lenient Streak)**:
습관 신호로서의 스트릭은 유지하되 *가혹 리셋 없음* — 하루 놓쳐도 0으로 떨어지지 않는다(커리큘럼 §8.4 정합). **streak freeze는 의도적으로 두지 않음**(듀오링고와의 차별화). 공백은 페널티가 아니라 *복귀 복습*으로 처리한다.
_Avoid_: "streak 0 리셋", "streak freeze", "연속 접속 페널티"

**복귀 복습 (Return Review)**:
**7일 이상** 공백 후 돌아온 사용자에게 *벌점·강제 후퇴가 아니라* 이미 완료한 내용의 복습 트레이닝을 제공해 재진입을 돕는다. 복귀 첫 세션은 *복습 레슨이 그날의 1레슨*(신규 해금은 다음날부터). 공백이 길수록 복습일 증가(7–14일 → 복습 1일, 그 이상 → 2일). 졸업일은 징벌 없이 *자연 지연*만. (커리큘럼 §2 "7일 미접속 → 전 주차 후퇴"를 *지지적 복습*으로 재해석.)
_Avoid_: "미접속 후퇴 페널티", "전 주차 강등", 복귀일에 복습+신규 동시(캡 위반)

**레슨 해부 (Lesson Anatomy)**:
한 레슨(10–15분) = 진입/워밍업 ~1–2분(SOVT가 겸함, 전용 워밍업 슬롯 최소) + 본운동 ~7–11분(+변주·인-레슨 피드백) + 쿨다운 ~1–2분(*권장이나 스킵 가능*, 게이트 아님). 커리큘럼 "쿨다운 5분 의무"를 압축·비강제로 재해석.
_Avoid_: "쿨다운 5분 의무", "워밍업 전용 5분", 쿨다운을 해금 조건으로 쓰는 것

**유성 마이크로-윈 (Voiced Micro-Win)**:
*모든 레슨*에 소리 내는 요소가 최소 1개 — **무성 전용 레슨 0개**. 1일차부터 자기 소리를 듣고 인-레슨 피드백을 받는다. 신체·호흡:유성 비중은 초반 **약 70:30**에서 졸업 무렵 역전. "곡(노래)"은 여전히 초급에 없음(장르 트랙 소관) — *발성 자체*만 1일차부터.
_Avoid_: "무성 레슨", "Phase A는 소리 없음", 초반에 곡 도입

**고정 선형 경로 (Fixed Linear Path)**:
모든 사용자가 *같은 레슨을 같은 순서로*. 수행에 따른 적응형 재배열·분기 없음(삭제한 평가 로직을 되살리므로). 듀오링고 클래식 경로.
_Avoid_: "적응형 경로", "개인화 재배열", "수행 기반 분기"

**변주 (Variation)**:
지루함을 줄이는 *유일한* 수단. 경로를 가르지 않고, 반복되는 *레슨 타입 안에서* 표면만 바꾼다(음역·모음·글라이드·멜로디·세션 위치 = 변이 5축). 변주 강도는 경로 따라 *내부적으로* 상승(초반 blocked 우세 → 후반 variable↑, §13.5 비율은 내부 설계 전용). 학습자를 *설명으로 설득*하지 않고 *경험을 바꿔서* 이탈을 막는다.
_Avoid_: "지루함을 설명으로 해소", 변주로 경로가 갈린다고 보는 것, 변주 근거를 학습자에게 설명

**완료 기반 진행 (Completion-Based Progression)**:
레슨을 *완료하면* 다음이 해금된다. 수행 품질은 해금을 막지 않는다(듀오링고와 동일). 유일한 명시적 평가 지점은 졸업이며, 그 졸업조차 *시험이 아니라 경로 완주*다.
_Avoid_: "체크포인트 시험", "수행 게이트", "통과 판정", "페이즈 전환 조건"

**통합 전이 (Unified Transition)**:
모든 코스 완주 시 동일: 축하 → 다음 코스 라우팅(초급→장르 트랙 선택 / 중급→고급) → 다음 코스 있으면 진입, 없으면 **유지 모드** + 의향 기록 → 출시 시 자동 연결. 장르 선택은 *비구속·변경 가능*. 제품 전역.
_Avoid_: "졸업 = 종료", "장르 선택 = 영구 확정"

**유지 모드 (Maintenance Mode)**:
다음 코스가 없을 때 진입하는, *직전 완주 코스 스킬만 얇게 반복*하는 일일 루프. 스트릭 유지·1일1레슨 캡 적용·신규 해금 없음. **V1 필수**(이탈 방지 그물). 연기된 [[자유 연습 모드]]와 별개 — 그쪽은 스트릭·진척 무관.
_Avoid_: "자유 연습 모드와 동일", 유지 모드에서 신규 스킬 해금

**자유 연습 모드 (Free Practice Mode)**:
1일 1레슨 캡과 *완전 분리된* 추가 연습 공간 — 해금·스트릭·졸업·진척에 1mm도 영향 없음. **개념만 채택, 현재 구현 안 함(추후 확장 예정)**. 미래 콘텐츠 후보: 도레미파솔 음정 드릴, 진도 맞춤 곡 등(추후 확정).
_Avoid_: 자유 연습으로 신규 운동 해금(캡 우회 ❌), "V1 기능"으로 취급

**일일 1레슨 캡 (One-Lesson-Per-Day Cap)**:
하루에 *해금용 레슨 1개*만 완료할 수 있다. 발성 적응(운동학습·청각운동 매핑·점막 회복)은 시간 의존적이라 빈도로 단축 불가 — 경로 길이가 곧 졸업 최소 일수다. 몰아치기로 며칠 만에 졸업해 준비 안 된 채 중급으로 가는 것을 막는다.
_Avoid_: "무제한 레슨", "몰아치기 졸업"

**인-레슨 피드백 (In-Lesson Feedback)**:
AI 발성 분석(과기식/균형/과압착 — 정식 표기 **저접지/균형/과접지**, hypo/balanced/hyper-adduction; CITATIONS·QI 기준)·표준 샘플 A/B·실시간 *시각* 피치 피드백. *정보 제공·연습 재료*일 뿐 해금·졸업을 **막지 않는다**. 단 크게 빗나가면 *선택형* "다시 해볼까요?" 넛지 1개 + 1줄 교정 팁(건너뛰기 자유). **신뢰도 낮은 음향 수치(jitter·마이크 민감 지표)는 표시하지 않는다**(한계를 설명할 필요 자체를 제거). 자가피드백은 *듣고 판단*이 아니라 *시각 곡선 전용*(골전도 착각 차단).
_Avoid_: 피드백을 "관문/판정"으로 쓰는 것, 강제 재시도, 신뢰도 낮은 수치 노출, "듣고 스스로 평가하라"

**졸업 (Graduation)**:
초급 커리큘럼 *경로 완주* = **장르 트랙 선택·중급 코스 진입의 관문**. 졸업 바는 *적응 완성*이 아니라 **"노래 연습을 시작해도 안전·유효한 최소 입문 토대"**(바를 의도적으로 낮춤). 4개 핵심 발성 스킬(① SOVT 4종 자가 워밍업 ② 과기식/균형/과압착 자기 청지각 식별 ③ 표준 샘플 전후 A/B ④ self-imitation + 시각 피드백 자가 사용)은 *시험 항목이 아니라 경로 레슨들이 반복 연습시키는 내용*이며, 완주가 곧 그 증명이다.

**초급 경로 (Beginner Path)**:
졸업까지의 선형 레슨열. 목표 길이 **약 6–8주(1일 1레슨 ≈ 40–56레슨)**. 척추 = **13개 IN 카드**(§4.1·4.2·4.4·4.5·4.6 + §5.1·5.2·5.3·5.4·5.5·5.6·5.7 + 표준샘플 SOP)를 변주로 펼침: 호흡·신체 토대 → SOVT 4종 → 균형 발성·자기청취·시각 피드백. 커리큘럼 "20–32주 적응"은 부정 안 하되 *완성*은 중급으로 연속(ADR-0004) — 초급은 시작점이지 완성점이 아님.
_Avoid_: "초급 24주", "초급에서 적응 완성", "140일 경로", IN 외 카드(모음정밀·곡·placement·VFE·appoggio정교화)를 초급에 넣는 것
_Avoid_: "8개 목표", "컨디션 점검 졸업기준", "적색신호 이해 졸업기준", "운동학습 3단계 설명 졸업기준", "무대공포 7-Step"(전부 제거됨)

**레슨 인스턴스 (Lesson Instance)**:
*오늘 학습자에게 보일 한 단위*. **Card**(템플릿) + **PathSlot**(위치) + day로 *런타임 도출*되는 비저장 객체. 카드 raw + variation(키=값 맵) + 파생 표면(예: 변주 라벨, 유성 마이크로윈 유무)을 한 곳에 묶는다. 코드의 `LessonInstance` = 같은 개념. UI는 카드 lookup과 변주 선택을 따로 호출하지 않고 `resolveLessonInstance(slot, day)` 한 번으로 받는다(ADR-0015 정합).
_Avoid_: "오늘의 카드"(라벨이 카드만 의미하는 듯 보임), 카드 라이브러리에서 직접 슬라이스별 데이터를 꺼내는 호출 흐름

## Relationships

- **지도 모드**는 본 제품에서 **자가주도** 단일 값으로 고정된다 — 강사·임상 동반은 제품 기능이 아니라 *외부 의뢰*다
- **장르 트랙**과 **지도 모드**는 서로 다른 축이다 (한쪽이 다른 쪽을 함의하지 않음)
- **하드-스톱 신호**는 **앱 실행 경고** 안에서만 노출된다 (별도 게이트·로직·문진 없음)
- **변주**는 **운동 제시 루프** 안에서 표면을 바꿔 지루함을 막는다 — 학습자에게 그 이유를 설명하지 않는다
- **졸업**은 4개 핵심 스킬로만 정의된다 (안전·메타인지·무대공포 항목은 졸업과 무관)
- **인-레슨 피드백**은 **완료 기반 진행**을 절대 막지 않는다 (정보·선택형 넛지일 뿐)
- **졸업**(경로 완주)은 **장르 트랙** 선택과 **중급 코스** 진입을 해금한다
- **일일 1레슨 캡** → 경로 레슨 수 = 졸업 최소 일수 (시간 의존적 적응 보호, ADR-0003)
- **초급 경로**(6–8주)는 *적응 완성*이 아니라 *최소 입문 토대*까지만 — 시간 의존 적응은 **중급 코스**로 연속 (하이브리드, ADR-0004)

## Flagged ambiguities

- "트랙"이 *감독 축*(자가주도/강사/임상)과 *장르 축*(클래식/뮤지컬/CCM) 양쪽에 쓰였음 — 해결: "트랙"은 **장르 축 전용**, 감독 축은 **지도 모드**(현재 자가주도 단일값)
- 커리큘럼 §3 적색신호 12개·컨디션 게이트·A/B/C 분기·self-attestation 잠금·C 제외 전부 폐기 → **앱 실행 경고(하드-스톱 4신호 + 면책)** 1개로 일원화 (ADR-0001)
- "제외 기준"(C 사용자 차단) 폐기 — 컨디션 게이트가 없어 강제할 수단도 없고, 정체성(일반 소비자 앱 + 면책)과 일관되게 면책 문구로 흡수
- 커리큘럼 §8.5·§12·§13.6의 "과학 교육으로 동기 / 학술 정당화 이해" 페다고지 정면 폐기 → **운동 제시 루프(무납득) + 변주**로 대체. 졸업목표 6·모듈 §6.6(무대공포 목표 8)·§12 학습자용 Fitts&Posner·OPERA 설명 전부 제거 (ADR-0002)
- 커리큘럼 "초급 24주(20–32주)" 재해석 — 초급은 6–8주 *최소 입문 토대*, 시간 의존 적응 완성은 초급+중급에 걸침 (ADR-0004)
- 잠긴 *제품 메커니즘*(듀오링고 일일·1일1레슨 캡·완료 기반·무납득·관대 스트릭·실행 경고·레슨 해부)은 *제품 전역* — 중급도 상속
- 곡/레퍼토리는 초급 끝까지 없음 → **중급에서 처음 등장**(뮤지컬=텍스트·캐릭터 기반 곡)
- Q21 졸업→전이 UX — 해결: 모든 코스 경계 공통 **통합 전이 + 유지 모드**(ADR-0010), 유지 모드 V1 필수
- 멀티컨텍스트 전환 — `CONTEXT-MAP.md` 생성, 본 문서 = 초급 공통 컨텍스트, 중급 뮤지컬은 별도 컨텍스트(survey 후 lazy 생성)
- 정합 검수 정정(2026-05): ① 물저항 SOVT = **P3-15**(P3-22 오기 수정) ② placement-컷 카드 = **P4-02/P4-04**, P4-06은 Singer's Formant(클래식→성악 분기) ③ "belt 진입=중급"은 코퍼스 레벨링 아닌 *우리 narrowing 결정*(ADR-0007 정정) ④ 하드-스톱 4신호 = 소비자 앱 즉시중단 셋, *임상 적색신호 목록 아님*(어지럼=SOVT 과호흡 cue, ADR-0001 정정) ⑤ 3분류 정식 표기 = **저접지/균형/과접지**(과기식/과압착은 표면 별칭)


===== FILE: CONTEXT-MAP.md =====

# Context Map

보컬 트레이닝 앱의 도메인 컨텍스트. 제품 메커니즘(듀오링고 일일·1일1레슨 캡·완료 기반 진행·무납득 운동 제시·관대 스트릭·앱 실행 경고·레슨 해부)은 *제품 전역*이며 모든 컨텍스트가 상속한다.

## Contexts

- [초급 공통](./CONTEXT.md) — 노래의 전제조건(호흡·발성·신체·자기청취)을 만드는 장르-무관 초급 커리큘럼. 곡 없음. 졸업 = 장르 트랙 선택·중급 진입 관문.
- [중급 — 공유 코어](./docs/curriculum/intermediate-core/CONTEXT.md) — 초급 졸업 + 장르 선택 후, *분기 이전* 모든 장르 공통. 블록1 브리지 + 블록2 공명·모음조정 (genre-neutral, ADR-0011).
- [중급 — 뮤지컬(분기)](./docs/curriculum/intermediate-musical/CONTEXT.md) — 공유 코어 이후 뮤지컬 분기. 블록3 믹스·구강트웽·패사지오·**벨트 진입** + 블록4 텍스트·딕션·캐릭터·곡.
- **중급 — 성악/가요(분기)** (미생성) — 동일 공유 코어에서 분기. 성악 = cover·voce chiusa·aggiustamento·아트송 등.
- **고급 — 뮤지컬** (미생성) — 풀/지속 벨트·벨트-믹스 확장·디스토션·고부하 레퍼토리. 중급의 belt-진입 천장을 이어받음 (ADR-0007).

## Relationships

- **초급 공통 → 중급 공유 코어 → 장르 분기**: 초급 졸업(4핵심 스킬) → 장르 선택 → 공유 코어(브리지·공명) → 블록3에서 장르 분기 (ADR-0011). 초급이 미룬 적응 완성은 코어의 브리지가 이어받음 (ADR-0004)
- **곡 경계**: 곡/레퍼토리는 초급·공유 코어에 없고 *장르 분기*(뮤지컬 블록4)에서 처음 등장
- **전이**: 모든 코스 경계는 ADR-0010 통합 전이(완주→라우팅 or 유지 모드→출시 시 자동 연결)
- 성악·가요 중급은 동일 공유 코어에서 분기하는 별도 컨텍스트(미작성)


===== FILE: app/pubspec.yaml =====

name: vocal_athlete
description: "A new Flutter project."
# The following line prevents the package from being accidentally published to
# pub.dev using `flutter pub publish`. This is preferred for private packages.
publish_to: 'none' # Remove this line if you wish to publish to pub.dev

# The following defines the version and build number for your application.
# A version number is three numbers separated by dots, like 1.2.43
# followed by an optional build number separated by a +.
# Both the version and the builder number may be overridden in flutter
# build by specifying --build-name and --build-number, respectively.
# In Android, build-name is used as versionName while build-number used as versionCode.
# Read more about Android versioning at https://developer.android.com/studio/publish/versioning
# In iOS, build-name is used as CFBundleShortVersionString while build-number is used as CFBundleVersion.
# Read more about iOS versioning at
# https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html
# In Windows, build-name is used as the major, minor, and patch parts
# of the product and file versions while build-number is used as the build suffix.
version: 1.0.0+1

environment:
  sdk: ^3.12.0

# Dependencies specify other packages that your package needs in order to work.
# To automatically upgrade your package dependencies to the latest versions
# consider running `flutter pub upgrade --major-versions`. Alternatively,
# dependencies can be manually updated by changing the version numbers below to
# the latest version available on pub.dev. To see which dependencies have newer
# versions available, run `flutter pub outdated`.
dependencies:
  flutter:
    sdk: flutter

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.8

  # 진행 상태 영속화(Task 2).
  shared_preferences: ^2.3.0

  # 실 마이크 PCM 스트림(A1 — frames 어댑터).
  record: ^6.2.1

dev_dependencies:
  flutter_test:
    sdk: flutter

  # The "flutter_lints" package below contains a set of recommended lints to
  # encourage good coding practices. The lint set provided by the package is
  # activated in the `analysis_options.yaml` file located at the root of your
  # package. See that file for information about deactivating specific lint
  # rules and activating additional ones.
  flutter_lints: ^6.0.0

# For information on the generic Dart part of this file, see the
# following page: https://dart.dev/tools/pub/pubspec

# The following section is specific to Flutter packages.
flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true

  # To add assets to your application, add an assets section, like this:
  # assets:
  #   - images/a_dot_burr.jpeg
  #   - images/a_dot_ham.jpeg

  # An image asset can refer to one or more resolution-specific "variants", see
  # https://flutter.dev/to/resolution-aware-images

  # For details regarding adding assets from package dependencies, see
  # https://flutter.dev/to/asset-from-package

  # To add custom fonts to your application, add a fonts section here,
  # in this "flutter" section. Each entry in this list should have a
  # "family" key with the font family name, and a "fonts" key with a
  # list giving the asset and other descriptors for the font. For
  # example:
  # fonts:
  #   - family: Schyler
  #     fonts:
  #       - asset: fonts/Schyler-Regular.ttf
  #       - asset: fonts/Schyler-Italic.ttf
  #         style: italic
  #   - family: Trajan Pro
  #     fonts:
  #       - asset: fonts/TrajanPro.ttf
  #       - asset: fonts/TrajanPro_Bold.ttf
  #         weight: 700
  #
  # For details regarding fonts from package dependencies,
  # see https://flutter.dev/to/font-from-package


############################################################
# Curriculum (top docs)
############################################################


===== FILE: docs/curriculum/CURRICULUM-REVIEW.md =====

# 커리큘럼 전체 검토 (자료 수집·검증 반영, 2026-06)

> 5단위(초급·중급코어·중급뮤지컬·성악·가요)를 RESEARCH-INDEX·VERIFICATION-MASTER·
> CITATION-AUDIT 결과와 대조한 *비판적 전체 검토*. 요약 아닌 정합성·갭·문제점 진단.

## 1. 전체 구조 — 정합 양호

경로: **초급(48레슨, 5블록)** → **중급 코어(블록1 브리지·블록2 공명·모음조정, genre-neutral)** →
**장르 분기(뮤지컬/성악/가요, 블록3 레지스터·블록4 텍스트·딕션·곡)** → 고급(미생성) → 통합 전이.

- ADR-0004(적응 완성 연속)·0011(공유 코어+블록3 분기)·0010(졸업/전이/유지)이 일관 적용. ✅
- 패사지오 핸드오프(코어=*인지* → 분기=*처리*: 뮤지컬 믹스/belt, 성악 cover)가 깔끔. ✅
- 전이목표 정반대(cover↔belt)를 코어에 장르색 금지로 분리 — 설계적으로 옳음. ✅

## 2. 단위별 검토

| 단위 | 카드 | 근거 품질(post-audit) | 평가 |
|---|---|---|---|
| 초급 | 13 IN(CARD-01~13) | SOVT RCT(ANDRADE/Adriaansen)·호흡 HIXON·3분류 KIM2025·운동학습 Schmidt&Lee | **견고**. 사인오프 완료, 변경 0 |
| 코어 | 11(IC-01~11) | VFE RCT(STEMPLE)·Appoggio MILLER·패사지오 ROUBEAU·트웽 Jelinger | **견고**. genre-neutral 잘 지켜짐 |
| 뮤지컬 | 12(IM-01~12) | belt MCGLASHAN2017(탐색적)·믹스 합의없음 | **양호+안전 HITL**. belt 보수 |
| 성악 | 9(CL-01~09) | cover MILLER·aggiustamento CHAN_DO·ring SUNDBERG | **양호+HITL**. ADR-0012 정합 |
| 가요 | 9(GY-01~09) | K-pop 매핑(산업)·트웽 Jelinger·딕션 LEE2020CGU | **양호+안전 S**. k-keok 제외 |

무납득(ADR-0002)·시각전용(ADR-0014)·1일1레슨(ADR-0003)은 전 단위 일관. ✅

## 3b. 갭 해소 현황 (구현 goal D1~I6, 2026-06)

- **G1 중급 레슨 수 ✅ 해소**: 코어·3분기 블록별 레슨 수 + 카드→레슨 변주 확장 명세(D1).
- **G2 표준샘플 SOP ✅ 해소**: IC-12 표준샘플 자기평가 카드 + 블록 경계 삽입(D2).
- **G3 커리큘럼↔앱 구현 ✅ 해소**: 중급 ~50카드 card_library 이식(I1) + 코스 manifest
  빌더(I2) + 졸업→분기 진입 실 로드(I3) + 분기 완주→유지(I4) + 안전 게이트(I5) +
  정합 가드(I6). 141 tests green. *롤아웃 스위치*(release·safetyApproved)는
  `INTERMEDIATE-IMPL-VERIFY.md` 참조(기존 ADR-0010 P10 + 안전 게이트).
- **G4 고급 트랙 ⬜ 범위 밖(의도적)**: 풀 벨트 등 신규 고위험 = 안전 설계 + HITL 필요.
- **G5 periodization/디로드 ⬜ 범위 밖**: 코어 갭 후보로 잔존.

## 3. 🔴 발견된 실질 갭 (우선순위) — 원본(이력 보존)

### G1. 중급 레슨 수 ↔ 카드 수 매핑 부재 (설계 갭)
- 초급은 *5블록 × 레슨범위 + 13카드 → 48레슨(변주로 확장)* 명세가 명확.
- 중급은 "코어+분기 ≈ 70–98레슨"만 있고 **블록별 레슨 수·카드→레슨 확장 규칙 없음**.
  코어 11카드·뮤지컬 12카드가 어떻게 70–98레슨으로 펼쳐지는지 미정.
- → 중급 매크로에 *블록별 레슨 수 + 변주 확장 배수*를 초급 수준으로 명시 필요.

### G2. 표준 샘플 SOP(자기평가) 중급 부재 (연속성 갭)
- 초급 졸업 4스킬 중 ③ "표준 샘플 전후 A/B"가 자기평가 축인데, **중급 4단위에 표준샘플 SOP 없음**.
- 중급은 진척·적응 *완성*을 다루면서 정작 *측정 카드*가 없음 → 졸업/전이 판정 근거 약화.
- → 각 중급 단위(또는 코어)에 표준샘플 SOP 카드 추가 검토(시각 전용·비차단 유지).

### G3. 커리큘럼 ↔ 앱 구현 갭 (가장 큼)
- 앱 `card_library.dart`는 **초급 13카드(CARD-01~13)만** 구현. 중급 IC/IM/CL/GY 카드는 *문서만*.
- 변주 엔진·LessonScreen·진행 상태머신은 초급 manifest 전제 → 중급 경로 미구현.
- → 중급을 실제 출시하려면 카드 데이터·manifest·분기 라우팅·장르별 경로 구현 필요(별도 대형 슬라이스).

### G4. 고급 트랙 전무
- 풀 벨트·완전 cover·풀 messa·고난도 런·디스토션·요들 등이 전부 "고급(미생성)"으로 이관됐으나 고급 단위 0개.
- 중급 완주 → "고급 미생성 → 유지 모드"로만 처리(ADR-0010). 기능은 있으나 *콘텐츠 천장*이 중급.

### G5. periodization/디로드 부재 (코어 갭 후보, 기존 기록)
- 부하 관리(주간 디로드·periodization)가 *어느 단위에도 없음*(VERIFICATION에 기록). belt/고음 도입하는 중급에서 특히 필요할 수 있음 → HITL 검토 항목과 연동.

## 4. 근거 품질 종합 (CITATION-AUDIT 반영)

- **강(RCT/정전/검증)**: VFE(STEMPLE)·SOVT(ANDRADE/Adriaansen)·패사지오(ROUBEAU)·트웽 MRI(Jelinger)·aggiustamento(CHAN_DO)·한국 3분류(KIM2025)·belt 음향(MCGLASHAN2017).
- **약(탐색적/합의없음)**: belt 효능(가창자 RCT 부재, `[탐색적]`)·믹스(과학 합의 없음)·K-pop 안전(코호트 부재, 서구 외삽).
- **정정 10건**: 메타데이터(저자/연도/저널/수치) 오류 — 안전 *방향* 무영향(VERIFICATION-MASTER). 환각 0.
- **ADR-0014 근거**: R3에서 실제 출처로 교체(F0 robust·perturbation device bias).

## 5. 안전 자세 — 적절·보수

- belt/트웽/패사지오/cover/messa/런 = HITL 사인오프 패킷(자가승인 0), k-keok 영구 제외.
- 손상 역학(MT 최고·가창자 46%·belt 고부하) V6 확정. belt 진입한정·call-based·중단 cue.
- 증거강도 낮음(K-pop 코호트 부재) 정직 표기. → **출시 전 발성 전문가 사인오프가 유일한 미결 안전 게이트**.

### 5b. 교차검증 업데이트 (독립 리서치 2종, 2026-06)
- 입력 패킷: [SAFETY-EVIDENCE-DOSSIER.md](../verification/SAFETY-EVIDENCE-DOSSIER.md)
  (Claude 심층·GPT 웹Pro 교차, 하드 모순 0).
- **합의:** 트웽·패사지오·cover 진입·messa 기초·런 = 조건부 가능 / belt 진입·레퍼토리 =
  조건부·일반공개 보류 / k-keok = 영구 제외 *유지 정당*(✅Andrade 2000 재확인).
- **§5 수정:** 사인오프가 *유일한* 게이트가 아님 — 둘 다 **강제 캡(음역·횟수·지속·주간) +
  swelling check + 다중 stop**의 *앱 구현*을 사인오프 선결조건으로 요구. 즉 미결 게이트는
  ①전문가 사인오프 + ②강제 캡 구현 **둘**.
- **dose 한계 확정:** ✅Zuim·Stewart·Titze 2023 — 안전 baseline vocal dose 문헌 부재 →
  모든 임계 수치는 보수적 추정(임상 검증 아님). belt 상한 여 C5/남 A4(✅Bourne&Garnier 2012;
  남 A4 단일근거 약함).

## 6. 종합 판정

- **설계·정합·안전 자세: 우수**. 5단위가 ADR·연구로 일관 정렬, 무납득·시각전용·보수 안전 일관.
- **콘텐츠 완성도: 초급=출시급, 중급=초안(레슨수·표준샘플 갭), 고급=없음**.
- **구현 격차: 큼** — 중급 이상은 문서만, 앱 미구현(G3).
- **다음 우선순위**:
  1. (안전) HITL 사인오프 — belt/cover/messa/런 (출시 전 필수).
  2. (설계) G1 중급 레슨수 매핑 + G2 표준샘플 SOP — 중급 초안→완성.
  3. (구현) 초급 앱 마이크 검증(기기) → 중급 카드/분기 구현(G3).
  4. (콘텐츠) 고급 트랙(G4)·periodization(G5)은 후순위.
- **인용 인프라**: 영어권 키 1저자 잔여 재확인(배경 ~60키) 권장 — 후속 인용 전.


===== FILE: docs/curriculum/HITL-SIGNOFF.md =====

# 발성안전 HITL 사인오프 패킷

> 목적: 안전-critical 카드를 *발성 전문가(이비인후과·음성치료·공인 보컬 코치)* 검토용으로
> 한 곳에 정리. **AI가 자가 승인하지 않음** — 본 문서는 *결정 필요 항목*을 제시할 뿐이다.
> 근거: ADR-0008(명시 위험수용=HITL 선례). 출시 전 본 항목 사인오프 필수.
> 안전 근거(V6 재검증): belt 고부하·k-keok 위험은 1차 출처로 확정, 손상 방향 유지·강화.
>
> **📎 입력 패킷:** 독립 리서치 2종(Claude 심층·GPT 웹Pro, 2026-06) 교차검증 결과는
> [SAFETY-EVIDENCE-DOSSIER.md](../verification/SAFETY-EVIDENCE-DOSSIER.md). 검토 전 먼저 읽을 것.
>
> **교차검증 합의(2026-06, 하드 모순 0):** 트웽·패사지오·cover 진입·messa 기초·런 = *조건부
> 가능*, belt 진입·belt 레퍼토리 = *조건부·일반공개 보류*, k-keok = *영구 제외 유지*.
> **⚠️ 사인오프 선결조건:** 두 리서치 모두 텍스트 cue만으로는 불충분 →
> **하드 캡(음역·횟수·지속·주간) + swelling check 게이트 + 다중 stop 신호**가 *앱에 강제 구현*
> 되어야 함을 전제. 즉 belt/cover/messa/런은 "전문가 ✅ **+** 강제 캡 구현" 후에만 출시. 캡 수치
> 확정·구현은 본 사인오프 후의 별도 개발 슬라이스(자가 수치확정 ❌).

## 사인오프 방법
각 카드의 "결정 필요" 항목에 검토자가 ✅승인 / ✏️수정요청 / ❌보류 + 코멘트.
전 항목 ✅ 전까지 해당 카드 **출시 금지**.

---

## A. 중급 뮤지컬 (intermediate-musical)

| 카드 | 내용 | 결정 필요 항목 | 검토 |
|---|---|---|---|
| IM-05 call-based 벨트 진입 [S] | "Hey!" 짧은 call, 밝게(크게❌) | 진입 음역 *상한*(어디까지)·세션당 *횟수*·*빈도*(주 몇 회)·지속시간 cap·중단 cue 충분성 | ☐ |
| IM-03 패사지오 처리 | 사이렌으로 전이 관리 | 고음 방향 상한·삑사리 반복 시 중단 임계 | ☐ |
| IM-02 구강 트웽 | AES 협착, 밝게 | 고음 지속 금지 경계·세션 노출량 | ☐ |
| IM-12 레퍼토리(라이트 belt 구절) | legit+라이트 belt | belt 구절 비중 상한·곡 난이도 게이트 | ☐ |

## B. 가요 (intermediate-gayo)

| 카드 | 내용 | 결정 필요 항목 | 검토 |
|---|---|---|---|
| GY-05 라이트 belt 진입 [S] | call-based, 밝게 | IM-05와 동일 + K-pop 미감 압박 하 보수성 유지 방안 | ☐ |
| GY-04 트웽/꽥 | 마녀/오리 소리 | 고음 지속·세션 노출량 | ☐ |
| GY-06 꺽기/런 기초 | 느리게→정확히 | 고음역 런 금지 경계·정확도 게이트 | ☐ |
| GY-09 레퍼토리 | 스피치라이크+라이트 belt | belt 구절 비중 상한 | ☐ |
| **k-keok(강한 글로털 어택)** | **카드 제외** | 결절·출혈 위험으로 *영구 제외* 확인 — 고급/HITL에서도 도입 여부 별도 결정 | ☐ |

## C. 성악 (intermediate-classical)

| 카드 | 내용 | 결정 필요 항목 | 검토 |
|---|---|---|---|
| CL-01 cover/voce chiusa 진입 [HITL] | 모음 둥글게, 후두누르기❌ | 진입 음역 상한·완전 cover(고급) 경계·과압 방지 cue 충분성 | ☐ |
| CL-08 messa di voce 기초 [HITL] | 약→강→약 기초 | 중음 한정 범위·다이내믹 폭 상한·고음 풀 messa 금지 경계 | ☐ |

## D. 초급 보강 (beginner, 결정 대기)

| 항목 | 내용 | 결정 필요 | 검토 |
|---|---|---|---|
| P1 빨대 지름 | 현행 5–6mm 유지 | (b) cue에 "가는 빨대❌(5–6mm)" 명시문구 추가 여부 | ☐ |
| P3 cue 변주 축 | 보류 | cue 문구 변주축 신설(별도 이슈) 진행 여부 | ☐ |

---

## E. 공통 검토 질문 (전 belt/고음 카드)
1. 부하·피로 *미감지*(ADR-0008) 상태로 belt/고음 도입 — 완화책(진입한정·call-based·중단 cue)이 일반 소비자에게 충분한가?
2. 중단 cue("통증·다음날 쉰목→중단")가 *행동 변화*를 실제로 유도하기에 충분한가, 추가 신호 필요한가?
3. 1일1레슨 캡(ADR-0003) 외에 belt 노출 *주간 상한*이 필요한가?
4. 증거강도 낮음(K-pop 코호트 부재 S갭) — 가요 belt를 더 보수화하거나 경고를 강화할까?

> **교차검증 입력(2026-06, 도시에 §2·§4 — 결정은 전문가 몫):**
> Q1·Q2 → 둘 다 **텍스트 cue만으로 불충분**. 다중 stop 신호 + swelling check(○Bastian 1990) 권고.
> Q3 → 둘 다 **주간 상한 필요** 권고(belt 주 2–3회·세션간 24–48h 회복; 단 정량 근거 부재=보수적 추정).
> Q4 → 둘 다 **더 보수화 + "서구 외삽" 명시 경고** 권고(가수 dysphonia ~46% ○Pestana 2017).
> belt 절대 상한: 여 C5/남 A4 아래(✅Bourne&Garnier 2012; 남 A4는 단일 근거 약함 — 검증 요청).

> 본 패킷의 안전 근거·인용은 CITATION-AUDIT(V6)·CITATION-KEYMAP로 검증됨(belt 고부하·
> 손상 역학 방향 확정). 인용 메타데이터 정정 8건은 안전 *방향*에 영향 없음(오히려 강화).


===== FILE: docs/curriculum/INTERMEDIATE-IMPL-VERIFY.md =====

# 중급 커리큘럼 구현 — 수동 검증 절차 (I1~I6)

> 졸업→장르→분기 진입→경로 진행이 앱에서 동작함을 확인하는 절차.
> 자동 검증: `flutter test`(141 green) + `flutter analyze`(클린). 본 문서는 *수동 흐름*.

## 구현 요약 (코드화 완료)
- **카드**: 중급 IC-01~12·IM-01~12·CL-01~09·GY-01~09 = card_library 이식(I1).
- **manifest**: buildCoreManifest(32) + buildMusical/Classical/Gayo(74/68/64)(I2).
- **분기 진입**: `Progression._enterCourse(genre)` 실 manifest 로드·index 0(I3).
- **분기 완주**: 코스 끝 → graduated + maintenance(고급 미생성, ADR-0010)(I4).
- **안전 게이트**: `safetyApproved=false`(기본) → pending 카드(belt/트웽/cover/messa/런)
  코스에서 제외. HITL 사인오프 완료 시에만 true(I5).
- **정합 가드**: 전 manifest cardId가 라이브러리에 존재(I6).

## 롤아웃 스위치 (중요)
ADR-0010 P10 설계상 장르 코스는 *released* 상태여야 진입(미release → 유지 모드 대기,
출시 시 자동 연결). 미들 코스는 *구현·게이트 완료*이나 **앱 기본은 미release**(staged
rollout). 즉 현재 앱에서 졸업→장르픽 = 유지 모드(코스 미연결)가 기본. 미들 코스를
실제로 켜려면 두 스위치:
1. **장르 release** — `progression.toggleRelease(genre)`(P10 자동연결 트리거).
2. **안전 사인오프** — `Progression(safetyApproved: true)` (HITL-SIGNOFF 완료 후만).
   미사인오프(기본)면 release돼도 belt/트웽/cover/messa/런 카드는 코스에서 제외.

> 이 두 스위치 분리는 *재설계가 아니라 기존 ADR-0010 P10 + I5 안전 게이트*. 앱 전역
> 기본 release/approve 결정은 롤아웃·안전 사인오프 사안이라 본 구현 범위 밖(자가 결정 ❌).

> **세션-독립 검증(W1~W5)**: 두 스위치의 진실은 이제 체크인 상수(`kReleasedGenres`·
> `kSafetySignoff`)에 박혀 있고, `docs/verification/`의 단일 소스·하네스가 정합을
> 강제한다. 신규 세션 재확인: `docs/verification/NEW-SESSION-REVERIFY.md`.

## 수동 검증 (개발 빌드, 코스 연결 시)
release 플래그를 켠 개발 빌드 기준:
1. 경고 → 확인 → 홈 → 오늘 시작 → 초급 레슨 진행.
2. (초급 졸업 시뮬: 1-슬롯 manifest) 졸업 → 장르 픽커 → 장르 선택.
3. release된 장르면 → **코어(IC) 레슨부터** 진행(todaysLesson = IC-xx).
4. 코어 통과 → 분기(IM/CL/GY) 레슨 연속(단일 manifest).
5. safetyApproved=false면 belt/트웽 등 게이트 카드 *미등장*(코스 길이 단축).
6. 분기 완주 → 유지 모드 배지(고급 미생성).

## 잔존(범위 밖, 의도적)
- **G4 고급 트랙**: 풀 벨트·완전 cover·풀 messa·고난도 런 = 미생성(신규 고위험 안전
  설계 + HITL 필요). 중급 천장(진입 한정)까지만 구현.
- **G5 periodization/디로드**: 미반영(코어 갭 후보).
- **belt 등 안전 카드 활성화**: HITL-SIGNOFF 완료 전 게이트 잠금(자가 승인 ❌).
- **실 마이크 곡선**: 코드 완료, 기기 육안 확인 미수행.
- 앱 전역 release/approve 기본값: 롤아웃·사인오프 결정(범위 밖).


===== FILE: docs/curriculum/VERIFICATION-MASTER.md =====

# 검증 종합 (VERIFICATION-MASTER) — V1~V9

> 전 커리큘럼·인용 정밀 검증(goal: 수집 정보 정밀 검증·보완)의 종합. 세부는
> `docs/research/CITATION-AUDIT.md`(키별 4등급) + 각 단위 VERIFICATION.md.

## 1. 한 줄 결론

**인용 메타데이터 오류는 만연(특히 영어권 single-author-year 키의 저자 오기), 그러나 기저 논문은 모두 실재하고 안전 claim은 단 1건도 REFUTED 아님.** 안전 결정(belt 진입한정·k-keok 제외·HITL)은 검증으로 *강화*됐고 변경 없음.

## 2. 검증 등급 분포 (CITATIONS, 개별 웹대조분)

| 등급 | 키 | 비고 |
|---|---|---|
| VERIFIED | PESTANA2017·ANDRADE2024·MCGLASHAN2017·CHAN_DO2021·KOR_KIM2025·JVOICE2025KPOP·KOR_LEE_HAN2022·ROUBEAU2009·STEMPLE_VFE | 서지·내용 정확 |
| VERIFIED(정전·평판) | Sundberg·Titze·Hirano·Hixon·Miller·Schmidt&Lee·Fitts&Posner·Bozeman·Cooksey·Gackle·Malde·Dimon 등 | 정전 저작, 판본·페이지 개별 미재확인 |
| PARTIAL | CHILDS2023·BEHLAU2021·LEE2017CGU(연도)·§D AI도구 다수·§E 한국 잔여·§G 뉴스 | 메타만/유료/출처유형 |
| **REFUTED(정정)** | **BRETL2023**(수치 39%→67/32–40)·**SIELSKA2024**(→2018 오귀속)·**LECHIEN2021**(→Rotsides/Laryngoscope)·**CHEN2024**(→Adriaansen)·**GIBIAT2024**(→Jelinger)·**NAIR2023PNAS**(→Jeong)·**MANFREDI2017**(→Grillo2016+프레이밍)·**DAVIES2020**(RCT→평가연구 의심) | 8건, 전부 ⚠️정정 적용 |
| 환각(미존재) | **0건** | 기저 논문 전부 실재 |

## 3. 정정 8건 + 영향 전파

| 키 | 오류 | 정정 | 영향 단위 |
|---|---|---|---|
| BRETL2023 | "뮤지컬 39%" | 1년차 32–40%/발생률 67% | D 뮤지컬·F 가요(방향 강화) |
| SIELSKA2024 | "22% 결절" 귀속 | →SIELSKA2018 J Voice | F 가요(귀속만, 수치 유지) |
| LECHIEN2021 | 저자·저널 | →Rotsides, Laryngoscope | (역학 보조) |
| CHEN2024 | 저자 | →Adriaansen 2025 | 초급/코어 SOVT RCT(설계 유지) |
| GIBIAT2024 | 저자 | →Jelinger 2024 | IC-10·IM-02·GY-04 트웽(내용 유지) |
| NAIR2023PNAS | 저자 | →Jeong 2023 | 초급 C5(내용 유지) |
| MANFREDI2017 | 저자·연도·**프레이밍** | →Grillo2016; "마이크 한계" 부적합 | 초급 C5/C12·ADR-0014 근거 교체 필요 |
| DAVIES2020 | "J Voice RCT" | →SAGE 평가연구; OCEBM 1b 하향 | part16/MX Evidence Ladder 약화 |

## 4. 안전 (V6) — REFUTED 0건

손상 역학 방향 전부 유지·강화(MT 최고·가창자 46%·belt 고부하·k-keok 위험). belt 진입한정·트웽·패사지오·cover·messa·런 **HITL 플래그 유지**, k-keok **제외 유지**. 감사는 안전을 *강화*하되 자가 변경하지 않음(HITL 대기).

## 5. 잔존 미해결 (등급)

- **S**: K-pop 트레이니 손상 코호트 부재 / Phase III 방법비교 RCT 부재 → 가요·belt 증거강도 낮음 단서 유지. (제품 범위 밖: 트랜스·변성기)
- **S(R4 재개방)**: 메소드 효능 *가창자 RCT* 부재 — Davies 2020이 RCT가 아니라 SAGE 평가연구로 확인되어 "단일 브랜드 가창자 RCT 확보" 철회. part16 메소드효능 갭 🟡→🔴. Alexander part MX ★★★→★★ 하향. (커리큘럼 카드엔 belt 외 Alexander 직접 의존 없어 안전 무관.)
- **A**: 한국어 가창 formant DB 부재 / 다언어 딕션 / 장르 세분화.
- **인프라 A**: CITATIONS 영어권 single-author-year 키의 *저자명 신뢰 불가* — 후속 사용 전 1저자 재확인 권장(본 감사가 8건 정정, 미개별검증 다수 PARTIAL).

## 6. HITL 사인오프 최종 목록 (출시 전 필수)

1. **belt 계열**: IM-05 call-based 벨트진입·IM-03 패사지오처리·IM-02 트웽·IM-12 레퍼토리(뮤지컬) / GY-04 트웽·GY-05 belt진입·GY-06 런·GY-09 레퍼토리(가요) — 음역 상한·진입 강도·빈도.
2. **성악**: CL-01 cover 진입·CL-08 messa di voce 기초 — 고음·지속.
3. **초급 보강**: P1(b) 빨대 명시문구·P3 cue 변주축(보류 결정).
4. **k-keok**: 영구 제외 유지(고급/HITL 한정).
5. **ADR-0014 근거 교체**: MANFREDI→다른 마이크 한계 출처(또는 골전도·저신뢰지표 근거로 재서술). 시각전용 설계 자체는 불변.

## 6b. Remediation 완료 (R1~R7, 2026-06)

| 단계 | 결과 |
|---|---|
| R1 | 정정 8건 완결 + `docs/CITATION-KEYMAP.md`(권위 정정표) 신설. CITATIONS 헤더 포인터 |
| R2a~d | PARTIAL 전수 재확인 — VALA(이니셜 B→M)·SELAMTZIS2019(UNVERIFIABLE) 추가 색출. 배경 키는 *정직 비검증* 표기(fake-verify 회피), 후속 인용 시 1저자 재확인 필요 |
| R3 | ADR-0014 근거 교체 — MANFREDI(→Grillo, 폐기) → MOBILEVOICE2022·SMARTPHONE_AVQI_META2025(F0 robust·jitter/shimmer/HNR device bias). 시각전용 설계 불변 |
| R4 | DAVIES2020 RCT→평가연구 하향 전수 전파(part12·13·16·MX·HX·CITATIONS). Alexander ★★★→★★. 메소드효능 RCT 갭 재개방 |
| R5 | 약근거 보강 — 등급 상향 0(belt 효능 RCT 미발견 정직 유지), 출처 날조 0. belt 특성화 corroboration 보강 |
| R6 | `docs/curriculum/HITL-SIGNOFF.md` — 안전 카드 전문가 검토 패킷, 자가 승인 0 |
| R7 | 본 종합 갱신 |

**정정 총계**: 메타데이터 오류 8(R1) + 2(R2a: VALA·SELAMTZIS) = **10건 색출·정정**. 환각(미존재 논문) 0건. 안전 claim REFUTED 0건(V6).

## 7. 검증 한계 (정직)

- 학술 *본문* 다수 유료 → claim 정밀 수치는 PARTIAL 잔존(예 belt "성문하압 2–3배" 배수).
- §D AI도구·§E 한국 잔여·§G 뉴스는 미개별검증 PARTIAL(안전 비관여 우선순위).
- 본 감사의 핵심 성과: **환각 0건 확인 + 저자/수치/귀속 오류 8건 색출·정정 + 안전 무결성 확인**.


===== FILE: docs/curriculum/RESEARCH-INDEX.md =====

# 커리큘럼 ↔ 리서치 인덱스 + 갭맵 (Task A 산출물)

> 목적: `docs/research/` 26개 파일 + 인용/태그 인프라를 각 커리큘럼 단위에 매핑하고,
> 단위별 핵심 claim·1차 출처·잔존 갭·안전 플래그를 한 곳에 고정한다. 이후 단위 작업
> (B 초급 / C 중급코어 / D 중급뮤지컬 / E 성악 / F 가요)의 *기준표*.
> 준거: ADR-0001~0016, CONTEXT.md, part 16 갭 매트릭스, `docs/TAGS.md`, `docs/CITATIONS.md`.

---

## 0. 리서치 인프라

- **인용 키 표준**: `docs/CITATIONS.md` (~88 키, 예 `[CITE: TITZE2006]`, `[CITE: BRETL2023]`).
- **증거/관행 태그**: `docs/TAGS.md` — `[근거 부족]` · `[탐색적 근거]` · `[Phase III RCT 부재]` · `[성악·CCM 병기]` · `[K-pop 산업관행]`.
- **증거 2축 평가**: 연구 설계(OCEBM) + 확실성(GRADE) — *학술 근거 강도*와 *현장 채택*은 분리 축(part 0).
- **잔존 갭 시급성**: S(안전/핵심주장) / A(챕터 부분작성) / B(2판) — part 16 §"잔존 갭".

## 1. 리서치 파일 → 단위 매핑

| 파일 | 주제 | 주 공급 단위 |
|---|---|---|
| part 0 / 1 / 2 | 프레임·심층 리서치 토대 | 전 단위(설계 원리) |
| part HP | 인체해부·생리 토대(Hirano 성대5층·Hixon 호흡·Fitts&Posner·Cooksey/Gackle 변성기·Lã&Howard 호르몬) | 전 단위(내부 근거) |
| part HX | 인체-가창 응용 문헌(Body Mapping·운동학습 응용·MPA·Accent Method) | 전 단위(내부 근거) |
| part QI | 정량 인덱스(formant·PTP·성대접지·belt/twang 음향) | 코어·뮤지컬·성악·가요 |
| part MX | 학파 매트릭스·계보·Evidence Ladder | 방법론 근거(횡단) |
| part 3 | 온셋·포네이션·내전·SOVT 전수 | **초급**·코어(VFE·온셋) |
| part 4 | 공명·성도형상·모음조정·포먼트튜닝·플레이스먼트 | **코어**·성악(singer's formant) |
| part 5 | 레지스터·패사지오·믹스·벨트·트웽·스피치라이크 | **뮤지컬**·가요·성악(passaggio) |
| part 6 / 6-KR | 딕션·조음 / 한국어 가창 딕션 | 뮤지컬·**가요(6-KR)**·성악 |
| part 7 | 자기모니터링·평가·청지각(웨어러블·AI 도구·컨슈머앱 한계) | 전 단위(피드백 설계, ADR-0014) |
| part 8 | 워밍업·쿨다운·회복·부하관리·음성위생 | 전 단위(**안전**) |
| part 9 / 9-KR | 정규기관 커리큘럼 / 한국 기관·K-pop 산업 | 코어·성악·**가요** |
| part 10 | 국가별 커리큘럼 구조 비교 | 매크로 시퀀스 근거 |
| part 11 | 온라인 강의·AI 보컬 도구 사례 | 피드백·도구(ADR-0014) |
| part 12 / 13 | 대표 교수법 비교 / 교육자·연구자 방법론 | 방법론 근거(벨트=EVT/CVT 등) |
| part 14 | 논쟁 지점·정의 충돌(support/appoggio/placement/register/mix/belt/twang/open throat) | **용어 정합**(전 단위) |
| part 15 | 훈련법 DB·동의어 통합(P3-xx·P4-xx·P5-xx·P6-xx ID 원천) | 카드 ID 원천(전 단위) |
| RESEARCH_COMPILATION 1–3 | 외부 리서치 컴파일(Wave 통합) | 갱신 근거(전 단위) |

> **카드 ID 규약**: `P{part}-{nn}`(예 P3-07)은 part 15/해당 part의 훈련법 DB 행 ID. 커리큘럼 문서가
> 이 ID로 카드를 참조 → SOURCES.md에서 ID→1차 출처로 추적한다.

## 2. 단위별 현황 + 갭 + 안전 플래그

### B. 초급 (beginner) — 산출물 보강
- **현황**: `cards.md`(13 IN, 사인오프) + `CURRICULUM.md`(5블록) 존재. 보강 제안서 `.scratch/beginner-v1/research-augmentation-proposal.md`(미적용, P1 빨대지름·P2 안전cue·P3 변주 — HITL 대기).
- **핵심 claim**: SOVT(Titze 합리화), appoggio(Miller), 균형 onset, 자기청취(녹음 비교), 5블록 blocked→variable(ADR-0006), 졸업 4스킬.
- **주 출처**: part 3(SOVT/온셋), part 7(자기모니터링), part 8(워밍업·위생), part HP(해부).
- **갭**: 보강 제안 3건 판정 미완. 사인오프 카드의 출처 역추적(SOURCES) 부재.
- **안전 플래그(HITL)**: SOVT 강도·빨대 지름·호흡(과호흡/어지럼) 중단 cue 완전성 — *기존 카드 본문 변경은 사인오프 전 금지*.

### C. 중급 코어 (intermediate-core) — cards.md + SOURCES + VERIFICATION 필요
- **현황**: `CONTEXT.md`+`CURRICULUM.md`(블록1 브리지·블록2 공명/모음조정, 카드 ID 참조) 작성됨. `cards.md`(ADR-0015 스키마) 미생성.
- **핵심 claim**: P3-07 균형발성·3분류(김형미 2025 균형/저접지/과접지), VFE 4과제(Stemple, RCT 최강), §4.3 Appoggio 정교화, P4-09/10 모음조정·포먼트튜닝 기초, P4-07 후두높이 인지, P4-12 비음 분리, 패사지오 *인지*(P5-03/06).
- **주 출처**: part 3(VFE·온셋), part 4(공명·포먼트), part 5(패사지오 인지), part QI(formant·접지).
- **갭**: cards.md 스키마화. 모음조정 R1:f0 정량 앵커(part QI).
- **안전 플래그(HITL)**: 균형발성 압착·SOVT 부하. (벨트/고음은 코어 밖 → 분기.)

### D. 중급 뮤지컬 (intermediate-musical) — cards.md + SOURCES + VERIFICATION 필요
- **현황**: `CONTEXT.md`+`CURRICULUM.md`(블록3 레지스터·블록4 텍스트/딕션/캐릭터/곡) 작성됨. `cards.md` 미생성.
- **핵심 claim**: P5-04 믹스(단일정의 ❌, 경험으로), 구강 트웽(P15-20 oral), 패사지오 처리, P15-18 Bozeman 모음전환, **call-based 벨트 진입(ADR-0007 천장)**, P6-08/09/10 텍스트·딕션, 한국어 딕션 교차스트림.
- **주 출처**: part 5(레지스터·벨트·트웽), part 6(딕션), part 12/13(EVT/CVT 벨트 근거), part 14(belt/twang 용어), part 9-KR(K-pop neutral 병기).
- **갭**: 벨트 Phase III RCT 부재(`[Phase III RCT 부재]`), 벨트 entry 근거 `[탐색적 근거]`(McGlashan 2017).
- **안전 플래그(HITL) — S 등급**: **벨트·고음·트웽·패사지오 처리** = ADR-0008 명시 위험수용. *자가 확정 금지*, 사인오프 필요. 완화책(진입까지·call-based·"밝게 크게아님")은 유지하되 안전 결정은 HITL.

### E. 성악 (classical) — 신규 (범위 확인 대상)
- **현황**: 폴더·문서 없음. ADR-0011 장르 분기 중 하나로 예정(미생성).
- **예상 핵심 claim**: aggiustamento(고소프라노 모음조정), singer's formant(2.8–3.2kHz), 패사지오 *클래식 처리*(커버링), messa di voce(고급), 이태리어/독일어 딕션, chiaroscuro.
- **주 출처**: part 4(singer's formant·포먼트), part 5(passaggio/covering), part 12/13(Bel Canto/Miller/Bozeman), part 9/10(콘서바토리), part 6(IT/DE 딕션).
- **안전 플래그(HITL)**: 고음·messa di voce·지속 — 고급 영역. 신규 트랙 생성 = 범위 결정 → 착수 시 확인.

### F. 가요 (gayo) — 신규 (범위 확인 대상)
- **현황**: 폴더·문서 없음. ADR-0011 분기 예정(미생성).
- **예상 핵심 claim**: CCM 스피치라이크·믹스·벨트, 한국어 가창 딕션(part 6-KR), K-pop 명명연습↔음성과학 매핑(k-keok/꺽기/siren/lip bubble ↔ SOVT/Estill, `[K-pop 산업관행]`), 마이크 전제(증폭) 명료도 policy.
- **주 출처**: part 6-KR(한국어 딕션·판소리), part 9-KR(K-pop 산업·매핑), part 5(CCM 벨트/트웽), part 11(도구).
- **갭(S 등급)**: K-pop 트레이니 손상 코호트 부재, 한국어 가창 formant DB 부재(A), 판소리 안전성 정량연구 부재(A).
- **안전 플래그(HITL) — S 등급**: 벨트·고음·꺽기·판소리식 부하. 신규 트랙 = 범위 결정 → 착수 시 확인.

## 3. 전 단위 공통 — 범위 밖(ADR/제품 결정상 *포함 금지*)
- **변성기·청소년·아동 가창**(part 16 S갭): ADR-0001 만 18세 이상·변성기 종료 대상 → **범위 밖**. 연구상 S갭이나 본 제품 비대상.
- **트랜스/젠더 확정 음성 훈련**(part 16 S갭, 연구 완전누락): 본 제품 일반 소비자 V1 비대상. 향후 별도 검토.
- **임상·치료 전용 프로토콜**(LSVT 등 의학감독 필요): 교육용 차용 드릴만 허용, 치료 프로토콜 자체는 제외(ADR-0001 의료도구 아님).
- **무대공포 모듈·학술 정당화 온보딩·강사/임상 동반 트랙**: ADR-0001/0002로 제거됨 — 되살리지 않음.

## 4. 작업 순서 (의존) — 진행 현황
A ✅ → B 초급 ✅ → C 중급코어 ✅ → D 중급뮤지컬 ✅(belt HITL) → E 성악 ✅(cover/messa HITL) → F 가요 ✅(belt/트웽/런 HITL, k-keok 제외).
산출물: 각 단위 `docs/curriculum/<unit>/{CURRICULUM, cards, SOURCES, VERIFICATION}`
(성악·가요는 CONTEXT 포함 신규). 모든 안전 S등급 항목은 VERIFICATION에 `HITL 사인오프 필요` 플래그.
각 단위 = 수집→웹보강→교차검증(적대적)→정합→집필(CURRICULUM/cards/SOURCES/VERIFICATION)→자기비평→확정.
안전 플래그 항목은 VERIFICATION.md에 `HITL 사인오프 필요`로 표시하고 자가 확정하지 않는다.


############################################################
# Curriculum (per-track: CONTEXT, CURRICULUM, cards, VERIFICATION)
############################################################


===== FILE: docs/curriculum/beginner/CURRICULUM.md =====

# 초급 커리큘럼 — 노래의 전제조건 (Beginner)

> 용어는 루트 `CONTEXT.md`(초급 공통) 글로서리를 따른다. 설계 결정 근거는 `docs/adr/0001–0010`.
> 본 문서는 *옛 「01 초급 공통 커리큘럼 (0-6개월)」을 대체*한다(archive 보존).

## 0. 정체성

일반 소비자용 **일일 보컬 트레이닝 앱**(듀오링고형 습관 루프)의 초급 단계. 노래를 *바로* 시키지 않는다 — 호흡·발성·신체·자기청취라는 **전제조건**을 만든다. 진단·치료·임상 안전 모니터링 도구가 **아니다**. 곡(노래)은 초급에 없다(장르 트랙·중급 소관).

## 1. 앱 실행 경고 (유일한 안전 장치)

앱 실행당 1회, 진입 시 1-탭 확인:

> "통증·어지럼·호흡곤란·각혈이 있으면 즉시 멈추고 의료기관을 방문하세요. 본 앱은 만 18세 이상·변성기 종료 대상이며, 의료·진단 도구가 아닙니다."

게이트·문진·설문·연령차단·온보딩 **없음**. 1탭 → 곧장 오늘 레슨. 시작에 계정 불필요(계정은 진척 동기화용 선택).

## 2. 진행 규칙

- **1일 1레슨**(해금용). 완료하면 다음 레슨 해금 — 수행 품질은 해금을 막지 않는다.
- 단일 고정 선형 경로(모두 같은 순서). 적응형 분기 없음.
- **관대 스트릭**: 하루 놓쳐도 0 리셋 없음. streak freeze 없음.
- **복귀 복습**: 7일+ 공백 후 복귀 첫 세션 = 복습 레슨(그날의 1레슨, 신규는 다음날). 7–14일 공백→복습 1일, 그 이상→2일. 졸업일은 자연 지연만.
- 진행·졸업은 **완료 기반**. 시험·체크포인트·수행 게이트 없음.

## 3. 레슨 해부 (10–15분)

| 구간 | 길이 | 내용 |
|---|---|---|
| 진입/워밍업 | ~1–2분 | SOVT가 겸함(전용 워밍업 슬롯 최소) |
| 본운동 | ~7–11분 | 그날 핵심 운동 + 변주 + 인-레슨 피드백 |
| 쿨다운 | ~1–2분 | 부드러운 하행 — *권장이나 스킵 가능*(게이트 아님) |

- **무성 레슨 0개**: 모든 레슨에 유성 마이크로-윈 최소 1개.
- **인-레슨 피드백**: 정보·연습 재료일 뿐 해금/졸업을 막지 않음. 크게 빗나가면 *선택형* "다시 해볼까요?" 1개 + 1줄 교정 팁(스킵 자유). 신뢰도 낮은 음향 수치(jitter 등)는 표시 안 함. 자가피드백은 *시각 곡선 전용*(듣고 판단 ❌).
- **무납득**: "왜"를 설명하지 않는다. 단 *과제를 정의하는 운동 지시 cue*("이로 물지 마세요", "밝게, 크게 아님")는 허용(rationale 아님).

## 4. 매크로 시퀀스 (5블록 — 내부 설계 전용, 사용자 비노출)

≈48레슨 기준(40–56 범위). 신체·호흡:유성 비중 점진 역전. blocked→variable 변주는 경로 따라 내부 상승(설명 ❌).

| 블록 | 레슨 | 신체·호흡:유성 | 카드 | 변주 |
|---|---|---|---|---|
| 1 토대 진입 | 1–8 | 70:30 | C1 자세·BodyMap, C2 호흡, C3 턱·혀·목 이완, C4 가벼운 첫 소리, C5 자기청취, **표준샘플#1** | 없음 |
| 2 SOVT 도입 | 9–20 | 50:50 | C6 빨대(메인), C7 립트릴 | 음역 1축 |
| 3 SOVT 확장 | 21–30 | 40:60 | C8 허밍/NG, C9 물저항 빨대 → SOVT 4종 완성, **표준샘플#2** | 음역+모음 2축 |
| 4 균형·자기청취 | 31–40 | 30:70 | C10 균형 발성 + C5 심화(과기식/균형/과압착) | 3축 |
| 5 자기모방·시각피드백 | 41–48 | 20:80 | C11 self-imitation, C12 시각 피드백, **표준샘플#3** | variable↑ |
| 졸업 | ~48 | — | 4스킬 완주 → 통합 전이(§6) | — |

빨대(C6)는 블록1에서 *맛보기 유성 마이크로-윈*으로만, *메인*은 블록2부터(호흡 기초 선행).

## 5. 카드 (13 IN — 10–15분 레슨 포맷)

각 카드: 사용자가 하는 것 / 유성 마이크로-윈 / 운동 지시 cue / 변주축 / 인-레슨 피드백. 절차는 1화면 1지시, 무납득.

- **C1 자세·Body Mapping**: 6 Places of Balance 정렬 관찰. 유성: 끝에 편한 /m/ 3회. cue "턱·어깨 풀기".
- **C2 흉곽-복부 호흡**: 늑골·복부 결합 호흡. 유성: voiced 한숨 /h→a/ 3회. cue "배만으로 ❌, 늑골도".
- **C3 턱·혀·목 이완**: silent ah → voiced ah. 유성: 가벼운 /a/ 3회. cue "혀 뿌리 내려놓기".
- **C4 가벼운 첫 소리**: /h/·/m/ easy onset. 유성: /h/-led 부드러운 onset 5회. cue "치지 말고 흘려보내기".
- **C5 골/공기 전도 자기청취**: 부를 때 소리 vs 시각 곡선 비교. (시각 전용 — 골전도 착각 차단.) 블록4에서 과기식/균형/과압착 식별 심화.
- **C6 빨대 발성**: 5–6mm 빨대 /u/ sustain. cue "이로 물지 마세요, 어지러우면 멈춤". 변주: 음역.
- **C7 립 트릴**: 입술 트릴 sustain·글라이드. cue "입술 힘 빼기".
- **C8 허밍/NG-hum**: /m/·/ŋ/ hum. cue "콧대 진동 느끼되 짜내지 않기".
- **C9 물저항 빨대**: 물 컵 빨대 버블(선택·회복 도구). cue "버블 일정하게". (천식·호흡기·어지럼 이력 시 다른 SOVT로 대체 가능 — *지시*로만, 게이트 ❌.)
- **C10 균형 발성**: 과기식↔균형↔과압착 사이 찾기. 인-레슨 AI 분류 표시(정보, 막지 않음).
- **C11 Self-Imitation**: 자기 2초 녹음 → 재생 → 재모방 → 시각 비교 5회.
- **C12 시각 피드백 피치 매칭**: 피아노롤 목표선 + 실시간 곡선, ±편차 색상. 빗나가도 완료 인정.
- **표준 샘플 SOP**(주기 카드, #1/#2/#3): 고정 과제(/a,i,u/ 5초·문장·글라이드) 동일 조건 녹음 → 전후 A/B 시각 비교.

## 6. 졸업 = 통합 전이

졸업 = 경로 완주(4핵심 스킬을 *반복 연습*했음이 곧 증명; 시험 ❌). 그 순간:

1. 축하
2. **장르 트랙 선택**(성악/뮤지컬/가요 — *비구속·변경 가능*)
3. 선택 장르 중급이 있으면 진입 / 없으면 **유지 모드**(4스킬 얇게 반복, 스트릭 유지, 신규 해금 ❌, V1 필수) + 의향 기록 → 출시 시 자동 연결

(자유 연습 모드는 별개·연기 — 스트릭/진척 무관, V1 미구현.)

## 7. 졸업 4스킬 (= 경로가 연습시키는 것, 시험 아님)

① SOVT 4종 자가 워밍업 ② 과기식/균형/과압착 자기 청지각 식별 ③ 표준 샘플 전후 A/B ④ self-imitation + 시각 피드백 자가 사용.

> 졸업은 *적응 완성*이 아니라 "노래 연습을 시작해도 안전·유효한 최소 입문 토대". 시간 의존 적응의 완성은 중급(장르)으로 연속(ADR-0004).

## 8. 명시 제외 (초급 아님)

곡/레퍼토리, 파사지오·비브라토·댐핑·벨트·믹스·고음·음역확장, 컨디션 게이트·적색신호12·EASE/VHI·동반자 트랙, 무대공포 7-step, 학술 정당화·운동학습 모델 설명, Appoggio 정교화·VFE 심화·모음 정밀·placement — 전부 중급/장르 또는 폐기(ADR-0005).


===== FILE: docs/curriculum/beginner/cards.md =====

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


===== FILE: docs/curriculum/beginner/VERIFICATION.md =====

# 초급 커리큘럼 — 검증 로그 (VERIFICATION)

> 6단계 루프의 검증·자기비평 산출물. 교차검증(적대적) + 보강 제안 판정 + 안전 플래그 + 잔존 갭.
> 원칙: 사인오프 카드 본문은 *안전 플래그 없이 변경 금지*. 본 작업은 cards.md/CURRICULUM.md **무변경**.

## 1. 교차검증 (claim별 반박 시도)

| claim | 지지 | 반박 시도 | 판정 |
|---|---|---|---|
| SOVT가 발성 부하↓·효율↑ | TITZE2006SOVT, ANDRADE2024(RCT), CHEN2024(아동 RCT) | "현장 변형 많아 효과 불균질" | **유지**. 물리적 합리화 + RCT. 변형(빨대 길이/물)은 별도 표기 |
| 흉곽-복부 *결합* 호흡(복식/흉식 이분법 폐기) | HIXON2008(정전) | "현장은 여전히 복식호흡 지도" | **유지**. 이분법은 part 14에서 용어 충돌로 정리됨. 학습자 cue는 "늑골도"로 중립 |
| 균형 onset이 기본 목표 | part 3 온셋 DB | "균형 onset 유일정답 아님(스타일)" | **유지+단서**. C4 cue 자체가 "치지 말고 흘려보내기"로 *기본값*만, 스타일 의도 존중(코어/분기에서 확장) |
| 자기청취는 시각 곡선 전용 | MANFREDI2017(마이크 한계), NAIR2023PNAS | "청각 자가판정도 교육적" | **유지**. 골전도 착각·저신뢰 음향수치 → ADR-0014 시각 전용이 정직. 청각판정은 의도적 배제 |
| 3분류(과기식/균형/과압착) | KOR_KIM2025 | "한국 1차·OCEBM 5(개념)로 약함" | **유지(약근거 표기)**. 교육 프레임으로 채택, 임상 진단 아님. 비차단 정보로만 |
| blocked→variable 진행 | SCHMIDT_LEE2019, FITTS_POSNER1967 | "보컬 직접 RCT 아님(운동학습 일반)" | **유지(내부 전용)**. 학습자 비노출 설계 원리라 과주장 위험 없음 |

**충돌 기록**: 본 단위 핵심 claim에서 *출처 간 정면 모순으로 멈출 사안 없음*. belt/passaggio/twang 등 논쟁 큰 항목은 초급 범위 밖(ADR-0005)이라 애초 미포함.

## 2. 보강 제안서 판정 (`.scratch/beginner-v1/research-augmentation-proposal.md`)

| # | 항목 | 판정 | 근거 |
|---|---|---|---|
| **P1** | 빨대 지름(3.5mm 고저항 vs 5–6mm) | **현행 5–6mm 유지** + 명시문구(b)는 **HITL 플래그·보류** | 5–6mm = 초급 저저항 안전·실패율↓(입문 토대 원칙). 3.5mm는 어지럼·과부하·"이로 물기" 유발 위험↑. cue 변경은 안전-인접 → 자가 적용 안 함 |
| **P2** | 안전 중단 cue 완전성 | **검증 완료 — 갭 없음(무변경)** | C2(과호흡·어지럼)·C6(어지럼·시야흐림·가슴통증)·C9(천식·호흡기·쌕쌕) 모두 part 8 기준 충족 |
| **P3** | cue 문구 변주 축 신설 | **보류(별도 이슈화)** | 변주 5축(음역·모음·글라이드·멜로디·세션위치) 밖 = 기능/스키마 변경, 미세보강 아님. 채택 시 rationale 금지 가드 별도 이슈 |

→ **결과: 초급 canonical 문서 변경 0건.** P1(b)·P3는 HITL/이슈 대기로 남김.

## 3. 안전 플래그 (HITL 사인오프 필요 — 자가 확정 안 함)

- **빨대 지름 명시문구(P1-b)**: 안전-인접 cue 변경 → 발성안전 HITL 검토 후에만 cards.md 반영.
- **C9 물저항 호흡기 대체 분기**: 현행 cue 유지. 천식·호흡기·어지럼 이력자 대체는 *지시*로만(게이트 아님) — 의료 판단 아님(ADR-0001).
- 그 외 C6 빨대·C2 호흡 중단 cue는 현행으로 충분(P2 검증). 변경 없음.

> 초급은 SOVT 저강도·균형 발성 위주라 belt/고음 같은 S등급 안전 항목은 부재(중급 뮤지컬/가요에서 등장).

## 4. ADR/CONTEXT 정합

- ADR-0001(유일 안전장치=실행경고): §1 그대로. 추가 게이트 없음. ✅
- ADR-0002(무납득): 모든 cue가 지시문, 출처는 본 문서에만. ✅
- ADR-0004/0005(6–8주 바·범위분할): 곡·passaggio·belt·appoggio정교화 등 초급 제외 유지. ✅
- ADR-0006(blocked→variable): 매크로 §4 + 변주 엔진(issue 26). ✅
- ADR-0014(시각전용·정직한계): C5/C11/C12 시각 곡선, 저신뢰 비표시. ✅
- ADR-0015(Card 스키마): cards.md 13 IN 준수(변경 없음). ✅
- ADR-0016(시간게이트 없음): 본운동 7–11분=가이드, 쿨다운 스킵가능. ✅
- CONTEXT 글로서리: 신규 용어 도입 없음(기존 어휘만). ✅

## 5. 자기비평 + 잔존 갭

- **누락**: 초급 자체 누락 없음(보강 제안서가 "신규 기법 0개" 확인). 외부 리서치가 추가할 여지 적음 = 초급 범위가 이미 잘 잡힘.
- **약근거 표기**: 3분류(KOR_KIM2025)·자기청취 효능은 OCEBM 낮음 → 교육 프레임·비차단 정보로 한정(임상 주장 아님).
- **잔존 갭(범위 밖, 추적용)**: 한국어 가창 formant DB 부재(A, part 16) — 초급은 곡 없어 영향 작음. 변성기/청소년은 ADR-0001로 범위 밖.
- **상위 단위 이관 확인**(보강 제안서 §5): appoggio 정교화→코어 §4.3, 모음조정·passaggio→코어 P4-09/10·P5-03/06, 트왱→코어 P4-12+뮤지컬, singer's formant→성악, placement→컷(ADR-0012). 모두 RESEARCH-INDEX.md 매핑과 일치.

## 6. 결론

초급은 **출처 역검증 통과**(13카드·매크로·졸업 4스킬 전부 CITATIONS 키로 추적됨), **보강 변경 0건**(P1 유지·P2 검증·P3 보류), **안전 갭 없음**(P2), **ADR 정합 완전**. canonical 문서 무변경, 본 SOURCES/VERIFICATION 신설로 단위 확정.


===== FILE: docs/curriculum/intermediate-core/CONTEXT.md =====

# 중급 공유 코어 (Intermediate · Shared Core)

초급 졸업 + 장르 트랙 선택 후, *장르 분기 이전*에 모든 학습자(성악·뮤지컬·가요)가 거치는 genre-neutral 중급 코어. 블록1 브리지 + 블록2 공명·모음조정. 블록3 레지스터부터 장르 분기(ADR-0011). 제품 메커니즘은 [[CONTEXT-MAP]] 전역 상속(글로서리 전용 — 구현·레슨수·UI 금지).

## Language

**브리지 (Bridge)**:
초급이 미룬 시간 의존 적응을 *완성*하는 진입 단계 — 균형 발성(P3-07)·SOVT·VFE·Appoggio를 곡/레지스터 부하 직전까지 안정화. ADR-0004가 중급으로 넘긴 책임의 입구. genre-neutral.
_Avoid_: "재초급", "복습"(복귀 복습과 다름 — 이건 적응 완성), 브리지에 장르색 입히기

**공명·모음조정 (Resonance & Vowel Adjustment)**:
포먼트/R1 기초, 모음조정·명료도↔효율 policy의 *genre-neutral 토대*. 패사지오는 여기서 *존재·인지*까지만(장르별 *처리*는 분기 후).
_Avoid_: 코어에서 cover/voce chiusa(성악 분기)·belt음향 타깃(뮤지컬 분기) 확정

**중급 공유 코어 (Intermediate Shared Core)**:
성악·뮤지컬·가요가 *공통으로* 거치는 분기 전 구간. 코어 통과 후 선택 장르 분기로 라우팅.
_Avoid_: "뮤지컬 중급의 일부"(코어는 장르 무관·선행), 코어에 장르 레지스터 도입

## Relationships

- **브리지 → 공명·모음조정** (= 블록1·2) → *블록3에서 장르 분기* (ADR-0011)
- 초급 **졸업**(4스킬)이 코어 진입을 해금 — 초급이 미룬 적응 완성은 **브리지**가 이어받음 (ADR-0004)
- 코어 이후 분기: [중급 — 뮤지컬](../intermediate-musical/CONTEXT.md) / 성악·가요(미작성)
- 제품 메커니즘 전역 상속 [[CONTEXT-MAP]]

## Flagged ambiguities

- 성악↔뮤지컬 분리/결합 — 해결: **공유 코어 + 블록3 분기**(ADR-0011). 전이 목표가 정반대(cover↔belt)라 코어엔 장르색 금지
- 패사지오는 코어에서 *인지*까지, 장르별 *처리*(클래식 cover / MT 믹스·belt진입)는 분기 후


===== FILE: docs/curriculum/intermediate-core/CURRICULUM.md =====

# 중급 공유 코어 — 커리큘럼 (Intermediate · Shared Core)

> 글로서리 `docs/curriculum/intermediate-core/CONTEXT.md`. 근거 ADR-0004/0011/0012. 제품 메커니즘은 `docs/app/APP-SPEC.md` 전역 상속.

## 0. 정체성

초급 졸업 + 장르 트랙 선택 후, *장르 분기(블록3) 이전* 모든 학습자(성악·뮤지컬·가요)가 거치는 **genre-neutral 중급 코어**. 블록1 브리지 + 블록2 공명·모음조정. 곡 없음(곡은 분기 블록4부터). 초급이 미룬 시간 의존 적응의 *완성*을 여기서 시작(ADR-0004).

## 1. 진행·안전·레슨 해부

초급과 동일(제품 전역) — 1일 1레슨 캡·완료 기반·단일 선형·관대 스트릭·복귀 복습·앱 실행 경고·무납득+변주·막지 않는 인-레슨 피드백(시각 전용, 저신뢰 수치 비표시)·레슨 해부(진입~2분/본 7–11/쿨다운 1–2 스킵가능)·무성 레슨 0개. 상세 `APP-SPEC.md`.

## 2. 매크로 (블록1·2 — 내부 설계 전용)

| 블록 | 주제 | 카드(코어 IN, ADR-0012) |
|---|---|---|
| 1 브리지 | 적응 완성 | P3-07 균형발성 · SOVT(빨대 P3-13·트릴·hum P3-19/20·물저항 **P3-15**) · VFE 4과제 P3-08~12 · 온셋 유형 P3-01~05 · §4.3 Appoggio 정교화(*아카이브 커리큘럼 §4.3 — research ID 아님*) |
| 2 공명·모음조정 | 음향 토대 | P4-05 SOVT→개모음 · P4-09/10 모음조정·포먼트튜닝 *기초* · P4-13 명료도↔효율 policy *개념* · P4-07 후두높이 *통제변수 인지* · P4-12 의도/비의도 비음 분리 · 패사지오 *인지*(P5-03/06 인지 수준) |

블록2 종료 → **장르 분기**로 라우팅(선택 장르: 뮤지컬/성악/가요).

### 2b. 레슨 수 매핑 (G1 — 내부 설계 전용)

초급 규칙 계승(13카드→48레슨, 카드당 평균 ~3레슨을 변주축으로 확장; ADR-0006 blocked→variable).
표준샘플 SOP(D2)는 각 블록 경계에 1레슨씩 삽입.

| 블록 | 카드(코어 IN) | 카드→레슨 확장 | 표준샘플 | 블록 레슨 수 |
|---|---|---|---|---|
| 1 브리지 | IC-01~05 (5장) | 5 × ~3 = 15 | +1(진입 베이스라인) | **16** |
| 2 공명·모음조정 | IC-06~11 (6장) | 6 × ~2.5 = 15 | +1(코어 통과 A/B) | **16** |

- **코어 소계 ≈ 32레슨**(범위 28–36). 변주 배수는 blocked(IC-02 SOVT·IC-05 Appoggio) ×2,
  lightVariable/variable(IC-01·07·11) ×3 기준으로 가감.
- 분기(블록3·4)는 각 분기 CURRICULUM의 동일 표 참조. **코어+분기 합산 ≈ 70–98레슨**과 정합:
  코어 32 + 분기 ~40–58 = ~72–90.

## 3. 카드 (코어 IN — 10–15분 포맷, 무납득·운동 지시 cue만)

- **P3-07 균형 발성**: 과기식↔균형↔과압착 사이. 인-레슨 3분류 정보(막지 않음). cue "짜내지도 새지도 않게".
- **SOVT 세트**(빨대/립트릴/허밍·NG/물저항): 부하 저감 + 워밍업 겸함. cue "이로 물지 마세요 / 일정하게".
- **VFE 4과제**(P3-08~12, Stemple): knoll sustain → /o/ SOVT 글라이드 → 저충격 파워. 지구력 토대(RCT 최강근거).
- **온셋 유형**(P3-01~05): hard/balanced/breathy 대조, /h/ easy onset, flow→voice 브리지. cue "치지 말고 흘려보내기" — 단 *균형 onset이 유일 정답 아님*(스타일 의도 존중).
- **§4.3 Appoggio 정교화**: 흡기자세 유지·호기 antagonism(초급서 미룸). cue "들숨 자세를 노래 동안 유지".
- **P4-05 SOVT→개모음 전이**: 빨대 /u/ → 같은 음 개모음 carryover.
- **P4-09/10 모음조정·포먼트튜닝 기초**: R1:f0 관계 *개념·기초만*(고소프라노 aggiustamento·belt 방향은 분기).
- **P4-13 명료도↔효율 policy 개념**: "정답은 장르·증폭 의존" 틀만 — 적용은 분기.
- **P4-07 후두높이**: 통제변수 *인지*("높이면 짧아짐"). 클래식 저/CCM 고는 분기에서.
- **P4-12 비음 분리**: 의도 nasality ↔ 비의도 nasalization 분리(P4-12 본체). "트웽 = 입 안 협착, 콧소리 ❌"는 part 5 §용어표(L32) 근거 — 운동 지시 cue로만.
- **패사지오 인지**(P5-03/06): primo/secondo *존재·관찰*까지. 장르별 *처리*는 분기.
- **IC-12 표준샘플 SOP**(D2·G2): 고정 과제(/a,i,u/·문장·글라이드) 동일 조건 녹음 → 직전 회차와 *시각* A/B. 초급 졸업 4스킬 ③ 계승, 블록 경계(2b 표)에 주기 삽입. 졸업/전이 판정의 자기평가 축 — 비차단·시각 전용. 분기 졸업 A/B도 동일 SOP 사용.

## 4. 분기·전이

블록2 완주 = 코어 통과. 선택 장르 분기로 진입(뮤지컬 → `intermediate-musical/CURRICULUM.md`). 코어는 *완성점 아님* — 적응 완성은 분기와 함께 연속(ADR-0004). 코스 경계 처리는 통합 전이(ADR-0010).

## 5. 명시 제외 (코어 아님 → 분기/타분기/컷)

- belt 음향 타깃·믹스·구강 트웽 *적용*·곡 → **뮤지컬 분기**
- cover/voce chiusa/copertura·aggiustamento 클래식 적용 → **성악 분기**(미작성)
- 풀 벨트·디스토션 → **고급** (요들은 원본상 중급~고급 — 우리는 보수적으로 고급에 둠)
- **P4-06 Singer's Formant/vocal ring**(클래식·측정가능) → **성악 분기 소관**(컷 아님)
- placement 은유(**P4-02/P4-04**, ⚫ 측정변수 없음)·CVT 풀 모드·판소리 시김새 → **컷**(ADR-0012)


===== FILE: docs/curriculum/intermediate-core/cards.md =====

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

### IC-12 · 표준샘플 SOP (자기평가, 주기 카드)  (kind: assessment · 블록 경계)
- cue: ["조용한 곳에서 같은 조건으로.", "/a/ /i/ /u/ 각 5초 + 표준 문장 1줄 + 저→고→저 글라이드.", "녹음 후 *시각 곡선*을 직전 회차와 나란히 비교(듣고 판단 ❌)."]
- voicedMicroWin: ["고정 과제 녹음 1세트(전체 유성)"]
- antiPatterns: ["매번 다른 과제로 비교 무력화 ❌", "청각으로만 자가판정 ❌"]
- anatomy: { entry:"환경·자세 확인", main:"고정 과제 녹음→직전 회차 시각 A/B", cooldown:"가벼운 허밍" } · cooldownSkippable: true
- feedback: { kind: visual }  # 졸업/전이 판정 연속(초급 졸업 4스킬 ③ 계승), 비차단
- variableAxes: { }   # 고정 과제 — 변주 없음(비교 가능성이 핵심, CARD-13과 동형)
- 중단 cue: ["통증 → 중단"]

### IC-11 · 패사지오 인지 (P5-03/06)  (kind: concept · 블록2)
- cue: ["저음→고음 사이렌으로 천천히.", "소리 질감이 바뀌는 *구간*을 관찰(없애려 하지 않기).", "(믹스·belt·cover 처리는 분기에서)."]
- voicedMicroWin: ["사이렌 글라이드 3회"]
- antiPatterns: ["전환 구간에서 힘으로 밀어붙이기 ❌"]
- anatomy: { entry:"가벼운 글라이드", main:"primo/secondo passaggio 존재·관찰", cooldown:"하행 사이렌 1회" } · cooldownSkippable: true
- feedback: { kind: visual }  # M0–M3 메커니즘(ROUBEAU2009) — 인지 수준만
- variableAxes: { range:["중음","±3도","약간 확장"], glide:["사이렌","작은 글라이드"] }
- 중단 cue: ["전환부 통증·삑사리 반복 → 중단"]


===== FILE: docs/curriculum/intermediate-core/VERIFICATION.md =====

# 중급 코어 — 검증 로그 (VERIFICATION)

> 6단계 루프 산출물. 교차검증(적대적) + 자기비평 + 안전 플래그 + 잔존 갭.

## 1. 교차검증 (claim별 반박 시도)

| claim | 지지 | 반박 시도 | 판정 |
|---|---|---|---|
| VFE가 지구력·효율 개선 | STEMPLE_VFE(RCT) | "원 RCT n 작음·대상 제한" | **유지(최강 근거)**. 가창 드릴 중 RCT 보유는 희소. 저충격 강조로 안전 |
| 3분류(과기식/균형/과압착) | KOR_KIM2025 | "OCEBM 5·한국1차" | **유지(약근거·교육 프레임)**. 임상 진단 아님, 비차단 정보 |
| Appoggio=흡기자세 유지 길항 | MILLER1996 | "정전이나 RCT 아님·용어 충돌(part14)" | **유지(지시 한정)**. cue는 "들숨 자세 유지"로 조작화, 생리 설명 금지 |
| 모음조정 R1:f0 기초 | BOZEMAN2013 | "고소프라노 aggiustamento·belt는?" | **코어 제외 확인**. 코어는 *기초 관찰*만, 적용은 분기(CHAN_DO2021은 성악) |
| 트웽=입안 협착(콧소리 ❌) | GIBIAT2024(MRI) | "트웽 정의 학파 충돌(part14)" | **유지(운동 지시)**. 협착 영상 근거 + cue로만, 정의 논쟁 비노출 |
| 패사지오 인지까지 | ROUBEAU2009(M0–M3) | "장르 처리 없이 인지만 유효한가" | **유지**. 분기 전 genre-neutral 토대. 처리=분기(설계상 의도) |

**충돌 기록**: cover↔belt 전이목표 정반대 → 코어에 장르색 금지로 회피(ADR-0011). 코어 자체 출처 모순으로 멈출 사안 없음.

## 2. 안전 플래그

- **신규 S등급 안전 항목 없음**: 코어는 belt·고음·풀벨트 *제외*(→뮤지컬/고급 분기). IC 카드의 SOVT·Appoggio·균형발성은 초급에서 이미 안전 cue 검증된 드릴의 *심화*라 신규 안전 결정 부재.
- **상속 안전 cue**: SOVT 어지럼·물저항 호흡기 대체(초급 P2 검증분), Appoggio 과호흡→일반호흡 복귀. 신규 위험 신호 없음.
- **주의(비-S)**: IC-01 균형발성 과압착, IC-04 hard onset 습관화 → 운동 지시 cue로 가드(자가 확정 가능, HITL 불요).

## 3. ADR/CONTEXT 정합
- ADR-0011(공유 코어+블록3 분기): 블록1·2 genre-neutral, 분기색 0. ✅
- ADR-0012(코어 vs 분기 카드 범위): belt음향·cover·aggiustamento·singer's formant·placement·CVT풀모드·판소리시김새 전부 코어 제외(§5). ✅
- ADR-0004(적응 완성 연속): 브리지가 초급 미룬 책임 이어받음. ✅
- ADR-0002(무납득): 전 cue 지시문, 출처 본 문서만. concept 카드(IC-08/09/11)도 "관찰" 지시지 설명 아님. ✅
- ADR-0015: cards.md 11장 스키마 준수. ✅

## 4. 자기비평 + 잔존 갭
- **누락 점검**: 보강 제안서 §5 "공간↔트왱 독립 다이얼·periodization/디로드"는 *어느 커리큘럼에도 없음* → 코어 갭 후보. 현재 미반영(별건). 기록만.
- **약근거**: 3분류·후두높이 인지·명료도 policy는 OCEBM 낮음(개념) → concept 카드로 분리, 임상/효능 주장 아님.
- **경계 확인**: IC-07 모음조정은 "기초 관찰"로 제한 — aggiustamento(성악)·포먼트튜닝 belt방향(뮤지컬) 침범 안 함. IC-11 패사지오 "인지"로 제한. ✅

## 5. 결론
중급 코어 = cards.md(11 IN) + SOURCES + VERIFICATION 신설로 단위 확정. CURRICULUM.md는 기존 유지(정합 확인). 신규 S등급 안전 항목 없음(belt/고음은 분기). **잔존 갭**: periodization/디로드·트왱 다이얼은 코어 갭 후보로 기록(별건).


===== FILE: docs/curriculum/intermediate-musical/CONTEXT.md =====

# 중급 — 뮤지컬 (Intermediate · Musical Theatre) — *공유 코어 이후 장르 분기*

[중급 공유 코어](../intermediate-core/CONTEXT.md)(블록1 브리지 + 블록2 공명·모음조정) 통과 후 진입하는 **뮤지컬 분기**(블록3 레지스터 + 블록4 텍스트·딕션·캐릭터·곡, ADR-0011). 텍스트·캐릭터 기반 곡을 향해 mix·구강 twang·패사지오·belt 진입을 쌓는다. 제품 메커니즘은 [[CONTEXT-MAP]] 전역 상속(글로서리 전용 — 구현·레슨수·UI 금지).

## Language

### 단계

**텍스트→캐릭터→곡 (Text→Character→Song)**:
뮤지컬의 *정체성* 루프 — 테크닉(<1분) → 새 호흡 → *텍스트를 말로 전달* → 같은 텍스트를 음정과 함께 → 캐릭터 의도. "노래를 부른다"가 아니라 "텍스트를 전달한 뒤 해석한다". (Rodenburg 라인 P6-09.)
_Avoid_: "곡 연습", "발성 위에 가사 얹기"(순서가 반대 — 텍스트 먼저)

**한국어 딕션 (Korean Diction)**:
한국 사용자 텍스트 전달의 필수 부하 — 평·경·격음 VOT(경음 → 과압 위험), 종성 7대표음(불파·지속 가능 여부), 연음·비음화, 번역 뮤지컬 운율 재조정(음절박자 한국어 ↔ 강세박자 원어). *독립 기둥이 아니라* 텍스트→캐릭터→곡의 **교차 스트림**(딕션은 텍스트 전달을 위해서만 의미 — 고립 시 전이 ❌).
_Avoid_: "딕션 전용 블록", "발음 교정 코스"(고립), 콧소리식 오역

### 레지스터

**패사지오 (Passaggio)**:
primo/secondo 레지스터 전이 구간(Miller Fach 표준). 훈련 목표는 전이를 *없애는 것이 아니라 관리*(불안정 분산·회복). primo ≠ secondo (다른 사건).
_Avoid_: "전이 제거", "브레이크 없애기", SLS "bridge"·CVT "mode change"를 같은 말로 섞기(동의어 아님, 학파별 정의)

**믹스 (Mix)**:
*과학적 합의 없음.* 단일 정의 금지 — M1-기반 / M2-기반 / 스타일 라벨(belt-mix 등) 별도 필드로 다룬다.
_Avoid_: "흉성 50% + 두성 50%"(검증된 적 없음), 단일 정의

**트웽 (Twang)**:
후두개/AES(아리에피글로틱 괄약) 협착 → 2.5–3.5 kHz 클러스터, *구강* 현상. 명료도·전달력·경제성. 중급은 *구강 트웽*까지.
_Avoid_: "콧소리", "비음", nasality(별개의 연구개 현상 — 흔한 한국어 오역)

**벨트 (Belt) / 벨트 진입 (Belt Entry)**:
음향 정의 = R1:H2 튜닝 + 높은 CQ + 성문하압 2–3배. **중급 천장 = 벨트 *진입*만**(call-based·짧게·보수적·"크게 말고 밝게"). 지속 벨트·벨트-믹스 확장·디스토션 = *고급 컨텍스트*(별도, 미생성).
_Avoid_: 중급에서 "풀 벨트/지속 벨트", "벨트 = 흉성 고음 지르기", "크게"

**legit (레짓)**:
클래식 인접의 맑은 음색 극(belt의 반대 극). 뮤지컬은 legit과 belt가 *공존*하는 장르.
_Avoid_: "클래식 그대로", legit/belt/mix를 생리적으로 정의된 것처럼 쓰기(현장 용어, 음향·생리 정의 빈약함을 표기)

**레퍼토리 (Repertoire)**:
곡. 초급엔 없고 *여기서 처음 등장*. 중급 = legit + 라이트 벨트-진입 곡 구절(풀 벨트 레퍼토리 ❌ → 고급).
_Avoid_: 초급에 곡 도입, 중급에 풀 벨트 곡

**뮤지컬 분기 경로 (MT Branch Path)**:
*공유 코어 이후* 뮤지컬 분기(블록3·4)의 선형 레슨열. 코어 + 분기 합산 목표 **약 10–14주(1일 1레슨 ≈ 70–98레슨)**. 완주 = **고급 뮤지컬 해금**(미생성 — ADR-0010 통합 전이: 장르 의향 + 유지 모드로 보류). 제품 메커니즘 전역 상속.
_Avoid_: "초급과 같은 6–8주", "완주 = 숙련 완성"(고급으로 연속), 분기 경로에 코어(브리지·공명) 포함시키기

## Relationships

- [공유 코어](../intermediate-core/CONTEXT.md)(브리지→공명·모음조정) **이후** 진입 → 블록3 레지스터(믹스·구강 트웽·패사지오·벨트 진입) → 블록4 텍스트→딕션→캐릭터→곡 (연구 part 3→4→5→6 핸드오프와 일치)
- **벨트 진입**이 뮤지컬 분기 레지스터 천장 — *풀 벨트*는 고급 뮤지컬 컨텍스트(미생성, ADR-0007)
- 코어의 **패사지오 인지**를 받아 *뮤지컬식 처리*(믹스·belt진입 방향)로 전개 — 클래식 cover/voce chiusa는 성악 분기 소관
- 제품 메커니즘(듀오링고 일일·1일1레슨 캡·완료 기반·무납득·관대 스트릭·실행 경고·레슨 해부)은 전역 상속 [[CONTEXT-MAP]]

## Example dialogue

> **개발자:** "중급에서 '벨트' 레슨이면 풀 벨트를 가르치나요?"
> **도메인:** "아니요 — 중급 천장은 *벨트 진입*입니다. call-based로 짧게, '크게'가 아니라 '밝게'. 지속 벨트는 고급. 뮤지컬이 부상률 1위라(39%) 진입까지만."
> **개발자:** "트웽은 콧소리 추가인가요?"
> **도메인:** "절대 아닙니다. 트웽은 구강 AES 협착이고 콧소리(비음)는 별개 연구개 현상입니다. 그 둘을 섞으면 안 됩니다."

## Flagged ambiguities

- 벨트 위치 — 코퍼스는 belt를 고급/전공에 둠 vs 잠금 결정은 중급 → 해결: **벨트 진입 = 중급, 풀 벨트 = 고급**(ADR-0007)
- "믹스"가 학파별로 레지스터/전이기능/스타일라벨로 충돌 → 해결: **단일 정의 금지, 다중 필드**
- "트웽"이 한국어로 콧소리로 자주 오역 → 해결: **구강 AES 협착, nasality와 분리**
- 지연발현 부상 안전 모순 — *해소가 아니라 명시적 위험 수용*으로 종결 (ADR-0008): 안전 = 앱 실행 경고 하나, belt 부하·피로 미감지를 알고도 진행. belt-진입 한정(ADR-0007)이 유일 완화
- belt/twang 정확성 cue 충돌 — 해결(ADR-0002 개정): "밝게/트웽=입 안" 등은 *운동 지시 cue로 허용*(rationale 아님), 골전도·마이크 한계는 *설계로 제거*(시각 전용 + 저신뢰 수치 비표시)
- 성악↔뮤지컬 분리/결합 — 해결: **공유 코어 + 블록3 분기**(ADR-0011). 브리지·공명은 [공유 코어](../intermediate-core/CONTEXT.md)로 이전, 본 컨텍스트는 뮤지컬 *분기*


===== FILE: docs/curriculum/intermediate-musical/CURRICULUM.md =====

# 중급 — 뮤지컬 분기 커리큘럼 (Intermediate · Musical Theatre Branch)

> 글로서리 `docs/curriculum/intermediate-musical/CONTEXT.md`. 근거 ADR-0007/0008/0009/0011/0012. 제품 메커니즘은 `docs/app/APP-SPEC.md` 전역 상속. **선행**: `docs/curriculum/intermediate-core/CURRICULUM.md`(블록1·2) 통과.

## 0. 정체성

공유 코어(브리지·공명·모음조정) 이후 진입하는 **뮤지컬 분기**(블록3 레지스터 + 블록4 텍스트·딕션·캐릭터·곡). 뮤지컬 = *연기하는 노래* — 텍스트를 전달한 뒤 해석. 곡(레퍼토리)이 *여기서 처음* 등장. 코어+분기 합산 ≈ 10–14주(1일 1레슨 ≈ 70–98레슨).

## 1. 진행·안전·레슨 해부

제품 전역 상속(`APP-SPEC.md`) — 초급/코어와 동일. **belt 안전**: ADR-0008로 부하·피로 모니터링 없이 진행함을 *명시 수용*. 완화 = belt를 **진입까지만**(ADR-0007) + 짧은 call-based + "밝게, 크게 아님" 운동 지시 cue.

## 2. 매크로 (블록3·4 — 내부 설계 전용)

| 블록 | 주제 | 카드(뮤지컬 분기 IN, ADR-0012) | 변주 |
|---|---|---|---|
| 3 레지스터 | 믹스→트웽→패사지오→belt 진입 | P5-04 믹스 · 구강 트웽(P15-20 *oral*) · 패사지오 *처리*(믹스·belt 방향) · P15-18 Bozeman 모음전환 · **call-based 벨트 진입(천장)** | escalating |
| 4 텍스트·딕션·캐릭터·곡 | 연기하는 노래 | P6-08 자음에너지 · **P6-09 Rodenburg 텍스트 루프** · P6-10 명료도 블라인드 · 한국어 딕션 P6KR-01~09(교차 스트림) · P6-07 패터 · P6-14 영어 딕션 | — |

완주 → **고급 뮤지컬**(미생성) → 통합 전이(ADR-0010): 의향 + 유지 모드.

### 2b. 레슨 수 매핑 (G1 — 내부 설계 전용)

초급 규칙 계승(카드당 평균 ~3레슨 변주 확장). 표준샘플 SOP(D2)는 블록 경계 1레슨.

| 블록 | 카드(뮤지컬 IN) | 카드→레슨 확장 | 표준샘플 | 블록 레슨 수 |
|---|---|---|---|---|
| 3 레지스터 | IM-01~05 (5장; IM-02/03/05 = 안전 게이트) | 5 × ~3 = 15 | +1 | **16** |
| 4 텍스트·딕션·캐릭터·곡 | IM-06~12 (7장) | 7 × ~3.5 = 25 | +1(분기 졸업 A/B) | **26** |

- **뮤지컬 분기 소계 ≈ 42레슨**(범위 38–48). 안전 게이트 카드(IM-02/03/05/12)는 사인오프
  전 잠금 → 미사인오프 시 *해당 레슨 분량이 제외*되어 분기 길이 단축(I5 게이트).
- **코어(32) + 뮤지컬 분기(42) ≈ 74레슨** — ADR(코어+분기 70–98) 정합.

## 3. 카드 (뮤지컬 분기 IN — 무납득·운동 지시 cue만)

### 블록3 레지스터
- **P5-04 믹스**: M1↔M2 사이 연결. 단일 정의 ❌ — *경험*으로 제시(M1기반/M2기반/스타일). cue "흉성 50%+두성 50% 같은 설명 없이, 이 음에서 이 느낌".
- **구강 트웽**(P15-20 oral만): 오리/마녀 소리 → 명료·전달·경제. cue "입 안을 좁혀 밝게, 콧소리 ❌".
- **패사지오 처리**: 코어의 *인지*를 받아 믹스·belt 방향으로 전이 *관리*(없애기 ❌). 사이렌·글라이드.
- **P15-18 Bozeman 모음 전환**: H2가 R1(F1)을 통과하는 지점 모음 조정("turning the vowel"). 운동 지시로만.
- **call-based 벨트 진입**(천장, ADR-0007): "Hey!" 콜 → 짧게(call-based), 보수적. cue "**밝게, 크게 아님**". 지속/풀 벨트 ❌(고급).

### 블록4 텍스트·딕션·캐릭터·곡
- **P6-08 자음 에너지 / 배우-스피치 브리지**: 문장 3조건(보통/뭉갬/정밀) → 정밀 채택 → chant→sing.
- **P6-09 텍스트 해체-재구성**(Rodenburg, MT 핵심): 테크닉<1분 → 새 호흡 → 텍스트 *말로* 전달 → 같은 텍스트 음정 → 3회 반복. (P6-09 절차 자체는 여기까지 — *캐릭터*는 본 분기 상위 프레임이지 P6-09 단계가 아님.)
- **P6-10 명료도 블라인드**: 시각/구조 피드백(듣고 판단 ❌).
- **한국어 딕션**(P6KR-01~09, 교차 스트림): 평·경·격음 VOT(경음→과압 주의 cue), 종성 7대표음(불파/지속), 연음·비음화, /ㅢ//ㅐㅔ/·이중모음 정책. **번역 뮤지컬 운율 재조정**(음절박자↔강세박자)은 part 6-KR의 *비카드 산문*(P6KR 카드 아님, "검증 필요" 태그) — 같이 다루되 카드로 오인 ❌. 고립 블록 ❌ — 곡과 함께.
- **P6-07 패터**: 빠른 조음 템포 램프(뮤지컬 태그).
- **P6-14 영어 딕션**: 영어권 레퍼토리용 이중모음/r 정책.
- **레퍼토리**: legit 곡 구절 + *라이트 벨트-진입* 구절. 풀 벨트 레퍼토리 ❌(고급). 공식 레벨표 없음 — legit → 라이트 belt-진입 난이도 순.

## 4. 명시 제외 (뮤지컬 분기 아님)

- 풀/지속 벨트·Belt→Mix 확장·/æ,e/ 확장·디스토션 → **고급 뮤지컬**(ADR-0007). 요들은 원본상 중급~고급 — 우리는 보수적으로 고급
- cover/voce chiusa/copertura·aggiustamento(클래식 고소프라노)·**P4-06 Singer's Formant/vocal ring** → **성악 분기**(미작성, 컷 아님)
- placement 은유(**P4-02/P4-04**, ⚫ 측정변수 없음)·CVT 풀 모드 시스템·판소리 시김새→애드립 → **컷**(ADR-0012)


===== FILE: docs/curriculum/intermediate-musical/cards.md =====

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


===== FILE: docs/curriculum/intermediate-musical/VERIFICATION.md =====

# 중급 뮤지컬 분기 — 검증 로그 (VERIFICATION)

> 6단계 루프 산출물. ⚠️ 본 단위는 **S등급 안전**(belt·고음·트웽·패사지오 처리) 포함.
> 해당 카드는 *자가 확정하지 않음* — 아래 §2 HITL 사인오프 필요 목록.
>
> **교차검증(독립 리서치 2종, 2026-06 — [도시에](../../verification/SAFETY-EVIDENCE-DOSSIER.md)):**
> 트웽(IM-02)·패사지오(IM-03) = 조건부 가능 / belt 진입(IM-05)·레퍼토리(IM-12) = 조건부·
> **일반공개 보류**(성인 beta + 하드캡 선행). belt 상한 여 C5/남 A4 아래(✅Bourne&Garnier 2012).
> 사인오프 선결조건 = 전문가 ✅ + 강제 캡·swelling check·다중 stop 구현. 수치는 보수적 추정(dose 부재).

## 1. 교차검증 (claim별 반박 시도)

| claim | 지지 | 반박 시도 | 판정 |
|---|---|---|---|
| 믹스 단일 정의 금지 | VALA2021, SELAMTZIS2019, CONTEXT | "현장은 흉성50+두성50 식 설명" | **유지**. 그 설명은 검증된 적 없음(part 14) → 경험·다중라벨로만 |
| 트웽=구강 AES 협착(비음 아님) | GIBIAT2024(MRI) | "한국어로 콧소리 오역 흔함" | **유지**. MRI 근거 + cue "콧소리 ❌" 명시. nasality 분리 |
| 벨트=R1:H2·높은 CQ·SPL↑ | MCGLASHAN2017(EGG/스트로보) | "`[탐색적 근거]`·Phase III RCT 부재" | **유지(약근거 표기)** + 진입 한정. 음향 정의는 관찰 가능, 효능 주장 안 함 |
| 벨트 진입까지만(중급 천장) | ADR-0007, BRETL2023(MT 39%) | "사용자는 풀 벨트 원함" | **유지(보수)**. 부상률 1위 장르 → call-based·짧게. 풀 벨트=고급 |
| 패사지오 관리(제거 ❌) | ROUBEAU2009, KOR_LEE_HAN2022 | "SLS bridge/CVT mode change와 혼용?" | **유지**. 동의어 아님(학파별) — 섞지 않음(CONTEXT) |
| 텍스트 우선(말→노래) | part 6 Rodenburg 라인 | "Rodenburg CITATIONS 키 없음" | **유지(`[근거 부족]` 표기)**. 현장 표준 라인, 효능 주장 아닌 절차 |

**충돌 기록**: belt 위치(코퍼스=고급/전공 vs 잠금결정=중급) → ADR-0007로 *진입=중급/풀=고급* 분리하여 해소. 지연발현 부상 안전 모순 → ADR-0008 *명시 위험수용*으로 종결(미해소가 아니라 수용). 둘 다 재오픈 사유 아님(기존 ADR로 종결됨).

## 2. ⚠️ 안전 플래그 — HITL 사인오프 필요 (자가 확정 안 함)

다음 카드는 발성안전 검토 *전* 앱 출시 금지:
- **IM-05 call-based 벨트 진입** [S등급]: 부하·피로 미감지(ADR-0008) 상태로 belt 도입. 완화(진입 한정·call-based·"밝게 크게아님"·중단 cue)는 설계됐으나, *실제 cue 강도·음역 상한·세션 빈도*는 발성 전문가 사인오프 필요.
- **IM-03 패사지오 처리**: 고음 방향 전이 관리 — 무리 시 손상. 중단 cue 있으나 사인오프 권장.
- **IM-02 구강 트웽**: 협착 과도 시 조임. 사인오프 권장.
- **IM-12 레퍼토리(라이트 belt-진입 구절)**: belt 적용 곡 — IM-05 사인오프에 연동.

> 근거: BRETL2023(MT 3년차 39% 병변), CHILDS2023, PESTANA2017(가창자 46%). 본 분기는
> 부상률 최고 장르라 안전 결정을 자가 확정하지 않는다(ADR-0008 선례 = HITL).

## 3. ADR/CONTEXT 정합
- ADR-0007(belt 진입=중급/풀=고급): IM-05 천장 한정, §4 풀벨트 고급 제외. ✅
- ADR-0008(명시 위험수용): VERIFICATION에 미감지 수용 명시 + HITL 플래그. ✅
- ADR-0011(공유 코어 후 분기): 코어 패사지오 인지 → 분기 처리 핸드오프. ✅
- ADR-0012(분기 카드 범위): cover/voce chiusa/aggiustamento/singer's formant=성악, placement/CVT풀모드/판소리시김새=컷. §4 준수. ✅
- ADR-0002(무납득): belt/twang cue "밝게/입안 좁힘"=운동 지시(rationale 아님). 골전도·마이크 한계=시각 전용으로 제거. ✅
- ADR-0014(시각전용): IM-08 명료도 "듣고 판단 ❌". ✅
- ADR-0015: cards.md 12장 스키마 준수. ✅

## 4. 자기비평 + 잔존 갭
- **약근거 표기**: belt(MCGLASHAN2017 `[탐색적]`·Phase III RCT 부재), 믹스(과학 합의 없음), Rodenburg(`[근거 부족]` 현장). 모두 효능 주장 아닌 *절차·음향 관찰*로 한정.
- **번역 뮤지컬 운율 재조정**: part 6-KR 비카드 산문(`검증 필요` 태그) — 카드 아님, IM-09에서 곡과 함께 다루되 별도 기둥 ❌(CURRICULUM 명시).
- **잔존 갭**: K-pop/한국 belt 코호트 부재(S, part16) — 뮤지컬은 서구 MT 코호트(BRETL) 외삽. 한국어 가창 formant DB 부재(A).
- **경계 확인**: cover/voce chiusa 침범 안 함(성악 분기). 풀 벨트·디스토션 침범 안 함(고급). ✅

## 4b. ⚠️ 인용 정정 전파 (CITATION-AUDIT V1)
- **BRETL2023 "뮤지컬 39%" → 정정**: 원 출처는 *1년차 유병률* MT 32–40%, *발생률* MT 67%(클래식 22%·CCM 27%는 발생률값). 본 문서·SOURCES의 "39% 최고"는 **"1년차 32–40%/발생률 67% 최고"**로 읽을 것. 안전 방향(MT 부상률 최고 → belt 보수화) *강화*됨(REFUTED 아님).
- 영향: belt 보수 결정·HITL 플래그 *유지·강화*. 수치만 정정, 설계 불변.

## 5. 결론
중급 뮤지컬 = cards.md(12 IN) + SOURCES + VERIFICATION 신설로 *초안 확정*. 단 **belt·트웽·패사지오·belt 곡(IM-02/03/05/12)은 HITL 사인오프 전 출시 금지** — 본 단위는 안전 결정을 자가 확정하지 않는다(ADR-0008). CURRICULUM.md/CONTEXT.md 기존 유지(정합 확인).


===== FILE: docs/curriculum/intermediate-classical/CONTEXT.md =====

# 중급 — 성악 (Intermediate · Classical) — *공유 코어 이후 장르 분기*

[중급 공유 코어](../intermediate-core/CONTEXT.md)(블록1 브리지 + 블록2 공명·모음조정) 통과 후 진입하는 **성악(클래식) 분기**(블록3 레지스터 + 블록4 텍스트·딕션·곡, ADR-0011). 비증폭(어쿠스틱) 전제의 *맑고 울리는*(chiaroscuro) 음색을 향해 cover·aggiustamento·singer's formant를 쌓는다. 제품 메커니즘은 [[CONTEXT-MAP]] 전역 상속(글로서리 전용).

## Language

### 레지스터 (클래식 처리)

**커버 / voce chiusa (Cover / Covering)**:
패사지오 위에서 모음을 *살짝 어둡게·둥글게* 조정해 레지스터 전이를 매끄럽게(secondo passaggio 처리의 클래식 방식). 뮤지컬 belt와 *반대 극* — 비증폭에서 음역을 안전·균질하게 확장. 중급은 *cover 진입*까지(완전 커버드 고음역 = 고급).
_Avoid_: "belt", "흉성 고음 지르기", 비증폭 전제 무시, cover = 후두 누르기(과압 ❌)

**aggiustamento (모음 조정 / Vowel Modification)**:
음이 오를수록 모음을 *중립 쪽으로* 옮겨 F1:f0 충돌을 피함(특히 소프라노 고음). 운동 지시("올라가며 모음 살짝 둥글게")로만, 포먼트 이론 설명 금지(ADR-0002).
_Avoid_: "포먼트 튜닝 강의", 모음 고정한 채 비명, 저음에서 과한 조정

**chiaroscuro (밝음·어둠 균형)**:
밝은 배음(ring)과 어두운 공간감의 *동시* 균형 — 클래식 음색의 핵심. 한쪽만 = 날카롭거나 먹먹함.
_Avoid_: "어둡게만"(먹먹), "밝게만"(날카로움), placement 은유로 설명

**singer's formant / vocal ring (P4-06)**:
2.8–3.2 kHz 배음 군집 → 오케스트라 위로 들리는 *비증폭 투과력*. 측정 가능(클래식 분기 소관, 코어·뮤지컬 아님 — ADR-0012). 중급은 *인지·맛보기*까지.
_Avoid_: "placement"(측정변수 없음 — 컷), CCM/마이크 전제에 ring 강요

### 텍스트·곡

**legato (레가토)**:
음과 음 사이 *끊김 없는* 흐름 — 클래식 라인의 토대. 자음으로 라인이 끊기지 않게.
_Avoid_: 음마다 새 onset(끊김), 자음 과타격

**이탈리아어/독일어 딕션 (IT/DE Diction)**:
클래식 레퍼토리(아리아·리트)의 필수 — 순수 모음(IT), 움라우트·자음군(DE). *곡과 함께*(고립 ❌). 영어 딕션은 영어권 곡에서.
_Avoid_: "딕션 전용 코스"(고립), 한국어식 모음 치환

**messa di voce (메사 디 보체)**:
한 음에서 약→강→약 다이내믹 곡선 — 호흡·성대 정밀 제어의 정점. *기초*는 중급, 완전한 messa di voce = 고급.
_Avoid_: 중급에서 풀 messa di voce 강요, 지속 고음에서 무리

**레퍼토리 (Repertoire)**:
아리아·리트 구절(legit 클래식). 풀 covered 고음역·완전 messa di voce 레퍼토리 = 고급.
_Avoid_: 초급에 곡, 중급에 풀 covered 고음 아리아

**성악 분기 경로 (Classical Branch Path)**:
*공유 코어 이후* 성악 분기(블록3·4) 선형 레슨열. 코어+분기 합산 ≈ 10–14주. 완주 = **고급 성악 해금**(미생성 — ADR-0010 통합 전이: 의향 + 유지 모드).
_Avoid_: "완주 = 숙련 완성"(고급 연속), 분기에 코어 포함

## Relationships

- [공유 코어](../intermediate-core/CONTEXT.md) **이후** 진입 → 블록3 레지스터(cover·aggiustamento·chiaroscuro·ring) → 블록4 legato·IT/DE 딕션·곡
- 코어 **패사지오 인지**를 받아 *클래식 처리*(cover/aggiustamento)로 전개 — 뮤지컬 belt와 반대 극
- **singer's formant(P4-06)**는 성악 분기 소관(코어·뮤지컬 아님, ADR-0012)
- 제품 메커니즘 전역 상속 [[CONTEXT-MAP]]

## Flagged ambiguities

- cover ↔ belt — 정반대 전이 목표. cover = 비증폭 어둡게·둥글게, belt = 증폭 밝게·높은 CQ. 섞지 않음
- cover ↔ 후두 누르기 — cover는 모음·공간 조정이지 후두 강제 하강 ❌(과압 위험)
- singer's formant ↔ placement — ring은 측정 가능(2.8–3.2kHz), placement는 측정변수 없는 은유(컷)
- 안전: 클래식은 부상률 상대적 낮음(BRETL 3년차 22%)이나 *0 아님* — 고음·지속·messa di voce는 보수적(진입·기초까지). 안전 = 앱 실행 경고 + 중단 cue


===== FILE: docs/curriculum/intermediate-classical/CURRICULUM.md =====

# 중급 — 성악 분기 커리큘럼 (Intermediate · Classical Branch)

> 글로서리 `docs/curriculum/intermediate-classical/CONTEXT.md`. 근거 ADR-0009/0011/0012. 제품 메커니즘은 `docs/app/APP-SPEC.md` 전역 상속. **선행**: `docs/curriculum/intermediate-core/CURRICULUM.md`(블록1·2) 통과.

## 0. 정체성

공유 코어(브리지·공명·모음조정) 이후 진입하는 **성악(클래식) 분기**(블록3 레지스터 + 블록4 텍스트·딕션·곡). 비증폭(어쿠스틱) 전제의 chiaroscuro 음색을 향해 cover·aggiustamento·singer's formant·legato를 쌓는다. 곡(아리아·리트)이 분기 블록4부터. 코어+분기 합산 ≈ 10–14주(1일 1레슨 ≈ 70–98레슨).

## 1. 진행·안전·레슨 해부

제품 전역 상속(`APP-SPEC.md`) — 초급/코어와 동일. **클래식 안전**: 부상률 상대적 낮음(BRETL 3년차 22%, 3장르 중 최저)이나 *0 아님*. 고음·지속·messa di voce는 **보수적**(cover 진입·기초까지, 완전 covered 고음역·풀 messa di voce = 고급). 안전 = 앱 실행 경고 + 중단 cue.

## 2. 매크로 (블록3·4 — 내부 설계 전용)

| 블록 | 주제 | 카드(성악 분기 IN, ADR-0012) | 변주 |
|---|---|---|---|
| 3 레지스터 | cover·aggiustamento·ring | CL-01 cover/voce chiusa 진입 · CL-02 aggiustamento · CL-03 chiaroscuro · CL-04 singer's formant 인지(P4-06) | escalating(보수) |
| 4 텍스트·딕션·곡 | legato·딕션·아리아/리트 | CL-05 legato · CL-06 이탈리아어 딕션 · CL-07 독일어 딕션 · CL-08 messa di voce 기초 · CL-09 레퍼토리 | — |

완주 → **고급 성악**(미생성) → 통합 전이(ADR-0010): 의향 + 유지 모드.

### 2b. 레슨 수 매핑 (G1 — 내부 설계 전용)

초급 규칙 계승(카드당 평균 ~3레슨 변주 확장). 표준샘플 SOP(D2)는 블록 경계 1레슨.

| 블록 | 카드(성악 IN) | 카드→레슨 확장 | 표준샘플 | 블록 레슨 수 |
|---|---|---|---|---|
| 3 레지스터 | CL-01~04 (4장; CL-01 = 안전 게이트) | 4 × ~3.5 = 14 | +1 | **15** |
| 4 텍스트·딕션·곡 | CL-05~09 (5장; CL-08 = 안전 게이트) | 5 × ~4 = 20 | +1(분기 졸업 A/B) | **21** |

- **성악 분기 소계 ≈ 36레슨**(범위 32–42). 안전 게이트(CL-01·CL-08) 미사인오프 시 제외.
- **코어(32) + 성악 분기(36) ≈ 68레슨** — ADR(코어+분기 70–98) 하단 근방(딕션 IT/DE 2언어로 ±).

## 3. 카드 (성악 분기 IN — 무납득·운동 지시 cue만)

### 블록3 레지스터
- **CL-01 cover/voce chiusa 진입**: 패사지오 위에서 모음을 살짝 어둡게·둥글게(belt 반대극). cue "올라가며 살짝 둥글게, 후두 누르기 ❌". *진입까지*(완전 cover=고급). `[HITL]` 고음.
- **CL-02 aggiustamento**: 오를수록 모음을 중립 쪽으로(소프라노 고음). cue "고음에서 /a/를 /ɔ/ 쪽으로 살짝".
- **CL-03 chiaroscuro**: 밝음(ring)+어둠(공간) 동시 균형. cue "밝되 먹먹하지 않게, 둥글되 날카롭지 않게".
- **CL-04 singer's formant 인지(P4-06)**: 2.8–3.2kHz ring을 화면으로 인지·맛보기. cue "울림이 모이는 지점 관찰"(placement 은유 ❌).

### 블록4 텍스트·딕션·곡
- **CL-05 legato**: 음 사이 끊김 없는 흐름. cue "자음으로 라인 끊지 않기".
- **CL-06 이탈리아어 딕션**: 순수 5모음·이중자음. *곡과 함께*.
- **CL-07 독일어 딕션**: 움라우트·자음군·종성. *곡과 함께*.
- **CL-08 messa di voce 기초**: 한 음 약→강→약 *기초* 곡선. cue "천천히 부풀렸다 줄이기, 무리 ❌". `[HITL]` 지속·다이내믹.
- **CL-09 레퍼토리**: 아리아·리트 구절(legit 클래식). 풀 covered 고음역·풀 messa di voce 레퍼토리 ❌(고급).

## 4. 명시 제외 (성악 분기 아님)

- 완전 covered 고음역·풀 messa di voce·고난도 콜로라투라 → **고급 성악**(미생성)
- belt·구강 트웽 적용·믹스 스타일 → **뮤지컬 분기**
- K-pop·CCM 스피치라이크·한국어 가창 딕션 → **가요 분기**
- placement 은유(P4-02/P4-04, 측정변수 없음)·CVT 풀 모드·판소리 시김새 → **컷**(ADR-0012)


===== FILE: docs/curriculum/intermediate-classical/cards.md =====

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


===== FILE: docs/curriculum/intermediate-classical/VERIFICATION.md =====

# 중급 성악 분기 — 검증 로그 (VERIFICATION)

> 6단계 루프 산출물. `[HITL]` 안전 항목(고음·지속) 포함 — 해당 카드 자가 확정 안 함.
>
> **교차검증(독립 리서치 2종, 2026-06 — [도시에](../../verification/SAFETY-EVIDENCE-DOSSIER.md)):**
> cover 진입(CL-01)·messa 기초(CL-08) = 조건부 가능(둘 다 *성악 트랙을 가장 출시 가능*으로
> 평가) / full cover·고음 풀 messa = 미출시 유지. 사인오프 선결조건 = 전문가 ✅ + 강제 캡·
> swelling check·다중 stop 구현. messa는 중음·저강도 한정 시 untrained도 비교적 안전(○Kirsch 2025).

## 1. 교차검증 (claim별 반박 시도)

| claim | 지지 | 반박 시도 | 판정 |
|---|---|---|---|
| cover=모음 둥글게(belt 반대극) | MILLER1996 | "cover=후두 누르기로 오해" | **유지**. cue "후두 누르기 ❌" 명시. 모음·공간 조정 |
| aggiustamento(고음 모음 중립화) | CHAN_DO2021(실증) | "포먼트 이론 설명 필요?" | **유지(운동 지시)**. "살짝 둥글게"로 조작화, 이론 설명 금지(ADR-0002) |
| singer's formant=2.8–3.2kHz | SUNDBERG1987(정전) | "placement와 혼동" | **유지**. ring=측정 가능, placement=측정변수 없는 은유(컷). cue로 분리 |
| chiaroscuro 동시 균형 | MILLER1996 | "주관적·측정 어려움" | **유지(지시·시각)**. "밝되 먹먹×, 둥글되 날카로움×"로 조작화 |
| messa di voce 기초 | MILLER1996, TITZE_VERDOLINI2012 | "지속·다이내믹 = 부하" | **유지(기초·HITL)**. 편한 중음 한정, 풀 messa=고급 |

**충돌 기록**: cover↔belt 정반대 전이 목표 → 분기 분리로 회피(ADR-0011/0012). 성악 자체 출처 모순으로 멈출 사안 없음. cover↔후두누르기 오해는 cue 가드.

## 2. ⚠️ 안전 플래그 — HITL 사인오프 필요

- **CL-01 cover/voce chiusa 진입** [고음]: 패사지오 위 처리 — 무리 시 손상. 진입 한정·중단 cue 있으나 *음역 상한·진입 강도*는 사인오프 권장.
- **CL-08 messa di voce 기초** [지속·다이내믹]: 호흡·성대 정밀 부하. 기초·중음 한정·중단 cue 있으나 사인오프 권장.
- 근거: BRETL2023(클래식 22%, 0 아님). 클래식은 3장르 중 최저 부상률이나 고음·지속은 보수적.

> 뮤지컬 belt(S등급)보다는 낮은 위험이나, 고음·messa는 *자가 확정하지 않고* 사인오프로 둔다.

## 3. ADR/CONTEXT 정합
- ADR-0011(공유 코어 후 분기): 코어 패사지오 인지 → 클래식 cover 처리. ✅
- ADR-0012(분기 카드 범위): cover/voce chiusa/aggiustamento/singer's formant(P4-06)=성악 분기 — 뮤지컬 §4·코어 §5가 명시 이관한 것을 *여기서 수용*. placement/CVT풀모드/판소리시김새=컷. ✅
- ADR-0002(무납득): cover/aggiustamento/ring cue 전부 운동 지시("둥글게/중립화/울림 관찰"), 포먼트 이론·placement 은유 금지. ✅
- ADR-0014(시각전용): CL-04 ring "화면으로 관찰". ✅
- ADR-0015: cards.md 9장 스키마 준수. ✅

## 4. 자기비평 + 잔존 갭
- **신규 트랙 정합**: 본 트랙은 *기존 분기 문서들이 "성악 소관"으로 이관한 항목*(cover·aggiustamento·singer's formant)을 수용해 만든 것 → 스코프 충돌 없음. ADR-0012가 이미 성악 분기 존재를 전제.
- **약근거**: chiaroscuro·ring 인지는 음향 정전이나 효능 RCT 아님 → 개념·관찰로 한정.
- **잔존 갭**: 한국어 가창 formant DB 부재(A, part 16) — 성악은 IT/DE 곡 위주라 영향 작음. 고급 성악(완전 cover·풀 messa·콜로라투라) 미생성.
- **경계 확인**: belt·트웽 침범 안 함(뮤지컬). K-pop·한국어 가창 딕션 침범 안 함(가요). 풀 covered 고음·풀 messa 침범 안 함(고급). ✅

## 5. 결론
중급 성악 = CONTEXT + CURRICULUM + cards(9 IN) + SOURCES + VERIFICATION 신규 5문서로 *초안 확정*. **CL-01 cover·CL-08 messa di voce는 HITL 사인오프 전 출시 금지**. 신규 트랙이나 ADR-0012가 성악 분기를 이미 전제했고, 타 분기가 이관한 항목을 수용한 것이라 스코프 충돌 없음.


===== FILE: docs/curriculum/intermediate-gayo/CONTEXT.md =====

# 중급 — 가요 (Intermediate · Gayo / K-pop·CCM) — *공유 코어 이후 장르 분기*

[중급 공유 코어](../intermediate-core/CONTEXT.md)(블록1 브리지 + 블록2 공명·모음조정) 통과 후 진입하는 **가요(K-pop·CCM) 분기**(블록3 스타일·레지스터 + 블록4 한국어 딕션·곡, ADR-0011). *마이크 증폭 전제*의 스피치라이크·믹스·구강 트웽·라이트 belt 진입을 쌓는다. 곡(가요 구절)이 분기 블록4부터. 코어+분기 합산 ≈ 10–14주. 제품 메커니즘은 [[CONTEXT-MAP]] 전역 상속.

## Language

### 스타일·레지스터

**스피치라이크 (Speech-like Singing)**:
*말하듯* 노래하는 CCM 토대 — 자연스러운 말소리 위치에서 출발(클래식 ring·성악 투과력과 반대 전제, 마이크가 음량 보완). 균형/효율 onset 기반.
_Avoid_: "클래식처럼 울리게", 비증폭 ring 강요, hard glottal 습관화

**K-pop 명명 연습 (K-pop Named Drills)**:
기획사·트레이너의 자체 어휘(*lip bubble*=립트릴, *siren*=글라이드 SOVT, *kkook*=균형 onset) — 학술 분류(SOVT/Estill)에 대응하나 산업 내부에선 명명·측정 안 됨. 학습자에게 SOVT 어휘를 *함께* 주면 메커니즘·안전 한계 이해 가능. **단 *k-keok*(강한 글로털 어택)은 결절·출혈 위험으로 중급 훈련 카드 제외**(고급/HITL 영역).
_Avoid_: k-keok hard attack를 중급 드릴로, 기획사 매뉴얼을 검증된 것으로 인용([K-pop 산업관행] 태그)

**트웽/꽥 (Twang)**:
구강 AES 협착 → 2.5–3.5kHz, 전달·경제(콧소리 ❌). K-pop은 같은 음역에서 *neutral voice* 미적 컨트라스트도 사용.
_Avoid_: "콧소리"(비음 — 별개), 고음 지속 트웽

**믹스 / belt 진입 (Mix / Belt Entry)**:
CCM 믹스(단일 정의 ❌) + 라이트 belt *진입*(call-based·짧게). 풀 belt·고음 지속 = 고급.
_Avoid_: "흉성50+두성50", 중급 풀 belt, 고음 지르기

**꺽기 / 런 (Riffs & Runs)**:
음을 빠르게 굴리는 장식(가요·R&B 핵심). *기초 패턴*만 중급(느리게→정확히), 고난도 런 = 고급.
_Avoid_: 정확도 없이 속도만, 고음역 무리 런

### 텍스트·곡

**한국어 가창 딕션 (Korean Singing Diction)**:
평·경·격음 VOT(경음→과압 주의), 종성 7대표음(불파/지속), 연음·비음화. *곡과 함께*(고립 ❌). 한국 사용자 1순위 부하.
_Avoid_: "딕션 전용 코스", 콧소리식 오역, 경음 과압착

**마이크 전제 명료도 (Amplified Clarity)**:
가요는 마이크 증폭 전제 — 명료도↔효율 policy가 증폭 쪽으로(과한 자음 타격 불필요). 모니터·컴프레션 환경 인지.
_Avoid_: 비증폭 ring 요구, 과한 프로젝션

**레퍼토리 (Repertoire)**:
가요 곡 구절(스피치라이크 + 라이트 belt-진입). 풀 belt·고난도 런·고음 지속 곡 = 고급.
_Avoid_: 초급에 곡, 중급에 풀 belt 가요

**가요 분기 경로 (Gayo Branch Path)**:
*공유 코어 이후* 가요 분기(블록3·4) 선형 레슨열. 코어+분기 ≈ 10–14주. 완주 = **고급 가요 해금**(미생성 — ADR-0010 통합 전이).
_Avoid_: "완주 = 숙련 완성"(고급 연속)

## Relationships

- [공유 코어](../intermediate-core/CONTEXT.md) **이후** 진입 → 블록3 스타일·레지스터(스피치라이크·믹스·트웽·belt진입·꺽기 기초) → 블록4 한국어 딕션·곡
- K-pop 명명연습(lip bubble/siren/kkook)은 코어/초급 SOVT의 *산업 별칭* — 같은 운동(part 9-KR 매핑)
- belt·트웽은 뮤지컬 분기와 *기법 공유*하나 *마이크 전제·가요 미감*으로 차별. cover(성악)는 미사용
- 제품 메커니즘 전역 상속 [[CONTEXT-MAP]]

## Flagged ambiguities

- k-keok(강한 글로털 어택) — 산업 관행이나 결절·출혈 위험(part 9-KR 안전 한계) → **중급 훈련 카드 제외**(고급/HITL). kkook(균형 onset)만 채택
- 트웽 ↔ 콧소리 — 구강 AES 협착 ≠ 연구개 비음(흔한 한국어 오역)
- belt — 중급=라이트 진입만, 풀 belt=고급(K-pop 부상 사례 다수 — Onew/Seeya 등)
- K-pop 트레이니 손상 코호트 부재(S등급 갭, part 16) → 안전 권고는 서구 CCM 코호트(SIELSKA 22%) 외삽, 증거 강도 낮음 명시
- 안전 = 앱 실행 경고 + 중단 cue. belt·런·트웽 고음은 보수적


===== FILE: docs/curriculum/intermediate-gayo/CURRICULUM.md =====

# 중급 — 가요 분기 커리큘럼 (Intermediate · Gayo / K-pop·CCM Branch)

> 글로서리 `docs/curriculum/intermediate-gayo/CONTEXT.md`. 근거 ADR-0009/0011/0012. 제품 메커니즘 `docs/app/APP-SPEC.md` 전역 상속. **선행**: `docs/curriculum/intermediate-core/CURRICULUM.md`(블록1·2) 통과.

## 0. 정체성

공유 코어 이후 진입하는 **가요(K-pop·CCM) 분기**(블록3 스타일·레지스터 + 블록4 한국어 딕션·곡). *마이크 증폭 전제*의 스피치라이크·믹스·구강 트웽·라이트 belt 진입·꺽기 기초를 쌓는다. 곡(가요 구절)이 블록4부터. 코어+분기 ≈ 10–14주(1일 1레슨 ≈ 70–98레슨).

## 1. 진행·안전·레슨 해부

제품 전역 상속(`APP-SPEC.md`) — 초급/코어 동일. **가요 안전**: K-pop 트레이니 손상 코호트 *부재*(S등급 갭, part 16) → 권고는 서구 CCM 코호트(SIELSKA2024 22% 결절) 외삽, 증거 강도 낮음. belt·런·트웽 고음은 **보수적**(진입·기초까지). **k-keok(강한 글로털 어택)은 결절·출혈 위험으로 카드 제외**. 안전 = 앱 실행 경고 + 중단 cue.

## 2. 매크로 (블록3·4 — 내부 설계 전용)

| 블록 | 주제 | 카드(가요 분기 IN, ADR-0012) | 변주 |
|---|---|---|---|
| 3 스타일·레지스터 | 스피치라이크·믹스·트웽·belt진입·꺽기 | GY-01 스피치라이크 · GY-02 믹스 · GY-03 K-pop SOVT 워밍업(lip bubble/siren) · GY-04 트웽/꽥[HITL] · GY-05 라이트 belt 진입[HITL·S] · GY-06 꺽기 기초[HITL] | escalating(보수) |
| 4 한국어 딕션·곡 | 딕션·증폭·곡 | GY-07 한국어 가창 딕션 · GY-08 마이크 전제 명료도 · GY-09 레퍼토리 | — |

완주 → **고급 가요**(미생성) → 통합 전이(ADR-0010): 의향 + 유지 모드.

### 2b. 레슨 수 매핑 (G1 — 내부 설계 전용)

초급 규칙 계승(카드당 평균 ~3레슨 변주 확장). 표준샘플 SOP(D2)는 블록 경계 1레슨.

| 블록 | 카드(가요 IN) | 카드→레슨 확장 | 표준샘플 | 블록 레슨 수 |
|---|---|---|---|---|
| 3 스타일·레지스터 | GY-01~06 (6장; GY-04/05/06 = 안전 게이트) | 6 × ~3 = 18 | +1 | **19** |
| 4 한국어 딕션·곡 | GY-07~09 (3장; GY-09 = 안전 게이트) | 3 × ~4 = 12 | +1(분기 졸업 A/B) | **13** |

- **가요 분기 소계 ≈ 32레슨**(범위 28–40). 안전 게이트(GY-04/05/06/09) 미사인오프 시 제외 →
  미사인오프 빌드에서 분기 길이 크게 단축(belt/트웽/런이 분기 핵심이라).
- **코어(32) + 가요 분기(32) ≈ 64레슨** — ADR 하단(한국어 딕션 비중·곡 확장으로 ±).

## 3. 카드 (가요 분기 IN — 무납득·운동 지시 cue만)

### 블록3 스타일·레지스터
- **GY-01 스피치라이크**: 말하듯 자연스러운 위치에서 노래로. cue "말하듯 편하게, 지르지 않기".
- **GY-02 믹스**: CCM 믹스(단일 정의 ❌, 경험으로). cue "이 음에서 이 느낌".
- **GY-03 K-pop SOVT 워밍업**: lip bubble(=립트릴)·siren(=글라이드 SOVT)·kkook(=균형 onset). 산업 별칭 ↔ SOVT 같이 제시. cue "립버블 일정하게 / 사이렌 부드럽게".
- **GY-04 트웽/꽥**: 구강 AES 협착(witch laugh/duck), 콧소리 ❌. `[HITL]`.
- **GY-05 라이트 belt 진입**: call-based 짧게·밝게(크게 ❌). 풀 belt ❌(고급). `[HITL·S]`.
- **GY-06 꺽기/런 기초**: 음 굴리기 *기초 패턴* 느리게→정확히. 고난도 런 ❌(고급). `[HITL]`.

### 블록4 한국어 딕션·곡
- **GY-07 한국어 가창 딕션**: 평·경·격음 VOT(경음 과압 주의)·종성 7대표음·연음·비음화. *곡과 함께*.
- **GY-08 마이크 전제 명료도**: 증폭 전제 — 과한 자음 타격 불필요. 모니터·컴프레션 인지.
- **GY-09 레퍼토리**: 가요 구절(스피치라이크 + 라이트 belt-진입). 풀 belt·고난도 런·고음 지속 곡 ❌(고급).

## 4. 명시 제외 (가요 분기 아님)

- **k-keok 강한 글로털 어택**(결절·출혈 위험) → 카드 제외(고급/HITL)
- 풀 belt·고음 지속·고난도 런·디스토션 → **고급 가요**(미생성)
- cover/voce chiusa·aggiustamento·singer's formant·IT/DE 딕션 → **성악 분기**
- legit MT·영어 딕션 중심 → **뮤지컬 분기**(기법 공유하나 미감·언어 차별)
- placement 은유·CVT 풀 모드·판소리 시김새→애드립 → **컷**(ADR-0012)


===== FILE: docs/curriculum/intermediate-gayo/cards.md =====

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


===== FILE: docs/curriculum/intermediate-gayo/VERIFICATION.md =====

# 중급 가요 분기 — 검증 로그 (VERIFICATION)

> 6단계 루프 산출물. ⚠️ **S등급 안전**(belt·트웽·런) + **S등급 갭**(K-pop 코호트 부재) 포함.
> `[HITL]` 카드 자가 확정 안 함. k-keok hard attack는 안전상 카드 제외.
>
> **교차검증(독립 리서치 2종, 2026-06 — [도시에](../../verification/SAFETY-EVIDENCE-DOSSIER.md)):**
> 트웽(GY-04)·런(GY-06) = 조건부 가능 / belt 진입(GY-05)·레퍼토리(GY-09) = 조건부·**일반공개
> 보류**. **k-keok 영구 제외 정당 재확인**(✅Andrade 2000: HGA 빈도 병변군>건강군). K-pop 전용
> 코호트 부재 → 둘 다 **더 보수화 + "서구 외삽" 경고** 권고. 선결조건 = 전문가 ✅ + 강제 캡 구현.

## 1. 교차검증 (claim별 반박 시도)

| claim | 지지 | 반박 시도 | 판정 |
|---|---|---|---|
| K-pop 명명=SOVT/Estill 같은 운동 | part 9-KR 매핑, KCONTENT_VOCAL | "기획사 매뉴얼 비공개·동료심사 없음" | **유지(기능적 추론·`[K-pop 산업관행]`)**. lip bubble=립트릴은 *문자 그대로 동일*. 매뉴얼 공개 시 갱신 |
| k-keok = 결절·출혈 위험 | part 9-KR 안전 한계 | "산업 표준 어택인데 빼도 되나" | **제외 유지**. hard glottal 반복 위험 명확 → 중급 비훈련(고급/HITL). kkook(균형)로 대체 |
| 트웽=구강 AES(비음 ❌) | GIBIAT2024(MRI) | "한국어 콧소리 오역 흔함" | **유지**. cue "콧소리 ❌" 명시 |
| belt=라이트 진입만 | MCGLASHAN2017, K-pop 손상 사례 | "K-pop은 고음 belt 미감" | **유지(보수)**. ONEW/Seeya 등 손상 다수 → 진입·call-based. 풀=고급 |
| 마이크 전제 명료도 | KOR_COMPRESSION | "라이브 비증폭은?" | **유지**. 가요=증폭 전제(클래식 ring과 반대). 비증폭은 성악 |

**충돌 기록**: belt/트웽은 뮤지컬과 *기법 공유*하나 마이크 전제·언어·미감으로 분기 분리. cover(성악)는 미사용. 출처 모순으로 멈출 사안 없음 — *증거 강도 낮음*은 §4에 명시.

## 2. ⚠️ 안전 플래그 — HITL 사인오프 필요

- **GY-05 라이트 belt 진입** [S등급]: 부하·피로 미감지(ADR-0008). K-pop 손상 사례 다수(ONEW2014·ALLKPOP_SEEYA2025·KOREABOO_LIST·KH_HEALTH). 진입 한정·call-based·중단 cue 있으나 *음역 상한·빈도* 사인오프 필요.
- **GY-04 트웽/꽥**: 고음 지속 시 후두 피로. 사인오프 권장.
- **GY-06 꺽기/런 기초**: 고음역 무리 런 위험. 기초·중단 cue 있으나 사인오프 권장.
- **GY-09 레퍼토리(belt 구절)**: GY-05 연동.
- **k-keok 제외**: 강한 글로털 어택은 *카드로 만들지 않음*(결절·출혈) — 고급/HITL 영역.

## 3. ⚠️ S등급 갭 (증거 강도 제약 명시)
- **K-pop 트레이니 손상 코호트 부재**(part 16 S): 1차 한국 데이터 없음 → 안전 권고는 서구 CCM 코호트(SIELSKA2024 22% 결절·BRETL2023 CCM 27%) **외삽**. 본 분기 안전 권고는 *증거 강도 낮음*을 안고 있음.
- **한국어 가창 formant DB 부재**(A): 딕션은 IPA 매핑(LEE2017CGU)까지, 측정 DB 미공개.
- **판소리 안전성 정량연구 부재**(A): 본 분기는 판소리 시김새 미포함(컷, ADR-0012)이라 직접 영향 없음.

## 3b. ⚠️ 인용 정정 전파 (CITATION-AUDIT V1)
- **SIELSKA2024 "22% 결절" → SIELSKA2018(J Voice) 재귀속**: 22% CCM 학생 결절은 2018 논문 소관(2024 Frontiers는 인구특성). 수치 자체는 실재 → 가요 안전 외삽 근거 *유지*(귀속만 정정).
- **belt/CCM 손상 외삽**: BRETL CCM 발생률 27%(정정 후도 동일), SIELSKA2018 22% — 가요 belt 보수화 근거 *유지*. K-pop 코호트 부재(S갭)로 증거강도 낮음은 불변.

## 4. ADR/CONTEXT 정합
- ADR-0007/0008(belt 진입·위험수용): GY-05 진입 한정 + HITL. ✅
- ADR-0011(공유 코어 후 분기): 코어 SOVT/패사지오 인지 → 가요 스타일 처리. ✅
- ADR-0012(분기 범위): cover/aggiustamento/singer's formant=성악, IT/DE·legit=뮤지컬, placement/CVT풀모드/판소리시김새=컷. §4 준수. ✅
- ADR-0002(무납득): K-pop 명명↔SOVT는 *운동 같음* 안내(메커니즘 설명 아닌 동일성), cue 전부 지시문. ✅
- ADR-0014(시각전용): 피드백 visual. ✅
- ADR-0015: cards.md 9장 스키마 준수. ✅

## 5. 자기비평 + 결론
- **안전 보수성**: 부상 사례 가장 가시적인 장르(K-pop) + 코호트 갭 → belt·트웽·런 전부 HITL, k-keok 제외. 보수적 설계.
- **경계 확인**: cover/IT·DE 딕션 침범 안 함(성악), 풀 belt·고난도 런 침범 안 함(고급). ✅
- 중급 가요 = CONTEXT+CURRICULUM+cards(9 IN)+SOURCES+VERIFICATION 신규 5문서로 *초안 확정*. **belt·트웽·런(GY-04/05/06/09)은 HITL 사인오프 전 출시 금지**, k-keok 영구 제외. 증거 강도 낮음(K-pop 코호트 갭) 명시.


############################################################
# Verification harness (docs/verification)
############################################################


===== FILE: docs/verification/VERIFICATION-STATUS.md =====

# 인간 게이트 검증 상태 — 단일 소스 (W4)

> "사람이 결정·조치할 항목"의 현재 검증 상태를 한 곳에 모은 **사람용 요약**.
> 기계용 단일 소스는 [`verification-status.json`](verification-status.json).
> 두 파일과 라이브 코드의 정합은 **W5 하네스(`flutter test`)가 강제**한다 — 어느
> 세션·어느 사람이든 `flutter test`만 돌리면 이 표가 코드와 일치하는지 즉시 검증된다.

## 현재 상태 (2026-06-04)

| 항목 | 결정 주체 | 상태 | 단일 소스 | 해제 방법 |
|---|---|---|---|---|
| 안전 사인오프 | 발성 전문가(HITL) | 🔒 UNVERIFIED | `kSafetySignoff` (빈) | `safety_signoff.dart` 레코드에 검토자+일자+근거 추가 |
| 장르 롤아웃 | 롤아웃/안전 | 🔒 UNVERIFIED | `kReleasedGenres` (빈) | `progression_state.dart` config에 장르 추가 |
| 기기 마이크 검증 | 검증자(육안) | 🔒 UNVERIFIED | `device-results.md` | [체크리스트](DEVICE-MIC-VERIFICATION.md) 수행 후 결과 기록 |
| 고급/periodization | 설계+HITL | ⬜ OUT_OF_SCOPE | CURRICULUM-REVIEW G4·G5 | 의도적 범위 밖(별도 안전 설계 필요) |

기본은 전부 잠금/미검증 = **안전 기본값**. AI는 어느 것도 자가 결정하지 않는다.

> **안전 사인오프 입력 패킷:** [SAFETY-EVIDENCE-DOSSIER.md](SAFETY-EVIDENCE-DOSSIER.md)
> (독립 리서치 2종 교차검증, 2026-06). 사인오프 = 전문가 ✅ **+** 강제 캡 구현
> ([backlog-safety-enforcement.md](backlog-safety-enforcement.md), 이슈 #1) 둘 다 충족 후.

## 세션-독립성이 보장되는 방식

1. **진실의 위치 = git에 박힌 산출물**: 사인오프=`kSafetySignoff`, 롤아웃=`kReleasedGenres`,
   기기=`device-results.md` + `verification-status.json`. 대화·메모리가 아니다.
2. **드리프트 차단**: W5가 이 JSON의 `signedOffCardIds`/`releasedGenres`를 라이브
   코드 상수와 대조 → JSON만 올리고 코드가 안 따르면(또는 반대) **테스트 실패**.
3. **재도출 1커맨드**: 신규 세션은 맥락 없이 `flutter test`로 현재 진실을 재확인.

## 갱신 규칙 (사람)

상태를 바꾸려면 **코드 산출물과 JSON을 함께** 갱신하고 커밋해야 한다(둘 중 하나만
바꾸면 W5 실패):

- **안전 카드 사인오프**: ① `kSafetySignoff`에 항목 추가(검토자/일자/근거)
  → ② JSON `safetySignoff.signedOffCardIds`에 같은 cardId 추가 + `stillGatedCardIds`에서 제거
  → ③ 전 카드 사인오프 시 `status: VERIFIED`.
- **장르 출시**: ① `kReleasedGenres`에 장르 추가 → ② JSON `releasedGenres`에 같은 이름 추가
  → ③ `status: VERIFIED`.
- **기기 검증**: ① `device-results.md`에 런 결과 append → ② JSON `deviceMic.status`를
  종합 결과(VERIFIED/FAIL→UNVERIFIED/BLOCKED)로 갱신.
- **고급/periodization**: 범위 진입 시 별도 안전 설계 ADR + HITL 후 본 표 갱신.

> ⚠️ AI는 위 ①(코드 상수)·기기 결과를 채우지 않는다. 사람만 채운다(자가 결정 금지).
> AI가 도울 수 있는 건 *채워진 사실을 JSON에 반영*하는 동기화뿐이며, 그조차 사람이
> 코드를 먼저 채운 뒤다.


===== FILE: docs/verification/verification-status.json =====

{
  "schema": "vocal-athlete/verification-status@1",
  "updated": "2026-06-05",
  "note": "인간 게이트 항목의 검증 상태 단일 소스(머신리더블). W5 하네스(flutter test)가 이 파일과 라이브 코드 상수의 정합을 강제한다. 임의로 status/목록을 올려도 코드가 뒷받침 못 하면 테스트 실패.",
  "statusEnum": ["VERIFIED", "UNVERIFIED", "BLOCKED", "OUT_OF_SCOPE"],
  "items": {
    "safetySignoff": {
      "decision": "human:HITL",
      "source": "app/lib/safety/safety_signoff.dart (kSafetySignoff)",
      "signedOffCardIds": [],
      "stillGatedCardIds": [
        "IM-02", "IM-03", "IM-05", "IM-12",
        "CL-01", "CL-08",
        "GY-04", "GY-05", "GY-06", "GY-09"
      ],
      "status": "UNVERIFIED",
      "note": "빈 사인오프 레코드 = 전 안전 카드(belt/트웽/cover/messa/런) 잠금. 발성 전문가 사인오프 전까지 UNVERIFIED. AI 자가 승인 ❌.",
      "evidenceInput": "docs/verification/SAFETY-EVIDENCE-DOSSIER.md (독립 리서치 2종 교차검증, 2026-06)",
      "prerequisite": "전문가 ✅ + 강제 캡 구현(docs/verification/backlog-safety-enforcement.md, 이슈 #1) — 둘 다 충족 후에만 사인오프 기입"
    },
    "rollout": {
      "decision": "human:rollout",
      "source": "app/lib/progression/progression_state.dart (kReleasedGenres)",
      "releasedGenres": [],
      "allGenres": ["musical", "classical", "gayo"],
      "status": "UNVERIFIED",
      "note": "빈 config = 전 장르 유지 모드(미출시). 출시는 롤아웃·안전 결정이라 사람만. AI 자가 롤아웃 ❌."
    },
    "deviceMic": {
      "decision": "human:device",
      "source": "docs/verification/device-results.md",
      "status": "UNVERIFIED",
      "note": "기기 육안 검증(소리→피치 곡선) 미수행. RecordingPitchSource는 코드·analyze만 검증됨(device-bound glue)."
    },
    "advancedTrack": {
      "decision": "human:design+HITL",
      "source": "docs/curriculum/CURRICULUM-REVIEW.md (G4·G5)",
      "status": "OUT_OF_SCOPE",
      "note": "고급 트랙(G4)·periodization/디로드(G5)는 의도적 범위 밖. 신규 고위험 = 별도 안전 설계 + HITL 필요."
    }
  }
}


===== FILE: docs/verification/SAFETY-EVIDENCE-DOSSIER.md =====

# 안전 근거 도시에 (HITL 사인오프 입력 패킷)

> **무엇:** 중급 안전 카드(belt·트웽·cover·messa·런·k-keok)에 대한 *독립 리서치 2종*의
> 교차검증 결과를 발성 전문가 검토용으로 정리한 패킷.
> **무엇이 아님:** 결정·승인이 아니다. AI는 자가 승인하지 않는다(`kSafetySignoff` 빈 채 유지).
> 본 문서는 면허 전문가(이비인후과·음성 SLP·공인 보컬코치)의 직접 진단·사인오프의 *입력*일 뿐이다.
>
> **출처:** ① Claude 심층 리서치, ② GPT 웹 Pro 확장 — 둘 다 2026-06 수행. **둘 다 면허
> 임상의가 아님**(각 산출물에서 명시). 사인오프 절차는 [HITL-SIGNOFF.md](../curriculum/HITL-SIGNOFF.md).

## 근거 재확인 표기 규칙
- **✅재확인(웹 2026-06)** — 본 에이전트가 웹으로 핵심 주장을 교차확인한 출처.
- **○리서치 제공(미재확인)** — 두 리서치가 제시한 출처를 *귀속만* 하고 독립 재확인하지 않음.
- 페이월/초록만 = PARTIAL. 환각 출처 0(없는 논문 인용 안 함).

---

## TL;DR (3줄)

1. **8개 카드 중 5개(트웽·패사지오·cover 진입·messa 기초·런)는 조건부 사인오프 가능, belt
   진입·belt 레퍼토리는 조건부·일반공개 보류, k-keok은 영구 제외 유지** — 두 리서치가 *독립적으로 수렴*(하드 모순 0).
2. **가장 중요한 공통 발견:** 정량적 "안전 vocal dose"는 문헌에 부재(✅재확인 Zuim·Stewart·Titze
   2023). 모든 수치는 임상 검증값이 아니라 **보수적 제품 임계값**.
3. **현 앱은 텍스트 cue만으로는 사인오프 불가** — 둘 다 *하드 캡 + 객관적 자가 모니터링(swelling
   check) + 다중 stop 신호*를 강제 조건으로 요구. → 사인오프 = 전문가 Yes **+** 강제 캡 구현.

---

## 1. 기법 × 도구 교차검증 매트릭스 (8카드)

| # | 카드 | GPT 웹Pro | Claude 심층 | 합의 | 공통 필수 조건 |
|---|---|---|---|---|---|
| 1 | IM-02/GY-04 트웽 | 조건부 Yes | Sign-off | ✅ **가능(조건부)** | 짧게·고음 sustained 금지·압착 오해 방지 |
| 2 | IM-03 패사지오 | 조건부 Yes | Sign-off | ✅ **가능(조건부)** | break=실패 아님·반복 break loop 금지·하행 우선 |
| 3 | IM-05/GY-05 belt 진입 | 조건부·일반공개 보류 | Conditional | ✅ **조건부(공개 보류)** | 음역 상한·횟수/주간 캡·swelling check·성인 beta |
| 4 | IM-12/GY-09 레퍼토리 | 조건부/보류 | Conditional | ✅ **조건부** | 음역 곡 게이트·belt 비중 상한·풀벨트 미출시 |
| 5 | CL-01 cover 진입 | 조건부 Yes | Sign-off | ✅ **가능(조건부)** | 2차 패사지오 직상방 상한·풀 cover 미출시·과압 cue |
| 6 | CL-08 messa 기초 | 조건부 Yes | Sign-off | ✅ **가능(조건부)** | 중음·저강도 한정·고음 풀 messa 금지 |
| 7 | GY-06 런 | 조건부 Yes | Conditional | ✅ **가능(조건부)** | 중음 한정·정확도 게이트·고음역 런 잠금 |
| 8 | k-keok 강한 성문어택 | No | Hold(영구제외) | ✅ **영구 제외 유지** | 무감독 도입 경로 없음 |

**불일치: 하드 모순 없음.** 라벨 차이(Claude "Sign-off" vs GPT "조건부 Yes")는 둘 다 *"캡을
강제하면 가능"* 이라는 같은 의미. 유일한 강조 차이는 belt: GPT가 "일반 공개는 beta 전까지
보류"를 더 명시(Claude도 Conditional이라 방향 동일).

### belt 음역 상한 — 두 각도, 모순 아님
- **Claude:** 생리적 belt 한계 **여 C5(523Hz)/남 A4(440Hz)** — 이 위는 belt 역학 불가
  (R1→2f0 동조 한계). ✅재확인: Bourne & Garnier 2012가 belt에서 R1을 2f0에 **C5까지** 동조한다고 보고.
- **GPT:** 보수적 *진입* 캡(트랙별 초기 C4~G4) — Claude의 생리 한계보다 훨씬 아래.
- **종합:** 진입은 생리 한계보다 한참 낮게, 절대 상한은 C5/A4 아래. ⚠️ **남 A4는 단일·약한
  근거**(Claude 산출물 자체가 "consensus 값, 단일 1차 verbatim 미검증"으로 표기) → 전문가 확정 필요.

---

## 2. 두 모델이 독립적으로 수렴한 공통 결론 (고신뢰)

1. **정량적 "안전 dose" 부재.** ✅재확인 — Zuim, Stewart & Titze 2023(*J Voice*, PMID 37951817)
   결론부: *"Researchers have yet to establish a safe baseline vocal dose for singers."*
   → 제시된 횟수·주당·지속 수치는 전부 **보수적 추정**(임상 검증 아님).
2. **텍스트 stop-cue("통증 시 중단")만으로는 불충분.** 초기 부종은 무통일 수 있음. 둘 다
   **다중 신호(다음날 쉰목·고음역 축소·작은 고음 faltering) + 객관적 자가 모니터링** 권고.
   Claude는 ○Bastian 1990 **swelling check**(아주 작은 고음 staccato faltering으로 점막 부종
   조기탐지)를 피치 곡선으로 구현하라 제안.
3. **피치 곡선 ≠ 부하 센서.** belt/shout/pressed yell을 구분 못 함 → 강도·압착 무신호. 둘 다 최대 한계로 지목.
4. **belt + belt 레퍼토리가 최고 위험.** 일반 공개 사인오프 불가에 가깝고, 성인 opt-in beta·하드캡·
   AE 모니터링·kill switch 선행 필요. 곡 맥락(감정 몰입)에서 노출량 초과·stop 무시 위험 가중.
5. **k-keok 영구 제외 정당.** ✅재확인 — Andrade 외 2000(*J Voice*, S0892-1997(00)80032-6):
   hard glottal attack 빈도가 MTD·편측/양측 양성병변군에서 건강 대조군보다 높음(147명).
   Claude는 *반대 논거*(편측 성대마비 보상치료의 감독 하 치료적 사용)까지 검토 후, 무감독 앱엔
   도입 경로 없음으로 제외 지지.
6. **K-pop/가요 전용 코호트 부재 → 서구 데이터 외삽.** 더 보수화 + "외삽" 명시 경고 필요.

---

## 3. 카드별 권고 임계값 요약 (보수적 추정 — 전문가 확정 대상)

> ⚠️ 아래 수치는 두 리서치의 *보수적 권고*이며 임상 검증값이 아니다. 앱에 박기 전 전문가가
> 확정해야 한다(본 도시에는 그 입력일 뿐). 피치 표기는 과학적 음높이(C4≈261Hz).

| 카드 | 음역 상한(권고) | 노출/빈도(권고) | 중단·게이트(권고) |
|---|---|---|---|
| 트웽 IM-02/GY-04 | 전이지점 +단3도 이내·고음 sustained 금지 | 단발 ≤2–3초·짧은 phrase 위주 | swelling check·압착 오해 모니터 |
| 패사지오 IM-03 | 2차 패사지오 직상방까지·push 금지 | 짧은 siren·하행 우선·약강도 | 반복 break 3회↑/다음날 쉰목→중단 |
| belt IM-05/GY-05 | 진입 캡(트랙별 C4~G4 초기)·절대상한 여C5/남A4 아래 | call ≤1–2초·세션 제한·주 2–3회·세션간 24–48h | swelling check 게이트·다중 stop·성인 beta |
| 레퍼토리 IM-12/GY-09 | belt음이 IM-05 캡 이내인 곡만 | belt phrase 비중 상한(소수)·주 1회↓ | 음역 기반 곡 난이도 잠금·풀벨트 곡 제외 |
| cover CL-01 | 2차 패사지오 직상방까지·풀 cover 미출시 | 짧은 slide·고음 체류 최소 | "누르면 즉시 낮추기"·swelling check |
| messa CL-08 | 편안 중음 1음·패사지오 근처/위 금지 | 약→조금강→약·다이내믹 폭 제한·짧게 | pitch drift 반복 시 하향·고음 풀 messa 금지 |
| 런 GY-06 | 중음 한정·고음역 런 잠금 | 느린 속도 우선 | 정확도 게이트(미달 시 속도단계 잠금) |
| k-keok | — | **0회(영구 제외)** | 데모/예시 코퍼스에서도 강한 onset 제거 |

(수치 상세·근거는 §6 출처표 및 원 리서치 산출물 참조.)

---

## 4. 📄 전문가 검토용 1페이지 요약

```
[Vocal_Athlete 중급 안전카드 — HITL 사인오프 검토 요약]
독립 리서치 2종(Claude 심층 / GPT 웹Pro, 2026-06) 교차검증. 하드 모순 0건, 강한 수렴.
※ 둘 다 면허 임상의 아님 — 본 요약은 전문가 결정의 입력일 뿐, 사인오프 대체 ❌.

■ 합의 판정
 · 영구 제외 유지: k-keok(강한 성문 어택) — 결절/육아종/MTD 연관, 무감독 도입 경로 없음
 · 조건부 가능(캡 강제 시): 트웽, 패사지오, cover 진입, messa 기초, 런
 · 조건부·일반공개 보류: belt 진입, belt 레퍼토리 — 성인 beta + 하드캡 선행

■ 결정적 공통 경고 (전문가 판단 요청)
 1) 안전 dose 임계값은 문헌 부재 → 제시 수치는 보수적 추정. 동의/조정?
 2) 현 앱은 텍스트 cue만 + 부하 미감지 + 피치곡선=강도 무판정.
    → "캡 코드 강제 + swelling check + 다중 stop"이 사인오프의 전제조건인가?
 3) belt 절대 상한 여 C5 / 남 A4 — 동의? (남 A4는 단일 1차근거 약함, 검증 필요)
 4) belt 주간 누적 캡(주 2–3회·세션간 24–48h 회복) 필요 여부·수치?
 5) K-pop/가요 belt·트웽 서구 외삽 — 더 보수화 / 경고 강화 동의?

■ 전문가가 직접 봐야 할 잔여(리서치가 못 푸는 것)
 데모 오디오 실제 발성 품질 · 한국어 cue 오해율 · 음역 캘리브레이션 품질 ·
 미성년 적용 · 기존 음성질환 self-exclusion 문구 · AE 판정 기준 ·
 관할권별 의료기기/웰니스/광고/개인정보 규제 분류

■ 사인오프: 카드별 ✅승인 / ✏️수정요청 / ❌보류 + 코멘트(검토자·일자·근거)
  → HITL-SIGNOFF.md 결정칸에 기입. 승인+강제캡 구현 후에만 kSafetySignoff 기입.
```

---

## 5. 사인오프 선결조건 (둘 다 강제 요구)

belt/cover/messa/런을 켜려면 **전문가 Yes 단독으로 부족**. 둘 다 다음을 *앱이 강제*하는 것을 전제로 함:

1. **하드 캡** — 음역 상한·세션당 횟수·1회 지속·주간 빈도·주간 누적을 코드가 강제(텍스트 안내 ❌).
2. **swelling check 게이트** — 고부하 카드 진입 전 "아주 작은 고음" 과제(피치 곡선)로 점막 부종
   조기 탐지, 평소보다 낮아지면 그날 고부하 잠금.
3. **다중 stop 신호** — 통증 + 다음날 쉰목 + 고음역 축소 + 작은 고음 faltering 중 하나라도 → 중단·회복.
4. **회복일 강제** — belt/고음 세션 간 24–48h, 반복 AE 사용자 30일 고부하 잠금.

> ⚠️ 위 캡의 *구체 수치 확정*과 *구현*은 전문가 사인오프 후의 별도 개발 슬라이스다(자가 수치확정 ❌).
> 현재 앱이 이를 강제하지 못하므로, **`kSafetySignoff`를 비워 카드를 잠근 현 상태가 정확히 옳은
> 기본값**이다. 백로그: [D4 강제캡/swelling check 이슈](backlog-safety-enforcement.md).

---

## 6. 근거·출처 표 (귀속 + 재확인 표기)

| 출처 | 주장 | 재확인 |
|---|---|---|
| Bourne & Garnier 2012, *JASA* 131(2):1586–1594, DOI 10.1121/1.3675010 | belt에서 R1을 2f0에 **C5까지** 동조; belt는 legit보다 고SPL·고closed quotient | ✅재확인(웹) |
| Zuim, Stewart & Titze 2023, *J Voice*, PMID 37951817 | **"안전 baseline vocal dose 미확립"**(가수) | ✅재확인(웹) |
| Andrade 외 2000, *J Voice*, S0892-1997(00)80032-6 | hard glottal attack 빈도가 MTD·양성병변군>건강대조군(147명) | ✅재확인(웹) |
| Bourne, Garnier & Samson 2016, *JASA*, DOI 10.1121/1.4954751 | 남성 belt도 legit과 EGG contact quotient·SPL 등에서 상이 | ○리서치 제공 |
| Echternach 외 2017, *PLOS ONE*, DOI 10.1371/journal.pone.0175865 | 전문 소프라노도 passaggio에서 불안정 transition | ○리서치 제공 |
| Roubeau 외 2009, *J Voice*, DOI 10.1016/j.jvoice.2007.10.014 | laryngeal vibratory mechanism·register 전환 생리 | ○리서치 제공 |
| Yanagisawa 외 1989, *J Voice*, DOI 10.1016/S0892-1997(89)80057-8 | twang·belt에서 AES narrowing 관찰 | ○리서치 제공 |
| Jelinger 외 2024, *J Voice*, DOI 10.1016/j.jvoice.2024.06.014 | MRI: twang 시 oropharyngeal/AES narrowing | ○리서치 제공(PARTIAL) |
| Hunter & Titze 2009, *Ann Otol Rhinol Laryngol*, DOI 10.1177/000348940911800608 | 2h 부하 후 단기 피로 90% 회복 4–6h·완전 12–18h | ○리서치 제공 |
| Titze, Švec & Popolo 2003, *JSLHR*, DOI 10.1044/1092-4388(2003/072) | vocal dose(distance) 개념·산업 외삽 | ○리서치 제공 |
| Kirsch 외 2025, *PLOS ONE*, DOI 10.1371/journal.pone.0314457 | untrained도 B2/B3 중음 messa 수행 가능 | ○리서치 제공 |
| Köberlein 외 2025, *PLOS ONE*, DOI 10.1371/journal.pone.0325284 | messa di voce는 안정 pitch에서 SPL 조절 난과제 | ○리서치 제공 |
| Echternach, Traser & Richter 2014, *J Voice*, DOI 10.1016/j.jvoice.2013.10.009 | 테너 passaggio vowel별 성도 형상(rt-MRI) | ○리서치 제공 |
| Bastian, Keidar & Verdolini-Marston 1990, *J Voice* 4(2):172–183 | "swelling check"로 점막 부종 조기 탐지 | ○리서치 제공 |
| Ruotsalainen 외, *Cochrane* 2007/2010, CD006372 | 음성위생/훈련 단독의 예방 효능 근거 약함 | ○리서치 제공 |
| Pestana 외 2017, *J Voice*, PMID 28342677 | 가수 자가보고 dysphonia 유병률 ~46% | ○리서치 제공 |
| Jiang & Titze 1994, *J Voice* 8:132–144 | 강도·성문하압·내전↑ → 충돌/충격 응력↑ | ○리서치 제공 |

> 그 외 출처(DeJonckere&Lebacq 2022, Ibarra 2021, Garnier 2010, Neumann 2005, McDonnell 2011,
> Welch 1989, Noson 2002, Stepp 2011, Lin 1991, Ranjbar 2023 등)는 원 리서치 산출물에 귀속돼
> 있으며 본 도시에에서 독립 재확인하지 않았다(○리서치 제공). 규제 출처(FDA general wellness,
> FTC health claims/COPPA, IMDRF SaMD, 한국 식약처 웰니스 기준, Google SRE canary)는 GPT 산출물
> PART 2에 귀속.

---

## 7. 한계 (정직 고지)

1. **두 리서치 모두 면허 임상의가 아님.** 본 도시에는 전문가 결정의 입력이며 의학적 책임을 지지 않음.
2. **가장 결정적 한계: belt·노래의 안전 dose 정량 임계값이 문헌에 사실상 부재**(✅재확인). 모든
   횟수·주당·지속 수치는 보수적 추정.
3. **무선별 일반인(layperson) belt·트웽 직접 안전 연구 전무.** 거의 모든 belt 연구가 숙련자/학생 표본.
4. **K-pop/가요 전용 코호트 부재** — 서구 데이터 외삽, 언어·스타일 차이 미검증.
5. **남성 belt A4 상한은 단일·약한 근거**(consensus 값) — 전문가 검증 필요.
6. hard glottal attack–병변 근거는 대부분 단면·후향(인과 longitudinal 제한) — 단 보수적 제외엔 충분.
7. **○리서치 제공 출처는 본 에이전트가 독립 재확인하지 않았다.** ✅ 3건(belt 상한·dose 부재·HGA)만
   웹 교차확인. 일부 원문 페이월(PARTIAL).
8. 본 도시에는 *보컬 안전*에 한정. 청력·자세·호흡기·심리 등은 다루지 않음.

---

## 8. 사인오프 후 반영 절차 (사람)
전문가가 카드별로 ✅승인하고 **강제 캡이 구현된 뒤에만**: ① `kSafetySignoff`에 검토자·일자·근거
기입 → ② `verification-status.json` 동기화 → ③ `flutter test`(W5) 정합 확인 → 커밋. (자가 승인 ❌)
세부: [VERIFICATION-STATUS.md](VERIFICATION-STATUS.md) §갱신 규칙.


===== FILE: docs/verification/backlog-safety-enforcement.md =====

# 백로그 — 안전 게이트 강제 구현 (belt/cover/messa/런 출시 선결조건)

> **상태:** 미착수(BACKLOG). **이슈:** [#1](https://github.com/minseo2222/Vocal_Athlete/issues/1).
> **선후관계:** 전문가 HITL 사인오프(임계 수치 확정) → 본 구현 → 출시.
> **왜:** 독립 리서치 2종([도시에](SAFETY-EVIDENCE-DOSSIER.md))이 *둘 다* "텍스트 cue만으로는
> 사인오프 불가, 캡을 앱이 강제해야 한다"를 결론. 현재 앱은 cue 텍스트만 있고 강제 캡이 없으므로,
> `kSafetySignoff`를 비워 카드를 잠근 현 상태가 옳은 기본값. 본 항목 구현 전엔 belt/cover/messa/런 출시 불가.
>
> ⚠️ **수치 미확정:** 아래 수치는 리서치의 *보수적 추정*이며 임상 검증값이 아니다(안전 dose 문헌
> 부재, ✅Zuim 2023). **전문가가 사인오프에서 확정한 값으로 대체**해야 한다 — AI 자가 수치확정 ❌.

## 구현 항목

### 1. 하드 캡 (코드 강제, 텍스트 안내 ❌)
- 카드별 **음역 상한**(개인 음역 캘리브레이션 기준), **세션당 횟수**, **1회 지속시간**,
  **주간 빈도**, **주간 누적**을 앱이 강제(초과 시 진행 차단/하향).
- belt 절대 상한: 여 C5 / 남 A4 *아래*(✅Bourne&Garnier 2012; 남 A4 단일근거 약함 → 전문가 확정).

### 2. swelling check 게이트 (객관적 자가 모니터링)
- 고부하 카드 진입 전 "아주 작은 고음" 과제를 *기존 피치 곡선*으로 수행 → 평소 mucosal
  ceiling보다 낮아지면 그날 고부하 카드 자동 잠금(○Bastian 1990).

### 3. 다중 stop 신호
- "통증" 단독(초기 부종은 무통일 수 있음) → **통증 / 다음날 쉰목 / 고음역 축소 / 작은 고음
  faltering** 중 하나라도 → 중단·회복. 카드 cue 텍스트도 이에 맞춰 갱신(전문가 확정 후).

### 4. 회복일 강제
- belt/고음 세션 간 24–48h 회복(권고치), 반복 AE 사용자 30일 고부하 잠금.

### 5. 음역 캘리브레이션
- 20–30초 비의학적 range calibration("편한 중음"·"첫 전이/불편 지점") → 모든 음역 상한을
  성별이 아닌 *실제 편한 음역* 기준으로. 캘리브레이션 없으면 고부하는 최저 트랙 기준만 공개.

### 6. (롤아웃) AE 텔레메트리 + kill switch
- 카드/장르/연령군별 completion·stop·pain·다음날 쉰목·cap-hit 수집 + 즉시 끌 kill switch
  (GPT 산출물 PART 2 거버넌스). canary 단계 출시.

## 수용 기준 (구현 완료 정의)
- 위 1–5가 코드로 강제되고 테스트로 검증(예: 상한 초과 차단, swelling-check 잠금, 다중 stop 잠금).
- 전문가가 확정한 수치가 반영됨(본 문서의 추정치가 아니라).
- 이후에만 `kSafetySignoff` 기입 → `verification-status.json` 동기화 → W5 정합 → 출시 검토.

## 참조
- 근거·합의: [SAFETY-EVIDENCE-DOSSIER.md](SAFETY-EVIDENCE-DOSSIER.md)
- 사인오프 절차: [HITL-SIGNOFF.md](../curriculum/HITL-SIGNOFF.md)
- 상태 단일 소스: [verification-status.json](verification-status.json)


===== FILE: docs/verification/DEVICE-MIC-VERIFICATION.md =====

# 기기 마이크 검증 — 자족·재현 체크리스트 (W3)

> 목적: 실 마이크 → 시각 피치 곡선이 기기에서 동작함을 *대화 맥락 없이* 누구나
> 동일하게 재현·기록할 수 있게 한다. `RecordingPitchSource`는 device-bound glue라
> 단위 테스트 대상이 아니므로(코드 주석 명시), 이 육안 검증이 유일한 확인 경로다.
>
> 이 문서만 읽고 그대로 따라 하면 된다. 사전 지식·이전 세션 불요.
> 결과는 아래 §4 템플릿을 복사해 `device-results.md`에 append 한다(git 영속).

---

## 0. 전제 (한 번만)

| 항목 | 값 / 확인법 |
|---|---|
| Flutter | `C:/src/flutter/bin/flutter.bat --version` (3.44+) |
| 기기 | Android 에뮬레이터(`emulator-5554`) 또는 실 기기 USB 디버깅 |
| 기기 목록 | `C:/src/flutter/bin/flutter.bat devices` 에 대상이 보일 것 |
| 작업 폴더 | `C:\Users\user\Desktop\pro v new\app` |
| 마이크 | 에뮬레이터: 확장 컨트롤(…) → Microphone → "Virtual microphone uses host audio input" ON. 실 기기: 권한 허용. |

> ⚠️ 에뮬레이터 가상 마이크가 호스트 입력을 쓰도록 켜져 있어야 곡선이 움직인다.
> 호스트 마이크가 음소거면 곡선이 안 움직여 *기기 결함이 아님* → 입력부터 확인.

---

## 1. 빌드 & 실행

```
cd "C:\Users\user\Desktop\pro v new\app"
C:/src/flutter/bin/flutter.bat run -d emulator-5554
```

- 빌드 해시 기록용: `git rev-parse --short HEAD` 를 실행 직전에 찍어 둔다.
- `flutter run` 콘솔에 "Syncing files to device…" 후 앱 화면이 떠야 한다.

---

## 2. 단계별 절차 + 기대 관측

각 단계의 *기대 관측*을 실제로 눈으로 확인하고 §4에 pass/fail 기록.

| # | 조작 | 기대 관측 |
|---|---|---|
| S1 | 앱 실행 | **실행 경고 화면**(LaunchWarning) 표시. 확인 버튼 존재. |
| S2 | 확인 버튼 탭 | (최초 실행) **OS 마이크 권한 다이얼로그** 표시. |
| S3 | 권한 **허용** | 홈 화면 표시(오늘 카드/스트릭/시작 버튼). |
| S4 | "오늘 시작" 탭 | **레슨 화면**(`lesson-screen`) 진입. |
| S5 | 본 운동(main) 단계까지 진행 | **피치 디스플레이**(`pitch-display`) + 가로 **파란 타깃선**(`pitch-target`) 표시. |
| S6 | 220Hz 부근(약 A3) 지속음 허밍 | **초록 점**(`pitch-current`)이 나타나 음높이에 따라 **상하로 이동**. (높으면 위, 낮으면 아래) |
| S7 | 타깃보다 일관되게 높/낮게 지속 | (편차 충분 시) **"⤴ 좀 더 높게 — 다시?" / "⤵ 좀 더 낮게 — 다시?"** 넛지(`retry-nudge`) 노출 가능. |
| S8 | 발성 멈춤(무음) | 초록 점 **사라짐**(무성/저신뢰 → 표시 없음). |

### 2b. 권한 거부 경로(별도 1회)

| # | 조작 | 기대 관측 |
|---|---|---|
| D1 | 앱 재설치 후 S2에서 권한 **거부** | 레슨 본 단계에 **"마이크 꺼짐 — 피치 표시 안 됨"** 문구, 초록 점 영영 안 뜸. 크래시 없음. |

---

## 3. 합격 기준

- **PASS** = S1~S8 전부 기대대로 + D1(거부 경로) 정상. 특히 **S6(소리에 반응해 점이 상하 이동)**가 핵심.
- **FAIL** = 어느 단계든 기대와 다름(점이 안 뜸/안 움직임/크래시/문구 누락 등).
- **BLOCKED** = 빌드 실패·기기 없음·마이크 입력 자체 부재 등 검증 불가.

> 정직 원칙: 한 단계라도 미확인이면 전체를 PASS로 적지 않는다. 미수행/불가는
> 그대로 UNVERIFIED/BLOCKED로 기록한다(통과 위장 ❌).

---

## 4. 결과 기록 템플릿 (복사 → `device-results.md`에 append)

```
### 검증 런 — <YYYY-MM-DD>
- 커밋(빌드): <git short hash>
- 기기: <emulator-5554 / 모델명·OS>
- 관측자: <이름>
- 종합: <PASS | FAIL | BLOCKED | UNVERIFIED>
- 단계별:
  - S1 경고화면: <pass/fail/-> 
  - S2 권한요청: <pass/fail/->
  - S3 허용→홈: <pass/fail/->
  - S4 레슨진입: <pass/fail/->
  - S5 피치UI/타깃선: <pass/fail/->
  - S6 소리→점 상하이동(핵심): <pass/fail/->
  - S7 넛지: <pass/fail/n-a>
  - S8 무음→점 사라짐: <pass/fail/->
  - D1 권한거부 경로: <pass/fail/->
- 비고: <관측 메모, 입력장치 상태 등>
```

> 기록 후 `verification-status.json`의 `device.status`를 동일 결과로 갱신하고
> (W4 단일 소스 동기화), 커밋·푸시한다. W5 하네스가 두 산출물의 정합을 강제한다.


===== FILE: docs/verification/device-results.md =====

# 기기 마이크 검증 — 결과 로그 (W3)

> `DEVICE-MIC-VERIFICATION.md` §4 템플릿으로 런마다 항목을 append.
> 최신 종합 결과를 `verification-status.json`의 `device.status`와 일치시킬 것.

## 현재 상태: UNVERIFIED (미수행)

아직 기기 육안 검증을 수행한 사람 기록이 없다. `RecordingPitchSource`는 코드·analyze
검증만 완료(단위 테스트 대상 아님). 실 기기에서 소리→곡선 반응은 *미확인*이다.

---

<!-- 검증 런을 아래에 append (최신이 위로) -->


===== FILE: docs/verification/NEW-SESSION-REVERIFY.md =====

# 신규 세션 재검증 — 맥락 없이 1커맨드로 진실 재도출 (V)

> 이 대화·이 세션을 전혀 모르는 사람(또는 새 AI 세션)이, 인간 게이트 항목의 현재
> 진실을 *정확히* 재확인하는 절차. 필요한 건 git 체크아웃 + 아래 두 가지뿐이다.

## 30초 요약

```
cd "C:\Users\user\Desktop\pro v new\app"
C:/src/flutter/bin/flutter.bat test test/verification_harness_test.dart
```

- **PASS** = 단일 소스([`verification-status.json`](verification-status.json))가 라이브
  코드와 정합. 그 JSON/[요약표](VERIFICATION-STATUS.md)를 *그대로 신뢰*하면 된다.
- **FAIL** = 누군가 코드나 JSON 한쪽만 바꿔 드리프트 발생. JSON을 믿지 말고 실패
  메시지가 가리키는 불일치를 사람이 해소해야 한다.

이게 세션 독립의 핵심이다: 진실은 대화 기억이 아니라 *체크인된 산출물 + 통과하는 테스트*다.

## 무엇이 어디서 결정되는가 (진실의 위치)

| 항목 | 진실의 단일 소스(git) | 기본값 | 누가 바꾸나 |
|---|---|---|---|
| 안전 사인오프 | `app/lib/safety/safety_signoff.dart` `kSafetySignoff` | 빈=전 카드 잠금 | 발성 전문가(HITL) |
| 장르 롤아웃 | `app/lib/progression/progression_state.dart` `kReleasedGenres` | 빈=전 장르 유지 | 롤아웃/안전 결정자 |
| 기기 마이크 | `docs/verification/device-results.md` | UNVERIFIED | 검증자(육안) |
| 고급/periodization | `docs/curriculum/CURRICULUM-REVIEW.md` G4·G5 | OUT_OF_SCOPE | 설계+HITL |

## 전체 재검증(권장)

```
cd "C:\Users\user\Desktop\pro v new\app"
C:/src/flutter/bin/flutter.bat test     # 159개 green = 게이트/라우팅/정합 전부 일치
C:/src/flutter/bin/flutter.bat analyze  # No issues found!
```

해당 테스트가 강제하는 불변식:
- `safety_signoff_test.dart` — 빈 레코드=전부 잠금, 유효 사인오프 1건=그 카드만 해제, 검토자명 누락=무효.
- `release_config_test.dart` — beginner/fromJson이 config를 권위로 읽음(persisted 무시).
- `verification_harness_test.dart` (W5) — JSON 단일 소스 ↔ 라이브 상수 정합(드리프트 차단).
- `card_library_test.dart` I1.2 — pending 안전 카드 플래그 고정.

## 각 항목을 "수행됨"으로 올리는 법 (사람)

[VERIFICATION-STATUS.md](VERIFICATION-STATUS.md) §갱신 규칙 참조. 요점: **코드 상수와
JSON을 함께** 갱신해야 한다. 한쪽만 바꾸면 W5가 실패시켜 거짓 통과를 막는다.

- 안전: `kSafetySignoff`에 사람 검토자+일자+근거 추가 → JSON 동기화. (AI 자가 승인 ❌)
- 롤아웃: `kReleasedGenres`에 장르 추가 → JSON 동기화. (AI 자가 롤아웃 ❌)
- 기기: [DEVICE-MIC-VERIFICATION.md](DEVICE-MIC-VERIFICATION.md) 수행 → `device-results.md`
  기록 → JSON `deviceMic.status` 갱신.

## 왜 세션이 바뀌어도 정확한가

1. 모든 결정의 진실이 **git에 박힌 파일**(코드 상수·결과 로그)이다 — 대화·메모리 0 의존.
2. **W5가 단일 소스와 코드의 정합을 강제** → 요약 문서가 코드와 어긋나면 즉시 테스트 실패.
3. 그래서 신규 세션은 *읽고 추측*하지 않고 *돌려서 확인*한다 — `flutter test` 결과가 진실.


############################################################
# Citations
############################################################


===== FILE: docs/CITATION-KEYMAP.md =====

# 인용 키 정정 매핑표 (CITATION-KEYMAP)

> CITATION-AUDIT(V1~V9)가 색출한 메타데이터 오류의 *권위 정정표*. CITATIONS.md의
> 해당 키는 ⚠️정정 인라인을 보유하며, 본 표가 *기존 키 → 정정 키/메타데이터*의
> 단일 기준이다. 키는 추적성을 위해 **삭제하지 않고** 정정 매핑만 둔다.
> 후속 인용·앱 콘텐츠 제작 시 **정정 메타데이터를 사용**할 것.

## A. 정정 확정 8건 (REFUTED/오귀속/과장)

| 기존 키 | 오류 유형 | 정정 (권위) | 영향 단위 | 안전 영향 |
|---|---|---|---|---|
| BRETL2023 | 수치 | "뮤지컬 39%" 삭제 → **1년차 유병률 MT 32–40%·CCM 17–18%·클래식 0%; 발생률 MT 67%·클래식 22%·CCM 27%** (논문·DOI lary.30533 유효) | D 뮤지컬·F 가요 | 방향 유지·**강화** |
| SIELSKA2024 | 오귀속 | "22% 결절"은 **SIELSKA2018**(J Voice, S0892199717302564, n=45 중 10명) 소관. 2024 Frontiers(PMC11133608)는 인구특성·자가평가 | F 가요 | 수치 유지, 귀속만 정정 |
| LECHIEN2021 | 저자·저널 | → **ROTSIDES2021**, *The Laryngoscope* lary.29303 (pubmed 33270237). 1저자 Rotsides, J | (역학 보조) | 방향 유지 |
| CHEN2024 | 저자 | → **ADRIAANSEN2025**, JSLHR (DOI 10.1044/2024_JSLHR-24-00243). 1저자 Adriaansen, A (Ghent) | 초급/코어 SOVT | 설계(RCT) 유지 |
| GIBIAT2024 | 저자 | → **JELINGER2024**, J Voice (pubmed 38964963). 1저자 Jelinger, J | IC-10·IM-02·GY-04 트웽 | 내용(AES 협착) 유지 |
| NAIR2023PNAS | 저자 | → **JEONG2023**, PNAS 120(11) (DOI 10.1073/pnas.2219394120). 1저자 Jeong, H | 초급 C5 | 내용 유지 |
| MANFREDI2017 | 저자·연도·**프레이밍** | → **GRILLO2016**, *Int J Telerehabilitation* 8(2):9-14 (PMC5536725). **원문은 "스마트폰 within-subject 적절"** → "마이크 한계" 프레이밍 부적합 | 초급 C5/C12·ADR-0014 | ADR-0014 근거 교체(R3) |
| DAVIES2020 | 근거 강도 과장 | "J Voice RCT" 미발견 → 실제 **SAGE 평가연구**(Janet Davies, tertiary music students, 학생/교사 pre·post 평가, n≈12). **OCEBM 1b(RCT) → 평가연구로 하향** | part16·MX·part12/13 | belt와 무관(방법 효능 앵커 약화, R4) |

## B. 키 명명 원칙 재확인 (오류 재발 방지)
- 키 = **실제 1저자 성 + 연도**. AI 생성 컴파일에서 1저자 환각이 집중됨(영어권).
- 한국 KCI 1차·정전 저작·완전 저자명단 인용은 정확했음 → 위 8건은 *single-author-year 영어권 키*에 한정.
- 후속: §A~J PARTIAL 키는 R2에서 1저자 전수 재확인.

## C. 사용 규칙
1. 위 8키를 새로 인용할 땐 **정정 키/메타데이터** 사용(예: GIBIAT2024 대신 JELINGER2024).
2. 기존 문서의 옛 키 표기는 *추적용으로 보존*하되, 본 표를 참조하도록 ⚠️정정 인라인 유지.
3. MANFREDI/DAVIES는 *내용·근거 강도*까지 바뀌므로 R3·R4에서 claim 재서술.


===== FILE: docs/CITATIONS.md =====

# CITATIONS.md — 신규 인용 키 마스터 인덱스

> ⚠️ **정정 권위표 = `docs/CITATION-KEYMAP.md`**. 메타데이터 오류 8건(저자·연도·
> 저널·수치)이 CITATION-AUDIT으로 색출됨 — 해당 키는 본문에 ⚠️정정 인라인 보유,
> 정정 메타데이터는 KEYMAP을 단일 기준으로 사용. 미개별검증 PARTIAL 키의 1저자는
> R2 전수 재확인 진행. 영어권 single-author-year 키의 1저자명은 재확인 전 신뢰 주의.
>
> `docs/research/RESEARCH_COMPILATION.md` 와 `RESEARCH_COMPILATION_2.md` 에서 docs 본문에 통합될 핵심 출처의 표준 인용 키 정의. 각 항목 형식:
>
> **[CITE: KEY]** — 저자 (연도). "제목," *저널/출판사*. URL.
> 핵심 한 줄 / OCEBM 등급 / 적용 대상 docs.
>
> KEY 명명 규칙: 단독저자 = `LASTNAMEYEAR`, 다저자·기관 = `LASTNAME또는SHORTYEAR`, 한국어 1차 출처는 `KORxxxxYEAR`.

---

## A. 종단 손상 역학 (Wave 1 핵심)

### [CITE: BRETL2023]
Bretl, M., Boyer, J., Lerner, M., Smith, B., Lobo, R., Zhang, Y., et al. (2023). "Vocal Fold Pathologies Among Undergraduate Singing Students In Three Different Genres," *The Laryngoscope* 133(7). https://onlinelibrary.wiley.com/doi/10.1002/lary.30533
*3년 종단: 클래식 1년차 0% → 3년차 22%, 뮤지컬 39%, CCM 27%. 클래식이 안전하다는 통념 정정.*
⚠️정정(CITATION-AUDIT V1): "뮤지컬 39%" 출처 미확인 — 원 출처는 *1년차 유병률* MT 32–40%·CCM 17–18%·클래식 0%, *발생률(incidence)* MT 67%·클래식 22%·CCM 27%(22·27은 발생률값으로 일치). 안전 방향(MT 최고) 유지·강화.
OCEBM: 2b (코호트). 적용: part 8, part 9, part 16.

### [CITE: CHILDS2023]
Childs, L. F., Anderson, A., Anciano, A., Vandenberg, S. (2023). "Association of Genre of Singing and Phonotraumatic Vocal Fold Lesions in Singers," *The Laryngoscope* 133(11). https://pubmed.ncbi.nlm.nih.gov/36196907/
*컨트리·복음·재즈·MT는 phonotrauma 우세, 오페라는 pseudocyst 우세.*
OCEBM: 3b (단면). 적용: part 9, part 8.

### [CITE: PESTANA2017]
Pestana, P. M., Vaz-Freitas, S., Manso, M. C. (2017). "Prevalence of Voice Disorders in Singers: Systematic Review and Meta-Analysis," *J Voice*. https://pubmed.ncbi.nlm.nih.gov/28342677/
*전체 가창자 음성장애 유병률 46.09% 통합치.*
OCEBM: 1a (메타분석). 적용: part 8, part 9.

### [CITE: SIELSKA2024]
Sielska-Badurek, E. M. et al. (2024). "Population characteristics and self-assessment of speaking and singing voice in Polish CCM singers — exploratory cross-sectional study," *Frontiers in Public Health*. https://pmc.ncbi.nlm.nih.gov/articles/PMC11133608/
*폴란드 CCM 학생의 22%가 훈련 시작 시점 결절 보유.*
⚠️정정(CITATION-AUDIT V1): "22% 결절" finding은 *Sielska-Badurek 2018, J Voice*(n=45 중 10명=22% 결절, S0892199717302564) 소관 — 본 2024 Frontiers 논문(인구특성·자가평가)에 오귀속. 키 SIELSKA2024와 별개로 SIELSKA2018(J Voice)로 재귀속해야 22% 사용 가능. 22% 수치 자체는 실재.
OCEBM: 3b. 적용: part 8, part 9, part 9-KR.

### [CITE: BEHLAU2021]
Behlau, M. et al. (2021). "Independence of Vocal Load From Vocal Pathology Across Singing Genres," *J Voice*. https://www.sciencedirect.com/science/article/abs/pii/S0892199721000084
*가창 부하 단독으로 병리 예측 불가, 테크닉·위생이 매개. "더 많이 부르면 더 다친다" 가정 도전.*
OCEBM: 3b. 적용: part 8, part 16.

### [CITE: LECHIEN2021]
Lechien, J. R. et al. (2021). "Laryngeal Pathologies Associated with the Genre of Singing and Professional Singing Status in a Treatment-Seeking Population," *J Voice*. https://pubmed.ncbi.nlm.nih.gov/33270237/
*치료 추구 코호트: 팝 63.2%, 풀타임 60.8%, 파트타임 62.2%, 아마추어 45.1%.*
⚠️정정(CITATION-AUDIT V1): **1저자 = Rotsides, J**(Lechien 아님), **저널 = The Laryngoscope**(lary.29303, "J Voice" 아님). 키→ROTSIDES2021 권장. 논문 실재(pubmed 33270237), 수치는 유료 본문 미확인(PARTIAL).
OCEBM: 3b. 적용: part 9, part 16.

### [CITE: PAWELCZYK2022]
Pawełczyk, M. et al. (2022). "Considerations and demands in the voice care of contemporary commercial singers in occupational health and safety aspects," *Med Pr*. https://pubmed.ncbi.nlm.nih.gov/35133326/
*CCM 가창을 직업보건 카테고리로 framing. 중증화 전 진료 미흡 패턴.*
OCEBM: 5 (전문가 의견). 적용: part 8.

### [CITE: TOLES2025]
Toles, L. E. et al. (2025). "Vocal Fold Kinematics in Phonotrauma From High Speed Videoendoscopy," *The Laryngoscope*. https://pubmed.ncbi.nlm.nih.gov/40709447/
*고속 비디오 내시경으로 phonotrauma 충돌 속도·폐쇄 비대칭 측정. 메커니즘 수준 증거.*
OCEBM: 4 (사례 시리즈). 적용: part 3, part 8.

### [CITE: GALINDO2023]
Galindo, G. E. et al. (2023). "Effect of nodule size and stiffness on phonation threshold and collision pressures in a synthetic hemilaryngeal model." https://pubmed.ncbi.nlm.nih.gov/36732229/
*합성 후두 모델: 결절 → 충돌압 ↑ → hyperfunction ↑ → 결절 ↑ 자기증폭 루프 정량화.*
OCEBM: 5 (모델 메커니즘). 적용: part 3, part 8, part QI.

### [CITE: NAYAK2025]
Nayak, S. et al. (2025). "Worldwide Prevalence of Voice Disorders Among Schoolteachers: Systematic Review and Meta-Analysis," *J Voice*. https://www.jvoice.org/article/S0892-1997(25)00171-7/abstract
*2025년 교사 유병률 메타분석. 기존 추정치 대체.*
OCEBM: 1a. 적용: part 8.

### [CITE: SCHWARZ2025]
Schwarz, K. et al. (2025). "Protective Factors for Vocal Health in Teachers: The Role of Singing, Voice Training, and Self-Efficacy," *Int J Environ Res Public Health* 22(7):1018. https://www.mdpi.com/1660-4601/22/7/1018
*n=124. 가창 배경·이전 보컬 훈련이 독립적 보호 요인.*
OCEBM: 3b. 적용: part 8.

### [CITE: OHLSSON2016]
Ohlsson, A.-C. et al. (2016). "Voice Disorders in Teacher Students — A Prospective Study and a Randomized Controlled Trial," *J Voice*. https://pubmed.ncbi.nlm.nih.gov/26474714/
*교사 후보생 RCT: 보컬 훈련이 발병률 유의 감소. 예방 RCT급 증거 (희귀).*
OCEBM: 1b (RCT). 적용: part 8, part 12.

### [CITE: PARK_BEHLAU2018]
Park, K. & Behlau, M. (2018). "Voice Disorders and Voice Knowledge in Choir Singers," *J Voice*. https://pubmed.ncbi.nlm.nih.gov/30104126/
*합창 단원 유병률·지식 격차. 아마추어 베이스라인.*
OCEBM: 3b. 적용: part 9.

### [CITE: DEVADAS2021A]
Devadas, U. et al. (2021). "A survey of vocal health in church choir singers," *Eur Arch Otorhinolaryngol*. https://pmc.ncbi.nlm.nih.gov/articles/PMC8266785/
*교회 합창 84%가 ≥2 음성 증상 보고.*
OCEBM: 3b. 적용: part 9.

### [CITE: DEVADAS2021B]
Devadas, U. et al. (2021). "Prevalence of Laryngopharyngeal Reflux Symptoms, Dysphonia, and Vocal Tract Discomfort in Amateur Choir Singers," *J Voice*. https://pubmed.ncbi.nlm.nih.gov/34404581/
*아마추어 합창 LPR 증상 유병률.*
OCEBM: 3b. 적용: part 8 (LPR 섹션).

### [CITE: DIETRICH2022]
Dietrich, M. & Verdolini Abbott, K. (2022). "Relationships Among Personality, Daily Speaking Voice Use, and Phonotrauma in Adult Female Singers," *J Voice*. https://pmc.ncbi.nlm.nih.gov/articles/PMC9150681/
*성격·말소리 사용량이 phonotrauma 매개. 가창자의 손상 벡터로서 말소리.*
OCEBM: 3b. 적용: part 8.

### [CITE: SALTURK2017]
Salturk, Z. et al. (2017). "Prevalence of Hearing Loss in Teachers of Singing and Voice Students," *J Voice*. https://pubmed.ncbi.nlm.nih.gov/27839986/
*보컬 교사 청력 손실 51.7%. 직업적 위험.*
OCEBM: 3b. 적용: part 8 (직업 위험).

### [CITE: GUNJAWATE2024]
Gunjawate, D. R. et al. (2024). "Vocal Health Awareness in Undergraduate Singing Students," ETSU 박사논문. https://dc.etsu.edu/cgi/viewcontent.cgi?article=4866&context=etd
*대학 가창자의 인식 갭. 커리큘럼 개입 근거.*
OCEBM: 3b (조사). 적용: part 9.

---

## B. 방법론 RCT/임상 (Wave 2 핵심)

### [CITE: MCGLASHAN2017]
McGlashan, J., Sadolin, C., Kjelin, H. (2017). "Overdrive and Edge as refiners of belting," *J Voice*. https://pubmed.ncbi.nlm.nih.gov/27876301/
*CVT 최초 동료심사 EGG·스트로보 belt 분석.*
OCEBM: 4 (사례 시리즈). 적용: part 5, part 12, part 13.

### [CITE: MCGLASHAN2023PROTO]
McGlashan, J., Sadolin, C., Kjelin, H. (2023). "A mixed-method feasibility study of the use of CVT in MTD: a study protocol," *Pilot and Feasibility Studies* 9, 87. https://pilotfeasibilitystudies.biomedcentral.com/articles/10.1186/s40814-023-01317-y
*CVT4MTD 임상시험 프로토콜.*
OCEBM: 2c (등록 시험). 적용: part 12, part MX.

### [CITE: MCGLASHAN2025]
McGlashan, J. et al. (2025). "Feasibility and Acceptability of Complete Vocal Technique-Voice Therapy as a Treatment for Primary Muscle Tension Dysphonia: A Feasibility Trial," *J Voice*. https://www.jvoice.org/article/S0892-1997(25)00308-X/fulltext
*11/11 완료, MPT 변동 없음, 다차원 측정 호전. CVT 임상 도입 첫 결과.*
OCEBM: 2c (feasibility). 적용: part 12, part 13, part MX. 태그: `[탐색적 근거]`.

### [CITE: CVT4MTD]
CVT4MTD — UK Health Research Authority registry / NCT05365126. https://www.hra.nhs.uk/planning-and-improving-research/application-summaries/research-summaries/cvt4mtd/ ; https://www.centerwatch.com/clinical-trials/listings/NCT05365126/
*CVT 등록 임상 IRB 승인 기록.*
OCEBM: 등록. 적용: part 12, part MX.

### [CITE: OUATTARA2017]
Ouattara, S. (2017). "Estill Voice Training and voice quality control in CCM: an exploratory study," *J Voice*. https://pubmed.ncbi.nlm.nih.gov/27686149/
*CCM 트레이니 EVT pre/post 탐색 연구.*
OCEBM: 4. 적용: part 12, part 13. 태그: `[탐색적 근거]`.

### [CITE: BERARDI2022]
Berardi, M. L. et al. (2022). "A Nonrandomized Trial for Student Teachers of an In-Person and Telepractice Global Voice Prevention and Therapy Model With Estill Voice Training Assessed by the VoiceEvalU8 App," *J Voice*. https://pmc.ncbi.nlm.nih.gov/articles/PMC8740681/
*비무작위, n=82. EVT 조건 유의 호전, 대면 ≈ 텔레.*
OCEBM: 2c. 적용: part 12, part 13. 태그: `[탐색적 근거]`.

### [CITE: STEINHAUER2024]
Steinhauer, K. & Klimek, M. M. (2024). "Connecting Auditory-Perceptual Prompts Used in Voice Therapy to Anatomy and Physiology: Application to the Estill Voice Model and the Rehabilitation Treatment Specification System," *Am J Speech Lang Pathol*. https://pubmed.ncbi.nlm.nih.gov/39043532/
*EVT figure를 RTSS 임상 분류에 매핑. EVT 비임상 비판에 대한 응답.*
OCEBM: 5 (이론·매핑). 적용: part 12, part 13, part 14.

### [CITE: PERCEIVE2025]
"Perceiving physiology from the voice: evidence for physiological coupling between laryngeal and epilaryngeal adjustments" (2025). https://pmc.ncbi.nlm.nih.gov/articles/PMC12879547/
*Estill 'figure 분리' 명제에 대한 부분 도전 — coupling 관찰.*
OCEBM: 3b. 적용: part 12, part 14.

### [CITE: MCCLELLAN2011]
McClellan, J. W. (2011). "A Comparative Analysis of Speech Level Singing and Traditional Vocal Training in the United States," 멤피스대 박사논문. https://digitalcommons.memphis.edu/etd/376/
*SLS 학술 비판: n=7 이중 훈련자 정성 분석.*
OCEBM: 4. 적용: part 12, part 13. 태그: `[Phase III RCT 부재]`.

### [CITE: WICKS2019]
Wicks, D. (2019). "Seth Riggs — His CCM Legacy," *Journal of Singing* 75(4):449. https://www.nats.org/_Library/JOS_On_Point/JOS-075-4-2019-449_-_Seth_Riggs_-_His_CCM_Legacy_-_Darren_Wicks.pdf
*NATS 발간 SLS 역사·비판: "cords zip up" 등 비과학적 명제 식별.*
OCEBM: 5. 적용: part 12, part 13. 태그: `[Phase III RCT 부재]`.

### [CITE: BARTLETT2020]
Bartlett, I. & Naismith, M. (2020). "An Investigation of Contemporary Commercial Music (CCM) Voice Pedagogy: A Class of its Own?" *Journal of Singing* 76(3):273-282. https://www.nats.org/_Library/JOS_On_Point/JOS-076-3-2020-273_-_Bartlett-Naismith_-_An_Investigatin_of_CCM.pdf
*7명 CCM 페다고그 인터뷰: 누구도 단일 브랜드와 동일시하지 않음. 브랜드 인증 이데올로기에 대한 직접 비판.*
OCEBM: 4 (질적). 적용: part 12, part 13, part 14, part 16.

### [CITE: NAISMITH2022]
Naismith, M. L. (2022). "Modern vocal pedagogy: Investigating a potential curricular framework for training popular music singing teachers," *J Popular Music Educ*. https://intellectdiscover.com/content/journals/10.1386/jpme_00105_1
*브랜드 페다고지 대안: action-research 커리큘럼 프레임.*
OCEBM: 5. 적용: part 12.

### [CITE: VALA2021]
Vala, B. (2021). "Mixed Voice for the Bel Canto and Musical Theatre Singer," UNT 박사논문. https://digital.library.unt.edu/ark:/67531/metadc1833442/m2/1/high_res_d/VALA-DISSERTATION-2021.pdf
*벨칸토 vs MT mix 비교 박사논문.*
⚠️정정(R2a): 1저자 **Matthew Vala**(B.→M.). 제목 "Training the Hybrid Singer: Mixed Voice…". UNT DMA 2021 실재.
OCEBM: 4. 적용: part 5, part 12.

### [CITE: SELAMTZIS2019]
Selamtzis, A. (2019). "Acoustic and EGG analyses of CVT vocal modes," KTH 박사논문. https://www.diva-portal.org/smash/get/diva2:1366879/FULLTEXT01.pdf
*KTH 박사논문, CVT EGG/음향 모드 실증 평가.*
⚠️정정(R2a·UNVERIFIABLE): 2019 KTH 학위논문(diva2:1366879) 미확인. 확인되는 건 *Selamtzis & Ternström ~2014 "Acoustical characteristics of vocal modes in singing"* — 연도·유형 의심. 사용 전 재확인 필요(믹스/CVT 보조, 안전 무관).
OCEBM: 4. 적용: part 5, part 13, part MX.

### [CITE: ANDRADE2024]
Andrade, P. A. et al. (2024). "Comparative Study of Two SOVT Protocols (RCT)," *JSLHR*. https://pubs.asha.org/doi/10.1044/2024_JSLHR-22-00456
*RCT급 SOVT 프로토콜 비교.*
OCEBM: 1b. 적용: part 3.

### [CITE: CHEN2024]
Chen, T. et al. (2024). "Short-Term Effects of Semi-Occluded Vocal Tract Therapy on the Phonation of Children With Vocal Fold Nodules: An RCT," *JSLHR*. https://pubs.asha.org/doi/10.1044/2024_JSLHR-24-00243
*아동 결절 SOVT 단기 효과 RCT.*
⚠️정정(CITATION-AUDIT V1): **1저자 = Adriaansen, A**(Ghent), "Chen" 아님. epub 2025-01(2024년분). 키→ADRIAANSEN2025 권장. 논문·설계(RCT) 실재(DOI 10.1044/2024_JSLHR-24-00243).
OCEBM: 1b. 적용: part 3, part 16 (변성기 갭).

### [CITE: DAVIES2020]
Davies, J. (2020). "Alexander Technique classes improve vocal training: a randomised study with university students," *J Voice*.
*가창자 대상 알렉산더 테크닉 RCT — 단일 브랜드 방법론 중 RCT 보유한 희귀 사례.*
⚠️정정(CITATION-AUDIT V1·SUSPECT): "J Voice RCT 'AT classes improve vocal training'" *해당 제목·저널 논문 미발견*. 실제 Davies 2020 = SAGE(Int J Music Educ 추정) "AT classes for tertiary music students: student/teacher evaluations of pre/post recordings"(n=12 평가연구)로 보임. **OCEBM 1b(RCT) 주장 과장 의심 → 평가연구로 하향**. "단일브랜드 RCT 앵커" 약화 — part 16/MX Evidence Ladder 재검토 필요.
OCEBM: ~~1b~~ → **평가연구(R4 하향, RCT 아님)**. 적용: part 2, part 5, part 12, part MX(전부 R4 정정 반영). 1저자 Janet Davies(Jennifer 오기).

---

## C. 공명·믹스·트웽 (Wave 1 보조)

### [CITE: GIBIAT2024]
Gibiat, V. et al. (2024). "Oropharyngeal and Aryepiglottic Narrowing for Twang: An MRI Study," *J Voice*. https://www.jvoice.org/article/S0892-1997(24)00192-9/abstract
*트웽의 인두·후두덮개 협착 MRI 영상 증거.*
⚠️정정(CITATION-AUDIT V2): **1저자 = Jelinger, J**(Gibiat 아님). 키→JELINGER2024. 논문·내용(구강·AES 협착 18.8–52.4%) 실재·확정.
OCEBM: 4 (영상 사례). 적용: part 4, part 5, part 14.

### [CITE: CHAN_DO2021]
Chan, M. P. Y. & Do, Y. (2021). "Vowel Modification (Aggiustamento) in Soprano Voices," *Music & Science*. https://doi.org/10.1177/20592043211055168
*소프라노 aggiustamento 실증 연구.*
OCEBM: 3b. 적용: part 4.

### [CITE: LEHOUX2024]
Lehoux, H. & Henrich Bernardoni, N. (2024). "Voice efficiency for different voice qualities," *Front Physiol*. https://www.frontiersin.org/journals/physiology/articles/10.3389/fphys.2022.1081622/full
*음질별 발성 효율 비교.*
OCEBM: 3b. 적용: part 5.

### [CITE: SAUNDERS2018]
Saunders Barton, M. & Spivey, N. (2018). *Cross-Training in the Voice Studio: A Balancing Act*. Plural.
*Penn State 표준 CCM/클래식 cross-training 교재.*
OCEBM: 5 (교재). 적용: part 5, part 12, part 13.

---

## D. 자기모니터링·웨어러블·AI (Wave 3 핵심)

### [CITE: NAIR2023PNAS]
Nair, R. et al. (2023). "Closed-loop network of skin-interfaced wireless devices for quantifying vocal fatigue and providing user feedback," *PNAS* 120(11). https://www.pnas.org/doi/10.1073/pnas.2219394120
*Northwestern 웨어러블 음성 도시미터, closed-loop 피드백. PNAS 등재.*
⚠️정정(CITATION-AUDIT V2): **1저자 = Jeong, H**(Nair 아님). 키→JEONG2023. 논문·내용 실재.
OCEBM: 5 (장치 검증). 적용: part 7, part 8, part 11, part QI.

### [CITE: ROSEN2022DOSI]
Rosen, R. et al. (2022). "Introducing a New Dosimeter for the Assessment and Monitoring of Vocal Risk Situations and Voice Disorders," *J Voice*. https://www.sciencedirect.com/science/article/pii/S0892199722002399
*신규 음성 도시미터 도입.*
OCEBM: 4. 적용: part 7, part QI.

### [CITE: CNN2025DAI]
"Application of convolutional neural network in the evaluation of singing teaching effect," *Discover Artificial Intelligence* (2025). https://link.springer.com/article/10.1007/s44163-025-00549-6
*CNN 기반 가창 교육 평가, 강의실 배포 평가.*
OCEBM: 3b. 적용: part 11.

### [CITE: TANG2025]
Tang, Y. et al. (2025). "Exploring the impact of AI-assisted practice applications on music learners' performance, self-efficacy, and self-regulated learning," *Frontiers in Psychology*. https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2025.1675762/full
*AI 앱이 학습자 자기효능감·수행에 미치는 영향. 준실험.*
OCEBM: 2c. 적용: part 11.

### [CITE: PSAMOS2024]
"Pitch-and-Spectrum-Aware Singing Quality Assessment with Bias Correction and Model Fusion," arXiv 2411.11123 (2024). https://arxiv.org/html/2411.11123
*VoiceMOS 2024 Track 2 SOTA 가창 MOS 예측.*
OCEBM: 5 (벤치). 적용: part 11.

### [CITE: VOQANET2025]
"Towards Robust Automated Perceptual Voice Quality Assessment with Deep Learning," arXiv 2505.21356 (2025). https://arxiv.org/html/2505.21356v1
*VOQANet — attention-based foundation model로 CAPE-V/GRBAS 자동화.*
OCEBM: 5. 적용: part 7, part 11.

### [CITE: SIPSURVEY2025]
"A Survey on 30+ Years of Automatic Singing Assessment and Singing Information Processing," arXiv 2601.12153 (2025). https://arxiv.org/html/2601.12153
*해당 분야 종합 서베이.*
적용: part 11.

### [CITE: SVSREVIEW2025]
"Synthetic Singers — Review of Deep-Learning-based Singing Voice Synthesis," arXiv 2601.13910 / IJCNLP 2025. https://aclanthology.org/2025.ijcnlp-long.24.pdf
*SVS 종합 서베이.*
적용: part 11.

### [CITE: GENMM2025]
"Generative Multi-modal Feedback for Singing Voice Synthesis Evaluation," arXiv 2512.02523 (2025). https://arxiv.org/abs/2512.02523
*"왜?" 설명형 차세대 AI 코치 파이프라인.*
적용: part 11.

### [CITE: JANG_TASLP2022]
Jang, H., Park, J., et al. (2022). "Deep Learning Approaches in Topics of Singing Information Processing," *IEEE/ACM TASLP*. https://dl.acm.org/doi/abs/10.1109/TASLP.2022.3190732
*ML-on-singing 권위적 리뷰.*
OCEBM: 5. 적용: part 11.

### [CITE: SGRUEL2025]
"Evaluation Singing Art Voice Quality Using Siamese Gated Recurrent Extreme Learning Networks," IEEE (2025). https://ieeexplore.ieee.org/document/11168495/
*Siamese GRU-ELM 하이브리드 미술발성 품질 평가.*
적용: part 11.

### [CITE: LEE2020TASLP]
Lee, J. et al. (2020). "Tag-based singing voice analysis (Korean dataset)," TASLP. https://jongpillee.github.io/assets/images/taslp2020_singing_tag.pdf
*K-pop 관련 태그 가창 데이터셋.*
적용: part 9-KR, part 11.

### [CITE: HU2022PITCH]
Hu, T.-Y. et al. (2022). "Smart-Median: A New Real-Time Algorithm for Smoothing Singing Pitch Contours," *Applied Sciences* 12(14):7026. https://www.mdpi.com/2076-3417/12/14/7026
*실시간 피치 평활 알고리즘.*
적용: part 11.

### [CITE: HOSOYA2023]
Hosoya, T. et al. (2023). "Automatic GRBAS Scoring of Pathological Voices using Deep Learning and a Small Set of Labeled Voice Data," *J Voice*. https://pubmed.ncbi.nlm.nih.gov/36437171/
*적은 라벨 데이터로 GRBAS 자동화 — 임상 적용 가능성.*
OCEBM: 4. 적용: part 7, part 11.

### [CITE: NOISE2024]
"The Effect of Noise on Deep Learning for Classification of Pathological Voice," *J Voice* (2024). https://pubmed.ncbi.nlm.nih.gov/38280184/
*노이즈에 의한 DL 분류 강건성 한계.*
OCEBM: 5. 적용: part 11.

### [CITE: ULOZA2023]
Uloza, V. et al. (2023). "An iOS-based VoiceScreen application: feasibility for use in clinical settings — pilot study," *PMC*. https://pmc.ncbi.nlm.nih.gov/articles/PMC9811036/
*임상급 스마트폰 앱 검증 파일럿.*
OCEBM: 4. 적용: part 7, part 11. 태그: `[탐색적 근거]`.

### [CITE: MOBILEVOICE2022]
(1저자 확인 권장) (2022). "Comparison of Acoustic Voice Features Derived From Mobile Devices and Studio Microphone Recordings," *Journal of Voice*. https://www.sciencedirect.com/science/article/pii/S0892199722003125
*모바일 기기는 F0·jitter는 스튜디오 마이크와 양호 일치, **HNR·shimmer·그 변종은 device bias·유의차** — F0 외 측정은 device·조건 robustness 제한.*
OCEBM: 3b. 적용: ADR-0014(R3 신규 근거), part 7·11. (R3 교체분 — MANFREDI/GRILLO 대체)

### [CITE: SMARTPHONE_AVQI_META2025]
(1저자 확인 권장) (2025). "The Accuracy of Smartphone Recordings for Clinical Voice Diagnostics in Acoustic Voice Quality Assessments: A Systematic Review and Meta-Analysis," *J Voice*(추정). https://pubmed.ncbi.nlm.nih.gov/41037430/
*스마트폰 임상 음성 진단 정확도 체계적 리뷰·메타분석.*
OCEBM: 1a(메타). 적용: ADR-0014(R3 신규 근거), part 7. *연도·저널 1저자 확인 권장*.

### [CITE: MANFREDI2017]
Manfredi, C. et al. (2017). "Influence of Smartphones and Software on Acoustic Voice Measures," *PMC*. https://pmc.ncbi.nlm.nih.gov/articles/PMC5536725/
*마이크 정확도 한계 — 컨슈머 앱 정확도 검증.*
⚠️정정(CITATION-AUDIT V2): 실제 **Grillo, E.U. et al. (2016)**, *Int J Telerehabilitation* 8(2):9-14, PMC5536725 — "Manfredi 2017" 아님(저자·연도·저널 오기). **원문 결론은 "스마트폰이 within-subject 음성 추적에 적절"** → "마이크 정확도 한계" 프레이밍과 상충. ADR-0014 시각전용 근거로는 부적합 → 근거 교체 필요(시각전용은 골전도·저신뢰지표 근거로 유지).
OCEBM: 4. 적용: part 7, part 11.

### [CITE: MOBILE2022VAL]
"Mobile Phone Applications Voice Tools and Voice Pitch Analyzer Validated With LingWAVES to Measure Voice Frequency," *J Voice* (2022). https://www.sciencedirect.com/science/article/pii/S0892199722003186
*컨슈머 앱 2종 실험실 표준 대비 검증.*
OCEBM: 4. 적용: part 11.

### [CITE: VOX4HEALTH2018]
Lin, Z.-T. et al. (2018). "Vox4Health: m-Health system for voice disorder detection — clinical study," *PMC*. https://pmc.ncbi.nlm.nih.gov/articles/PMC6106917/
적용: part 11.

### [CITE: LEE2022IOS]
Lee, J. et al. (2022). "Effect of an iOS App on Voice Therapy Adherence and Motivation," PMC. https://pmc.ncbi.nlm.nih.gov/articles/PMC8740599/
적용: part 11.

### [CITE: CHOIPARK2024]
Choi, J. & Park, S. (2024). "Korean Pansori Vocal Note Transcription Using Attention-Based Segmentation," *Applied Sciences* 14(2):492. https://www.mdpi.com/2076-3417/14/2/492
*판소리 attention-based 음표 전사.*
OCEBM: 5. 적용: part 6-KR, part 11.

### [CITE: SMARTREV2021]
"Smartphone Use in Clinical Voice Recording and Acoustic Analysis: A Literature Review," *J Voice* (2021). https://pubmed.ncbi.nlm.nih.gov/32736910/
적용: part 11.

---

## E. 한국어 1차 학술문헌 (Wave 4 핵심)

### [CITE: KOR_LEE_HAN2022]
이송희, 한경훈 (2022). "파사지오 구간 발성 개선을 위한 보컬 지도방안 연구: 에스틸 보이스 트레이닝의 트웽 기법을 활용하여," *예술교육연구*. https://www.kci.go.kr/kciportal/landing/article.kci?arti_id=ART002917940
*KCI 등재. 실용음악 학생 n=10 파일럿. EVT 트웽을 한국 파사지오에 적용.*
OCEBM: 4. 적용: part 5, part 9-KR.

### [CITE: KOR_KIM2025]
김형미 (2025). "보컬리스트의 효율적 발성을 위한 성대접지 메커니즘 연구," *한국산학기술학회논문지* 26(10):756-763. https://www.kci.go.kr/kciportal/ci/sereArticleSearch/ciSereArtiView.kci?sereArticleSearchBean.artiId=ART003258894
*KCI 등재. 성대접지 3분류(균형/저접지/과접지) 훈련 프레임.*
OCEBM: 5 (개념·교육). 적용: part 3, part 9-KR, part QI.

### [CITE: KOR_EHWA_PRACTICAL]
"한국의 현대 '실용음악'과 '보컬'의 개념상의 문제점 및 고등교육에서 보컬의 학문적 수용 전망," *이화음악논집*. https://www.kci.go.kr/kciportal/ci/sereArticleSearch/ciSereArtiView.kci?sereArticleSearchBean.artiId=ART001559589
*실용음악 보컬의 학문적 자리매김 기초 논문.*
적용: part 9-KR, part 10.

### [CITE: KOR_PANSORI_GLOTTAL]
"판소리 가수와 전문 성악가의 발성 평가를 위한 성문의 특성 및 음향학적 분석," KCI. https://www.kci.go.kr/kciportal/ci/sereArticleSearch/ciSereArtiView.kci?sereArticleSearchBean.artiId=ART001026868
*판소리 vs 서양 성악 성문·음향 비교.*
적용: part 6-KR, part 9-KR.

### [CITE: KOR_FACH_GENDER]
"성악가의 성별 및 성종에 따른 발성적 특징과 차이," KCI. https://www.kci.go.kr/kciportal/ci/sereArticleSearch/ciSereArtiView.kci?sereArticleSearchBean.artiId=ART001353084
*성별·Fach 음향 차이 — 한국 1차 데이터.*
적용: part 5, part QI.

### [CITE: KOR_SLS_CVT]
"SLS 발성법과 CVT 발성법의 비교 분석," *한국산학기술학회 논문지* (DBpia). https://www.dbpia.co.kr/journal/articleDetail?nodeId=NODE11202324
*한국 국내 SLS-vs-CVT 직접 비교 동료심사.*
적용: part 12, part 9-KR.

### [CITE: KOR_SONG_THESIS]
송명은. "음성질환자 보컬들을 위한 올바른 발성테크닉 연구: 성대질환 사례를 중심으로," 경희대 학위논문. https://www.dbpia.co.kr/journal/detail?nodeId=T14578251
*음성질환 CCM 가창자 대상 — 임상-페다고지 가교.*
적용: part 8, part 9-KR.

### [CITE: KOR_VISUAL_QUANT]
"노래의 가창력 평가를 위한 시각적, 정량적 방법의 제안," *한국통신학회논문지*. https://dbpia.co.kr/journal/articleDetail?language=ko_KR&nodeId=NODE07047434
*시각·정량 가창력 평가 — 한국 공학 측 AI 피드백 접근.*
적용: part 7, part 11.

### [CITE: KOR_MIDDLEHIGH]
"중등학교 가창 교육의 실태 분석," *음악교육공학*. https://www.dbpia.co.kr/journal/articleDetail?nodeId=NODE11261920
*한국 중·고 가창 교육 실태.*
적용: part 9-KR, part 16.

### [CITE: KOR_CAI]
"보컬 가창 훈련을 위한 CAI 개발 연구," KCI. https://www.kci.go.kr/kciportal/landing/article.kci?arti_id=ART002166030
*컴퓨터 보조 보컬 훈련 — AI 피드백 한국 선례.*
적용: part 11.

### [CITE: KOR_VOCAL_STEM]
"분리된 보컬을 활용한 음색기반 음악 특성 탐색 연구," *방송공학회논문지* (DBpia). https://www.dbpia.co.kr/journal/articleDetail?nodeId=NODE09277449
*K-pop 보컬 stem 음색 분석 — 방송공학 관점.*
적용: part 9-KR.

### [CITE: KOR_NODULE_TX]
"성대 결절 환자의 발성 패턴에 따른 음성 치료 접근의 효과," 대한음성언어의학회 학술대회. https://www.dbpia.co.kr/journal/articleDetail?nodeId=NODE09424875
*결절 음성치료 한국 임상 효능.*
OCEBM: 4. 적용: part 8, part 9-KR.

### [CITE: KOR_JKSLP_BELCANTO]
"서양식 성악발성법의 의학적 이해," *대한후두음성언어의학회지* (jkslp). https://jkslp.org/upload/pdf/jkslp-22-2-106.pdf
*벨칸토 의학적 이해 한국 후두학회 리뷰.*
적용: part 9-KR, part 12.

### [CITE: KOR_SOPRANO_ACOUSTIC]
"소프라노의 성악 발성에 대한 음향학적 특징 연구," *한국음향학회지*. https://koreascience.kr/article/JAKO200011921105774.pdf
*한국 소프라노 포먼트·비브라토 데이터.*
적용: part 4, part 5, part QI.

### [CITE: KOR_POP_BREATH]
"대중음악의 호흡과 발성에 관한 연구," ScienceON / KISTI. https://scienceon.kisti.re.kr/srch/selectPORSrchArticle.do?cn=DIKO0009889768
*대중음악 호흡·발성 한국 연구.*
적용: part 9-KR.

### [CITE: KOR_PRACTICAL_PRACT]
"실용음악 보컬 실기교육에 관한 연구," RISS. https://www.riss.kr/search/detail/ssoSkipDetailView.do?p_mat_type=be54d9b8bc7cdb09&control_no=c6b717b6869e078affe0bdc3ef48d419
*한국 실용음악 보컬 실기 교육 실태.*
적용: part 9-KR, part 10.

### [CITE: KOR_CLASSICAL_VS_CCM]
"성악과 보컬 발성법을 통한 효과적인 실용보컬지도법," ScienceON. https://scienceon.kisti.re.kr/srch/selectPORSrchArticle.do?cn=DIKO0014258052
*클래식 성악 vs 실용 보컬 비교 페다고지.*
적용: part 9-KR, part 12.

### [CITE: KOR_VRP]
"Voice Range Profile 검사의 간편 측정법 개발 연구," *언어치료연구* (DBpia). https://www.dbpia.co.kr/journal/articleDetail?nodeId=NODE11213843
*한국 VRP 간이 프로토콜.*
적용: part 7, part QI.

### [CITE: KOR_SPEECHRATE]
"한국어 발화 속도의 지역, 성별, 세대에 따른 특징 연구," *말소리와 음성과학* (DBpia). https://www.dbpia.co.kr/Journal/articleDetail?nodeId=NODE07133924
*한국어 코퍼스 발화 속도 데이터.*
적용: part 6-KR.

### [CITE: KOR_PSS_JOURNAL]
*Phonetics and Speech Sciences (말소리와 음성과학)* — KoreaScience. https://koreascience.kr/journal/OMSOCX/v14n4.do
*한국음성학회 대표 학술지 진입점.*
적용: part 6-KR, part 9-KR.

### [CITE: KOR_PRACTICAL_CASE]
"실용음악 보컬 발성과 테크닉 사례분석," ScienceON. https://scienceon.kisti.re.kr/srch/selectPORSrchArticle.do?cn=DIKO0015767488&dbt=DIKO
*CCM 발성·테크닉 한국 사례 연구.*
적용: part 9-KR.

### [CITE: KOR_KOBAIN]
상명대 김경준 (2017). "커트 코베인 보컬 표현 기법 연구," DBpia. https://www.dbpia.co.kr/journal/detail?nodeId=T14585513
*상명대 단일 아티스트 분석.*
적용: part 11, part 13.

### [CITE: KOR_BUBLE]
상명대 허준희. "마이클 부블레의 보컬 표현기법 연구," DBpia. https://www.dbpia.co.kr/journal/detail?nodeId=T15085285
적용: part 11.

### [CITE: KOR_COMPRESSION]
"보컬 녹음 시 가수의 모니터 환경에서 보컬 컴프레션이 가창에 미치는 영향," DBpia. https://www.dbpia.co.kr/journal/detail?nodeId=T15085288
*K-pop 프로덕션 측 모니터 컴프레션 영향.*
적용: part 9-KR.

---

## F. 한국어 가창 딕션 (Wave 4)

### [CITE: LEE2017CGU]
Lee, C. N. (2017). "Adapting the IPA Systems of Korean Diction to Classical Vocal Method," CGU 박사논문. https://scholarship.claremont.edu/cgu_etd/689/
*한국어 IPA × 클래식 성악 직접 다룬 박사논문 — 기존 docs 명시 갭 보완.*
⚠️정정(CITATION-AUDIT V3): 저자 Clara N. Lee·CGU ETD 689 실재하나 **연도 2020**(2017 오기). 키→LEE2020CGU 권장. 내용 일치.
OCEBM: 4. 적용: part 6-KR, part 9-KR.

### [CITE: LABOUFF2008]
LaBouff, K. (2008). *Singing and Communicating in English*. Oxford UP.
*미국 음대 표준 영어 딕션 교재.*
적용: part 6.

### [CITE: SALGADO2014]
Salgado, B. (2014). "A Cross-Cultural Examination of Breath and Sound Production in Pansori." (peer-reviewed)
*판소리 호흡·음성 비교 민족음악·음성과학 교차.*
적용: part 6-KR.

### [CITE: SALGADO2022]
Salgado, B. (2022). "Pansori today: aesthetic demands vs. vocal health," *Revista de Investigación e Innovación en Ciencias de la Salud*.
*판소리 미적 요구 vs 음성 건강.*
적용: part 6-KR, part 8.

### [CITE: LEE2017PANSORI]
Lee, B.-W. (2017). "Vocal characteristics of pansori singers," *J Voice*.
*판소리 가창자 음향 특성.*
적용: part 6-KR.

---

## G. K-pop 산업 / 학술 (Wave 3 핵심)

### [CITE: JVOICE2025KPOP]
"Auditory Perception of Neutral Voices in K-Pop Singers," *Journal of Voice* (Nov 2025). https://www.sciencedirect.com/science/article/abs/pii/S0892199725004874
*J Voice 최초 K-pop 전용 논문. K-pop 음성의 젠더 중립성 청지각.*
OCEBM: 3b. 적용: part 5, part 9-KR, part 14.

### [CITE: CAMBRIDGE_KPOP]
"What's behind the 'K'? Common audio features of Korean popular music before and after the rise of K-POP," *Popular Music* (Cambridge). https://www.cambridge.org/core/journals/popular-music/article/whats-behind-the-k-common-audio-features-of-korean-popular-music-before-and-after-the-rise-of-kpop/E0A20BDA5FD01DD9FB6F65BC7A6EE172
*K-pop 전후 음향 특성 동료심사 음악학 분석.*
OCEBM: 3b. 적용: part 9-KR.

### [CITE: KCONTENT_VOCAL]
"K-pop Vocal Training: How Korean Idols Build World-Class Live Performance Skills," KcontentHub. https://kcontenthub.com/en/k-pop-vocal-training-how-korean-idols-build-world-class-live-performance-skills/
*K-pop 명명 연습 (k-keok, kkook, siren, lip bubble) 1차 기술 — 산업 자료.*
적용: part 9-KR, part 15. 태그: `[K-pop 산업관행]`.

### [CITE: KH_TRAINER]
"Behind the K-pop scene: Vocal trainer So Su-lyn," The Korea Herald. https://www.koreaherald.com/article/3829114
*트레이너 인터뷰 (10년차, SM/JYP/YG 학생).*
적용: part 9-KR. 태그: `[K-pop 산업관행]`.

### [CITE: SM_DAILYDRAMA]
"Inside K-pop's Toughest Gauntlet: SM Entertainment's Trainee System," Daily Drama. https://dailydrama.com/k-pop/inside-k-pops-toughest-gauntlet-sm-entertainments-trainee-system/
*SM 트레이닝 일과 상세.*
적용: part 9-KR. 태그: `[K-pop 산업관행]`.

### [CITE: KH_HEALTH]
"Health issues plague K-pop girl groups," The Korea Herald. https://www.koreaherald.com/article/3416833
*K-pop 걸그룹 시스템적 건강 이슈 — 한국 일간지.*
적용: part 8, part 9-KR.

### [CITE: ALLKPOP_SEEYA2025]
"Seeya's Kim Yeon Ji opens up about vocal cord cyst surgery and temporary hiatus," AllKpop (May 2025). https://www.allkpop.com/article/2025/05/seeyas-kim-yeon-ji-opens-up-about-vocal-cord-cyst-surgery-and-temporary-hiatus
*최근 K-pop 성대낭종 수술 사례.*
적용: part 8, part 9-KR.

### [CITE: ONEW2014]
"SHINee's Onew Has a Vocal Fold Nodules Removal Surgery," KpopBehind (2014). https://www.kpopbehind.com/2014/06/shinees-onew-has-vocal-fold-nodules.html
*온유 결절 수술 — 3.5개월 거의 완전 휴식 회복 기록.*
적용: part 8, part 9-KR.

### [CITE: KOREABOO_LIST]
"15 K-Pop Idols Who Bravely Underwent Serious Surgeries," Koreaboo. https://www.koreaboo.com/lists/15-kpop-idols-bravely-underwent-serious-surgeries/
*K-pop 가창 손상 사례 집계 (Wendy 데뷔 시점 결절, Exy 결절로 보컬→래퍼 전환 등).*
적용: part 9-KR.

### [CITE: BLOOMBERG2019]
"K-Pop's Dark Side: Assault, Prostitution, Suicide, and Spycams," Bloomberg (Nov 2019). https://www.bloomberg.com/news/features/2019-11-06/k-pop-s-dark-side-assault-prostitution-suicide-and-spycams
*Bloomberg-급 K-pop 산업 비판 보도.*
적용: part 9-KR.

### [CITE: AALTO_KPOP]
"Idols & Ideals: Ethical challenges in the Korean music industry," Aalto University 석사논문. https://aaltodoc.aalto.fi/server/api/core/bitstreams/08f8628b-1962-4380-9e95-f0522f5c7b8f/content
*Aalto 학위논문 — K-pop 윤리 분석.*
적용: part 9-KR.

### [CITE: TRAINEE_LAW2024]
"How Effective Are South Korea's Labor and Contract Laws in Safeguarding Minors in the K-pop Trainee System," ResearchGate (2024). https://www.researchgate.net/publication/395552491
*K-pop 미성년 트레이니 노동·계약법 학술 분석.*
적용: part 9-KR.

### [CITE: KH_GLOBAL]
"K-Pop Agencies' Global Strategy | HYBE, SM, JYP, and YG Expansion Case Study," Essential Business Marketing. https://essentialbizmarketing.com/blog/international-business/global-expansion-strategies-of-hybe-sm-jyp-and-yg-entertainment/
*기획사 글로벌 트레이닝 시스템.*
적용: part 9-KR. 태그: `[K-pop 산업관행]`.

### [CITE: KT_TEEN2025]
"Why teen K-pop trainee numbers are dropping despite greater investment," The Korea Times (Dec 2025). https://www.koreatimes.co.kr/entertainment/k-pop/20251201/why-teen-k-pop-trainee-numbers-are-dropping-despite-greater-investment
*최근 트레이니 수 감소 산업 동향.*
적용: part 9-KR.

### [CITE: KH_AGENCY_STYLE]
"Your idols' style by agency," Korea Herald. https://www.koreaherald.com/article/10010990
*기획사별 스타일 차별화.*
적용: part 9-KR.

### [CITE: TROT_NAMINSU]
"On a sound analysis of Korean Trot singer Nam in-su's voice," ResearchGate. https://www.researchgate.net/publication/317496250
*트로트 가수 음향 분석 — K-pop 이전 한국 가창 학술.*
적용: part 9-KR.

### [CITE: TROT_LEENANYOUNG]
"Acoustic analysis on vocal voice of Lee Nan-Young, a legendary singer of Korea," ResearchGate. https://www.researchgate.net/publication/310760477
적용: part 9-KR.

---

## H. 메타·교차 (참조용)

### [CITE: SUNDBERG1987]
Sundberg, J. (1987). *The Science of the Singing Voice*. NIU Press.
*가창 음성과학 정전 텍스트.*
적용: 다수 (이미 docs에 등장 가능, 키 표준화).

### [CITE: TITZE2000]
Titze, I. R. (2000). *Principles of Voice Production*. NCVS.
*1차 생체역학 텍스트.*
적용: 다수.

### [CITE: TITZE2006SOVT]
Titze, I. R. (2006). "Voice training and therapy with a semi-occluded vocal tract: Rationale and scientific underpinnings," *J Speech Lang Hear Res* 49. https://pubmed.ncbi.nlm.nih.gov/16671856/
적용: part 3.

### [CITE: HENRICH2006]
Henrich, N. (2006). "Mirroring the voice from Garcia to the present day," *Logopedics Phoniatrics Vocology*.
*Garcia 이후 후두 메커니즘 모델 역사 리뷰.*
적용: part 5, part 13.

### [CITE: ROUBEAU2009]
Roubeau, B., Henrich, N., Castellengo, M. (2009). "Laryngeal vibratory mechanisms: the notion of vocal register revisited," *J Voice* 23(4). https://pubmed.ncbi.nlm.nih.gov/18538982/
*M0–M3 후두 메커니즘 분류 1차 출처.*
적용: part 5, part QI.

### [CITE: HUNTER_TITZE2003]
Titze, I. R., Svec, J. G., Popolo, P. S. (2003). "Vocal dose measures: Quantifying accumulated vibration exposure in vocal fold tissues," *J Speech Lang Hear Res* 46(4). https://pubs.asha.org/doi/10.1044/1092-4388(2003/072)
*Vocal Dose 4변수 1차.*
적용: part 8, part QI.

---

## I. 인체해부·생리학 토대 (part HP 신규)

### [CITE: HIRANO1981]
Hirano, M. (1981). *Clinical Examination of Voice*. Springer-Verlag.
*성대 5층 구조 (epithelium / superficial·intermediate·deep lamina propria / vocalis muscle) 정전. GRBAS 척도 1차.*
적용: part HP §3, part QI §9.

### [CITE: HIRANO1974]
Hirano, M. (1974). "Morphological structure of the vocal cord as a vibrator and its variations," *Folia Phoniatr* 26(2):89-94.
*성대 점막파·body-cover 모델 1차 출처.*
적용: part HP §3.

### [CITE: HIXON2008]
Hixon, T. J., Weismer, G., Hoit, J. D. (2008). *Preclinical Speech Science: Anatomy, Physiology, Acoustics, Perception*. Plural Publishing.
*Speech breathing의 흉곽-복부 결합 모델 정전 교과서. "복식 vs 흉식" 이분법 폐기 근거.*
적용: part HP §1, part 14 *복식호흡* 카드.

### [CITE: FITTS_POSNER1967]
Fitts, P. M. & Posner, M. I. (1967). *Human Performance*. Brooks/Cole.
*운동 학습 3단계 (cognitive → associative → autonomous) 정전. 보컬 학습 진도 모델의 토대.*
적용: part HP §5.

### [CITE: SCHMIDT_LEE2019]
Schmidt, R. A., Lee, T. D., Winstein, C. J., Wulf, G., Zelaznik, H. N. (2019). *Motor Control and Learning: A Behavioral Emphasis* (6th ed.). Human Kinetics.
*운동 학습 현대 정전. blocked vs random, massed vs distributed, KR/KP feedback 변수.*
적용: part HP §5, part 8 P8-07.

### [CITE: COOKSEY2000]
Cooksey, J. M. (2000). *Working with Adolescent Voices*. Concordia. + Cooksey (1977) "The Development of a Contemporary Eclectic Theory for the Training and Cultivation of the Junior High School Male Changing Voice," *Choral Journal*.
*남성 변성기 5단계 정전 (Cooksey stages I–V). Premutational → Newvoice settling.*
적용: part HP §8.

### [CITE: GACKLE2011]
Gackle, L. (2011). *Finding Ophelia's Voice, Opening Ophelia's Heart: Nurturing the Adolescent Female Voice*. Heritage Music Press.
*여성 변성기 4단계 정전 (Gackle phases I–IV). Premenarcheal → Postmenarcheal stable.*
적용: part HP §8.

### [CITE: LA_HOWARD2011]
Lã, F. M. B. & Howard, D. M. (2011). "Female sex hormones and voice quality," in *The Oxford Handbook of Singing*. Oxford UP. + Lã, F. M. B. (2012). *Hormones and the female singing voice*.
*여성 호르몬·생리주기·임신·갱년기와 가창 음성 정전.*
적용: part HP §7.

### [CITE: HELDING2020]
Helding, L. (2020). *The Musician's Mind: Teaching, Learning, and Performance in the Age of Brain Science*. Rowman & Littlefield.
*음악가 운동 학습·인지·무대 공포 신경과학 통합.*
적용: part HP §5, §10.

### [CITE: KENNY2011]
Kenny, D. T. (2011). *The Psychology of Music Performance Anxiety*. Oxford UP. + Kenny K-MPAI (Music Performance Anxiety Inventory).
*무대 공포 정전 + 측정 도구.*
적용: part HP §10.

### [CITE: TITZE_VERDOLINI2012]
Titze, I. R. & Verdolini Abbott, K. (2012). *Vocology: The Science and Practice of Voice Habilitation*. NCVS.
*Vocology 정전. 음성 부하·재활·점진 과부하 음성 적용 토대.*
적용: part HP §9, part 8.

### [CITE: SAPIENZA_RUDDY2018]
Sapienza, C. & Ruddy, B. H. (2018). *Voice Disorders* (4th ed.). Plural Publishing.
*음성 장애 임상 정전. 결절·폴립·낭종·MTD 메커니즘 분리.*
적용: part HP §3.

---

## J. 인체-가창 응용 문헌 (part HX 신규)

> RESEARCH_COMPILATION_3.md 딥 리서치 결과로 메타 보강·세분화. 4판·공저자·1차 원형 출처·세분화 인용 키 모두 반영.

### [CITE: MALDE2017]
Malde, M., Allen, M., Zeller, K. (2012/2013). *What Every Singer Needs to Know About the Body* (2nd ed.). Plural Publishing. ISBN 978-1-59756-494-6. Introduction by Barbara Conable; Appendix B by T. R. Nichols.
**4th ed. (2023)** ISBN 978-1-63550-261-9 — 앱 콘텐츠 제작 시 *4판 우선 인용* 권장.
*Body Mapping 가창자용 표준 교재 (Andover Educators 라인). 6 Places of Balance·Inclusive Awareness·Breath/Articulation Mapping. 해부 다이어그램은 라이선스 보호 — 자체 일러스트 제작 + 텍스트 인용만.*
적용: part HX §1·§2, `app/01-A` Phase A 자세·호흡 콘텐츠.

### [CITE: DIMON2018]
Dimon, T. Jr. & Brown, G. D. (illust.) (2018). *Anatomy of the Voice: An Illustrated Guide for Singers, Vocal Coaches, and Speech Therapists*. North Atlantic Books. ISBN 978-1-62317-197-1 (paper) / 978-1-62317-198-8 (eBook). 약 192쪽.
*Alexander Technique 라인 (Dimon Institute, NY) + 후두·호흡·성도 해부 통합. Whispered "ah" 진단·훈련, suspensory muscles 매달림 구조. 일러스트는 강력한 저작권 보호 — 자체 다이어그램 제작 필수.*
적용: part HX §2, `app/01-A` Phase A·B.

### [CITE: CHAPMAN2017]
Chapman, J. L. & Morris, R. (공저) (2017). *Singing and Teaching Singing: A Holistic Approach to Classical Voice* (3rd ed.). Plural Publishing. ISBN 978-1-59756-891-3.
*"Body and Soul" 통합 — Primal Sound (원초음 회복), Postural Alignment, Accent Method (Smith·Thyme-Frøkjær 라인 차용 챕터, Chapman & Morris 공저), Phonation, Resonance, Articulation, Artistry. 영국 NHS 음성 클리닉 임상 가교.*
적용: part HX §2·§3, part 1 호흡, part HP §10.

### [CITE: GREENE2002]
Greene, D. (2002). *Performance Success: Performing Your Best Under Pressure*. Routledge / Theatre Arts Books. ISBN 978-0-87830-122-5 (paper) / 978-1-136-76763-0 (eBook). 약 151쪽.
*7-step Centering Routine. 1차 원형: **Robert Nideffer (1976) Centering** — Greene가 음악·무용·연기로 적응. Performance = Potential − Interference (Gallwey 공식 인용·확장). 7-Skill Performance Inventory 자가평가 도구.*
적용: part HX §5, part HP §10, `app/01-A` 무대 공포 모듈 (Phase C).

### [CITE: PATEL2007]
Patel, A. D. (2008). *Music, Language, and the Brain*. Oxford UP. Hardcover ISBN 978-0-19-512375-3 / paperback (2010) ISBN 978-0-19-975530-1. 약 528쪽, 1,300+ 참고문헌.
*음악·언어 인지 신경학 정전. 가창은 음악·언어 교차 영역. 후속 논문은 [CITE: PATEL2011_OPERA] 참조.*
적용: part HX §4, part HP §5, `app/01-A` onboarding 효익 설명.

### [CITE: PATEL2011_OPERA]
Patel, A. D. (2011). "Why would musical training benefit the neural encoding of speech? The OPERA hypothesis," *Frontiers in Psychology* 2:142. + Patel (2014) *Hearing Research* expanded.
*OPERA 가설 5조건: Overlap (신경 공유) · Precision (음악 > 일상언어 정밀도) · Emotion · Repetition · Attention. 음악 훈련이 언어 신경 부호화에 전이되는 조건. 가설 단계 — `[탐색적 근거]`.*
적용: part HX §4, `app/01-A` onboarding ("왜 노래 훈련이 한국어 발음·말하기에도 도움?").

### [CITE: PFORDRESHER_AMI]
Pfordresher, P. Q. 라인 (다수 논문, 2003–현재) — 가창의 청각-운동 통합 (auditory-motor integration) 연구 프로그램. 본 앱 청지각 훈련의 *가장 강한 학술 근거* (`[OCEBM L2–L3]`). 4편 세분화 인용 [CITE: PFORDRESHER2007PP] [CITE: PFORDRESHER2014SWY] [CITE: PFORDRESHER2021SSAP] [CITE: BERGLIN2022FB] 참조.
적용: part HX §4, part HP §5, part 7 P7-13~14.

### [CITE: PFORDRESHER2007PP]
Pfordresher, P. Q. & Brown, S. (2007). "Poor-pitch singing in the absence of 'tone deafness'," *Music Perception* 25(2):95-115. DOI 10.1525/mp.2007.25.2.95.
*음치 ≠ 청지각 결손. "Poor-pitch singers did not differ from good singers in pitch discrimination accuracy." 산출/매핑 문제로 재정의.*
적용: `app/01-A` onboarding 진단 (청지각 ↔ 산출 분리 테스트 근거).

### [CITE: PFORDRESHER2014SWY]
Pfordresher, P. Q. & Mantell, J. T. (2014). "Singing with yourself: Evidence for an inverse modeling account of poor-pitch singing," *Cognitive Psychology* 70:31-57. DOI 10.1016/j.cogpsych.2013.12.005.
*"All singers imitated sung pitch more accurately when imitating recordings of themselves; the advantage was enhanced for poor-pitch singers." → 자가 녹음 모방 > 일반 모델 모방.*
적용: `app/01-A` Phase A·B "내 목소리 따라부르기" 모듈 신설 직접 근거.

### [CITE: PFORDRESHER2021SSAP]
Pfordresher, P. Q. & Demorest, S. M. (2021). "The prevalence and correlates of accurate singing," *Journal of Research in Music Education* 69(1):5-23. DOI 10.1177/0022429420951630.
*표본 632명 SSAP. modal tendency = accurate singing이지만 약 30%가 부정확 분포 꼬리. 자가주도 학습자의 적정 난이도 구간 설정 근거.*
적용: `app/01-A` onboarding 레벨링.

### [CITE: BERGLIN2022FB]
Berglin, J., Pfordresher, P. Q., Demorest, S. M. (2022). "The effect of visual and auditory feedback on adult poor-pitch remediation," *Psychology of Music* 50(4). DOI 10.1177/03057356211026730.
*시각 피드백(피아노 롤·실시간 피치 곡선) > 청각 피드백 단독. 성인 음치 재교육 RCT급 효과. 본 앱 실시간 피치 시각화 UI의 학술 근거.*
적용: `app/01-A` 실시간 피치 시각화 UI 사양.

### [CITE: GREEN_GALLWEY1986]
Green, B. & Gallwey, W. T. (1986). *The Inner Game of Music*. Doubleday. ISBN 0-385-23126-1. Pan Macmillan reprint (2015) ISBN 978-1-4472-9172-5. GIA Publications G3598.
*Performance = Potential − Interference. Self 1 (비판·분석·언어) vs Self 2 (직관·신체·통합). Awareness drill, non-judgmental observation, process cue. Greene 7-step과 호환.*
적용: part HX §5, part HP §10, `app/01-A` 자가 녹음 리뷰 *non-judgmental prompt*.

### [CITE: RISTAD1981]
Ristad, E. (1981). *A Soprano on Her Head*. Real People Press.
*가창 학습 심리·자기 제한 고전. 학술서가 아닌 페다고지 에세이 — 학습자 동기·자기 인식 자료.*
적용: part HX §5, `app/01-A` 학습자 안내 자료 (선택).

### [CITE: BUNCH_DAYME2009]
Bunch Dayme, M. (2009). *Dynamics of the Singing Voice* (5th ed.). Springer Vienna. ISBN 978-3-211-88728-8 (print) / 978-3-211-88729-5 (eBook). DOI 10.1007/978-3-211-88729-5. 약 233쪽. **6th ed.**는 Routledge로 이전 출간.
*가창 해부·생리 학부 표준 교재. McCoy 2019와 양대 텍스트. Posture → Breathing → Phonation → Resonance → Articulation 위계. 5판 신규 Ch. 7 Pedagogical Aspects (CCM 통합). Study Outlines 부록은 학생 self-study 체크리스트.*
적용: part HX §1, part HP §1·§2, `app/01-A` 주차별 anatomy quiz.

### [CITE: SMITH_THYME_FROKJAER]
Smith, S. & Thyme-Frøkjær, K. (1976/2001). *The Accent Method: A Rhythmic Approach to Vocal Therapy*. Communication Skill Builders.
*Accent Method 1차 매뉴얼 — 호흡-발성 동시 통합 리듬 기반 치료. 3단계 리듬 + 복부 능동 사용 + 자음 강조 발성. Mokhlesin 2018 RCT 검증 (MTD).*
적용: part HX §3, part 12, part HP §1.

### [CITE: NIDEFFER1976]
Nideffer, R. M. (1976). *The Inner Athlete: Mind Plus Muscle for Winning*. Crowell. + Nideffer 후속 attentional control 연구.
*스포츠심리학 Centering 1차 원형. Greene 2002의 7-step 직접 기반.*
적용: part HX §5, part HP §10.

### [CITE: KEMPSTER_CAPEV]
Kempster, G. B., Gerratt, B. R., Verdolini Abbott, K., Barkmeier-Kraemer, J., & Hillman, R. E. (2009). "Consensus auditory-perceptual evaluation of voice (CAPE-V): Development of a standardized clinical protocol," *American Journal of Speech-Language Pathology* 18(2):124–132. https://pubs.asha.org/doi/10.1044/1058-0360(2008/08-0017)
*CAPE-V 표준 프로토콜 1차 출처. ASHA 공식 합의. 6 차원 (overall severity / roughness / breathiness / strain / pitch / loudness) VAS 0–100. GRBAS 후속 표준. 임상가가 평정하는 임상·연구용 도구.*
OCEBM: 5 (전문가 합의 표준 프로토콜). 적용: 01 초급 §7 평가, part 7 P7-05, part QI §9.

### [CITE: AAODHF2018]
Stachler, R. J., Francis, D. O., Schwartz, S. R., et al. (2018). "Clinical Practice Guideline: Hoarseness (Dysphonia) (Update)," *Otolaryngology–Head and Neck Surgery* 158(S1):S1–S42. https://pubmed.ncbi.nlm.nih.gov/29494321/
*AAO-HNSF 임상 가이드라인 갱신판. 4주 상한 기준 (2009판 90일에서 단축). 응급 후두 평가 modifier (호흡곤란·stridor·신경학적 증상·최근 삽관·두경부/흉부 수술·목 외상·흡연력·직업적 음성 사용자·두경부 방사선 치료 이력).*
OCEBM: 5 (임상 합의 가이드라인). 적용: curriculum/01 §3·§9, app/01-B §3·§6.

### [CITE: NIDCD_HOARSENESS]
National Institute on Deafness and Other Communication Disorders (NIDCD). "Hoarseness." https://www.nidcd.nih.gov/health/hoarseness + "Taking Care of Your Voice." https://www.nidcd.nih.gov/health/taking-care-your-voice
*3주 상한 후두암 선별 권고. 객혈·삼킴곤란·목 종괴·말/삼킴 통증·호흡곤란·완전 음성상실 며칠+·whispering 같은 음역·강도 극단 회피.*
적용: curriculum/01 §3·§9·§4 황색 신호.

### [CITE: STEMPLE_VFE]
Stemple, J. C., Lee, L., D'Amico, B., & Pickup, B. (1994). "Efficacy of vocal function exercises as a method of improving voice production," *Journal of Voice* 8(3):271–278.
*Vocal Function Exercises (VFE) 4-과제 패키지 RCT 정전. 성인 여성 음성 생산 지표 변화 보고.*
OCEBM: 1b (RCT). 적용: part 3 P3-08~12, 01 초급 §5.8.

### [CITE: BOZEMAN2013]
Bozeman, K. (2013). *Practical Vocal Acoustics: Pedagogic Applications for Teachers and Singers*. Pendragon Press.
*Acoustic pedagogy 정전. R1:H2 모델, passive vowel modification, acoustic passage area.*
OCEBM: 5 (페다고지 합의 + 음향 측정). 적용: part 4, part 5, part 13, part 14, 01 초급 §6.3.

### [CITE: BOZEMAN2017]
Bozeman, K. (2017). *Kinesthetic Voice Pedagogy: Motivating Acoustic Efficiency*. Inside View Press.
*Kinesthetic 접근 + acoustic framework 통합. Practical Vocal Acoustics 후속.*
OCEBM: 5. 적용: part 4, part 13, 01 초급 §6.3.

### [CITE: MCCOY2019]
McCoy, S. (2019). *Your Voice: An Inside View* (3rd ed.). Inside View Press.
*NATS 표준 학부 보컬 페다고지 교과서. 해부·생리·음향을 학부 수준 통합.*
OCEBM: 5 (학부 표준 교재). 적용: part 13, part 14, part HP, part HX, 01 초급 §6.3.

### [CITE: MILLER1996]
Miller, R. (1996). *On the Art of Singing*. Oxford UP. + Miller, R. (1986). *The Structure of Singing: System and Art in Vocal Technique*. Schirmer.
*Richard Miller 정전 — 클래식 성악 교육의 학문적 정형화. Appoggio·passaggio·Fach 모델.*
OCEBM: 5 (페다고지 정전). 적용: part 12, part 13, part 14 *Appoggio·Passaggio* 카드, part QI §6, 01 초급 §4.3.

---

## I. 키 사용 규칙

1. 본문 내 인용 표기는 `[CITE: KEY]` 또는 한글 본문에는 `(저자 연도 / 저널)` 단축형 사용.
2. KEY는 본 문서에 정의된 것만 사용. 신규 KEY 추가 시 본 문서 갱신 후에만 본문 사용.
3. KEY 변경 시 모든 docs 파일의 등장 위치를 grep으로 동시 갱신.
4. 한국어 1차 출처는 항상 `KOR_` 접두어 사용.
5. K-pop 산업 자료 키는 매체 약어 + 연도 형태(예: `KH_HEALTH`, `BLOOMBERG2019`).

---

## J. 통계

- 총 KEY 수: 약 88개 (Wave 1~5 통합 시 100±)
- A. 손상 역학: 18개
- B. 방법론 RCT: 17개
- C. 공명·믹스: 4개
- D. AI/웨어러블: 19개
- E. 한국어 1차: 24개
- F. 한국어 딕션: 5개
- G. K-pop 산업/학술: 17개
- H. 메타: 6개

(중복 적용 키는 한 번만 카운트)

---

## K. 검증 체크리스트 (Wave 종료 시)

- [ ] 모든 docs 본문의 `[CITE: KEY]`가 본 문서에 정의되어 있는가? (grep `\[CITE:` 결과와 본 문서 KEY 목록 교차 비교)
- [ ] 본 문서의 모든 KEY가 적어도 하나의 docs 파일에 등장하는가? (역방향 grep)
- [ ] OCEBM 등급 표기가 일관된가?
- [ ] 한국어 출처가 한글로 표기되었는가?

---

## L. 교차검증 도시에 신규 키 (2026-06, 독립 리서치 2종)

> 출처: [SAFETY-EVIDENCE-DOSSIER.md](verification/SAFETY-EVIDENCE-DOSSIER.md) §6.
> 아래 3건은 본 작업에서 **웹으로 핵심 주장을 독립 재확인(✅)** 함. 나머지 도시에 출처는
> 리서치 제공(미재확인, ○)이며 도시에 §6 표에 귀속만 — 본 인덱스엔 미등재(재확인 후 승격).

### [CITE: BOURNE2012] ✅재확인(웹 2026-06)
Bourne, T., & Garnier, M. (2012). "Physiological and acoustic characteristics of the female music theater voice," *JASA* 131(2):1586–1594. https://doi.org/10.1121/1.3675010
belt는 R1을 2f0에 **C5까지** 동조(legit보다 고SPL) / OCEBM 4·GRADE 낮음 / 적용: belt 음역 상한(IM-05·GY-05), 도시에.

### [CITE: ZUIM2023] ✅재확인(웹 2026-06)
Zuim, A. F., Stewart, C. F., & Titze, I. R. (2023). "Vocal Demands of Musical Theatre Rehearsals: A Dosimetry Study," *Journal of Voice*. PMID 37951817. https://doi.org/10.1016/j.jvoice.2023.09.020
**"안전 baseline vocal dose 미확립"**(가수) — 모든 dose 임계는 보수적 추정 / OCEBM 4 / 적용: 주간 캡 권고, 도시에.

### [CITE: ANDRADE2000] ✅재확인(웹 2026-06)
Andrade, D. F., et al. (2000). "The frequency of hard glottal attacks in patients with muscle tension dysphonia, unilateral benign masses and bilateral benign masses," *Journal of Voice*. https://doi.org/10.1016/S0892-1997(00)80032-6
HGA 빈도 MTD·양성병변군 > 건강대조군(147명) → k-keok 영구 제외 지지 / OCEBM 4 / 적용: 가요 k-keok 제외, 도시에.


############################################################
# Design specs & plans (docs/superpowers)
############################################################


===== FILE: docs/superpowers/specs/2026-06-09-dark-lesson-map-uiux-design.md =====

# 다크 레슨맵 — UI/UX 개선 설계

> 상태: 승인됨(2026-06-09). 방향=다크 레슨맵(다크 톤 유지 + 레슨맵·일러스트 악센트·마이크로애니메이션).
> 마이크는 현재 검증 불가 → 본 패스는 *비-피치* UI/UX에 집중(피치 표시 코드·동작 불변).

## 1. 배경·목표

현재 앱은 기능 완성(159 tests green)이나 시각적으로 밋밋하고 "매일 하고 싶은" 동기가 약함.
듀오링고식 재미를 주되 **ADR-0002 무납득**(동기부여·설명 카피 금지) 때문에 응원 멘트는 못 쓴다.
→ 재미는 *색·일러스트·레슨맵·진행 시각화·절제된 애니메이션*으로만 준다.

- **목표:** 전 화면(홈·레슨·졸업/장르픽/설정) 다크 레슨맵 톤으로 폴리시 + 홈을 여정 맵으로 재구성.
- **비목표:** 마이크/피치 동작 변경, 안전 게이트·진행 모델 변경, 실제 일러스트 외주, 라이트 테마.

## 2. 제약 (불변)

- ADR-0002 무납득: 동기/설명 카피 없음. ADR-0003 1일1레슨. ADR-0015 카드 스키마.
- 진행 모델·`kSafetySignoff`·`kReleasedGenres`·피치 스택 불변.
- 기존 위젯 Key·동작 보존 우선(회귀 최소화). 구조가 바뀌는 곳만 테스트 TDD 갱신.

## 3. 디자인 시스템 (선행)

색상값이 6개 화면에 하드코딩 중복(`#0E0F13`·`#171922`·`#39D98A`·`#6C8CFF`·`#3A3F55` 등).

- 신규 `app/lib/theme/app_theme.dart`: `AppColors`(bg/surface/done/now/locked/text 계열) +
  간격/라운드 상수. 화면들이 이를 참조하도록 *치환만*(픽셀 동일 유지).
- 동작·텍스트·레이아웃 불변 → 기존 테스트 안전. 이후 톤 변경은 1곳에서.

## 4. 홈 = 레슨맵 (핵심 변화)

기존 `_ProgressBlocks`(5블록 가로 막대, `Key('progress-blocks')`)를 **세로 여정 맵**으로 교체.

### 구조
- 상단 헤더: `🔥 N일`(`Key('home-streak')` 보존) + `⚙️`(`home-settings` 보존).
- **맵 본문**(`Key('lesson-map')`): 48슬롯이 5블록 섹션으로 묶인 세로 스크롤 경로.
  - 섹션 라벨: 토대·SOVT·발성·감각·졸업(텍스트 '토대'·'졸업' 유지 → 테스트 호환).
  - 노드 상태: 완료=초록 ✓ / 오늘=파랑 맥동 ▶ / 미래=잠금 🔒. **탭 불가**(여정 시각화).
  - 블록별 일러스트 악센트: 이모지 + 간단 CSS/도형(추후 실제 아트 교체 가능, swappable).
  - "오늘" 위치 = `progression.currentIndex`. 완료=index 미만, 미래=초과.
- 하단 CTA: 오늘 노드에 연결된 **"오늘 시작"**(`Key('start-today')` 보존). 카드 `anatomyMain`
  ("6점 정렬 관찰") 표기 → H1 텍스트 기대 유지. 완료 시 `Key('today-done')` + 시작 버튼 비활성.

### 테스트 영향
- H3가 `progress-blocks`를 검증 → **TDD로 갱신**: `lesson-map` 존재 + 섹션 라벨(토대/졸업) +
  오늘/완료 노드 상태 검증. H1·H2·H4는 키 보존으로 통과 유지.
- 신규 위젯 테스트: 노드 상태 매핑(완료/오늘/미래 카운트가 currentIndex와 일치), 탭 불가.

## 5. 레슨 화면 폴리시 (구조 유지)

- 3단 스테퍼: 현재 단계 강조(채움) + 단계 전환 시 cue **페이드 전환**.
- cue 타이포 위계(여백·줄간격) 정리, 하단 시트 라운드·그림자 정돈.
- 마이크 꺼짐: `Key('mic-off-notice')`·텍스트·동작 보존하되 회색 피치 자리표시 영역으로 덜 휑하게.
- 키(`lesson-screen`·`next-button`·`complete-button`·`skip-cooldown`·`lesson-stepper`·`pitch-display`) 보존.

## 6. 졸업·장르픽·설정

- 졸업: 🎉 + 3장르 카드(일러스트 악센트). 키(`graduation-screen`·`genre-*`) 보존.
- 설정·장르픽: 토큰 적용 + 카드 스타일 통일. 동작·키 불변.

## 7. 마이크로애니메이션 (절제)

- 오늘 노드 맥동(반복), 버튼 누름 스케일, 스트릭 숫자 bump, 완료 시 노드 ✓ 체크인,
  맵 진입 시 경로 가벼운 하이라이트.
- ❌ 컨페티·축하 카피(ADR-0002). 위젯 테스트는 `pumpAndSettle` 호환 위해 무한 반복
  애니메이션은 테스트에서 정지 가능하게(또는 유한) 설계.

## 8. 구현 전략

- **TDD** 화면별 red-green. 순서: ①디자인 토큰(치환, 회귀 가드) → ②홈 맵(H3 갱신+신규) →
  ③레슨 폴리시 → ④졸업/설정 → ⑤애니메이션.
- 기존 159 테스트 유지(H3만 갱신), 신규 위젯 테스트 추가. analyze 클린.
- 마이크 미접촉. 커밋·푸시 단위로 진행.

## 9. 수용 기준

- 홈이 레슨맵으로 렌더, 오늘/완료/미래 노드가 `currentIndex`와 정합, 시작/완료 동작 보존.
- 전 화면 토큰 기반 일관 톤. 절제된 마이크로애니메이션.
- 전 테스트 green + analyze 클린. 피치/진행/안전 동작 불변.


===== FILE: docs/superpowers/plans/2026-06-09-dark-lesson-map-uiux.md =====

# 다크 레슨맵 UI/UX 구현 계획

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 전 화면 다크 레슨맵 톤으로 폴리시하고, 홈을 여정 맵으로 재구성한다(탭 불가, 오늘 노드만 시작).

**Architecture:** 색상/간격을 `app_theme.dart` 토큰으로 추출(픽셀 동일 치환) → 홈의 5블록 바를 `LessonMap` 위젯으로 교체 → 레슨·졸업·설정 폴리시 → 테스트-안전한(설정 가능, 한 번에 끝나는) 마이크로애니메이션. 기존 위젯 Key·동작 보존, 마이크/피치/진행/안전 코드 불변.

**Tech Stack:** Flutter 3.44 / Dart 3.12, flutter_test 위젯 테스트, 기존 `Progression`/`Card` 모델.

---

## 파일 구조

- Create: `app/lib/theme/app_theme.dart` — 색·간격·라운드 토큰(`AppColors`, `AppRadii`).
- Create: `app/lib/lesson/lesson_map.dart` — 홈 여정 맵 위젯(`LessonMap`).
- Create: `app/test/lesson_map_widget_test.dart` — 맵 노드 상태/탭불가 테스트.
- Modify: `app/lib/progression/progression_state.dart` — `slots` 읽기 getter 추가.
- Modify: `app/lib/lesson/home_screen.dart` — 5블록 바 → `LessonMap`, 토큰 적용.
- Modify: `app/test/home_screen_widget_test.dart` — H3 갱신(blocks → map).
- Modify: `app/lib/lesson/lesson_screen.dart` — 토큰·스테퍼 강조·cue 페이드·피치 자리표시.
- Modify: `app/lib/lesson/graduation_screen.dart`, `settings_screen.dart` — 토큰 적용.
- Modify: `app/lib/lesson/pitch/pitch_display.dart` — 토큰 적용(색만).

**검증 명령(공통):**
- 단일 테스트: `C:/src/flutter/bin/flutter.bat test test/<file>.dart`
- 전체: `C:/src/flutter/bin/flutter.bat test` (현재 159 green)
- analyze: `C:/src/flutter/bin/flutter.bat analyze` (작업 디렉터리 `app/`)

---

## Task 1: 디자인 토큰 (`app_theme.dart`) — 회귀 안전 치환

**Files:**
- Create: `app/lib/theme/app_theme.dart`
- Modify: `app/lib/lesson/home_screen.dart` (색 리터럴 → 토큰)
- Test: 기존 `test/home_screen_widget_test.dart` (변경 없음, 회귀 가드)

순수 리팩터(동작·픽셀 불변) → TDD 예외: 기존 테스트가 before/after green이면 통과.

- [ ] **Step 1: 토큰 파일 생성**

```dart
// app/lib/theme/app_theme.dart
/// 앱 공통 색·라운드 토큰. 화면 전역 하드코딩 색을 1곳으로.
library;

import 'package:flutter/material.dart';

class AppColors {
  static const bg = Color(0xFF0E0F13);       // 배경
  static const surface = Color(0xFF171922);  // 카드/시트
  static const surfaceAlt = Color(0xFF222637); // pill
  static const done = Color(0xFF39D98A);     // 완료(green)
  static const now = Color(0xFF6C8CFF);      // 현재(blue)
  static const locked = Color(0xFF3A3F55);   // 잠금/미래
  static const lockedSurface = Color(0xFF2C3142);
  static const textHi = Colors.white;
  static const textMid = Colors.white60;
  static const textLow = Colors.white38;
}

class AppRadii {
  static const card = 12.0;
  static const sheet = 22.0;
  static const pill = 999.0;
}
```

- [ ] **Step 2: 전체 테스트 green 확인(치환 전 기준선)**

Run: `C:/src/flutter/bin/flutter.bat test`
Expected: All tests passed! (159)

- [ ] **Step 3: home_screen.dart 색 리터럴을 토큰으로 치환**

`home_screen.dart` 상단에 `import '../theme/app_theme.dart';` 추가 후, 색 리터럴 1:1 치환(값 동일):
`Color(0xFF0E0F13)`→`AppColors.bg`, `Color(0xFF171922)`→`AppColors.surface`,
`Color(0xFF39D98A)`→`AppColors.done`, `Color(0xFF6C8CFF)`→`AppColors.now`,
`Color(0xFF3A3F55)`→`AppColors.locked`, `Colors.white60`→`AppColors.textMid`,
`Colors.white38`→`AppColors.textLow`. **레이아웃/텍스트/키 변경 없음.**

- [ ] **Step 4: 전체 테스트 + analyze green 확인(치환 후 동일)**

Run: `C:/src/flutter/bin/flutter.bat test` → All tests passed! (159)
Run: `C:/src/flutter/bin/flutter.bat analyze` → No issues found!

- [ ] **Step 5: Commit**

```bash
git add app/lib/theme/app_theme.dart app/lib/lesson/home_screen.dart
git commit -m "UI1 — 디자인 토큰 app_theme.dart 추출 + 홈 치환(픽셀 동일)"
git push
```

---

## Task 2: 홈 여정 맵 (`LessonMap`) — 5블록 바 교체

**Files:**
- Modify: `app/lib/progression/progression_state.dart` (slots getter)
- Create: `app/lib/lesson/lesson_map.dart`
- Create: `app/test/lesson_map_widget_test.dart`
- Modify: `app/lib/lesson/home_screen.dart` (`_ProgressBlocks` → `LessonMap`)
- Modify: `app/test/home_screen_widget_test.dart` (H3 갱신)

- [ ] **Step 1: Progression에 slots getter 추가 (먼저, 맵이 블록 정보 필요)**

`progression_state.dart`의 `int get total => _manifest.length;` 아래에 추가:

```dart
  /// UI — 여정 맵용 읽기 전용 슬롯 뷰(블록·인덱스 표시).
  List<PathSlot> get slots => List.unmodifiable(_manifest);
```

- [ ] **Step 2: 실패 테스트 작성 — 맵 노드 상태 매핑**

```dart
// app/test/lesson_map_widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/lesson_map.dart';
import 'package:vocal_athlete/progression/progression_state.dart';
import 'package:vocal_athlete/progression/path.dart';

void main() {
  Widget host(Progression p) => MaterialApp(
        home: Scaffold(body: LessonMap(progression: p)),
      );

  testWidgets('LM1 맵 렌더 + 섹션 라벨(토대·졸업) 존재', (tester) async {
    await tester.pumpWidget(host(Progression.beginner()));
    expect(find.byKey(const Key('lesson-map')), findsOneWidget);
    expect(find.text('토대'), findsOneWidget);
    expect(find.text('졸업'), findsOneWidget);
  });

  testWidgets('LM2 완료/오늘/미래 노드 수 = currentIndex 정합', (tester) async {
    final p = Progression.from(buildPlaceholderManifest(), currentIndex: 3);
    await tester.pumpWidget(host(p));
    // 완료 노드 3개(인덱스 0..2), 오늘 1개(인덱스 3).
    expect(find.byKey(const Key('node-done')), findsNWidgets(3));
    expect(find.byKey(const Key('node-today')), findsOneWidget);
  });
}
```

- [ ] **Step 3: 실패 확인**

Run: `C:/src/flutter/bin/flutter.bat test test/lesson_map_widget_test.dart`
Expected: FAIL — `lesson_map.dart` / `LessonMap` 미존재(컴파일 에러).

- [ ] **Step 4: LessonMap 구현** (먼저 `app_theme.dart`의 `AppColors`에 `static const lockedSurface = Color(0xFF2C3142);` 추가 — 미래 노드가 사용)

```dart
// app/lib/lesson/lesson_map.dart
/// 홈 여정 맵 — 슬롯을 블록 섹션으로 묶어 세로로. 탭 불가(여정 시각화).
/// 완료=초록 ✓ / 오늘=파랑 ▶ / 미래=잠금 🔒. 상태는 currentIndex 기준.
library;

import 'package:flutter/material.dart';

import '../progression/progression_state.dart';
import '../theme/app_theme.dart';

class LessonMap extends StatelessWidget {
  const LessonMap({super.key = const Key('lesson-map'), required this.progression});

  final Progression progression;

  static const _blockLabels = ['토대', 'SOVT', '발성', '감각', '졸업'];

  String _label(int block) =>
      (block >= 1 && block <= _blockLabels.length) ? _blockLabels[block - 1] : '블록 $block';

  @override
  Widget build(BuildContext context) {
    final slots = progression.slots;
    final today = progression.currentIndex;
    // 블록별 슬롯 그룹(등장 순서 유지).
    final blocks = <int, List<int>>{};
    for (var i = 0; i < slots.length; i++) {
      blocks.putIfAbsent(slots[i].block, () => []).add(i);
    }
    final orderedBlocks = blocks.keys.toList()..sort();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final b in orderedBlocks) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 14, 4, 8),
              child: Text(
                _label(b),
                style: const TextStyle(
                    color: AppColors.textMid, fontSize: 12, letterSpacing: 1),
              ),
            ),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final i in blocks[b]!)
                  _Node(
                    state: i < today
                        ? _NodeState.done
                        : i == today
                            ? _NodeState.today
                            : _NodeState.future,
                    // 윈딩 느낌: 짝/홀로 좌우 여백.
                    offset: (i - blocks[b]!.first).isEven ? 0 : 28,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

enum _NodeState { done, today, future }

class _Node extends StatelessWidget {
  const _Node({required this.state, required this.offset});
  final _NodeState state;
  final double offset;

  @override
  Widget build(BuildContext context) {
    final (bg, border, glyph, glyphColor, key) = switch (state) {
      _NodeState.done => (
          const Color(0xFF1D3A2C),
          AppColors.done,
          '✓',
          AppColors.done,
          const Key('node-done')
        ),
      _NodeState.today => (
          AppColors.now,
          AppColors.now,
          '▶',
          Colors.white,
          const Key('node-today')
        ),
      _NodeState.future => (
          AppColors.surface,
          AppColors.lockedSurface,
          '🔒',
          AppColors.locked,
          const Key('node-future')
        ),
    };
    return Padding(
      padding: EdgeInsets.only(left: offset),
      child: Container(
        key: key,
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          border: Border.all(color: border, width: 2),
          boxShadow: state == _NodeState.today
              ? [BoxShadow(color: AppColors.now.withValues(alpha: 0.35), blurRadius: 10, spreadRadius: 2)]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(glyph, style: TextStyle(color: glyphColor, fontSize: 18)),
      ),
    );
  }
}
```

- [ ] **Step 5: 맵 테스트 green 확인**

Run: `C:/src/flutter/bin/flutter.bat test test/lesson_map_widget_test.dart`
Expected: PASS (LM1, LM2).

- [ ] **Step 6: 홈 H3 테스트 갱신(blocks → map)**

`home_screen_widget_test.dart` H3를 교체:

```dart
  testWidgets('H3 home shows streak + lesson map with section labels',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('home-streak')), findsOneWidget);
    expect(find.byKey(const Key('lesson-map')), findsOneWidget);
    expect(find.text('토대'), findsOneWidget);
    expect(find.text('졸업'), findsOneWidget);
  });
```

- [ ] **Step 7: 실패 확인(홈은 아직 blocks)**

Run: `C:/src/flutter/bin/flutter.bat test test/home_screen_widget_test.dart`
Expected: H3 FAIL — `lesson-map` 미발견(홈이 아직 `_ProgressBlocks`).

- [ ] **Step 8: 홈에서 `_ProgressBlocks`를 `LessonMap`으로 교체**

`home_screen.dart`:
- `import 'lesson_map.dart';` 추가.
- `// 5블록 진행도` 블록의 `_ProgressBlocks(progression: p)` + 뒤따르는 `const Spacer()`를
  다음으로 교체(맵이 가변 영역을 차지):

```dart
              // 여정 맵
              Expanded(child: LessonMap(progression: p)),
              const SizedBox(height: 12),
```

- 파일 하단의 `_ProgressBlocks` 클래스 전체 삭제(본 변경으로 미사용 — 고아 정리).

- [ ] **Step 9: 홈 + 전체 테스트 green**

Run: `C:/src/flutter/bin/flutter.bat test test/home_screen_widget_test.dart` → PASS(H1~H4)
Run: `C:/src/flutter/bin/flutter.bat test` → All tests passed!
Run: `C:/src/flutter/bin/flutter.bat analyze` → No issues found!

- [ ] **Step 10: Commit**

```bash
git add app/lib/progression/progression_state.dart app/lib/lesson/lesson_map.dart app/lib/lesson/home_screen.dart app/test/lesson_map_widget_test.dart app/test/home_screen_widget_test.dart
git commit -m "UI2 — 홈 5블록 바 → 여정 레슨맵(LessonMap), H3 갱신"
git push
```

---

## Task 3: 레슨 화면 폴리시 (토큰 + 스테퍼 강조 + cue 페이드)

**Files:**
- Modify: `app/lib/lesson/lesson_screen.dart`
- Test: `app/test/lesson_screen_widget_test.dart` (기존 보존 + 1 추가)

- [ ] **Step 1: 실패 테스트 — 단계 전환 시 현재 스테퍼 라벨 강조 확인**

`lesson_screen_widget_test.dart`에 추가(파일 상단 import에 `package:vocal_athlete/lesson/lesson_screen.dart` 이미 있음):

```dart
  testWidgets('LP1 진입 단계에서 진입 스테퍼가 now 상태(볼드)', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: LessonScreen(progression: Progression.beginner())));
    await tester.pumpAndSettle();
    final entry = tester.widget<Text>(find.text('진입·워밍업'));
    expect(entry.style?.fontWeight, FontWeight.w700);
  });
```

(현재 스테퍼는 '본운동'을 항상 now로 하드코딩 → 진입 단계인데 '진입·워밍업'이 w700이 아님 → 실패.)

- [ ] **Step 2: 실패 확인**

Run: `C:/src/flutter/bin/flutter.bat test test/lesson_screen_widget_test.dart --name LP1`
Expected: FAIL — fontWeight w400.

- [ ] **Step 3: 스테퍼를 `_step`에 연동 + 토큰 적용**

`lesson_screen.dart` 스테퍼 Row를 `_step` 기반으로:

```dart
            // 3단 스테퍼(진입·본운동·쿨다운) — 현재 단계 강조
            Padding(
              key: const Key('lesson-stepper'),
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 2),
              child: Row(
                children: [
                  _Step(
                      label: '진입·워밍업',
                      state: _stepStateFor(LessonStep.entry)),
                  const SizedBox(width: 8),
                  _Step(
                      label: '본운동 7–11분',
                      state: _stepStateFor(LessonStep.main)),
                  const SizedBox(width: 8),
                  _Step(
                      label: '쿨다운', state: _stepStateFor(LessonStep.cooldown)),
                ],
              ),
            ),
```

`_LessonScreenState`에 헬퍼 추가:

```dart
  _StepState _stepStateFor(LessonStep s) {
    if (s.index < _step.index) return _StepState.done;
    if (s.index == _step.index) return _StepState.now;
    return _StepState.next;
  }
```

`_Step`/`_StepState` 색 리터럴을 토큰으로(`AppColors.done/now/locked`). 파일 상단에
`import '../theme/app_theme.dart';` 추가.

- [ ] **Step 4: cue 페이드 — 단계 전환 시 부드럽게**

cue `Center`(`Key('lesson-cue')`)의 자식을 `AnimatedSwitcher`로 감싸 페이드(200ms). `_step`
변경 시 child의 `ValueKey(_step)`로 전환. 텍스트/키 보존:

```dart
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: KeyedSubtree(
                  key: ValueKey(_step),
                  child: Column( /* 기존 cue Column 그대로 */ ),
                ),
              ),
```

(AnimatedSwitcher는 유한 전환 → `pumpAndSettle` 안전.)

- [ ] **Step 5: 토큰 치환(나머지 색 리터럴)**

`lesson_screen.dart`의 `Color(0xFF0E0F13)`→`AppColors.bg`, `Color(0xFF171922)`→`AppColors.surface`,
`Color(0xFF39D98A)`→`AppColors.done`, `Color(0xFF222637)`→`AppColors.surfaceAlt`(이 토큰을 `AppColors`에 먼저 추가: `static const surfaceAlt = Color(0xFF222637);`),
`Color(0xFF3A3F55)`→`AppColors.locked`. 마이크 꺼짐 자리표시: `mic-off-notice` 텍스트 보존,
그 영역 배경을 `AppColors.surface`로 채워 덜 휑하게(레이아웃·키 불변).

- [ ] **Step 6: 레슨 테스트 + 전체 green**

Run: `C:/src/flutter/bin/flutter.bat test test/lesson_screen_widget_test.dart` → PASS(LP1 + 기존)
Run: `C:/src/flutter/bin/flutter.bat test` → All tests passed!
Run: `C:/src/flutter/bin/flutter.bat analyze` → No issues found!

- [ ] **Step 7: Commit**

```bash
git add app/lib/lesson/lesson_screen.dart app/test/lesson_screen_widget_test.dart
git commit -m "UI3 — 레슨 스테퍼 단계 연동·cue 페이드·토큰 적용"
git push
```

---

## Task 4: 졸업·장르픽·설정·피치 토큰 적용

**Files:**
- Modify: `graduation_screen.dart`, `settings_screen.dart`, `pitch/pitch_display.dart`
- Test: 기존 위젯 테스트(회귀 가드, 변경 없음)

순수 색 치환(동작·키·텍스트 불변) → 기존 테스트 green 유지로 검증.

- [ ] **Step 1: 세 파일 색 리터럴 → 토큰 치환**

각 파일 상단 `import '../theme/app_theme.dart';`(pitch_display는 `'../../theme/app_theme.dart'`).
공통 매핑 적용: `0xFF0E0F13`→`bg`, `0xFF171922`→`surface`, `0xFF39D98A`→`done`,
`0xFF6C8CFF`→`now`, `0xFF3A3F55`→`locked`, `Colors.white60`→`textMid`, `Colors.white38`→`textLow`.
졸업 3장르 버튼에 작은 일러스트 악센트 이모지 추가(예: 🎭 뮤지컬 / 🎼 성악 / 🎤 가요) — 버튼
`Key('genre-*')`·탭 동작·기존 텍스트 보존(이모지는 라벨 앞 접두만).

- [ ] **Step 2: 전체 테스트 + analyze green**

Run: `C:/src/flutter/bin/flutter.bat test` → All tests passed!
Run: `C:/src/flutter/bin/flutter.bat analyze` → No issues found!

- [ ] **Step 3: Commit**

```bash
git add app/lib/lesson/graduation_screen.dart app/lib/lesson/settings_screen.dart app/lib/lesson/pitch/pitch_display.dart
git commit -m "UI4 — 졸업·설정·피치 토큰 적용 + 장르 일러스트 악센트"
git push
```

---

## Task 5: 마이크로애니메이션 (테스트-안전, 한 번에 끝남)

**Files:**
- Modify: `app/lib/lesson/home_screen.dart`(시작 버튼 누름 스케일), `lesson_map.dart`(오늘 노드 등장 스케일-인)
- Test: `app/test/lesson_map_widget_test.dart`(애니 후 정착 확인)

⚠️ **무한 반복 애니메이션 금지**(`pumpAndSettle` 행 방지). 모두 **1회 실행 후 정착**.

- [ ] **Step 1: 실패 테스트 — 오늘 노드 등장 애니가 정착 후 표시 유지**

`lesson_map_widget_test.dart`에 추가:

```dart
  testWidgets('LM3 오늘 노드 등장 애니 정착 후에도 존재(pumpAndSettle 안전)',
      (tester) async {
    final p = Progression.from(buildPlaceholderManifest(), currentIndex: 2);
    await tester.pumpWidget(host(p));
    await tester.pumpAndSettle(); // 무한 반복이면 여기서 타임아웃
    expect(find.byKey(const Key('node-today')), findsOneWidget);
  });
```

- [ ] **Step 2: 실패 또는 통과 확인(기준선)**

Run: `C:/src/flutter/bin/flutter.bat test test/lesson_map_widget_test.dart --name LM3`
Expected: 현재는 애니 없음 → PASS(기준). (이 테스트는 이후 무한반복 회귀를 막는 가드.)

- [ ] **Step 3: 오늘 노드 등장 스케일-인(1회)**

`lesson_map.dart` `_Node`의 today 케이스 Container를 `TweenAnimationBuilder`로 1회 스케일-인:

```dart
    final child = Container(/* 기존 Container 그대로 */);
    if (state != _NodeState.today) return Padding(padding: EdgeInsets.only(left: offset), child: child);
    return Padding(
      padding: EdgeInsets.only(left: offset),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.85, end: 1.0),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutBack,
        builder: (_, s, c) => Transform.scale(scale: s, child: c),
        child: child,
      ),
    );
```

(`TweenAnimationBuilder`는 1회 후 정착 → `pumpAndSettle` 안전.)

- [ ] **Step 4: 시작 버튼 누름 스케일(홈)**

`home_screen.dart` `start-today` `FilledButton`을 누를 때 살짝 줄었다 복귀하는 효과는
`FilledButton` 기본 `InkWell` 피드백으로 충분 — 추가 구현 생략(YAGNI). 대신 버튼 `style`에
`animationDuration: const Duration(milliseconds: 120)` 지정(키·동작 불변).

- [ ] **Step 5: 맵 + 전체 테스트 green**

Run: `C:/src/flutter/bin/flutter.bat test test/lesson_map_widget_test.dart` → PASS(LM1~LM3)
Run: `C:/src/flutter/bin/flutter.bat test` → All tests passed!
Run: `C:/src/flutter/bin/flutter.bat analyze` → No issues found!

- [ ] **Step 6: Commit**

```bash
git add app/lib/lesson/lesson_map.dart app/lib/lesson/home_screen.dart app/test/lesson_map_widget_test.dart
git commit -m "UI5 — 테스트-안전 마이크로애니메이션(오늘 노드 스케일-인)"
git push
```

---

## 완료 기준 (전체)

- 홈이 `LessonMap`으로 렌더, 완료/오늘/미래 노드가 `currentIndex`와 정합, 시작/완료 동작 보존.
- 전 화면 토큰 기반 일관 다크 톤 + 장르 일러스트 악센트 + 절제된(정착하는) 마이크로애니메이션.
- 전 테스트 green(159 + 신규 LM1~LM3·LP1) + analyze 클린. 피치/진행/안전/키 동작 불변.


===== FILE: docs/superpowers/plans/2026-06-09-r4-home.md =====

# R4 단일 홈 (오늘-히어로 + 여정 미리보기) 구현 계획

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 홈을 R4 단일 화면(오늘 한 레슨 히어로 카드 + 오늘 중심 여정 미리보기 + 5블록 칩)으로 재구성한다. 탭바 없음.

**Architecture:** 기존 풀-스크롤 `LessonMap`을 컴팩트 `JourneyPreview`(오늘 ±2 노드 윈도우 + 블록 칩)로 대체하고, 오늘 프리뷰 카드+시작 버튼을 `TodayHero`로 통합한다. 위젯 Key 보존(home-screen·home-streak·start-today·today-done·home-settings·lesson-map). 마이크/진행/안전 로직 불변.

**Tech Stack:** Flutter 3.44 / Dart 3.12, flutter_test 위젯 테스트, 기존 `Progression`/`Card`/`AppColors`.

---

## 파일 구조

- Modify: `app/lib/theme/app_theme.dart` — `AppColors.streak` 토큰 추가(헤더 🔥 강조).
- Replace: `app/lib/lesson/lesson_map.dart` — `LessonMap`(풀 스크롤) → `JourneyPreview`(컴팩트).
- Replace: `app/test/lesson_map_widget_test.dart` — `JourneyPreview` 윈도우/칩 테스트로 이관.
- Create: `app/lib/lesson/today_hero.dart` — 오늘 히어로 카드.
- Create: `app/test/today_hero_widget_test.dart` — 히어로 단위 테스트.
- Modify: `app/lib/lesson/home_screen.dart` — 헤더+히어로+여정라벨+미리보기로 재조립.
- Modify: `app/test/home_screen_widget_test.dart` — H3를 JourneyPreview/블록 칩에 맞춰 갱신.

**검증 명령:** 단일 `C:/src/flutter/bin/flutter.bat test test/<file>.dart` · 전체 `C:/src/flutter/bin/flutter.bat test`(현재 166 green) · `C:/src/flutter/bin/flutter.bat analyze`(작업 디렉터리 `app/`).

---

## Task 1: JourneyPreview (LessonMap 대체) + streak 토큰

**Files:**
- Modify: `app/lib/theme/app_theme.dart`
- Replace: `app/lib/lesson/lesson_map.dart`
- Replace: `app/test/lesson_map_widget_test.dart`

- [ ] **Step 1: streak 토큰 추가**

`app_theme.dart` `AppColors`에 추가(헤더에서 사용):
```dart
  static const streak = Color(0xFFFF9F43); // 스트릭 🔥 강조
```

- [ ] **Step 2: 실패 테스트 작성 — JourneyPreview 윈도우/칩**

`app/test/lesson_map_widget_test.dart` 전체를 다음으로 교체:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/lesson_map.dart';
import 'package:vocal_athlete/progression/progression_state.dart';
import 'package:vocal_athlete/progression/path.dart';

void main() {
  Widget host(Progression p) =>
      MaterialApp(home: Scaffold(body: JourneyPreview(progression: p)));

  testWidgets('JP1 미리보기 + 블록 칩(토대·졸업) 존재', (tester) async {
    await tester.pumpWidget(host(Progression.beginner()));
    expect(find.byKey(const Key('lesson-map')), findsOneWidget);
    expect(find.text('토대'), findsOneWidget);
    expect(find.text('졸업'), findsOneWidget);
  });

  testWidgets('JP2 오늘 중심 윈도우 — currentIndex 3: 완료 2·오늘 1·미래 2',
      (tester) async {
    final p = Progression.from(buildPlaceholderManifest(), currentIndex: 3);
    await tester.pumpWidget(host(p));
    expect(find.byKey(const Key('node-done')), findsNWidgets(2));
    expect(find.byKey(const Key('node-today')), findsOneWidget);
    expect(find.byKey(const Key('node-future')), findsNWidgets(2));
  });

  testWidgets('JP3 시작점 currentIndex 0: 완료 0·오늘 1', (tester) async {
    final p = Progression.from(buildPlaceholderManifest(), currentIndex: 0);
    await tester.pumpWidget(host(p));
    expect(find.byKey(const Key('node-done')), findsNothing);
    expect(find.byKey(const Key('node-today')), findsOneWidget);
  });

  testWidgets('JP4 탭 불가(노드에 onTap/InkWell 없음)', (tester) async {
    await tester.pumpWidget(host(Progression.beginner()));
    expect(find.byType(InkWell), findsNothing);
    expect(find.byType(GestureDetector), findsNothing);
  });
}
```

- [ ] **Step 3: 실패 확인**

Run: `C:/src/flutter/bin/flutter.bat test test/lesson_map_widget_test.dart`
Expected: FAIL — `JourneyPreview` 미존재(컴파일 에러).

- [ ] **Step 4: lesson_map.dart 교체 — JourneyPreview 구현**

`app/lib/lesson/lesson_map.dart` 전체를 다음으로 교체:
```dart
/// 홈 여정 미리보기 — 오늘 ±2 노드 윈도우(완료/오늘/미래) + 5블록 칩. 탭 불가(시각화).
/// 풀 경로 조망은 블록 칩(macro), 지역 맥락은 노드 윈도우(micro)로 분담.
library;

import 'package:flutter/material.dart';

import '../progression/progression_state.dart';
import '../theme/app_theme.dart';

class JourneyPreview extends StatelessWidget {
  const JourneyPreview(
      {super.key = const Key('lesson-map'), required this.progression});

  final Progression progression;

  static const _blockLabels = ['토대', 'SOVT', '발성', '감각', '졸업'];

  String _blockLabel(int block) =>
      (block >= 1 && block <= _blockLabels.length) ? _blockLabels[block - 1] : '블록 $block';

  /// 오늘 중심 최대 5개 슬롯 인덱스 윈도우.
  List<int> _window(int today, int total) {
    if (total <= 0) return const [];
    var start = today - 2;
    if (start < 0) start = 0;
    var end = start + 5;
    if (end > total) {
      end = total;
      start = end - 5 < 0 ? 0 : end - 5;
    }
    return [for (var i = start; i < end; i++) i];
  }

  @override
  Widget build(BuildContext context) {
    final slots = progression.slots;
    final today = progression.currentIndex;
    final total = slots.length;
    final window = _window(today, total);

    // 블록별 슬롯 인덱스 → 칩 상태.
    final blocks = <int, List<int>>{};
    for (var i = 0; i < total; i++) {
      blocks.putIfAbsent(slots[i].block, () => []).add(i);
    }
    final orderedBlocks = blocks.keys.toList()..sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 노드 윈도우
        Container(
          height: 96,
          decoration: BoxDecoration(
            color: const Color(0xFF101117),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF1C2030)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final i in window)
                _Node(
                  state: i < today
                      ? _NodeState.done
                      : i == today
                          ? _NodeState.today
                          : _NodeState.future,
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // 블록 칩
        Row(
          children: [
            for (var k = 0; k < orderedBlocks.length; k++) ...[
              if (k > 0) const SizedBox(width: 6),
              Expanded(
                child: _BlockChip(
                  label: _blockLabel(orderedBlocks[k]),
                  state: _blockStateOf(blocks[orderedBlocks[k]]!, today),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  _NodeState _blockStateOf(List<int> indices, int today) {
    if (indices.every((i) => i < today)) return _NodeState.done;
    if (indices.contains(today)) return _NodeState.today;
    return _NodeState.future;
  }
}

enum _NodeState { done, today, future }

class _Node extends StatelessWidget {
  const _Node({required this.state});
  final _NodeState state;

  @override
  Widget build(BuildContext context) {
    final ({Color bg, Color border, String glyph, Color glyphColor, Key key, double size})
        v = switch (state) {
      _NodeState.done => (
          bg: AppColors.doneSurface, border: AppColors.done, glyph: '✓',
          glyphColor: AppColors.done, key: const Key('node-done'), size: 34),
      _NodeState.today => (
          bg: AppColors.now, border: AppColors.now, glyph: '▶',
          glyphColor: Colors.white, key: const Key('node-today'), size: 46),
      _NodeState.future => (
          bg: AppColors.surface, border: AppColors.lockedSurface, glyph: '🔒',
          glyphColor: AppColors.textLow, key: const Key('node-future'), size: 34),
    };
    return Container(
      key: v.key,
      width: v.size,
      height: v.size,
      decoration: BoxDecoration(
        color: v.bg,
        shape: BoxShape.circle,
        border: Border.all(color: v.border, width: 2),
        boxShadow: state == _NodeState.today
            ? [
                BoxShadow(
                    color: AppColors.now.withValues(alpha: 0.30),
                    blurRadius: 9, spreadRadius: 2)
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: Text(v.glyph, style: TextStyle(color: v.glyphColor, fontSize: 16)),
    );
  }
}

class _BlockChip extends StatelessWidget {
  const _BlockChip({required this.label, required this.state});
  final String label;
  final _NodeState state;

  @override
  Widget build(BuildContext context) {
    final (bg, fg, suffix) = switch (state) {
      _NodeState.done => (AppColors.doneSurface, AppColors.done, ' ✓'),
      _NodeState.today => (const Color(0xFF11203A), AppColors.now, ''),
      _NodeState.future => (const Color(0xFF15171F), const Color(0xFF566179), ''),
    };
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: state == _NodeState.today
            ? Border.all(color: const Color(0xFF2B3A60))
            : null,
      ),
      alignment: Alignment.center,
      child: Text('$label$suffix',
          style: TextStyle(color: fg, fontSize: 10, fontWeight: FontWeight.w600)),
    );
  }
}
```

- [ ] **Step 5: 테스트 green 확인**

Run: `C:/src/flutter/bin/flutter.bat test test/lesson_map_widget_test.dart`
Expected: PASS (JP1~JP4).

- [ ] **Step 6: Commit**

```bash
git add app/lib/theme/app_theme.dart app/lib/lesson/lesson_map.dart app/test/lesson_map_widget_test.dart
git commit -m "R4-1 — LessonMap → JourneyPreview(오늘 윈도우+블록 칩)·streak 토큰

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
git push
```

(주: 이 시점에 `home_screen.dart`는 아직 `LessonMap`을 참조 → 컴파일 깨짐. Task 3에서 해소. 전체 `flutter test`는 Task 3 후 실행.)

---

## Task 2: TodayHero 위젯

**Files:**
- Create: `app/lib/lesson/today_hero.dart`
- Create: `app/test/today_hero_widget_test.dart`

- [ ] **Step 1: 실패 테스트 작성**

`app/test/today_hero_widget_test.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/today_hero.dart';
import 'package:vocal_athlete/progression/progression_state.dart';

void main() {
  Widget host(Progression p, {VoidCallback? onStart}) => MaterialApp(
      home: Scaffold(body: TodayHero(progression: p, onStart: onStart ?? () {})));

  testWidgets('TH1 오늘 — 제목(anatomyMain)·시작 버튼 활성', (tester) async {
    await tester.pumpWidget(host(Progression.beginner()));
    expect(find.textContaining('6점 정렬 관찰'), findsOneWidget); // CARD-01 anatomyMain
    final btn = tester.widget<FilledButton>(find.byKey(const Key('start-today')));
    expect(btn.onPressed, isNotNull);
  });

  testWidgets('TH2 시작 탭 → onStart 호출', (tester) async {
    var tapped = false;
    await tester.pumpWidget(host(Progression.beginner(), onStart: () => tapped = true));
    await tester.tap(find.byKey(const Key('start-today')));
    expect(tapped, isTrue);
  });

  testWidgets('TH3 오늘 완료 — today-done 표시·시작 비활성', (tester) async {
    final p = Progression.beginner()..completeLesson();
    await tester.pumpWidget(host(p));
    expect(find.byKey(const Key('today-done')), findsOneWidget);
    final btn = tester.widget<FilledButton>(find.byKey(const Key('start-today')));
    expect(btn.onPressed, isNull);
  });
}
```

- [ ] **Step 2: 실패 확인**

Run: `C:/src/flutter/bin/flutter.bat test test/today_hero_widget_test.dart`
Expected: FAIL — `TodayHero` 미존재.

- [ ] **Step 3: TodayHero 구현**

`app/lib/lesson/today_hero.dart`:
```dart
/// 홈 오늘 히어로 — 오늘 한 레슨을 전면 카드로(라벨·제목·cue·칩·시작). 완료 시 초록·체크·비활성.
library;

import 'package:flutter/material.dart';

import '../progression/progression_state.dart';
import '../theme/app_theme.dart';
import 'lesson_instance.dart';

class TodayHero extends StatelessWidget {
  const TodayHero({super.key, required this.progression, required this.onStart});

  final Progression progression;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final p = progression;
    final instance = resolveLessonInstance(p.todaysLesson, p.day);
    final card = instance.card;
    final done = p.didToday;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: done
              ? const [Color(0xFF13251C), Color(0xFF101A15)]
              : const [Color(0xFF1B2030), AppColors.surface],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: done ? AppColors.doneSurface : const Color(0xFF262B3B)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            done ? '오늘 완료' : '오늘의 레슨',
            key: done ? const Key('today-done') : null,
            style: TextStyle(
                color: done ? AppColors.done : AppColors.textLow,
                fontSize: 11,
                letterSpacing: 2),
          ),
          const SizedBox(height: 9),
          Row(
            children: [
              if (done) ...[
                Container(
                  width: 34, height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.doneSurface,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.done, width: 2),
                  ),
                  alignment: Alignment.center,
                  child: const Text('✓',
                      style: TextStyle(color: AppColors.done, fontSize: 17)),
                ),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: Text(card.anatomyMain,
                    style: const TextStyle(
                        color: AppColors.textHi,
                        fontSize: 26,
                        fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            done
                ? '오늘 레슨 끝 — 내일 또.'
                : (card.cue.isNotEmpty ? card.cue.first : ''),
            style: const TextStyle(color: AppColors.textMid, fontSize: 13),
          ),
          if (!done) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                if (instance.hasVoicedMicroWin)
                  _chip('● ${card.voicedMicroWin.first}', AppColors.done,
                      AppColors.doneSurface),
                if (instance.hasVoicedMicroWin) const SizedBox(width: 8),
                _chip('7–11분', AppColors.textMid, AppColors.surfaceAlt),
              ],
            ),
          ],
          const SizedBox(height: 18),
          SizedBox(
            height: 52,
            child: FilledButton(
              key: const Key('start-today'),
              onPressed: done ? null : onStart,
              style: FilledButton.styleFrom(
                  animationDuration: const Duration(milliseconds: 120)),
              child: Text(done ? '오늘 완료' : '오늘 시작 →',
                  style:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String text, Color fg, Color bg) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
        child: Text(text,
            style: TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w600)),
      );
}
```

- [ ] **Step 4: 테스트 green**

Run: `C:/src/flutter/bin/flutter.bat test test/today_hero_widget_test.dart`
Expected: PASS (TH1~TH3).

- [ ] **Step 5: Commit**

```bash
git add app/lib/lesson/today_hero.dart app/test/today_hero_widget_test.dart
git commit -m "R4-2 — TodayHero 히어로 카드(오늘/완료 상태)

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
git push
```

---

## Task 3: 홈 재조립 (헤더 + 히어로 + 여정 라벨 + 미리보기)

**Files:**
- Modify: `app/lib/lesson/home_screen.dart`
- Modify: `app/test/home_screen_widget_test.dart` (H3 갱신)

- [ ] **Step 1: H3 갱신 — JourneyPreview/블록 칩 기준**

`home_screen_widget_test.dart` H3를 다음으로 교체(키·블록 칩 라벨 검증):
```dart
  testWidgets('H3 home shows streak + journey preview with block chips',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('home-streak')), findsOneWidget);
    expect(find.byKey(const Key('lesson-map')), findsOneWidget);
    expect(find.text('토대'), findsOneWidget);
    expect(find.text('졸업'), findsOneWidget);
  });
```

- [ ] **Step 2: 실패 확인(아직 옛 레이아웃)**

Run: `C:/src/flutter/bin/flutter.bat test test/home_screen_widget_test.dart`
Expected: 컴파일 에러(home가 LessonMap 참조) 또는 H3 실패.

- [ ] **Step 3: home_screen.dart 재조립**

`app/lib/lesson/home_screen.dart`의 import에서 `import 'lesson_map.dart';`를 유지(이름은 JourneyPreview로 사용)하고 `import 'today_hero.dart';` 추가. `build`의 `body` 안 `Padding`의 `child` Column 전체를 다음으로 교체:
```dart
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 헤더 — 날짜·현재 블록 / 스트릭 + 설정
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('🔥 ${p.streak}',
                            key: const Key('home-streak'),
                            style: const TextStyle(
                                color: AppColors.streak,
                                fontSize: 16,
                                fontWeight: FontWeight.w800)),
                      ],
                    ),
                    IconButton(
                      key: const Key('home-settings'),
                      onPressed: onSettings,
                      icon: const Icon(Icons.settings, color: AppColors.textLow),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TodayHero(progression: p, onStart: onStart),
                const SizedBox(height: 22),
                // 여정 라벨
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('여정',
                          style: TextStyle(
                              color: AppColors.textMid, fontSize: 11, letterSpacing: 1)),
                      Text(
                          '${p.currentIndex + 1} / ${p.total} · 졸업까지 ${p.total - p.currentIndex - 1}',
                          style: const TextStyle(
                              color: AppColors.textMid, fontSize: 11)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                JourneyPreview(progression: p),
                const SizedBox(height: 8),
              ],
            ),
          ),
```
또한 `build` 상단의 미사용이 된 지역변수를 제거: `final instance = resolveLessonInstance(p.todaysLesson, p.day);` 와 `final card = instance.card;`(이제 TodayHero가 자체 계산 → 미사용 경고 방지). 그에 따라 `import 'lesson_instance.dart';`도 home에서 미사용이면 제거.

(주: 기존 `LessonMap`/`_ProgressBlocks` 참조·옛 프리뷰 카드·별도 start 버튼·today-done은 전부 제거됨 — 시작/완료/today-done은 이제 `TodayHero` 안. `home_screen.dart` 상단 docstring의 "5블록 진행도" 문구는 "여정 미리보기"로 갱신.)

- [ ] **Step 4: 홈 + 전체 테스트 green**

Run: `C:/src/flutter/bin/flutter.bat test test/home_screen_widget_test.dart` → H1·H2·H3·H4 PASS
Run: `C:/src/flutter/bin/flutter.bat test` → All tests passed! (166 → 167: +JP/TH 신규 4+3 −기존 LM 5 등 변동, 최종 수는 실행으로 확인)
Run: `C:/src/flutter/bin/flutter.bat analyze` → No issues found!

- [ ] **Step 5: Commit**

```bash
git add app/lib/lesson/home_screen.dart app/test/home_screen_widget_test.dart
git commit -m "R4-3 — 홈 재조립(헤더·TodayHero·여정 라벨·JourneyPreview), 탭바 없음

Co-Authored-By: Claude Opus 4.8 (1M context) <noreply@anthropic.com>"
git push
```

---

## Task 4: 최종 검증

**Files:** (없음 — 검증만)

- [ ] **Step 1: 전체 스위트 + analyze**

Run: `C:/src/flutter/bin/flutter.bat test` → All tests passed!
Run: `C:/src/flutter/bin/flutter.bat analyze` → No issues found!

- [ ] **Step 2: 키 보존·미사용 토큰 0 확인**

- 보존 키 grep: `home-screen`·`home-streak`·`start-today`·`today-done`·`home-settings`·`lesson-map`·`node-done`·`node-today`·`node-future` 각각 ≥1.
- `AppColors` 각 토큰(특히 신규 `streak`) ≥1 사용 확인(미사용 0).

- [ ] **Step 3: 잔여 참조 정리 확인**

- `grep -rn "LessonMap" app/lib app/test` → 0(전부 JourneyPreview로 대체).
- `_ProgressBlocks` 잔재 0(이전 PR에서 제거됨, 재확인).

---

## 완료 기준 (전체)

- 홈이 R4 단일 화면(헤더·TodayHero·여정 라벨·JourneyPreview, 탭바 없음)으로 렌더.
- 오늘/완료 상태 정확(start-today 활성/비활성, today-done), 여정 미리보기 윈도우가 currentIndex와 정합, 블록 칩 5개(토대~졸업) 상태 정확.
- 전 테스트 green + analyze 클린. 피치/진행/안전 로직·보존 키 불변. 미사용 토큰 0.


############################################################
# APP SOURCE (app/lib)
############################################################


===== FILE: app/lib/lesson/card.dart =====

/// C2 — 레슨 카드 모델(ADR-0015 핵심 필드).
///
/// V1 minimal: id + cue(지시문) + voicedMicroWin. anatomy/feedback/antiPatterns
/// /variableAxes/stopCues는 소비자 슬라이스(U3/U4/U5/C3)가 추가(YAGNI).
library;

/// I1 — 안전 검토 상태(HITL-SIGNOFF). pending = 발성 전문가 사인오프 전이라
/// 기본 잠금(belt·트웽·패사지오처리·cover·messa·런). none = 안전 검토 불요.
enum SafetyReview { none, pending }

class Card {
  const Card({
    required this.id,
    required this.cue,
    required this.voicedMicroWin,
    this.anatomyEntry = '',
    this.anatomyMain = '',
    this.anatomyCooldown = '',
    this.variableAxes = const {},
    this.safetyReview = SafetyReview.none,
  });

  final String id;
  final List<String> cue;
  final List<String> voicedMicroWin;
  // U3 — 레슨 해부 (ADR-0015). cards.md anatomy{entry,main,cooldown}.
  final String anatomyEntry;
  final String anatomyMain;
  final String anatomyCooldown;
  // C3 — 변주축(ADR-0015 variableAxes). 키=축, 값=후보 리스트. 비면 변주 없음.
  final Map<String, List<String>> variableAxes;
  // I1 — 안전 게이트(자가 승인 ❌). pending이면 사인오프 전 잠금(I5).
  final SafetyReview safetyReview;
}


===== FILE: app/lib/lesson/card_library.dart =====

/// C2 — 13 IN 카드 라이브러리 + 리졸버.
///
/// 소스: docs/curriculum/beginner/cards.md (C1 산출물, 발성안전 사인오프).
/// 변주 엔진(C3)은 본 슬라이스 밖 — 여기는 단순 lookup.
library;

import 'card.dart';
import '../progression/path.dart';
import '../safety/safety_signoff.dart';

const Map<String, Card> kCardLibrary = {
  'CARD-01': Card(
    id: 'CARD-01',
    cue: [
      '바닥/의자에 편하게.',
      '턱·어깨 힘 빼기.',
      '6점 균형 의식만 — 움직이지 않기.',
    ],
    voicedMicroWin: ['끝에 편한 /m/ 3회(각 2–3초)'],
    anatomyEntry: '가벼운 신체 스캔',
    anatomyMain: '6점 정렬 관찰',
    anatomyCooldown: '느린 호흡 3회',
    variableAxes: {
      'sessionPos': ['워밍업', '본'],
    },
  ),
  'CARD-02': Card(
    id: 'CARD-02',
    cue: [
      '코로 천천히 들이쉬고 늑골·배가 같이 부풀게.',
      '배만으로 ❌, 늑골도.',
      '내쉴 때 어깨 ❌.',
    ],
    voicedMicroWin: ['voiced 한숨 /h→a/ 3회(음정 안 정함)'],
    anatomyEntry: '무음 호흡 관찰',
    anatomyMain: '늑골-복부 결합 호흡',
    anatomyCooldown: '느린 날숨 연장',
    variableAxes: {
      'sessionPos': ['워밍업', '본'],
    },
  ),
  'CARD-03': Card(
    id: 'CARD-03',
    cue: [
      '턱을 무겁게 떨어뜨리기.',
      '혀 뿌리 내려놓기.',
      'silent ah 후 가벼운 voiced ah.',
    ],
    voicedMicroWin: ['가벼운 /a/ 3회(편한 중음)'],
    anatomyEntry: '턱·혀 풀기',
    anatomyMain: 'silent ah → voiced ah',
    anatomyCooldown: '하품-한숨 1회',
    variableAxes: {
      'sessionPos': ['워밍업', '본'],
    },
  ),
  'CARD-04': Card(
    id: 'CARD-04',
    cue: [
      '치지 말고 숨을 흘려보내듯 /h/.',
      '/h/에 가볍게 소리 얹기 → /m/.',
      '크게 ❌, 편하게.',
    ],
    voicedMicroWin: ['/h/-led 부드러운 onset 5회'],
    anatomyEntry: '무성 호기 3회',
    anatomyMain: '/h/→/m/ easy onset',
    anatomyCooldown: '가벼운 /m/ 하행',
    variableAxes: {
      'range': ['편한 중음', '약간 낮게'],
      'sessionPos': ['워밍업', '본'],
    },
  ),
  'CARD-05': Card(
    id: 'CARD-05',
    cue: [
      '짧게 소리 내고 멈춰 듣기.',
      '내 느낌 말고 화면 곡선을 보기.',
      '(블록4) 균형/과기식/과압착 중 어디로 보이는지 표시.',
    ],
    voicedMicroWin: ['편한 음 2–3초 발성 후 시각 곡선 확인 3회'],
    anatomyEntry: '짧은 발성',
    anatomyMain: '발성→시각 곡선 대조',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'range': ['중음', '약간 높/낮'],
      'vowel': ['a', 'i', 'u'],
    },
  ),
  'CARD-06': Card(
    id: 'CARD-06',
    cue: [
      '5–6mm 빨대를 입술 안에 부드럽게.',
      '이로 물지 마세요.',
      '빨대로 /u/ 5초, 편한 중음.',
      '어지러우면 즉시 멈추세요.',
    ],
    voicedMicroWin: ['빨대 /u/ sustain 5초 × 3'],
    anatomyEntry: '무음 빨대 호기 1회',
    anatomyMain: '빨대 /u/ sustain 반복',
    anatomyCooldown: '빨대 빼고 /u/ 1회',
    variableAxes: {
      'range': ['중음', '±2도'],
      'vowel': ['u', 'a'],
    },
  ),
  'CARD-07': Card(
    id: 'CARD-07',
    cue: [
      '입술 힘 빼고 부르르 떨기.',
      '일정하게 유지.',
      '편한 음으로 5초.',
    ],
    voicedMicroWin: ['립 트릴 sustain 5초 × 3, 가벼운 글라이드 1회'],
    anatomyEntry: '무성 입술 트릴',
    anatomyMain: '유성 트릴 sustain·글라이드',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'range': ['중음', '±2도'],
      'glide': ['sustain', '작은 5도 글라이드'],
    },
  ),
  'CARD-08': Card(
    id: 'CARD-08',
    cue: [
      '입 다물고 /m/ 콧대 진동 느끼기.',
      '짜내지 말기.',
      '/ŋ/로 바꿔 같은 느낌.',
    ],
    voicedMicroWin: ['/m/ 5초 × 2, /ŋ/ 5초 × 2'],
    anatomyEntry: '가벼운 /m/',
    anatomyMain: '/m/·/ŋ/ sustain·작은 글라이드',
    anatomyCooldown: '하행 허밍',
    variableAxes: {
      'range': ['중음', '±3도'],
      'vowel': ['m', 'ŋ'],
      'glide': ['sustain', '글라이드'],
    },
  ),
  'CARD-09': Card(
    id: 'CARD-09',
    cue: [
      '컵 물에 빨대 1–2cm 담그기.',
      '버블 일정하게.',
      '약한 강도로 5초.',
    ],
    voicedMicroWin: ['물 버블 발성 5초 × 3'],
    anatomyEntry: '무음 버블 1회',
    anatomyMain: '유성 물 버블 반복',
    anatomyCooldown: '빨대 빼고 /u/ 1회',
    variableAxes: {
      'range': ['중음'],
      'glide': ['sustain'],
    },
  ),
  'CARD-10': Card(
    id: 'CARD-10',
    cue: [
      '숨 너무 새지도(과기식) 꽉 막지도(과압착) 않게.',
      '그 사이 편한 지점에서 5초.',
      '짜내지 말기.',
    ],
    voicedMicroWin: ['편한 음 sustain 5초 × 4'],
    anatomyEntry: '가벼운 onset',
    anatomyMain: '균형 지점 탐색 sustain',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'range': ['중음', '±3도'],
      'vowel': ['a', 'i', 'u'],
    },
  ),
  'CARD-11': Card(
    id: 'CARD-11',
    cue: [
      '편한 음 2초 녹음.',
      '재생을 듣기.',
      '방금 그 소리를 다시 따라하기.',
      '5회 반복.',
    ],
    voicedMicroWin: ['자기 녹음 모방 발성 5회'],
    anatomyEntry: '편한 음 1회',
    anatomyMain: '녹음→재생→재모방→시각 비교 5회',
    anatomyCooldown: '가벼운 /m/',
    variableAxes: {
      'range': ['중음', '±3도'],
      'vowel': ['a', 'u'],
    },
  ),
  'CARD-12': Card(
    id: 'CARD-12',
    cue: [
      '목표선을 보며 그 높이로 소리내기.',
      '곡선을 목표선에 붙이기.',
      '빗나가도 계속 — 다음에 가까이.',
    ],
    voicedMicroWin: ['목표음 매칭 발성 5회(각 3–5초)'],
    anatomyEntry: '가벼운 글라이드',
    anatomyMain: '피아노롤 목표선 매칭',
    anatomyCooldown: '하행 글라이드 1회',
    variableAxes: {
      'range': ['중음', '±3도', '약간 확장'],
      'vowel': ['a', 'i', 'u'],
      'glide': ['고정음', '작은 글라이드'],
    },
  ),
  'CARD-13': Card(
    id: 'CARD-13',
    cue: [
      '조용한 곳에서.',
      '/a/ /i/ /u/ 각 5초.',
      '표준 문장 1줄 읽기.',
      '/a/로 저→고→저 한 호흡.',
    ],
    voicedMicroWin: ['지속 모음 3종 + 글라이드 녹음(전체가 유성)'],
    anatomyEntry: '환경 확인',
    anatomyMain: '고정 과제 녹음',
    anatomyCooldown: '가벼운 허밍',
  ),

  // ===== 중급 코어 (intermediate-core, IC) =====
  'IC-01': Card(
    id: 'IC-01',
    cue: ['짜내지도 새지도 않게.', '그 사이 편한 지점에서 5초.', '화면 곡선으로 확인.'],
    voicedMicroWin: ['균형 지점 sustain 5초 × 4'],
    anatomyEntry: '가벼운 onset',
    anatomyMain: '과기식↔균형↔과압착 탐색',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'range': ['중음', '±2도'],
      'vowel': ['a', 'i', 'u'],
    },
  ),
  'IC-02': Card(
    id: 'IC-02',
    cue: ['빨대로 /u/ 또는 립 트릴 5초.', '이로 물지 마세요.', '일정한 굵기 유지.', '어지러우면 즉시 멈추세요.'],
    voicedMicroWin: ['SOVT sustain 5초 × 3'],
    anatomyEntry: '무음 호기 1회',
    anatomyMain: 'SOVT sustain·가벼운 글라이드',
    anatomyCooldown: '빨대 빼고 /u/ 1회',
    variableAxes: {
      'range': ['중음', '±3도'],
      'glide': ['sustain', '작은 글라이드'],
    },
  ),
  'IC-03': Card(
    id: 'IC-03',
    cue: ['① 가장 편한 음 최대한 길게.', '② /o/로 저→고 부드럽게.', '③ 고→저 부드럽게.', '④ 음별 최대 지속 — 짜내지 않게.'],
    voicedMicroWin: ['VFE 4과제 각 1회(저충격)'],
    anatomyEntry: '편한 음 1회',
    anatomyMain: 'knoll→글라이드→지속 4과제',
    anatomyCooldown: '가벼운 /m/',
    variableAxes: {
      'range': ['편한 중음', '약간 확장'],
    },
  ),
  'IC-04': Card(
    id: 'IC-04',
    cue: ['/h/로 숨 흘려보내듯 시작.', '/h/에 가볍게 소리 얹기.', '치지 말고 — 균형 onset이 유일 정답은 아님(편하게 탐색).'],
    voicedMicroWin: ['easy onset 5회'],
    anatomyEntry: '무성 호기 3회',
    anatomyMain: 'hard/balanced/breathy 대조',
    anatomyCooldown: '가벼운 /m/ 하행',
    variableAxes: {
      'onset': ['balanced', 'breathy'],
      'range': ['중음'],
    },
  ),
  'IC-05': Card(
    id: 'IC-05',
    cue: ['들숨 자세(흉곽 확장)를 노래하는 동안 유지.', '내쉴 때 한꺼번에 무너뜨리지 않기.'],
    voicedMicroWin: ['흡기자세 유지 발성 5초 × 3'],
    anatomyEntry: '늑골 확장 인지',
    anatomyMain: '흡기자세 유지 호기 antagonism',
    anatomyCooldown: '느린 날숨 연장',
    variableAxes: {
      'range': ['중음', '±2도'],
    },
  ),
  'IC-06': Card(
    id: 'IC-06',
    cue: ['빨대 /u/ 5초.', '빨대 빼고 같은 음 개모음(/a/)으로 이어가기.', '느낌 유지(carryover).'],
    voicedMicroWin: ['SOVT→개모음 carryover 5회'],
    anatomyEntry: '빨대 /u/ 1회',
    anatomyMain: 'SOVT→개모음 전이 반복',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'vowel': ['a', 'o', 'e'],
      'range': ['중음', '±2도'],
    },
  ),
  'IC-07': Card(
    id: 'IC-07',
    cue: ['같은 음에서 모음을 /i/↔/a/↔/u/로 천천히 바꾸기.', '밝기·울림 변화를 화면으로 관찰.', '(고소프라노 조정·belt 방향은 여기서 안 함).'],
    voicedMicroWin: ['모음 전환 sustain 5회'],
    anatomyEntry: '편한 음 1회',
    anatomyMain: 'R1:f0 관계 기초 관찰',
    anatomyCooldown: '하행 글라이드',
    variableAxes: {
      'vowel': ['i', 'a', 'u'],
      'range': ['중음', '±2도'],
    },
  ),
  'IC-08': Card(
    id: 'IC-08',
    cue: ['같은 문장을 또렷하게 vs 편하게 두 번.', '차이를 화면·감각으로 관찰.', '정답은 장르·증폭에 따라 다름 — 지금은 관찰만.'],
    voicedMicroWin: ['명료/효율 대조 발성 각 3회'],
    anatomyEntry: '편한 발성',
    anatomyMain: '명료도↔효율 대조 관찰',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'sessionPos': ['워밍업', '본'],
    },
  ),
  'IC-09': Card(
    id: 'IC-09',
    cue: ['삼킬 때(후두↑)와 하품 시작(후두↓) 느낌 비교.', '노래는 그 사이 편한 높이.', '(클래식 저·CCM 고 타깃은 분기에서).'],
    voicedMicroWin: ['중립 후두높이 sustain 5초 × 3'],
    anatomyEntry: '후두 높이 인지',
    anatomyMain: '중립 높이 통제변수 관찰',
    anatomyCooldown: '느린 호흡',
    variableAxes: {
      'range': ['중음'],
    },
  ),
  'IC-10': Card(
    id: 'IC-10',
    cue: ['/m/ 후 /a/로 — 비음이 빠지는지 관찰.', '트웽 = 입 안 좁힘(밝게), 콧소리 ❌.', '의도 nasality와 비의도 nasalization 구분.'],
    voicedMicroWin: ['/m/→/a/ 비음 분리 5회'],
    anatomyEntry: '가벼운 /m/',
    anatomyMain: '비음 ↔ 비비음 대조',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'vowel': ['m', 'a', 'i'],
      'range': ['중음'],
    },
  ),
  'IC-11': Card(
    id: 'IC-11',
    cue: ['저음→고음 사이렌으로 천천히.', '소리 질감이 바뀌는 구간을 관찰(없애려 하지 않기).', '(믹스·belt·cover 처리는 분기에서).'],
    voicedMicroWin: ['사이렌 글라이드 3회'],
    anatomyEntry: '가벼운 글라이드',
    anatomyMain: 'primo/secondo passaggio 존재·관찰',
    anatomyCooldown: '하행 사이렌 1회',
    variableAxes: {
      'range': ['중음', '±3도', '약간 확장'],
      'glide': ['사이렌', '작은 글라이드'],
    },
  ),
  'IC-12': Card(
    id: 'IC-12',
    cue: ['조용한 곳에서 같은 조건으로.', '/a/ /i/ /u/ 각 5초 + 표준 문장 1줄 + 저→고→저 글라이드.', '녹음 후 시각 곡선을 직전 회차와 비교(듣고 판단 ❌).'],
    voicedMicroWin: ['고정 과제 녹음 1세트(전체 유성)'],
    anatomyEntry: '환경·자세 확인',
    anatomyMain: '고정 과제 녹음→직전 회차 시각 A/B',
    anatomyCooldown: '가벼운 허밍',
  ),

  // ===== 중급 뮤지컬 분기 (intermediate-musical, IM) =====
  'IM-01': Card(
    id: 'IM-01',
    cue: ['이 음에서 이 느낌으로(흉성/두성 비율 설명 없이).', '저→고 한 호흡으로 부드럽게.', '갑자기 두꺼워지거나 얇아지지 않게.'],
    voicedMicroWin: ['믹스 글라이드 5회'],
    anatomyEntry: '가벼운 사이렌',
    anatomyMain: 'M1↔M2 연결(경험으로)',
    anatomyCooldown: '하행 글라이드',
    variableAxes: {
      'range': ['중음', '±3도'],
      'style': ['M1기반', 'M2기반'],
    },
  ),
  'IM-02': Card(
    id: 'IM-02',
    cue: ['오리·마녀 소리처럼 입 안을 좁혀 밝게.', '콧소리 ❌(트웽 = 입 안, 비음 아님).', '짧게 시작.'],
    voicedMicroWin: ['구강 트웽 발성 5회'],
    anatomyEntry: '가벼운 /a/',
    anatomyMain: '구강 AES 협착(밝게)',
    anatomyCooldown: '중립 모음 1회',
    variableAxes: {
      'vowel': ['a', 'e'],
      'range': ['중음'],
    },
    safetyReview: SafetyReview.pending,
  ),
  'IM-03': Card(
    id: 'IM-03',
    cue: ['코어에서 관찰한 전이 구간을 사이렌으로 통과.', '없애려 하지 말고 부드럽게 관리.', '고음으로 밀어붙이지 않기.'],
    voicedMicroWin: ['전이 구간 사이렌 통과 5회'],
    anatomyEntry: '중음 사이렌',
    anatomyMain: 'primo/secondo 전이 관리',
    anatomyCooldown: '하행 사이렌',
    variableAxes: {
      'range': ['중음', '±4도'],
      'glide': ['사이렌', '작은 글라이드'],
    },
    safetyReview: SafetyReview.pending,
  ),
  'IM-04': Card(
    id: 'IM-04',
    cue: ['올라가며 모음을 살짝 어둡게 돌리기(turning the vowel).', '특정 음에서 울림이 바뀌는 지점 관찰.', '억지로 누르지 않기.'],
    voicedMicroWin: ['모음 전환 글라이드 5회'],
    anatomyEntry: '편한 모음 1회',
    anatomyMain: 'H2가 R1 통과 지점 모음 조정',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'vowel': ['a→ɔ', 'e→ø'],
      'range': ['중고음'],
    },
  ),
  'IM-05': Card(
    id: 'IM-05',
    cue: ["'Hey!' 부르듯 짧게.", '밝게 — 크게 아님.', '짧게 끊어서, 지속하지 않기.', '조금이라도 아프면 즉시 멈춤.'],
    voicedMicroWin: ["call-based 'Hey!' 진입 3회(짧게)"],
    anatomyEntry: '가벼운 call',
    anatomyMain: 'call-based belt 진입만(보수적)',
    anatomyCooldown: '하행 글라이드·가벼운 SOVT',
    variableAxes: {
      'range': ['진입 음역 한정'],
    },
    safetyReview: SafetyReview.pending,
  ),
  'IM-06': Card(
    id: 'IM-06',
    cue: ['문장을 보통/뭉갬/정밀 3가지로.', '정밀 버전 채택.', '말하듯(chant) → 노래로 이어가기.'],
    voicedMicroWin: ['chant→sing 전이 3회'],
    anatomyEntry: '문장 말하기',
    anatomyMain: '3조건 대조→정밀 채택→chant→sing',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'sessionPos': ['워밍업', '본'],
    },
  ),
  'IM-07': Card(
    id: 'IM-07',
    cue: ['테크닉 1분 미만.', '새 호흡.', '텍스트를 말로 전달.', '같은 텍스트를 음정과 함께.', '3회 반복.'],
    voicedMicroWin: ['텍스트 말→노래 루프 3회'],
    anatomyEntry: '짧은 테크닉',
    anatomyMain: '말 전달→음정 전달 루프',
    anatomyCooldown: '느린 호흡',
    variableAxes: {
      'sessionPos': ['본'],
    },
  ),
  'IM-08': Card(
    id: 'IM-08',
    cue: ['녹음 후 가사가 또렷한지 화면·구조로 확인.', '듣고 판단하지 말고 시각/체크로.'],
    voicedMicroWin: ['명료도 점검 발성 3회'],
    anatomyEntry: '문장 1회',
    anatomyMain: '명료도 시각/구조 피드백',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'sessionPos': ['본'],
    },
  ),
  'IM-09': Card(
    id: 'IM-09',
    cue: ['평·경·격음 구분 — 경음은 과압 주의(짜내지 않기).', '종성 7대표음 또렷이.', '연음·비음화 자연스럽게.', '곡과 함께(고립 ❌).'],
    voicedMicroWin: ['딕션 적용 구절 3회'],
    anatomyEntry: '문장 말하기',
    anatomyMain: 'VOT·종성·연음 적용(곡 안)',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'sessionPos': ['본'],
    },
  ),
  'IM-10': Card(
    id: 'IM-10',
    cue: ['짧은 구절을 느리게 → 점점 빠르게.', '또렷함 유지되는 최대 템포까지만.', '무너지면 한 단계 늦춤.'],
    voicedMicroWin: ['패터 템포 램프 3단계'],
    anatomyEntry: '느린 구절',
    anatomyMain: '조음 템포 램프',
    anatomyCooldown: '턱 풀기',
    variableAxes: {
      'tempo': ['느림', '중간', '빠름'],
    },
  ),
  'IM-11': Card(
    id: 'IM-11',
    cue: ['이중모음은 첫 모음 길게·끝 모음 짧게.', 'r은 곡 스타일대로(미·영).', '또렷하되 과하지 않게.'],
    voicedMicroWin: ['영어 구절 딕션 3회'],
    anatomyEntry: '구절 말하기',
    anatomyMain: '이중모음/r 정책 적용',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'sessionPos': ['본'],
    },
  ),
  'IM-12': Card(
    id: 'IM-12',
    cue: ['legit 구절은 맑게.', 'belt-진입 구절은 짧고 밝게(크게 아님).', '풀 벨트로 끌지 않기(고급).'],
    voicedMicroWin: ['곡 구절 적용 1회(legit 또는 라이트 belt-진입)'],
    anatomyEntry: '테크닉 1분',
    anatomyMain: 'legit→라이트 belt-진입 구절',
    anatomyCooldown: '하행 글라이드·SOVT',
    variableAxes: {
      'difficulty': ['legit', '라이트 belt-진입'],
    },
    safetyReview: SafetyReview.pending,
  ),

  // ===== 중급 성악 분기 (intermediate-classical, CL) =====
  'CL-01': Card(
    id: 'CL-01',
    cue: ['올라가며 모음을 살짝 어둡게·둥글게.', '후두 누르기 ❌(모음·공간 조정만).', '진입까지만 — 고음 무리하지 않기.'],
    voicedMicroWin: ['cover 진입 글라이드 5회'],
    anatomyEntry: '중음 사이렌',
    anatomyMain: '패사지오 위 모음 둥글게(진입)',
    anatomyCooldown: '하행 사이렌·SOVT',
    variableAxes: {
      'range': ['중고음(진입 한정)'],
      'glide': ['사이렌'],
    },
    safetyReview: SafetyReview.pending,
  ),
  'CL-02': Card(
    id: 'CL-02',
    cue: ['올라갈수록 /a/를 /ɔ/ 쪽으로 살짝.', '모음 고정한 채 비명 ❌.', '저음에선 과한 조정 ❌.'],
    voicedMicroWin: ['모음 조정 글라이드 5회'],
    anatomyEntry: '편한 모음 1회',
    anatomyMain: 'f0 상승 시 모음 중립화',
    anatomyCooldown: '하행 글라이드',
    variableAxes: {
      'vowel': ['a→ɔ', 'e→ø'],
      'range': ['중고음'],
    },
  ),
  'CL-03': Card(
    id: 'CL-03',
    cue: ['밝되 먹먹하지 않게.', '둥글되 날카롭지 않게.', '두 느낌을 동시에.'],
    voicedMicroWin: ['chiaroscuro 균형 sustain 5초 × 3'],
    anatomyEntry: '편한 음 1회',
    anatomyMain: 'ring+공간 동시 균형 탐색',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'vowel': ['a', 'o', 'e'],
      'range': ['중음', '±2도'],
    },
  ),
  'CL-04': Card(
    id: 'CL-04',
    cue: ['울림이 모이는 지점을 화면으로 관찰.', '2.8–3.2kHz ring 맛보기.', 'placement(어디에 둔다) 식 은유 ❌.'],
    voicedMicroWin: ['ring 인지 sustain 5초 × 3'],
    anatomyEntry: '편한 음 1회',
    anatomyMain: "singer's formant 인지·맛보기",
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'range': ['중음', '±2도'],
    },
  ),
  'CL-05': Card(
    id: 'CL-05',
    cue: ['음과 음 사이 끊김 없이.', '자음으로 라인 끊지 않기.', '한 호흡 안에서 흐르게.'],
    voicedMicroWin: ['legato 라인 구절 3회'],
    anatomyEntry: '5음 글라이드',
    anatomyMain: '끊김 없는 라인(자음 흐름)',
    anatomyCooldown: '하행 글라이드',
    variableAxes: {
      'range': ['중음', '±3도'],
    },
  ),
  'CL-06': Card(
    id: 'CL-06',
    cue: ['순수 5모음(a·e·i·o·u) 또렷이.', '이중자음 길게.', '곡과 함께(고립 ❌).'],
    voicedMicroWin: ['이탈리아어 구절 딕션 3회'],
    anatomyEntry: '모음 말하기',
    anatomyMain: '순수모음·이중자음 적용(곡 안)',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'sessionPos': ['본'],
    },
  ),
  'CL-07': Card(
    id: 'CL-07',
    cue: ['움라우트(ü·ö) 입모양 정확히.', '자음군·종성 또렷이.', '곡과 함께.'],
    voicedMicroWin: ['독일어 구절 딕션 3회'],
    anatomyEntry: '모음 말하기',
    anatomyMain: '움라우트·자음군 적용(곡 안)',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'sessionPos': ['본'],
    },
  ),
  'CL-08': Card(
    id: 'CL-08',
    cue: ['한 음에서 천천히 부풀렸다(약→강) 줄이기(강→약).', '기초만 — 무리한 강세 ❌.', '편한 중음역에서.'],
    voicedMicroWin: ['messa di voce 기초 곡선 3회'],
    anatomyEntry: '편한 음 sustain',
    anatomyMain: '약→강→약 다이내믹 기초',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'range': ['편한 중음(기초 한정)'],
    },
    safetyReview: SafetyReview.pending,
  ),
  'CL-09': Card(
    id: 'CL-09',
    cue: ['legit 클래식 구절 맑게·둥글게.', 'legato 유지.', '풀 covered 고음·풀 messa 구절 ❌(고급).'],
    voicedMicroWin: ['아리아/리트 구절 적용 1회'],
    anatomyEntry: '테크닉 1분',
    anatomyMain: 'legit 클래식 구절 적용',
    anatomyCooldown: '하행 글라이드·SOVT',
    variableAxes: {
      'difficulty': ['리트 구절', '쉬운 아리아 구절'],
    },
  ),

  // ===== 중급 가요 분기 (intermediate-gayo, GY) =====
  'GY-01': Card(
    id: 'GY-01',
    cue: ['말하듯 편한 위치에서 시작.', '그대로 노래로 이어가기.', '지르지 않기(마이크가 음량 보완).'],
    voicedMicroWin: ['말→노래 전이 5회'],
    anatomyEntry: '문장 말하기',
    anatomyMain: '말소리 위치→노래 carryover',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'range': ['중음', '±2도'],
      'sessionPos': ['워밍업', '본'],
    },
  ),
  'GY-02': Card(
    id: 'GY-02',
    cue: ['이 음에서 이 느낌으로(비율 설명 없이).', '저→고 부드럽게.', '갑자기 두꺼워지거나 얇아지지 않게.'],
    voicedMicroWin: ['믹스 글라이드 5회'],
    anatomyEntry: '가벼운 사이렌',
    anatomyMain: 'M1↔M2 연결(경험으로)',
    anatomyCooldown: '하행 글라이드',
    variableAxes: {
      'range': ['중음', '±3도'],
      'style': ['M1기반', 'M2기반'],
    },
  ),
  'GY-03': Card(
    id: 'GY-03',
    cue: ['립버블(=립 트릴) 일정한 굵기로 5초.', '사이렌(글라이드) 저→고→저 부드럽게.', 'kkook = 짧고 단단하되 짜내지 않기(균형).'],
    voicedMicroWin: ['립버블·사이렌 각 3회'],
    anatomyEntry: '무음 호기 1회',
    anatomyMain: '산업명↔SOVT 워밍업(같은 운동)',
    anatomyCooldown: '빨대 빼고 /u/',
    variableAxes: {
      'range': ['중음', '±3도'],
      'glide': ['사이렌', 'sustain'],
    },
  ),
  'GY-04': Card(
    id: 'GY-04',
    cue: ['마녀 웃음·오리 소리처럼 입 안을 좁혀 밝게.', '콧소리 ❌(구강, 비음 아님).', '짧게 — 고음 지속 ❌.'],
    voicedMicroWin: ['구강 트웽 발성 5회'],
    anatomyEntry: '가벼운 /a/',
    anatomyMain: '구강 AES 협착(밝게)',
    anatomyCooldown: '중립 모음 1회',
    variableAxes: {
      'vowel': ['a', 'e'],
      'range': ['중음'],
    },
    safetyReview: SafetyReview.pending,
  ),
  'GY-05': Card(
    id: 'GY-05',
    cue: ['부르듯 짧게(call-based).', '밝게 — 크게 아님.', '끊어서, 지속하지 않기.', '조금이라도 아프면 즉시 멈춤.'],
    voicedMicroWin: ['call-based 진입 3회(짧게)'],
    anatomyEntry: '가벼운 call',
    anatomyMain: '라이트 belt 진입만(보수적)',
    anatomyCooldown: '하행 글라이드·SOVT',
    variableAxes: {
      'range': ['진입 음역 한정'],
    },
    safetyReview: SafetyReview.pending,
  ),
  'GY-06': Card(
    id: 'GY-06',
    cue: ['음을 느리게 정확히 굴리기.', '정확도 먼저, 속도는 나중.', '고음역 무리 런 ❌.'],
    voicedMicroWin: ['느린 런 패턴 3회'],
    anatomyEntry: '느린 3음 패턴',
    anatomyMain: '런 기초 정확도→템포',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'tempo': ['느림', '중간'],
      'range': ['중음'],
    },
    safetyReview: SafetyReview.pending,
  ),
  'GY-07': Card(
    id: 'GY-07',
    cue: ['평·경·격음 구분 — 경음은 과압 주의(짜내지 않기).', '종성 7대표음 또렷이.', '연음·비음화 자연스럽게.', '곡과 함께(고립 ❌).'],
    voicedMicroWin: ['딕션 적용 구절 3회'],
    anatomyEntry: '문장 말하기',
    anatomyMain: 'VOT·종성·연음 적용(곡 안)',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'sessionPos': ['본'],
    },
  ),
  'GY-08': Card(
    id: 'GY-08',
    cue: ['마이크가 음량 보완 — 과한 자음 타격 불필요.', '또렷하되 편하게.', '모니터·컴프레션 환경 인지.'],
    voicedMicroWin: ['증폭 전제 발성 3회'],
    anatomyEntry: '편한 발성',
    anatomyMain: '증폭 전제 명료도↔효율',
    anatomyCooldown: '가벼운 허밍',
    variableAxes: {
      'sessionPos': ['본'],
    },
  ),
  'GY-09': Card(
    id: 'GY-09',
    cue: ['스피치라이크 구절 편하게.', 'belt-진입 구절은 짧고 밝게(크게 ❌).', '풀 belt·고난도 런·고음 지속 구절 ❌(고급).'],
    voicedMicroWin: ['가요 구절 적용 1회(스피치라이크 또는 라이트 belt)'],
    anatomyEntry: '테크닉 1분',
    anatomyMain: '스피치라이크→라이트 belt 구절',
    anatomyCooldown: '하행 글라이드·SOVT',
    variableAxes: {
      'difficulty': ['스피치라이크', '라이트 belt-진입'],
    },
    safetyReview: SafetyReview.pending,
  ),
};

/// I5 — 안전 게이트 대상(safetyReview:pending) 카드 ID 집합.
/// 미사인오프(safetyApproved=false) 시 코스 manifest에서 제외(belt/cover 등 비활성).
/// W1 — pending 카드 중 *유효 사인오프가 없는* 것의 id 집합(=여전히 잠긴 카드).
/// signoff 인자 생략 시 체크인된 [kSafetySignoff](기본 빈)을 사용 → 빈 레코드면
/// 모든 pending 카드 잠금(하위 호환). 사람이 레코드에 항목을 추가하면 그 카드만 해제.
Set<String> safetyGatedCardIds([
  Map<String, SafetySignoff> signoff = kSafetySignoff,
]) =>
    {
      for (final e in kCardLibrary.entries)
        if (e.value.safetyReview == SafetyReview.pending &&
            !(signoff[e.key]?.isValid ?? false))
          e.key,
    };

/// PathSlot → Card 해석. V1 = 라이브러리 lookup.
/// 카드 미등록 시 ArgumentError(전수 가드 테스트 C2.3가 강제).
Card resolveCard(PathSlot slot) {
  final c = kCardLibrary[slot.cardId];
  if (c == null) {
    throw ArgumentError('Card not in library: ${slot.cardId}');
  }
  return c;
}


===== FILE: app/lib/lesson/graduation_screen.dart =====

/// U7 — 졸업 화면 + 장르 픽커 (P8 chooseGenre 진입).
///
/// 절벽 아닌 *전이*(ADR-0010). 비구속 — 픽 결과는 호출자(_AppShell)가 라우팅.
library;

import 'package:flutter/material.dart';

import '../progression/progression_state.dart';
import '../theme/app_theme.dart';

class GraduationScreen extends StatelessWidget {
  const GraduationScreen({super.key = const Key('graduation-screen'),
                          required this.onPick});

  final void Function(Genre) onPick;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.bg,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  '🎉 초급 완주!',
                  style: TextStyle(
                      color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                const Text(
                  '이어갈 장르를 골라요.',
                  style: TextStyle(color: Colors.white54, fontSize: 14),
                ),
                const SizedBox(height: 28),
                _GenreButton(
                    keyName: const Key('genre-musical'),
                    emoji: '🎭',
                    label: '뮤지컬',
                    onTap: () => onPick(Genre.musical)),
                const SizedBox(height: 10),
                _GenreButton(
                    keyName: const Key('genre-classical'),
                    emoji: '🎼',
                    label: '성악',
                    onTap: () => onPick(Genre.classical)),
                const SizedBox(height: 10),
                _GenreButton(
                    keyName: const Key('genre-gayo'),
                    emoji: '🎤',
                    label: '가요',
                    onTap: () => onPick(Genre.gayo)),
              ],
            ),
          ),
        ),
      );
}

class _GenreButton extends StatelessWidget {
  const _GenreButton({required this.keyName, required this.emoji, required this.label, required this.onTap});
  final Key keyName;
  final String emoji;
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: FilledButton(
          key: keyName,
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$emoji '),
              Text(label),
            ],
          ),
        ),
      );
}


===== FILE: app/lib/lesson/home_screen.dart =====

/// 홈 화면 — 매일 진입점(R4). 오늘 히어로 + 여정 미리보기. 탭바 없음.
///
/// ADR-0002 무납득: 설명·동기 카피 없음. ADR-0015: 사용자는 오늘 레슨을 고르지 않음.
library;

import 'package:flutter/material.dart';

import '../progression/progression_state.dart';
import '../theme/app_theme.dart';
import 'lesson_map.dart';
import 'today_hero.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key = const Key('home-screen'),
    required this.progression,
    required this.onStart,
    this.onSettings,
  });

  final Progression progression;
  final VoidCallback onStart;
  final VoidCallback? onSettings;

  @override
  Widget build(BuildContext context) {
    final p = progression;
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 헤더 — 스트릭 / 설정
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('🔥 ${p.streak}일',
                        key: const Key('home-streak'),
                        style: const TextStyle(
                            color: AppColors.streak,
                            fontSize: 16,
                            fontWeight: FontWeight.w800)),
                    IconButton(
                      key: const Key('home-settings'),
                      onPressed: onSettings,
                      icon: const Icon(Icons.settings, color: AppColors.textLow),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TodayHero(progression: p, onStart: onStart),
                const SizedBox(height: 22),
                // 여정 라벨
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('여정',
                          style: TextStyle(
                              color: AppColors.textMid,
                              fontSize: 11,
                              letterSpacing: 1)),
                      Text(
                          '${p.currentIndex + 1} / ${p.total} · 졸업까지 ${p.total - p.currentIndex - 1}',
                          style: const TextStyle(
                              color: AppColors.textMid, fontSize: 11)),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                JourneyPreview(progression: p),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


===== FILE: app/lib/lesson/lesson_instance.dart =====

/// LessonInstance — *오늘 학습자에게 보일* Card + 변주를 묶은 런타임 모델
/// (ADR-0015 LessonInstance = resolve(Card, PathSlot, day)).
///
/// Hybrid: `card` raw를 그대로 노출(escape hatch) + 파생 표면(`variationLabel`,
/// `hasVoicedMicroWin`)을 getter로. 라이브러리 lookup은 `resolveLessonInstance`가 흡수.
library;

import 'package:flutter/foundation.dart' show visibleForTesting;

import '../progression/path.dart';
import 'card.dart';
import 'card_library.dart';
import 'variation.dart';

class LessonInstance {
  const LessonInstance({
    required this.card,
    required this.slot,
    required this.day,
    required this.variation,
  });

  final Card card;
  final PathSlot slot;
  final int day;
  final Map<String, String> variation;

  /// "오늘: …" UI 라벨용. 빈 variation이면 빈 문자열.
  String get variationLabel =>
      variation.entries.map((e) => '${e.key}=${e.value}').join(' · ');

  bool get hasVoicedMicroWin => card.voicedMicroWin.isNotEmpty;
}

/// UI 단일 진입점 — PathSlot·day로 LessonInstance 도출. 내부에서 카드 lookup.
LessonInstance resolveLessonInstance(PathSlot slot, int day) =>
    buildLessonInstance(resolveCard(slot), slot, day);

/// 카드 주입 변형 — 테스트에서 가상 카드로 instance 구성할 때.
@visibleForTesting
LessonInstance buildLessonInstance(Card card, PathSlot slot, int day) =>
    LessonInstance(
      card: card,
      slot: slot,
      day: day,
      variation: selectVariation(card, slot, day),
    );


===== FILE: app/lib/lesson/lesson_map.dart =====

/// 홈 여정 미리보기 — 오늘 ±2 노드 윈도우(완료/오늘/미래) + 5블록 칩. 탭 불가(시각화).
/// 풀 경로 조망은 블록 칩(macro), 지역 맥락은 노드 윈도우(micro)로 분담.
library;

import 'package:flutter/material.dart';

import '../progression/progression_state.dart';
import '../theme/app_theme.dart';

class JourneyPreview extends StatelessWidget {
  const JourneyPreview(
      {super.key = const Key('lesson-map'), required this.progression});

  final Progression progression;

  static const _blockLabels = ['토대', 'SOVT', '발성', '감각', '졸업'];

  String _blockLabel(int block) =>
      (block >= 1 && block <= _blockLabels.length) ? _blockLabels[block - 1] : '블록 $block';

  /// 오늘 중심 최대 5개 슬롯 인덱스 윈도우.
  List<int> _window(int today, int total) {
    if (total <= 0) return const [];
    var start = today - 2;
    if (start < 0) start = 0;
    var end = start + 5;
    if (end > total) {
      end = total;
      start = end - 5 < 0 ? 0 : end - 5;
    }
    return [for (var i = start; i < end; i++) i];
  }

  @override
  Widget build(BuildContext context) {
    final slots = progression.slots;
    final today = progression.currentIndex;
    final total = slots.length;
    final window = _window(today, total);

    final blocks = <int, List<int>>{};
    for (var i = 0; i < total; i++) {
      blocks.putIfAbsent(slots[i].block, () => []).add(i);
    }
    final orderedBlocks = blocks.keys.toList()..sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 96,
          decoration: BoxDecoration(
            color: const Color(0xFF101117),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF1C2030)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final i in window)
                _Node(
                  state: i < today
                      ? _NodeState.done
                      : i == today
                          ? _NodeState.today
                          : _NodeState.future,
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            for (var k = 0; k < orderedBlocks.length; k++) ...[
              if (k > 0) const SizedBox(width: 6),
              Expanded(
                child: _BlockChip(
                  label: _blockLabel(orderedBlocks[k]),
                  state: _blockStateOf(blocks[orderedBlocks[k]]!, today),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  _NodeState _blockStateOf(List<int> indices, int today) {
    if (indices.every((i) => i < today)) return _NodeState.done;
    if (indices.contains(today)) return _NodeState.today;
    return _NodeState.future;
  }
}

enum _NodeState { done, today, future }

class _Node extends StatelessWidget {
  const _Node({required this.state});
  final _NodeState state;

  @override
  Widget build(BuildContext context) {
    final ({Color bg, Color border, String glyph, Color glyphColor, Key key, double size})
        v = switch (state) {
      _NodeState.done => (
          bg: AppColors.doneSurface, border: AppColors.done, glyph: '✓',
          glyphColor: AppColors.done, key: const Key('node-done'), size: 34),
      _NodeState.today => (
          bg: AppColors.now, border: AppColors.now, glyph: '▶',
          glyphColor: Colors.white, key: const Key('node-today'), size: 46),
      _NodeState.future => (
          bg: AppColors.surface, border: AppColors.lockedSurface, glyph: '🔒',
          glyphColor: AppColors.textLow, key: const Key('node-future'), size: 34),
    };
    return Container(
      key: v.key,
      width: v.size,
      height: v.size,
      decoration: BoxDecoration(
        color: v.bg,
        shape: BoxShape.circle,
        border: Border.all(color: v.border, width: 2),
        boxShadow: state == _NodeState.today
            ? [
                BoxShadow(
                    color: AppColors.now.withValues(alpha: 0.30),
                    blurRadius: 9, spreadRadius: 2)
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: Text(v.glyph, style: TextStyle(color: v.glyphColor, fontSize: 16)),
    );
  }
}

class _BlockChip extends StatelessWidget {
  const _BlockChip({required this.label, required this.state});
  final String label;
  final _NodeState state;

  @override
  Widget build(BuildContext context) {
    final (bg, fg, suffix) = switch (state) {
      _NodeState.done => (AppColors.doneSurface, AppColors.done, ' ✓'),
      _NodeState.today => (const Color(0xFF11203A), AppColors.now, ''),
      _NodeState.future => (const Color(0xFF15171F), const Color(0xFF566179), ''),
    };
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: state == _NodeState.today
            ? Border.all(color: const Color(0xFF2B3A60))
            : null,
      ),
      alignment: Alignment.center,
      child: Text('$label$suffix',
          style: TextStyle(color: fg, fontSize: 10, fontWeight: FontWeight.w600)),
    );
  }
}


===== FILE: app/lib/lesson/lesson_screen.dart =====

/// U1 — 레슨 화면 D 셸(채택안 D, 프로토 검증).
///
/// U3 — 단계 머신(진입/본운동/쿨다운) 도입. 시각 피치 = U4, "다시?" 넛지 = U5.
library;

import 'package:flutter/material.dart';

import '../progression/progression_state.dart';
import '../theme/app_theme.dart';
import 'lesson_instance.dart';
import 'pitch/pitch_display.dart';
import 'pitch/pitch_source.dart';

/// U3 — 레슨 단계 머신(진입→본운동→쿨다운).
enum LessonStep { entry, main, cooldown }

class LessonScreen extends StatefulWidget {
  const LessonScreen(
      {this.progression,
      this.onComplete,
      this.pitchSource,
      super.key = const Key('lesson-screen')});

  final Progression? progression;
  final VoidCallback? onComplete;
  final PitchSource? pitchSource;

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  LessonStep _step = LessonStep.entry;
  // _p가 변이형이라 widget.progression 참조 비교가 무용 — 카드ID 자체를 추적.
  String? _lastCardId;

  _StepState _stepStateFor(LessonStep s) {
    if (s.index < _step.index) return _StepState.done;
    if (s.index == _step.index) return _StepState.now;
    return _StepState.next;
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.progression;
    final instance =
        p == null ? null : resolveLessonInstance(p.todaysLesson, p.day);
    final card = instance?.card;
    final id = card?.id;
    if (id != null && _lastCardId != null && id != _lastCardId) {
      _step = LessonStep.entry;
    }
    _lastCardId = id;
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 헤더
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    p == null
                        ? ''
                        : '${p.todaysLesson.cardId} · ${p.currentIndex + 1}/${p.total}',
                    style:
                        const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Flexible(
                    child: Wrap(
                      alignment: WrapAlignment.end,
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        if (p != null)
                          _Pill(
                              key: const Key('streak'),
                              text: '🔥 ${p.streak}'),
                        if (p != null && p.maintenance)
                          const _Pill(
                              key: Key('maintenance-badge'), text: '유지 모드'),
                        if (instance != null && instance.hasVoicedMicroWin)
                          const _Pill(text: '● 유성'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 3단 스테퍼(진입·본운동·쿨다운) — 현재 단계 강조
            Padding(
              key: const Key('lesson-stepper'),
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 2),
              child: Row(
                children: [
                  _Step(label: '진입·워밍업', state: _stepStateFor(LessonStep.entry)),
                  const SizedBox(width: 8),
                  _Step(label: '본운동 7–11분', state: _stepStateFor(LessonStep.main)),
                  const SizedBox(width: 8),
                  _Step(label: '쿨다운', state: _stepStateFor(LessonStep.cooldown)),
                ],
              ),
            ),
            // cue 중앙 (C2: 실제 카드 cue로 배선)
            Expanded(
              child: Center(
                key: const Key('lesson-cue'),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: KeyedSubtree(
                    key: ValueKey(_step),
                    // 단계별 단일 콘텐츠 — 진입=워밍업만, 본=본 cue, 쿨다운=쿨다운(중첩 없음).
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: card == null
                          ? const SizedBox.shrink()
                          : Text(
                              switch (_step) {
                                LessonStep.entry => '워밍업: ${card.anatomyEntry}',
                                LessonStep.main => card.cue.join('\n'),
                                LessonStep.cooldown =>
                                  '쿨다운: ${card.anatomyCooldown}',
                              },
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _step == LessonStep.entry
                                    ? Colors.white70
                                    : Colors.white,
                                fontSize: _step == LessonStep.entry ? 18 : 21,
                                height: 1.5,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
            // 하단 시트
            Container(
              key: const Key('lesson-sheet'),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadii.sheet)),
              ),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.locked,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('본운동 · 7–11분',
                          style: TextStyle(color: Colors.white54)),
                      if (_step == LessonStep.main)
                        InkWell(
                          key: const Key('skip-cooldown'),
                          onTap: widget.onComplete,
                          borderRadius: BorderRadius.circular(AppRadii.pill),
                          child: const _Pill(text: '쿨다운 건너뛰기'),
                        ),
                    ],
                  ),
                  if (card != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      '● ${card.voicedMicroWin.first}',
                      style: const TextStyle(
                          color: AppColors.done, fontSize: 13),
                    ),
                  ],
                  if (_step == LessonStep.main &&
                      instance != null &&
                      instance.variation.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        '오늘: ${instance.variationLabel}',
                        key: const Key('today-variation'),
                        style: const TextStyle(
                            color: Colors.white54, fontSize: 12),
                      ),
                    ),
                  const SizedBox(height: 12),
                  // U4 — main 단계에서만 시각 피치 표시. 마이크 없으면 안내 한 줄.
                  if (_step == LessonStep.main) ...[
                    if (widget.pitchSource == null)
                      Container(
                        height: 110,
                        decoration: BoxDecoration(
                          color: AppColors.lockedSurface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          '🎤\n마이크 꺼짐 — 피치 표시 안 됨',
                          key: Key('mic-off-notice'),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white38, fontSize: 12),
                        ),
                      )
                    else
                      PitchDisplay(source: widget.pitchSource),
                  ] else
                    const SizedBox(height: 110),
                  const SizedBox(height: 12),
                  if (_step != LessonStep.cooldown) ...[
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        key: const Key('next-button'),
                        onPressed: () => setState(() {
                          _step = _step == LessonStep.entry
                              ? LessonStep.main
                              : LessonStep.cooldown;
                        }),
                        child: const Text('다음'),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      key: const Key('complete-button'),
                      onPressed: widget.onComplete,
                      child: const Text('완료'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _StepState { done, now, next }

class _Step extends StatelessWidget {
  const _Step({required this.label, required this.state});
  final String label;
  final _StepState state;
  @override
  Widget build(BuildContext context) {
    final color = switch (state) {
      _StepState.done => AppColors.done,
      _StepState.now => AppColors.now,
      _StepState.next => AppColors.locked,
    };
    return Expanded(
      child: Column(
        children: [
          Container(
              height: 5,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(3))),
          const SizedBox(height: 6),
          Text(label,
              style: TextStyle(
                  color: state == _StepState.now
                      ? Colors.white
                      : Colors.white38,
                  fontSize: 11,
                  fontWeight: state == _StepState.now
                      ? FontWeight.w700
                      : FontWeight.w400)),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text, super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.surfaceAlt,
          borderRadius: BorderRadius.circular(AppRadii.pill),
        ),
        child: Text(text,
            style: const TextStyle(color: Colors.white54, fontSize: 12)),
      );
}


===== FILE: app/lib/lesson/pitch/deviation.dart =====

/// U5b — 편차 분류 순수 모듈 (Flutter import 없음).
///
/// PitchSource readings에서 *지속적 큰 편차*를 감지 → 선택형 "다시?" 넛지
/// 트리거 신호로 사용. ADR-0002 정합: 정당화 없는 *지시 cue*만 노출 책임.
library;

import 'dart:math' as math;

import 'pitch_source.dart';

enum DeviationDirection { flat, sharp, none }

/// 12-TET cents from target. f0Hz·targetHz > 0 전제.
double centsFromTarget(double f0Hz, double targetHz) =>
    1200 * (math.log(f0Hz / targetHz) / math.ln2);

({bool nudge, DeviationDirection direction}) classifyDeviation(
  Iterable<PitchReading> recent, {
  required double targetHz,
  double severeCents = 100,
  int windowN = 5,
  int severeMin = 3,
}) {
  final voiced = recent
      .where((r) => r.f0Hz != null && r.f0Hz! > 0)
      .map((r) => centsFromTarget(r.f0Hz!, targetHz))
      .toList();
  if (voiced.isEmpty) {
    return (nudge: false, direction: DeviationDirection.none);
  }
  final window =
      voiced.length <= windowN ? voiced : voiced.sublist(voiced.length - windowN);
  final severe = window.where((c) => c.abs() > severeCents).toList();
  if (severe.length < severeMin) {
    return (nudge: false, direction: DeviationDirection.none);
  }
  final mean = severe.reduce((a, b) => a + b) / severe.length;
  final dir = mean > 0 ? DeviationDirection.sharp : DeviationDirection.flat;
  return (nudge: true, direction: dir);
}


===== FILE: app/lib/lesson/pitch/f0.dart =====

/// F0(기본 주파수) 검출 — 자기상관 기반(ADR-0014 pYIN 자리 V1).
///
/// 순수, no I/O. PitchSource 구현체(MicPitchSource)가 프레임마다 호출.
/// 비차단 피드백(ADR-0002)이라 완벽 정확도가 V1 게이트 아님 — 정직하게
/// 명확한 주기가 없으면 null(무음/무성).
library;

/// 모노 PCM 프레임에서 F0(Hz) 추정. 명확한 주기 없으면 null.
double? estimateF0(List<double> samples, int sampleRate,
    {double minHz = 70, double maxHz = 1000}) {
  final n = samples.length;
  if (n < 64) return null;

  // DC 제거.
  double mean = 0;
  for (final s in samples) {
    mean += s;
  }
  mean /= n;

  // 에너지 게이트(무음 skip).
  double energy = 0;
  for (final s in samples) {
    final v = s - mean;
    energy += v * v;
  }
  if (energy / n < 1e-6) return null;

  final maxLag = (sampleRate / minHz).floor().clamp(1, n - 1);
  final minLag = (sampleRate / maxHz).floor().clamp(1, maxLag);

  double bestCorr = 0;
  int bestLag = 0;
  for (var lag = minLag; lag <= maxLag; lag++) {
    double corr = 0;
    for (var i = 0; i + lag < n; i++) {
      corr += (samples[i] - mean) * (samples[i + lag] - mean);
    }
    if (corr > bestCorr) {
      bestCorr = corr;
      bestLag = lag;
    }
  }
  if (bestLag == 0 || bestCorr <= 0) return null;
  return sampleRate / bestLag;
}


===== FILE: app/lib/lesson/pitch/mic_pitch_source.dart =====

/// Task 5(A1) — 실 마이크 PitchSource 골격 (ADR-0014 pYIN 자리).
///
/// PCM 프레임 stream을 주입받아 각 프레임을 F0 검출 → PitchReading으로 변환.
/// 실 마이크 캡처(권한·오디오 패키지)는 이 `frames` stream을 채우는 *어댑터*가
/// 담당 — 본 클래스는 패키지 의존 없이 변환·라이프사이클만 책임(테스트 가능).
/// 골전도 착각 차단: 출력은 시각용 F0뿐(ADR-0014 honest, 저신뢰=null).
library;

import 'f0.dart';
import 'pitch_source.dart';

class MicPitchSource implements PitchSource {
  MicPitchSource({required this.frames, this.sampleRate = 16000});

  /// 마이크에서 들어오는 모노 PCM 프레임(정규화 [-1,1]).
  final Stream<List<double>> frames;
  final int sampleRate;

  @override
  Stream<PitchReading> get readings async* {
    var t = 0.0;
    await for (final frame in frames) {
      yield PitchReading(
        f0Hz: estimateF0(frame, sampleRate),
        timestampSec: t,
      );
      t += frame.length / sampleRate;
    }
  }

  // 실 마이크 캡처 시작/정지는 frames 어댑터가 처리 — 골격은 no-op success.
  // 권한 요청도 어댑터 책임(start가 Future<bool>인 이유).
  @override
  Future<bool> start() async => true;

  @override
  Future<void> stop() async {}

  @override
  void dispose() {}
}


===== FILE: app/lib/lesson/pitch/pcm.dart =====

/// A1 — PCM16 디코딩 (순수). 마이크 바이트 → 정규화 샘플.
library;

import 'dart:typed_data';

/// 리틀엔디언 int16 PCM 바이트를 [-1,1] 정규화 double 샘플로 변환.
/// 홀수 바이트 꼬리는 버림.
List<double> pcm16ToSamples(Uint8List bytes) {
  final n = bytes.length ~/ 2;
  final out = List<double>.filled(n, 0);
  final bd = bytes.buffer.asByteData(bytes.offsetInBytes);
  for (var i = 0; i < n; i++) {
    out[i] = bd.getInt16(i * 2, Endian.little) / 32768.0;
  }
  return out;
}


===== FILE: app/lib/lesson/pitch/pitch_display.dart =====

/// U4 — Visual pitch display (stub-fed; A1 swaps in real F0).
///
/// Visual only (ADR-0014 honesty): target line + current-pitch indicator.
/// Unvoiced / low-confidence readings (`f0Hz == null`) leave no indicator.
library;

import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'deviation.dart';
import 'pitch_source.dart';

const _kBufferLen = 8;
const _kNudgeCue = <DeviationDirection, String>{
  DeviationDirection.sharp: '⤵ 좀 더 낮게 — 다시?',
  DeviationDirection.flat: '⤴ 좀 더 높게 — 다시?',
};

class PitchDisplay extends StatefulWidget {
  const PitchDisplay({super.key, this.source, this.targetHz = 220.0});

  final PitchSource? source;
  final double targetHz;

  @override
  State<PitchDisplay> createState() => _PitchDisplayState();
}

class _PitchDisplayState extends State<PitchDisplay> {
  StreamSubscription<PitchReading>? _sub;
  final Queue<PitchReading> _recent = ListQueue<PitchReading>(_kBufferLen);
  PitchReading? _latest;
  bool _dismissed = false;

  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  @override
  void didUpdateWidget(covariant PitchDisplay old) {
    super.didUpdateWidget(old);
    if (old.source != widget.source) {
      _sub?.cancel();
      _latest = null;
      _recent.clear();
      _dismissed = false;
      _subscribe();
    }
  }

  void _subscribe() {
    final src = widget.source;
    if (src == null) return;
    _sub = src.readings.listen((r) {
      if (!mounted) return;
      setState(() {
        _latest = r;
        if (_recent.length >= _kBufferLen) _recent.removeFirst();
        _recent.add(r);
      });
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reading = _latest;
    final cls =
        classifyDeviation(_recent, targetHz: widget.targetHz);
    final showNudge = cls.nudge && !_dismissed;
    return Container(
      key: const Key('pitch-display'),
      height: 110,
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          // Target line — horizontal mid.
          const Align(
            alignment: Alignment.center,
            child: SizedBox(
              key: Key('pitch-target'),
              height: 2,
              width: double.infinity,
              child: ColoredBox(color: AppColors.now),
            ),
          ),
          if (reading?.f0Hz != null)
            Align(
              alignment: Alignment(0, _yOffset(reading!.f0Hz!)),
              child: Container(
                key: const Key('pitch-current'),
                width: 14,
                height: 14,
                decoration: const BoxDecoration(
                  color: AppColors.done,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          if (showNudge)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _kNudgeCue[cls.direction] ?? '',
                      key: const Key('retry-nudge'),
                      style: const TextStyle(
                          color: AppColors.warn, fontSize: 12),
                    ),
                    const SizedBox(width: 6),
                    InkWell(
                      key: const Key('nudge-dismiss'),
                      onTap: () => setState(() => _dismissed = true),
                      child: const Icon(Icons.close,
                          size: 14, color: Colors.white54),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// −1 (top) ↔ +1 (bottom). Sharp = above target = upward = negative Y.
  double _yOffset(double hz) {
    final cents = centsFromTarget(hz, widget.targetHz);
    return (-cents / 50.0).clamp(-1.0, 1.0);
  }
}


===== FILE: app/lib/lesson/pitch/pitch_source.dart =====

/// U4 — PitchSource interface (ADR-0014 swappable seam).
///
/// Real F0 detection (pYIN) drops in behind the same interface in A1 (issue 25).
/// Pure: no Flutter imports.
library;

class PitchReading {
  const PitchReading({required this.f0Hz, required this.timestampSec});

  /// Estimated fundamental in Hz; null = unvoiced / low-confidence.
  /// Honest reporting (ADR-0014): nulls are surfaced, not hidden behind a guess.
  final double? f0Hz;
  final double timestampSec;
}

abstract class PitchSource {
  Stream<PitchReading> get readings;

  /// 캡처 시작. true=ready, false=권한 거부·장치 점유 등 실패.
  /// 호출자(_AppShell)가 false면 source를 표시 트리에서 빼거나 banner 처리.
  Future<bool> start();

  /// 캡처 중단. dispose 전 multiple stop/restart 허용.
  Future<void> stop();

  /// 리소스 해제. 이후 호출 금지.
  void dispose();
}

/// Synthetic source: deterministic wobble around `targetHz`. For UI iteration
/// and tests before A1 lands.
class StubPitchSource implements PitchSource {
  StubPitchSource({
    this.targetHz = 220.0,
    this.interval = const Duration(milliseconds: 50),
  });

  final double targetHz;
  final Duration interval;

  @override
  Stream<PitchReading> get readings =>
      Stream<PitchReading>.periodic(interval, _generate);

  // Stub은 권한·리소스 없음 — 모든 lifecycle hook은 no-op (success).
  @override
  Future<bool> start() async => true;

  @override
  Future<void> stop() async {}

  @override
  void dispose() {}

  PitchReading _generate(int i) => PitchReading(
        f0Hz: targetHz + ((i % 10) - 5) * 5.0,
        timestampSec: i * interval.inMilliseconds / 1000.0,
      );
}


===== FILE: app/lib/lesson/pitch/recording_pitch_source.dart =====

/// A1 — 실 마이크 PitchSource (record 패키지 glue).
///
/// 책임: 권한·캡처 라이프사이클 + PCM 바이트 → 프레임 버퍼링. F0 변환은
/// MicPitchSource에 위임(테스트됨), PCM 디코딩은 pcm16ToSamples(테스트됨).
/// 본 클래스는 device-bound glue라 단위 테스트 대신 analyze + 기기 검증.
library;

import 'dart:async';
import 'dart:typed_data';

import 'package:record/record.dart';

import 'mic_pitch_source.dart';
import 'pcm.dart';
import 'pitch_source.dart';

class RecordingPitchSource implements PitchSource {
  RecordingPitchSource({
    AudioRecorder? recorder,
    this.sampleRate = 16000,
    this.frameSize = 2048,
  }) : _rec = recorder ?? AudioRecorder();

  final AudioRecorder _rec;
  final int sampleRate;
  final int frameSize;

  final StreamController<List<double>> _frames =
      StreamController<List<double>>.broadcast();
  late final MicPitchSource _inner =
      MicPitchSource(frames: _frames.stream, sampleRate: sampleRate);
  StreamSubscription<Uint8List>? _byteSub;
  final List<double> _buf = [];

  @override
  Stream<PitchReading> get readings => _inner.readings;

  @override
  Future<bool> start() async {
    if (!await _rec.hasPermission()) return false;
    final byteStream = await _rec.startStream(RecordConfig(
      encoder: AudioEncoder.pcm16bits,
      sampleRate: sampleRate,
      numChannels: 1,
    ));
    _byteSub = byteStream.listen(_onBytes);
    return true;
  }

  void _onBytes(Uint8List bytes) {
    _buf.addAll(pcm16ToSamples(bytes));
    while (_buf.length >= frameSize) {
      _frames.add(_buf.sublist(0, frameSize));
      _buf.removeRange(0, frameSize);
    }
  }

  @override
  Future<void> stop() async {
    await _byteSub?.cancel();
    _byteSub = null;
    if (await _rec.isRecording()) await _rec.stop();
  }

  @override
  void dispose() {
    _byteSub?.cancel();
    _frames.close();
    _rec.dispose();
  }
}


===== FILE: app/lib/lesson/settings_screen.dart =====

/// Task 4 — 설정 화면 (미니멀). 마이크 권한 상태·버전·알림 토글.
library;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key = const Key('settings-screen'),
    required this.onBack,
    this.micGranted = false,
    this.version = '0.1.0',
    this.onChangeGenre,
  });

  final VoidCallback onBack;
  final bool micGranted;
  final String version;

  /// 졸업/유지 모드에서만 비-null — 장르 변경 진입점.
  final VoidCallback? onChangeGenre;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notify = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          key: const Key('settings-back'),
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: const Text('설정', style: TextStyle(fontSize: 18)),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            key: const Key('settings-notify'),
            title: const Text('알림', style: TextStyle(color: Colors.white)),
            value: _notify,
            onChanged: (v) => setState(() => _notify = v),
          ),
          if (widget.onChangeGenre != null)
            ListTile(
              key: const Key('settings-change-genre'),
              title: const Text('장르 변경',
                  style: TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.chevron_right, color: AppColors.textLow),
              onTap: widget.onChangeGenre,
            ),
          ListTile(
            title: const Text('마이크 권한',
                style: TextStyle(color: Colors.white)),
            trailing: Text(widget.micGranted ? '허용됨' : '미허용',
                style: const TextStyle(color: AppColors.textMid)),
          ),
          ListTile(
            title: const Text('버전',
                style: TextStyle(color: Colors.white)),
            trailing: Text(widget.version,
                style: const TextStyle(color: AppColors.textLow)),
          ),
        ],
      ),
    );
  }
}


===== FILE: app/lib/lesson/today_hero.dart =====

/// 홈 오늘 히어로 — 오늘 한 레슨을 전면 카드로(라벨·제목·cue·칩·시작). 완료 시 초록·체크·비활성.
library;

import 'package:flutter/material.dart';

import '../progression/progression_state.dart';
import '../theme/app_theme.dart';
import 'lesson_instance.dart';

class TodayHero extends StatelessWidget {
  const TodayHero({super.key, required this.progression, required this.onStart});

  final Progression progression;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final p = progression;
    final instance = resolveLessonInstance(p.todaysLesson, p.day);
    final card = instance.card;
    final done = p.didToday;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: done
              ? const [Color(0xFF13251C), Color(0xFF101A15)]
              : const [Color(0xFF1B2030), AppColors.surface],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: done ? AppColors.doneSurface : const Color(0xFF262B3B)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            done ? '오늘 완료' : '오늘의 레슨',
            key: done ? const Key('today-done') : null,
            style: TextStyle(
                color: done ? AppColors.done : AppColors.textLow,
                fontSize: 11,
                letterSpacing: 2),
          ),
          const SizedBox(height: 9),
          Row(
            children: [
              if (done) ...[
                Container(
                  width: 34, height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.doneSurface,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.done, width: 2),
                  ),
                  alignment: Alignment.center,
                  child: const Text('✓',
                      style: TextStyle(color: AppColors.done, fontSize: 17)),
                ),
                const SizedBox(width: 10),
              ],
              Expanded(
                child: Text(card.anatomyMain,
                    style: const TextStyle(
                        color: AppColors.textHi,
                        fontSize: 26,
                        fontWeight: FontWeight.w800)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            done
                ? '오늘 레슨 끝 — 내일 또.'
                : (card.cue.isNotEmpty ? card.cue.first : ''),
            style: const TextStyle(color: AppColors.textMid, fontSize: 13),
          ),
          if (!done) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                if (instance.hasVoicedMicroWin)
                  _chip('● ${card.voicedMicroWin.first}', AppColors.done,
                      AppColors.doneSurface),
                _chip('7–11분', AppColors.textMid, AppColors.surfaceAlt),
              ],
            ),
          ],
          const SizedBox(height: 18),
          SizedBox(
            height: 52,
            child: FilledButton(
              key: const Key('start-today'),
              onPressed: done ? null : onStart,
              style: FilledButton.styleFrom(
                  animationDuration: const Duration(milliseconds: 120)),
              child: Text(done ? '오늘 완료' : '오늘 시작 →',
                  style:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String text, Color fg, Color bg) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
        child: Text(text,
            style: TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w600)),
      );
}


===== FILE: app/lib/lesson/variation.dart =====

/// C3 — 변주 엔진. (Card, PathSlot, day) → 선택된 축 값 맵.
///
/// 결정적·무난수. variationLevel(blocked/lightVariable/variable)이 회전 범위 결정.
library;

import 'card.dart';
import '../progression/path.dart';

Map<String, String> selectVariation(Card card, PathSlot slot, int day) {
  if (card.variableAxes.isEmpty) return const {};
  final out = <String, String>{};
  var i = 0;
  for (final entry in card.variableAxes.entries) {
    final values = entry.value;
    if (values.isEmpty) continue;
    final rotate = switch (slot.variationLevel) {
      VariationLevel.blocked => false,
      VariationLevel.lightVariable => i == 0,
      VariationLevel.variable => true,
    };
    out[entry.key] = rotate ? values[day % values.length] : values.first;
    i++;
  }
  return out;
}


===== FILE: app/lib/main.dart =====

/// 앱 엔트리 — 실행 경고 게이트 → 레슨 화면(D, 채택안).
library;

import 'package:flutter/material.dart';

import 'lesson/graduation_screen.dart';
import 'lesson/home_screen.dart';
import 'lesson/lesson_screen.dart';
import 'lesson/settings_screen.dart';
import 'lesson/pitch/pitch_source.dart';
import 'lesson/pitch/recording_pitch_source.dart';
import 'progression/progression_state.dart';
import 'progression/progression_store.dart';
import 'safety/launch_warning.dart';
import 'theme/app_theme.dart';

void main() => runApp(DebugApp(
    pitchSource: RecordingPitchSource(), store: ProgressionStore()));

class DebugApp extends StatelessWidget {
  const DebugApp({
    super.key,
    this.initialProgression,
    this.pitchSource,
    this.store,
    this.todayEpochDay,
    this.startInLesson = false,
  });

  /// 테스트 seam — 주입 시 사용, 없으면 기본 `Progression.beginner()`.
  final Progression? initialProgression;

  /// U4 — pitch source. 기본 null(테스트). 프로덕션 main()이 StubPitchSource 주입.
  final PitchSource? pitchSource;

  /// Task 2 — 영속화 store. 주입 시 시작 때 load·변이 때 save.
  /// null이면 인메모리(기존 테스트 동작 유지).
  final ProgressionStore? store;

  /// Task 3 — 오늘 날짜(epoch day) 주입 seam. null이면 DateTime.now()로 계산.
  final int? todayEpochDay;

  /// 테스트 seam — true면 홈을 건너뛰고 곧장 레슨(레슨 동작 테스트용).
  final bool startInLesson;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'vocal_athlete',
        debugShowCheckedModeBanner: false,
        home: _AppShell(
            initial: initialProgression,
            pitchSource: pitchSource,
            store: store,
            todayEpochDay: todayEpochDay,
            startInLesson: startInLesson),
      );
}

/// 로컬 자정 기준 epoch day(1970-01-01부터의 일수).
int currentEpochDay() {
  final n = DateTime.now();
  return DateTime(n.year, n.month, n.day).millisecondsSinceEpoch ~/
      Duration.millisecondsPerDay;
}

/// F2 — 앱 실행 경고 게이트(인메모리, 앱 실행당 1회).
class _AppShell extends StatefulWidget {
  const _AppShell(
      {this.initial,
      this.pitchSource,
      this.store,
      this.todayEpochDay,
      this.startInLesson = false});
  final Progression? initial;
  final PitchSource? pitchSource;
  final ProgressionStore? store;
  final int? todayEpochDay;
  final bool startInLesson;
  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
  bool _ack = false;
  late bool _started = widget.startInLesson; // 홈 "오늘 시작" 탭 시 레슨 진입
  bool _showSettings = false;
  bool _showGenrePicker = false; // 설정에서 장르 변경 재진입
  bool _pitchReady = false;
  Progression? _p; // store load 전엔 null(로딩 표시)

  @override
  void initState() {
    super.initState();
    _initProgression();
  }

  Future<void> _initProgression() async {
    final store = widget.store;
    final loaded = store == null ? null : await store.load();
    if (!mounted) return;
    final p = loaded ?? widget.initial ?? Progression.beginner();
    // Task 3 — 실 날짜 동기화: 흐른 날만큼 캡 해제·gap 반영.
    p.syncToToday(widget.todayEpochDay ?? currentEpochDay());
    setState(() => _p = p);
    _persist();
  }

  /// 변이 후 영속화(store 있을 때만). fire-and-forget.
  void _persist() {
    final p = _p;
    if (widget.store == null || p == null) return;
    // ignore: discarded_futures
    widget.store!.save(p);
  }

  Future<void> _onAck() async {
    setState(() => _ack = true);
    final src = widget.pitchSource;
    if (src == null) return;
    final ok = await src.start();
    if (!mounted) return;
    setState(() => _pitchReady = ok);
  }

  void _onComplete() {
    final outcome = _p!.completeLesson();
    _persist();
    setState(() => _started = false); // 오늘 레슨 끝 → 홈(또는 졸업 화면) 복귀
    final msg = kOutcomeMessage[outcome] ?? '';
    if (msg.isEmpty) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        key: const Key('outcome-snack'),
        content: Text(msg),
      ),
    );
  }

  void _onPickGenre(Genre g) {
    setState(() {
      _p!.chooseGenre(g);
      _showGenrePicker = false;
    });
    _persist();
  }

  @override
  void dispose() {
    final src = widget.pitchSource;
    if (src != null) {
      // unawaited — dispose는 sync. stop은 fire-and-forget.
      // ignore: discarded_futures
      src.stop();
      src.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = _p;
    if (p == null) {
      // store load 대기 — 짧은 빈 화면.
      return const Scaffold(backgroundColor: AppColors.bg);
    }
    if (!_ack) {
      return LaunchWarning(onConfirm: _onAck);
    }
    // 졸업 직후(미선택) 또는 설정에서 장르 변경 재진입.
    if ((p.graduated && p.genre == null) || _showGenrePicker) {
      return GraduationScreen(onPick: _onPickGenre);
    }
    if (_showSettings) {
      return SettingsScreen(
        micGranted: _pitchReady,
        onBack: () => setState(() => _showSettings = false),
        // 졸업/유지 모드(장르 선택됨)에서만 변경 진입점 노출.
        onChangeGenre: p.genre != null
            ? () => setState(() {
                  _showSettings = false;
                  _showGenrePicker = true;
                })
            : null,
      );
    }
    if (!_started) {
      return HomeScreen(
        progression: p,
        onStart: () => setState(() => _started = true),
        onSettings: () => setState(() => _showSettings = true),
      );
    }
    return LessonScreen(
      progression: p,
      pitchSource: _pitchReady ? widget.pitchSource : null,
      onComplete: _onComplete,
    );
  }
}


===== FILE: app/lib/progression/outcome_resolver.dart =====

/// resolveOutcome — `completeLesson`의 분류 로직을 순수 함수로 분리한 *전이 그래프*.
///
/// 부수효과(인덱스/스트릭 변이)는 호출자(`Progression.completeLesson`)에 남고,
/// 본 함수는 *오직 분류*. Flutter import 없음.
library;

import 'progression_state.dart';

CompleteOutcome resolveOutcome({
  required bool didToday,
  required bool graduated,
  required bool transitionDayHit,
  required bool maintenance,
  required int pendingReview,
  required bool atEnd,
}) {
  if (didToday) {
    if (graduated) return CompleteOutcome.transitionGraduated;
    if (transitionDayHit) return CompleteOutcome.transitionToNext;
    return CompleteOutcome.capped;
  }
  if (maintenance) return CompleteOutcome.maintenance;
  if (pendingReview > 0) return CompleteOutcome.review;
  if (!atEnd) return CompleteOutcome.advanced;
  return CompleteOutcome.graduated;
}


===== FILE: app/lib/progression/path.dart =====

/// P1 — 단일 고정 선형 경로 (ADR-0015 PathManifest / PathSlot).
///
/// 순수: Flutter import 없음. 잠긴 결정 인코딩 —
/// 단일 고정 선형(배열 순서), 5블록(ADR-0006), bodyVoicedRatio 70:30→20:80,
/// blocked→variable variationLevel 내부 상승. 카드는 *플레이스홀더*(실배선 = C2).
library;

/// 변주 강도(경로 따라 내부 상승, 사용자 비노출).
enum VariationLevel { blocked, lightVariable, variable }

/// ADR-0015 PathSlot. LessonInstance는 런타임 도출(C2/C3) — 여기선 슬롯만.
class PathSlot {
  final int index; // 0-based 경로 위치
  final String cardId; // 플레이스홀더 카드 참조 (CARD-01..CARD-13)
  final int block; // 1..5 (설계 전용, 사용자 비노출)
  final double bodyVoicedRatio; // 신체·호흡 비중(0.70 → 0.20)
  final VariationLevel variationLevel;

  const PathSlot({
    required this.index,
    required this.cardId,
    required this.block,
    required this.bodyVoicedRatio,
    required this.variationLevel,
  });
}

/// 5블록 매크로(ADR-0006). (블록, 끝슬롯index, 카드집합, 비중, 변주).
const _blocks = <_Block>[
  _Block(1, 8, ['CARD-01', 'CARD-02', 'CARD-03', 'CARD-04', 'CARD-05', 'CARD-13'],
      0.70, VariationLevel.blocked),
  _Block(2, 20, ['CARD-06', 'CARD-07'], 0.50, VariationLevel.blocked),
  _Block(3, 30, ['CARD-08', 'CARD-09', 'CARD-13'], 0.40,
      VariationLevel.lightVariable),
  _Block(4, 40, ['CARD-05', 'CARD-10'], 0.30, VariationLevel.lightVariable),
  _Block(5, 48, ['CARD-11', 'CARD-12', 'CARD-13'], 0.20,
      VariationLevel.variable),
];

class _Block {
  final int id;
  final int endSlot; // 1-based 마지막 레슨 번호
  final List<String> cards;
  final double ratio;
  final VariationLevel variation;
  const _Block(this.id, this.endSlot, this.cards, this.ratio, this.variation);
}

const int pathLength = 48;

// ===== 중급 코어 + 장르 분기 (I2) — D1 레슨 수 매핑 반영 =====
// 코어(블록1·2) + 분기(블록3·4). 변주: 코어 light→variable, 분기 variable(ADR-0006).
// 표준샘플 SOP(IC-12)는 각 블록 카드열 말미에 두어 주기적으로 등장(D2).

const _coreBlocks = <_Block>[
  _Block(1, 16, ['IC-01', 'IC-02', 'IC-03', 'IC-04', 'IC-05', 'IC-12'],
      0.20, VariationLevel.lightVariable),
  _Block(2, 32, ['IC-06', 'IC-07', 'IC-08', 'IC-09', 'IC-10', 'IC-11', 'IC-12'],
      0.15, VariationLevel.variable),
];

const _musicalBlocks = <_Block>[
  _Block(3, 48, ['IM-01', 'IM-02', 'IM-03', 'IM-04', 'IM-05', 'IC-12'],
      0.10, VariationLevel.variable),
  _Block(4, 74,
      ['IM-06', 'IM-07', 'IM-08', 'IM-09', 'IM-10', 'IM-11', 'IM-12', 'IC-12'],
      0.10, VariationLevel.variable),
];

const _classicalBlocks = <_Block>[
  _Block(3, 47, ['CL-01', 'CL-02', 'CL-03', 'CL-04', 'IC-12'],
      0.10, VariationLevel.variable),
  _Block(4, 68, ['CL-05', 'CL-06', 'CL-07', 'CL-08', 'CL-09', 'IC-12'],
      0.10, VariationLevel.variable),
];

const _gayoBlocks = <_Block>[
  _Block(3, 51,
      ['GY-01', 'GY-02', 'GY-03', 'GY-04', 'GY-05', 'GY-06', 'IC-12'],
      0.10, VariationLevel.variable),
  _Block(4, 64, ['GY-07', 'GY-08', 'GY-09', 'IC-12'],
      0.10, VariationLevel.variable),
];

/// 블록열 → PathSlot 리스트(결정적 modulo 확장).
List<PathSlot> _expand(List<_Block> blocks) {
  final slots = <PathSlot>[];
  var prevEnd = 0;
  for (final b in blocks) {
    for (var lesson = prevEnd + 1; lesson <= b.endSlot; lesson++) {
      final within = lesson - prevEnd - 1;
      slots.add(PathSlot(
        index: lesson - 1,
        cardId: b.cards[within % b.cards.length],
        block: b.id,
        bodyVoicedRatio: b.ratio,
        variationLevel: b.variation,
      ));
    }
    prevEnd = b.endSlot;
  }
  return slots;
}

/// 결정적 플레이스홀더 PathManifest 생성(초급 5블록).
List<PathSlot> buildPlaceholderManifest() => _expand(_blocks);

/// 중급 코어 manifest(블록1·2, genre-neutral). 분기 진입 전 공유.
List<PathSlot> buildCoreManifest() => _expand(_coreBlocks);

/// 장르 코스 = 코어(블록1·2) + 분기(블록3·4). I3의 genre→빌더 매핑이 사용.
List<PathSlot> buildMusicalManifest() => _expand([..._coreBlocks, ..._musicalBlocks]);
List<PathSlot> buildClassicalManifest() => _expand([..._coreBlocks, ..._classicalBlocks]);
List<PathSlot> buildGayoManifest() => _expand([..._coreBlocks, ..._gayoBlocks]);


===== FILE: app/lib/progression/progression_state.dart =====

/// P1 — 진행 상태 + "오늘의 레슨" 셀렉터 (순수, Flutter import 없음).
///
/// P1 범위 = 경로 + 셀렉터만. 완료→해금(advance)은 P2(별도 슬라이스).
/// progression.py 검증 패턴의 실코드 거처.
library;

import '../lesson/card_library.dart' show safetyGatedCardIds;
import 'outcome_resolver.dart';
import 'path.dart';

/// P8 — 장르 트랙(CONTEXT 글로서리). 졸업 후 비구속 선택.
enum Genre { musical, classical, gayo }

/// W2 — 장르 코스 롤아웃 설정 (세션-독립 단일 소스).
///
/// 여기 든 장르만 졸업→픽 시 실제 중급 코스로 연결된다(staged rollout, ADR-0010 P10).
/// 비어 있으면(기본) 모든 장르가 유지 모드 = 미출시. 앱 진입 경로(beginner/fromJson)는
/// *이 config를 권위로* 읽으므로, 저장된 stale release 상태가 config를 덮어쓰지 못한다
/// — 즉 출시 진실은 대화·세션·영속화가 아니라 체크인된 이 상수다.
///
/// ⚠️ AI 자가 롤아웃 금지: AI는 이 집합을 채우지 않는다. 빈 채로 둔다.
///    출시는 롤아웃·안전 사인오프 결정이라 사람만 한다.
const Set<Genre> kReleasedGenres = {};

/// P4 — 캡된 완료의 보고. 전진/캡 동작은 불변, *보고*만 분기.
enum CompleteOutcome {
  advanced,
  capped,
  transitionGraduated,
  transitionToNext,
  review,
  graduated,
  maintenance
}

/// ADR-0010 보강 문구. UI(U7) 표시용 — 캡 에러가 아닌 *전이 화면*.
const Map<CompleteOutcome, String> kOutcomeMessage = {
  CompleteOutcome.advanced: '',
  CompleteOutcome.capped: '오늘 레슨은 끝났어요. 내일 또 만나요.',
  CompleteOutcome.transitionGraduated:
      '🎉 경로 완주! 오늘은 여기까지 — 장르를 고르고 내일부터 다음 코스',
  CompleteOutcome.transitionToNext: '🎉 전이 완료 — 내일 다음 코스 1과부터',
  CompleteOutcome.review: '↩ 오랜만이에요 — 가볍게 복습부터. 신규는 내일부터.',
  CompleteOutcome.graduated: '🎉 완주! 잘 해냈어요.',
  CompleteOutcome.maintenance: '오늘도 가볍게 유지. 새 코스 열리면 이어가요.',
};

class Progression {
  List<PathSlot> _manifest; // I3 — 분기 진입 시 코스 manifest로 교체(swappable)
  int _currentIndex; // 0-based, 현재(오늘) 슬롯
  bool _didToday; // P3 — 1일 1레슨 캡
  int _day; // P4 — 달력일(advanceDay에서 증가)
  bool _graduated; // P4 — 실설정=P7
  int _transitionDay; // P4 — 코스 전이 발생일(실설정=P8/P10)
  int _streak; // P5 — 관대 스트릭(0 리셋·freeze 없음)
  int _lastActiveDay; // P6 — 마지막 활동일(0=없음), 공백 계산용
  int _pendingReview; // P6 — 남은 복귀 복습일
  Genre? _genre; // P8 — 졸업 후 선택(null=미선택), 비구속
  bool _maintenance; // P9 — 유지 모드(자유 연습 모드와 별개)
  final Set<Genre> _released; // P10 — 출시된 장르 중급(V1 기본 빔=스텁)
  int _lastCalendarDay; // Task3 — 마지막 동기화한 실 날짜(epoch day, 0=미설정)
  /// I5 — 안전 사인오프 여부. false(기본)면 pending 카드를 코스에서 제외(게이트).
  /// HITL-SIGNOFF 완료 시에만 true(자가 승인 ❌). 출시 빌드 기본=false.
  final bool safetyApproved;

  /// Task 3 — 실 캘린더 동기화. todayEpochDay = 1970-01-01부터의 일수.
  /// 날짜가 흐른 만큼 advanceDay()를 호출해 캡 해제·gap을 기존 로직으로 처리.
  /// 같은 날 재실행은 no-op. 첫 호출은 기준만 잡음.
  void syncToToday(int todayEpochDay) {
    if (_lastCalendarDay == 0) {
      _lastCalendarDay = todayEpochDay;
      return;
    }
    if (todayEpochDay <= _lastCalendarDay) return;
    final elapsed = todayEpochDay - _lastCalendarDay;
    for (var i = 0; i < elapsed; i++) {
      advanceDay();
    }
    _lastCalendarDay = todayEpochDay;
  }

  static Genre? _genreByName(String? n) {
    if (n == null) return null;
    for (final g in Genre.values) {
      if (g.name == n) return g;
    }
    return null;
  }

  bool get didToday => _didToday;
  Genre? get genre => _genre;
  bool get maintenance => _maintenance;
  bool isReleased(Genre g) => _released.contains(g); // P10 — 디버그/검증
  int get day => _day;
  int get streak => _streak;
  int get pendingReview => _pendingReview;
  bool get graduated => _graduated;

  Progression._(this._manifest, this._currentIndex,
      {this._didToday = false,
      this._day = 1,
      this._graduated = false,
      this._transitionDay = 0,
      this._lastActiveDay = 0,
      this._streak = 0,
      this._pendingReview = 0,
      this._genre,
      this._maintenance = false,
      this._lastCalendarDay = 0,
      this.safetyApproved = false,
      Set<Genre> released = const {}})
      : _released = {...released};

  factory Progression.beginner() =>
      Progression._(buildPlaceholderManifest(), 0,
          released: kReleasedGenres);

  /// Task 2 — 영속화 직렬화. manifest는 고정 경로라 저장 안 함(복원 시 재생성).
  Map<String, dynamic> toJson() => {
        'currentIndex': _currentIndex,
        'didToday': _didToday,
        'day': _day,
        'graduated': _graduated,
        'transitionDay': _transitionDay,
        'lastActiveDay': _lastActiveDay,
        'streak': _streak,
        'pendingReview': _pendingReview,
        'genre': _genre?.name,
        'maintenance': _maintenance,
        'released': _released.map((g) => g.name).toList(),
        'lastCalendarDay': _lastCalendarDay,
      };

  factory Progression.fromJson(Map<String, dynamic> j) => Progression._(
        buildPlaceholderManifest(),
        j['currentIndex'] as int,
        didToday: j['didToday'] as bool,
        day: j['day'] as int,
        graduated: j['graduated'] as bool,
        transitionDay: j['transitionDay'] as int,
        lastActiveDay: j['lastActiveDay'] as int,
        streak: j['streak'] as int,
        pendingReview: j['pendingReview'] as int,
        genre: _genreByName(j['genre'] as String?),
        maintenance: j['maintenance'] as bool,
        lastCalendarDay: (j['lastCalendarDay'] as int?) ?? 0,
        // W2 — 출시 상태는 체크인 config가 권위. 저장된 'released'는 무시
        // (롤아웃은 전역 결정이라 per-user 영속값이 config를 덮지 못함).
        released: kReleasedGenres,
      );

  /// 테스트용: 임의 매니페스트/위치/상태.
  factory Progression.from(
    List<PathSlot> manifest, {
    int currentIndex = 0,
    bool didToday = false,
    int day = 1,
    bool graduated = false,
    int transitionDay = 0,
    int lastActiveDay = 0,
    bool safetyApproved = false,
  }) =>
      Progression._(manifest, currentIndex,
          didToday: didToday,
          day: day,
          graduated: graduated,
          transitionDay: transitionDay,
          lastActiveDay: lastActiveDay,
          safetyApproved: safetyApproved);

  int get currentIndex => _currentIndex;
  int get total => _manifest.length;

  /// UI — 여정 맵용 읽기 전용 슬롯 뷰(블록·인덱스 표시).
  List<PathSlot> get slots => List.unmodifiable(_manifest);

  bool get atEnd => _currentIndex >= _manifest.length - 1;

  /// "오늘의 레슨" 셀렉터 — 현재 슬롯 반환.
  PathSlot get todaysLesson => _manifest[_currentIndex];

  /// P2 — 레슨 완료 → 완료 기반 해금(포인터 1 전진).
  /// *인자 없음* = 수행 품질이 해금을 막지 않음(구조적 강제, ADR-0002/완료기반).
  /// 경로 끝에서는 더 전진하지 않음(졸업 처리는 P7, 별도 슬라이스).
  CompleteOutcome completeLesson() {
    // 캡 경로 — 변이 없음, 분류만.
    if (_didToday) {
      return resolveOutcome(
        didToday: true,
        graduated: _graduated,
        transitionDayHit: _transitionDay == _day,
        maintenance: _maintenance,
        pendingReview: _pendingReview,
        atEnd: atEnd,
      );
    }
    // P6 — 공백 계산 → 복귀 복습 트리거(활동 등록 전)
    final gap = _lastActiveDay == 0 ? 0 : _day - _lastActiveDay - 1;
    if (gap >= 7 && _pendingReview == 0 && !_graduated) {
      _pendingReview = gap <= 14 ? 1 : 2;
    }
    // 활동 등록(P3·P5·P6 공통 변이)
    _didToday = true;
    _streak++;
    _lastActiveDay = _day;
    // 활동 outcome 분류
    final outcome = resolveOutcome(
      didToday: false,
      graduated: _graduated,
      transitionDayHit: _transitionDay == _day,
      maintenance: _maintenance,
      pendingReview: _pendingReview,
      atEnd: atEnd,
    );
    // outcome별 후속 변이
    switch (outcome) {
      case CompleteOutcome.review:
        _pendingReview--; // P6 — 복귀일=복습, 신규 해금 ❌
      case CompleteOutcome.advanced:
        _currentIndex++;
      case CompleteOutcome.graduated:
        _graduated = true; // P7 — 마지막 슬롯 완주(점수 무관, ADR-0004)
        // I4 — 분기(장르 코스) 완주: 고급 미생성 → 유지 모드(ADR-0010).
        // 초급 완주(genre 미선택)는 picker로(유지 모드 아님).
        if (_genre != null) _maintenance = true;
      case CompleteOutcome.maintenance:
      case CompleteOutcome.capped:
      case CompleteOutcome.transitionGraduated:
      case CompleteOutcome.transitionToNext:
        break;
    }
    return outcome;
  }

  /// P8 — 졸업 후에만 장르 선택. 재호출=교체(비구속), 페널티 없음.
  void chooseGenre(Genre g) {
    if (!_graduated) return;
    _genre = g;
    if (_released.contains(g)) {
      _enterCourse(g); // P10 — 출시됨 → 코스 진입(코어+분기 로드)
    } else {
      _maintenance = true; // P9 — 미출시 → 유지 모드
    }
  }

  /// P10 — (테스트/관리 스텁) 장르 중급 출시 토글.
  /// 새로 출시됐고 그 장르 대기 중(유지 모드)이면 자동 연결.
  void toggleRelease(Genre g) {
    if (!_released.add(g)) {
      _released.remove(g);
      return;
    }
    if (_maintenance && _genre == g) _enterCourse(g);
  }

  /// I3 — 장르 → 코스 manifest(코어 블록1·2 + 분기 블록3·4) 매핑.
  static List<PathSlot> _courseManifest(Genre g) => switch (g) {
        Genre.musical => buildMusicalManifest(),
        Genre.classical => buildClassicalManifest(),
        Genre.gayo => buildGayoManifest(),
      };

  /// I3 — 코스 진입: 선택 장르의 코어→분기 manifest 로드 + 새 코스 시작.
  /// 완료 기반 진행·1일1레슨 캡은 그대로(새 manifest 위에서 동일 규칙).
  /// I5 — safetyApproved=false면 안전 게이트(pending) 카드 슬롯 제외 후 재인덱싱.
  void _enterCourse(Genre g) {
    var course = _courseManifest(g);
    if (!safetyApproved) {
      final gated = safetyGatedCardIds();
      final kept = course.where((s) => !gated.contains(s.cardId)).toList();
      course = [
        for (var i = 0; i < kept.length; i++)
          PathSlot(
            index: i,
            cardId: kept[i].cardId,
            block: kept[i].block,
            bodyVoicedRatio: kept[i].bodyVoicedRatio,
            variationLevel: kept[i].variationLevel,
          ),
      ];
    }
    _manifest = course;
    _currentIndex = 0; // 새 코스 1과부터
    _maintenance = false;
    _graduated = false;
    _transitionDay = _day;
    _pendingReview = 0;
  }

  /// P3 — 날짜 진행 = 캡 해제. P4 — 달력일 증가. 해금(_currentIndex) 불변.
  void advanceDay() {
    _didToday = false;
    _day++;
  }
}


===== FILE: app/lib/progression/progression_store.dart =====

/// Task 2 — Progression 영속화 어댑터 (shared_preferences).
///
/// Progression(순수) ↔ 디스크 사이의 seam. 저장은 JSON 문자열 1개.
library;

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'progression_state.dart';

class ProgressionStore {
  static const _key = 'progression_v1';

  /// 저장된 진행 상태 복원. 없으면 null.
  Future<Progression?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_key);
    if (s == null) return null;
    return Progression.fromJson(jsonDecode(s) as Map<String, dynamic>);
  }

  Future<void> save(Progression p) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(p.toJson()));
  }
}


===== FILE: app/lib/safety/launch_warning.dart =====

/// F2 — 앱 실행 경고 화면 (ADR-0001/0008 · 유일한 안전 장치).
///
/// 앱 실행당 1회 1-탭 확인. 문진/입력/연령 게이트/계정 없음.
library;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// 캐노니컬 문구(CONTEXT.md `앱 실행 경고` · ADR-0001).
const List<String> kHardStopSigns = ['통증', '어지럼', '호흡곤란', '각혈'];
const String kAgeLine = '만 18세 이상·변성기 종료 대상';
const String kDisclaimer = '의료·진단 도구가 아닙니다';
const String kWarningSentence =
    '통증·어지럼·호흡곤란·각혈이 있으면 즉시 멈추고 의료기관을 방문하세요. '
    '본 앱은 만 18세 이상·변성기 종료 대상이며, 의료·진단 도구가 아닙니다.';

class LaunchWarning extends StatelessWidget {
  const LaunchWarning({super.key, required this.onConfirm});

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              // 마이크가 위에서 내려오는 진입 애니메이션(장식 — 추가 탭/게이트 아님).
              Center(
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: -80, end: 0),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOutCubic,
                  builder: (context, dy, child) =>
                      Transform.translate(offset: Offset(0, dy), child: child),
                  child: const Icon(Icons.mic_none,
                      key: Key('launch-mic'), color: Colors.white, size: 64),
                ),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text('Vocal Athlete',
                    key: Key('launch-logo'),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5)),
              ),
              const SizedBox(height: 28),
              const Text('시작 전 안내',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              const SizedBox(height: 16),
              const Text(
                kWarningSentence,
                style: TextStyle(
                    color: Colors.white, fontSize: 16, height: 1.6),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onConfirm,
                  child: const Text('확인'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


===== FILE: app/lib/safety/safety_signoff.dart =====

/// W1 — 안전 카드 HITL 사인오프 레코드 (세션-독립 검증 단일 소스).
///
/// belt/트웽/cover/messa/런 등 고위험 카드(card.safetyReview == pending)는
/// 발성 전문가의 사람 검토(HITL-SIGNOFF.md) 없이는 코스에서 영구 잠금된다(I5).
/// 본 레코드는 *그 검토 결과를 git에 박는 단일 소스*다 — 대화·세션이 아니라
/// 체크인된 이 파일이 "어느 카드가 사인오프됐는가"의 진실이다.
///
/// ⚠️ AI 자가 승인 금지: AI는 이 맵을 채우지 않는다. 빈 채로 둔다.
///    사람 검토자만 검토자 신원·일자·근거를 적어 게이트를 연다.
library;

/// 한 안전 카드에 대한 사람 검토 사인오프. 세 필드가 모두 채워져야 유효(게이트 해제).
class SafetySignoff {
  const SafetySignoff({
    required this.reviewer,
    required this.date,
    required this.evidence,
  });

  /// 검토자 신원(발성 전문가/SLP 등). 비면 무효.
  final String reviewer;

  /// 사인오프 일자(YYYY-MM-DD). 비면 무효.
  final String date;

  /// 근거(HITL-SIGNOFF 패킷 항목·문서 링크). 비면 무효.
  final String evidence;

  /// 세 필드 모두 비어있지 않아야 유효한 사인오프. 공백만은 무효.
  bool get isValid =>
      reviewer.trim().isNotEmpty &&
      date.trim().isNotEmpty &&
      evidence.trim().isNotEmpty;
}

/// 체크인된 사인오프 레코드 (cardId → SafetySignoff). 기본 = 빈.
///
/// 빈 레코드면 모든 pending 카드가 잠금 유지 = 안전 기본값.
/// 사람이 HITL-SIGNOFF.md 검토 완료 후, 검토한 카드의 항목을 여기에 추가한다:
///
/// ```dart
/// const Map<String, SafetySignoff> kSafetySignoff = {
///   'IM-02': SafetySignoff(
///     reviewer: '홍길동(SLP)', date: '2026-06-04',
///     evidence: 'HITL-SIGNOFF.md#IM-02'),
/// };
/// ```
///
/// ⚠️ AI는 이 맵을 채우지 않는다(자가 승인 금지). 빈 채로 유지.
const Map<String, SafetySignoff> kSafetySignoff = {};


===== FILE: app/lib/theme/app_theme.dart =====

/// 앱 공통 색·라운드 토큰. 화면 전역 하드코딩 색을 1곳으로.
library;

import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();
  static const bg = Color(0xFF0E0F13);       // 배경
  static const surface = Color(0xFF171922);  // 카드/시트
  static const done = Color(0xFF39D98A);     // 완료(green)
  static const now = Color(0xFF6C8CFF);      // 현재(blue)
  static const locked = Color(0xFF3A3F55);   // 잠금/미래
  static const surfaceAlt = Color(0xFF222637);   // 필 배경
  static const lockedSurface = Color(0xFF2C3142);
  static const textHi = Colors.white;        // 강조 텍스트
  static const textMid = Colors.white60;     // 보조 텍스트
  static const textLow = Colors.white38;     // 흐림 텍스트
  static const doneSurface = Color(0xFF1D3A2C); // 완료 노드 채움(진한 초록)
  static const warn = Color(0xFFFFD166);        // 경고/넛지 노랑
  static const streak = Color(0xFFFF9F43);      // 스트릭 🔥 강조
}

class AppRadii {
  const AppRadii._();
  static const sheet = 22.0;
  static const pill = 999.0;
}


############################################################
# APP TESTS (app/test)
############################################################


===== FILE: app/test/calendar_integration_test.dart =====

/// Task 3 — 실 캘린더 바인딩 통합: dev 버튼 제거 + 날짜로 캡 해제.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocal_athlete/main.dart';
import 'package:vocal_athlete/progression/progression_state.dart';
import 'package:vocal_athlete/progression/progression_store.dart';

void main() {
  testWidgets('C3a dev 다음날 button removed from lesson', (tester) async {
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('dev-advance-day')), findsNothing);
  });

  testWidgets('C3b new calendar day releases cap (can complete again)',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    final store = ProgressionStore();
    // 어제(epoch 100) 완료한 상태 저장
    final seeded = Progression.beginner();
    seeded.syncToToday(100);
    seeded.completeLesson(); // streak 1, didToday true
    await store.save(seeded);

    // 오늘(epoch 101)로 실행 → 캡 해제되어 다시 완료 가능
    await tester.pumpWidget(
        DebugApp(store: store, todayEpochDay: 101));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('start-today')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('complete-button')));
    await tester.pumpAndSettle();

    final reloaded = await store.load();
    expect(reloaded!.streak, 2); // 어제1 + 오늘1
  });
}


===== FILE: app/test/calendar_sync_test.dart =====

/// Task 3 — 실 캘린더 동기화(syncToToday) 순수 테스트.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/progression/progression_state.dart';

void main() {
  test('C1 same day no-op, next day releases cap, unlock preserved', () {
    final p = Progression.beginner();
    p.syncToToday(100); // 첫 설정 — 기준만 잡고 no-op
    p.completeLesson(); // didToday=true, index 0→1
    expect(p.didToday, isTrue);

    p.syncToToday(100); // 같은 날 재실행 → 캡 유지
    expect(p.didToday, isTrue);

    p.syncToToday(101); // 다음날 → 캡 해제
    expect(p.didToday, isFalse);
    expect(p.currentIndex, 1); // 해금은 보존
  });

  test('C2 7-day gap triggers return-review (gap 로직 재사용)', () {
    final p = Progression.beginner();
    p.syncToToday(100);
    p.completeLesson(); // day1 활동
    p.syncToToday(108); // 8일 점프(공백 7일) → 복귀 복습 트리거
    final outcome = p.completeLesson();
    expect(outcome, CompleteOutcome.review);
  });
}


===== FILE: app/test/card_library_test.dart =====

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/card.dart';
import 'package:vocal_athlete/lesson/card_library.dart';
import 'package:vocal_athlete/progression/path.dart';

void main() {
  test('C2.1 CARD-01 present with non-empty cue and voicedMicroWin', () {
    final c = kCardLibrary['CARD-01'];
    expect(c, isNotNull);
    expect(c!.cue, isNotEmpty);
    expect(c.voicedMicroWin, isNotEmpty);
  });

  test('C2.3 all manifest cardIds resolve to a card with non-empty fields',
      () {
    final ids = {for (final s in buildPlaceholderManifest()) s.cardId};
    for (final id in ids) {
      final c = kCardLibrary[id];
      expect(c, isNotNull, reason: '$id missing in library');
      expect(c!.cue, isNotEmpty, reason: '$id empty cue');
      expect(c.voicedMicroWin, isNotEmpty, reason: '$id empty voicedMicroWin');
    }
  });

  test('C2.4 resolveCard returns the card whose id matches the slot', () {
    final manifest = buildPlaceholderManifest();
    for (final slot in manifest.take(5)) {
      expect(resolveCard(slot).id, slot.cardId);
    }
  });

  test('C3.6 variableAxes values contain no rationale tokens (ADR-0002)', () {
    const banned = ['왜', '이유', '때문', '위해서', '효과'];
    for (final entry in kCardLibrary.entries) {
      for (final axis in entry.value.variableAxes.entries) {
        for (final v in axis.value) {
          for (final token in banned) {
            expect(v.contains(token), isFalse,
                reason:
                    '${entry.key} axis ${axis.key} value "$v" contains "$token"');
          }
        }
      }
    }
  });

  test('U3.6 all cards have non-empty anatomy{entry,main,cooldown}', () {
    for (final entry in kCardLibrary.entries) {
      final c = entry.value;
      expect(c.anatomyEntry, isNotEmpty, reason: '${entry.key} anatomyEntry empty');
      expect(c.anatomyMain, isNotEmpty, reason: '${entry.key} anatomyMain empty');
      expect(c.anatomyCooldown, isNotEmpty,
          reason: '${entry.key} anatomyCooldown empty');
    }
  });

  test('U2.3 no card cue contains rationale/motivation tokens (ADR-0002)',
      () {
    // 무납득 구조 강제 — cue는 지시문만, "왜"/정당화 어휘 미포함.
    const banned = ['왜', '이유', '때문', '위해서', '효과'];
    for (final entry in kCardLibrary.entries) {
      for (final line in entry.value.cue) {
        for (final token in banned) {
          expect(line.contains(token), isFalse,
              reason: '${entry.key} cue line "$line" contains "$token"');
        }
      }
    }
  });

  test('I1.1 all intermediate cards present (IC/IM/CL/GY)', () {
    final ids = <String>[
      for (var i = 1; i <= 12; i++) 'IC-${i.toString().padLeft(2, '0')}',
      for (var i = 1; i <= 12; i++) 'IM-${i.toString().padLeft(2, '0')}',
      for (var i = 1; i <= 9; i++) 'CL-${i.toString().padLeft(2, '0')}',
      for (var i = 1; i <= 9; i++) 'GY-${i.toString().padLeft(2, '0')}',
    ];
    for (final id in ids) {
      final c = kCardLibrary[id];
      expect(c, isNotNull, reason: '$id missing in library');
      expect(c!.cue, isNotEmpty, reason: '$id empty cue');
      expect(c.voicedMicroWin, isNotEmpty, reason: '$id empty voicedMicroWin');
    }
  });

  test('I6.1 every cardId in all course manifests resolves (no dangling)', () {
    final manifests = <String, List<PathSlot>>{
      'beginner': buildPlaceholderManifest(),
      'core': buildCoreManifest(),
      'musical': buildMusicalManifest(),
      'classical': buildClassicalManifest(),
      'gayo': buildGayoManifest(),
    };
    for (final entry in manifests.entries) {
      for (final slot in entry.value) {
        expect(() => resolveCard(slot), returnsNormally,
            reason: '${entry.key}: ${slot.cardId} not in library');
      }
    }
  });

  test('I1.2 HITL-SIGNOFF safety cards flagged pending; others none', () {
    const pending = {
      'IM-02', 'IM-03', 'IM-05', 'IM-12',
      'CL-01', 'CL-08',
      'GY-04', 'GY-05', 'GY-06', 'GY-09',
    };
    for (final entry in kCardLibrary.entries) {
      final expected =
          pending.contains(entry.key) ? SafetyReview.pending : SafetyReview.none;
      expect(entry.value.safetyReview, expected,
          reason: '${entry.key} safetyReview mismatch');
    }
  });
}



===== FILE: app/test/deviation_test.dart =====

/// U5b — 편차 분류 순수 함수 테스트.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/pitch/deviation.dart';
import 'package:vocal_athlete/lesson/pitch/pitch_source.dart';

PitchReading _r(double? hz) =>
    PitchReading(f0Hz: hz, timestampSec: 0);

void main() {
  test('N3 classifyDeviation — direction sharp/flat by severe mean sign', () {
    final sharp = _r(440); // +1200
    final flat = _r(110); // -1200
    expect(
      classifyDeviation(List.filled(3, sharp), targetHz: 220).direction,
      DeviationDirection.sharp,
    );
    expect(
      classifyDeviation(List.filled(3, flat), targetHz: 220).direction,
      DeviationDirection.flat,
    );
  });

  test('N2 classifyDeviation — 3/5 severe → nudge:true, 2/5 → false', () {
    final severe = _r(440); // +1200 cents at target=220
    final ok = _r(220); // 0 cents
    expect(
      classifyDeviation(
        [severe, severe, severe, ok, ok],
        targetHz: 220,
      ).nudge,
      isTrue,
    );
    expect(
      classifyDeviation(
        [severe, severe, ok, ok, ok],
        targetHz: 220,
      ).nudge,
      isFalse,
    );
    expect(classifyDeviation([], targetHz: 220).nudge, isFalse);
    expect(
      classifyDeviation([_r(null), _r(null), _r(null)], targetHz: 220).nudge,
      isFalse,
    );
  });

  test('N1 centsFromTarget — 같은 음 0, 한 옥타브 1200', () {
    expect(centsFromTarget(220, 220), 0);
    expect(centsFromTarget(440, 220), closeTo(1200, 0.01));
  });
}


===== FILE: app/test/f0_test.dart =====

import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/pitch/f0.dart';

void main() {
  test('estimateF0 recovers a synthetic sine within 5%', () {
    const sr = 16000;
    const f = 220.0; // A3
    final samples = List<double>.generate(
        2048, (i) => sin(2 * pi * f * i / sr));
    final est = estimateF0(samples, sr);
    expect(est, isNotNull);
    expect((est! - f).abs() / f, lessThan(0.05));
  });

  test('estimateF0 returns null on silence', () {
    final est = estimateF0(List<double>.filled(2048, 0), 16000);
    expect(est, isNull);
  });
}


===== FILE: app/test/graduation_screen_widget_test.dart =====

/// U7 — 졸업 화면(장르 픽커) 위젯 테스트.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/lesson_screen.dart';
import 'package:vocal_athlete/main.dart';
import 'package:vocal_athlete/progression/path.dart';
import 'package:vocal_athlete/progression/progression_state.dart';

void _phoneViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(1260, 2700);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Progression _graduatedNoGenre() {
  const slot = PathSlot(
    index: 0,
    cardId: 'CARD-01',
    block: 1,
    bodyVoicedRatio: 0.70,
    variationLevel: VariationLevel.blocked,
  );
  return Progression.from([slot], graduated: true);
}

void main() {
  testWidgets('G2 three genre buttons + tap musical → Progression.genre=musical',
      (tester) async {
    _phoneViewport(tester);
    final p = _graduatedNoGenre();
    await tester.pumpWidget(DebugApp(initialProgression: p));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('genre-musical')), findsOneWidget);
    expect(find.byKey(const Key('genre-classical')), findsOneWidget);
    expect(find.byKey(const Key('genre-gayo')), findsOneWidget);
    await tester.tap(find.byKey(const Key('genre-musical')));
    await tester.pumpAndSettle();
    expect(p.genre, Genre.musical);
  });

  testWidgets('G1 graduated + genre=null → graduation screen, no lesson screen',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(DebugApp(initialProgression: _graduatedNoGenre()));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('graduation-screen')), findsOneWidget);
    expect(find.byType(LessonScreen), findsNothing);
  });
}


===== FILE: app/test/home_screen_widget_test.dart =====

/// Task 1 — 홈 화면 위젯 테스트 (경고→홈→레슨 라우팅).
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/lesson_screen.dart';
import 'package:vocal_athlete/main.dart';

void _phoneViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(1260, 2700);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('H1 ack → home screen (not lesson) with today card + 오늘 시작',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('home-screen')), findsOneWidget);
    expect(find.byType(LessonScreen), findsNothing);
    // 오늘 카드 프리뷰 — CARD-01 anatomyMain "6점 정렬 관찰"
    expect(find.textContaining('6점 정렬 관찰'), findsOneWidget);
    expect(find.byKey(const Key('start-today')), findsOneWidget);
  });

  testWidgets('H2 tap 오늘 시작 → lesson screen', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('start-today')));
    await tester.pumpAndSettle();
    expect(find.byType(LessonScreen), findsOneWidget);
    expect(find.byKey(const Key('home-screen')), findsNothing);
  });

  testWidgets('H3 home shows streak + journey preview with block chips',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('home-streak')), findsOneWidget);
    expect(find.byKey(const Key('lesson-map')), findsOneWidget);
    expect(find.text('토대'), findsOneWidget);
    expect(find.text('졸업'), findsOneWidget);
  });

  testWidgets('H4 completing today returns home with 오늘 완료 state',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('start-today')));
    await tester.pumpAndSettle();
    // 본운동에서 쿨다운 스킵으로 오늘 레슨 완료
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('skip-cooldown')));
    await tester.pumpAndSettle();
    // 홈 복귀 + 완료 상태
    expect(find.byKey(const Key('home-screen')), findsOneWidget);
    expect(find.byType(LessonScreen), findsNothing);
    expect(find.byKey(const Key('today-done')), findsOneWidget);
    // 시작 버튼은 비활성(다시 못 들어감 = 1일1레슨 캡 구조화)
    final start = tester.widget<FilledButton>(
        find.byKey(const Key('start-today')));
    expect(start.onPressed, isNull);
  });
}


===== FILE: app/test/launch_warning_widget_test.dart =====

/// F2 — 앱 실행 경고 화면 위젯 테스트 (TDD).
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/main.dart';
import 'package:vocal_athlete/lesson/home_screen.dart';

void _phoneViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(1260, 2700); // 420 x 900 logical @ DPR 3
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('F2.1 app launch shows warning with hard-stops + 18+ + disclaimer + confirm',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    expect(find.textContaining('통증'), findsOneWidget);
    expect(find.textContaining('어지럼'), findsOneWidget);
    expect(find.textContaining('호흡곤란'), findsOneWidget);
    expect(find.textContaining('각혈'), findsOneWidget);
    expect(find.textContaining('만 18세'), findsOneWidget);
    expect(find.textContaining('의료·진단 도구가 아닙니다'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, '확인'), findsOneWidget);
  });

  testWidgets('F2.2 tap 확인 → home shown, warning gone', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(FilledButton, '확인'), findsNothing);
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('F2.3 no medical/onboarding inputs on warning screen',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    expect(find.byType(TextField), findsNothing);
    expect(find.byType(TextFormField), findsNothing);
    expect(find.byType(Checkbox), findsNothing);
    expect(find.byType(Radio), findsNothing);
  });

  testWidgets('LW1 warning shows descending mic + logo, confirm intact',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.pump(); // 애니메이션 첫 프레임
    expect(find.byKey(const Key('launch-mic')), findsOneWidget);
    expect(find.byKey(const Key('launch-logo')), findsOneWidget);
    // 안전 문구·확인 버튼 그대로(ADR-0001)
    expect(find.textContaining('통증'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, '확인'), findsOneWidget);
  });

  testWidgets('F2.4 after confirm, warning does not reappear in same run',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    // 추가 펌프 — 같은 run 내 상태 유지, 경고 재등장 없음
    await tester.pump(const Duration(seconds: 1));
    expect(find.widgetWithText(FilledButton, '확인'), findsNothing);
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}


===== FILE: app/test/lesson_instance_test.dart =====

/// LessonInstance — Card·variation·anatomy를 (slot, day)로 묶은 런타임 모델.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/card_library.dart';
import 'package:vocal_athlete/lesson/lesson_instance.dart';
import 'package:vocal_athlete/progression/path.dart';

void main() {
  test('resolveLessonInstance exposes card + variation for slot/day', () {
    final manifest = buildPlaceholderManifest();
    final slot = manifest.first; // CARD-01, block 1, blocked
    final i = resolveLessonInstance(slot, 1);
    expect(i.card.id, 'CARD-01');
    expect(i.variation, {'sessionPos': '워밍업'});
    expect(i.variationLabel, 'sessionPos=워밍업');
    expect(i.hasVoicedMicroWin, isTrue);
  });

  test('variationLabel empty when card has no variableAxes (CARD-13)', () {
    final card13 = kCardLibrary['CARD-13']!;
    const slot = PathSlot(
      index: 47,
      cardId: 'CARD-13',
      block: 5,
      bodyVoicedRatio: 0.20,
      variationLevel: VariationLevel.variable,
    );
    final i = buildLessonInstance(card13, slot, 0);
    expect(i.variation, isEmpty);
    expect(i.variationLabel, '');
  });
}


===== FILE: app/test/lesson_map_widget_test.dart =====

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/lesson_map.dart';
import 'package:vocal_athlete/progression/progression_state.dart';
import 'package:vocal_athlete/progression/path.dart';

void main() {
  Widget host(Progression p) =>
      MaterialApp(home: Scaffold(body: JourneyPreview(progression: p)));

  testWidgets('JP1 미리보기 + 블록 칩(토대·졸업) 존재', (tester) async {
    await tester.pumpWidget(host(Progression.beginner()));
    expect(find.byKey(const Key('lesson-map')), findsOneWidget);
    expect(find.text('토대'), findsOneWidget);
    expect(find.text('졸업'), findsOneWidget);
  });

  testWidgets('JP2 오늘 중심 윈도우 — currentIndex 3: 완료 2·오늘 1·미래 2',
      (tester) async {
    final p = Progression.from(buildPlaceholderManifest(), currentIndex: 3);
    await tester.pumpWidget(host(p));
    expect(find.byKey(const Key('node-done')), findsNWidgets(2));
    expect(find.byKey(const Key('node-today')), findsOneWidget);
    expect(find.byKey(const Key('node-future')), findsNWidgets(2));
  });

  testWidgets('JP3 시작점 currentIndex 0: 완료 0·오늘 1', (tester) async {
    final p = Progression.from(buildPlaceholderManifest(), currentIndex: 0);
    await tester.pumpWidget(host(p));
    expect(find.byKey(const Key('node-done')), findsNothing);
    expect(find.byKey(const Key('node-today')), findsOneWidget);
  });

  testWidgets('JP4 탭 불가(노드에 onTap/InkWell 없음)', (tester) async {
    await tester.pumpWidget(host(Progression.beginner()));
    expect(find.byType(InkWell), findsNothing);
    expect(find.byType(GestureDetector), findsNothing);
  });
}


===== FILE: app/test/lesson_screen_widget_test.dart =====

/// U1 — 레슨 화면 D 셸 위젯 테스트.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/main.dart';
import 'package:vocal_athlete/lesson/lesson_screen.dart';
import 'package:vocal_athlete/lesson/pitch/pitch_source.dart';
import 'package:vocal_athlete/progression/path.dart';
import 'package:vocal_athlete/progression/progression_state.dart';

class _SpyPitchSource implements PitchSource {
  int startCalls = 0;
  int stopCalls = 0;
  int disposeCalls = 0;
  bool grant = true;
  @override
  Stream<PitchReading> get readings => const Stream<PitchReading>.empty();
  @override
  Future<bool> start() async {
    startCalls++;
    return grant;
  }
  @override
  Future<void> stop() async => stopCalls++;
  @override
  void dispose() => disposeCalls++;
}

void _phoneViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(1260, 2700);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

void main() {
  testWidgets('U1.1 launch → confirm → LessonScreen shown',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byType(LessonScreen), findsOneWidget);
    expect(find.byKey(const Key('lesson-screen')), findsOneWidget);
  });

  testWidgets('U1.2 header shows current slot cardId + idx/total',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.textContaining('CARD-01'), findsOneWidget); // P1 manifest slot 0
    expect(find.textContaining('1/48'), findsOneWidget);
  });

  testWidgets('U1.3 tap 완료 → returns home (오늘 완료, 캡 구조화)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.textContaining('CARD-01'), findsOneWidget);
    await tester.tap(find.byKey(const Key('complete-button')));
    await tester.pumpAndSettle();
    // 완료 → 홈 복귀 + 오늘 완료(슬롯 전진은 progression 내부, 별도 검증)
    expect(find.byKey(const Key('home-screen')), findsOneWidget);
    expect(find.byKey(const Key('today-done')), findsOneWidget);
  });

  testWidgets('U1.4 D structural elements present (stepper, cue, sheet)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('lesson-stepper')), findsOneWidget);
    expect(find.byKey(const Key('lesson-cue')), findsOneWidget);
    expect(find.byKey(const Key('lesson-sheet')), findsOneWidget);
    expect(find.byKey(const Key('complete-button')), findsOneWidget);
  });

  testWidgets('C2.2 cue area renders resolved card cue (CARD-01)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    // 본운동 단계에서 본 cue 렌더(진입은 워밍업만 — 단계 분리)
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pumpAndSettle();
    // CARD-01 cue 일부
    expect(find.textContaining('바닥/의자에 편하게'), findsOneWidget);
    expect(find.textContaining('턱·어깨 힘 빼기'), findsOneWidget);
    // placeholder 사라짐
    expect(find.textContaining('운동 cue 자리'), findsNothing);
  });

  testWidgets('U2.2 sheet shows voicedMicroWin body (CARD-01)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    // CARD-01 voicedMicroWin: "끝에 편한 /m/ 3회(각 2–3초)"
    expect(find.textContaining('/m/ 3회'), findsOneWidget);
  });

  testWidgets('U6.1 header shows streak (starts at 0)', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    final streak = find.byKey(const Key('streak'));
    expect(streak, findsOneWidget);
    expect(find.descendant(of: streak, matching: find.text('🔥 0')),
        findsOneWidget);
  });

  testWidgets('U6.2 streak updates 0→1 after complete (홈에 반영)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('complete-button')));
    await tester.pumpAndSettle();
    // 완료 → 홈 복귀, 홈 스트릭이 1
    final streak =
        tester.widget<Text>(find.byKey(const Key('home-streak')));
    expect(streak.data, contains('1'));
  });

  testWidgets('U3.1 initial step is entry — shows 워밍업 + 다음 button',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.textContaining('워밍업:'), findsOneWidget);
    expect(find.byKey(const Key('next-button')), findsOneWidget);
  });

  testWidgets('L4 _AppShell teardown → source.stop() + dispose() called',
      (tester) async {
    final spy = _SpyPitchSource();
    await tester.pumpWidget(DebugApp(pitchSource: spy, startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(spy.stopCalls, 0);
    expect(spy.disposeCalls, 0);
    // 앱 트리에서 제거 = State.dispose
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpAndSettle();
    expect(spy.stopCalls, 1);
    expect(spy.disposeCalls, 1);
  });

  testWidgets('PD1 mic denied → main step shows mic-off notice',
      (tester) async {
    _phoneViewport(tester);
    final spy = _SpyPitchSource()..grant = false;
    await tester.pumpWidget(DebugApp(pitchSource: spy, startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // → main
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('mic-off-notice')), findsOneWidget);
  });

  testWidgets('L3 start() denied → LessonScreen gets null pitchSource',
      (tester) async {
    _phoneViewport(tester);
    final spy = _SpyPitchSource()..grant = false;
    await tester.pumpWidget(DebugApp(pitchSource: spy, startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // → main
    await tester.pumpAndSettle();
    // UI3: pitchSource == null → 마이크 자리표시 컨테이너(PitchDisplay 미렌더)
    expect(find.byKey(const Key('mic-off-notice')), findsOneWidget);
    expect(find.byKey(const Key('pitch-display')), findsNothing);
    expect(find.byKey(const Key('pitch-current')), findsNothing);
  });

  testWidgets('L2 _AppShell calls pitchSource.start() once after ack',
      (tester) async {
    final spy = _SpyPitchSource();
    await tester.pumpWidget(DebugApp(pitchSource: spy, startInLesson: true));
    expect(spy.startCalls, 0); // ack 전 미호출
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(spy.startCalls, 1);
  });

  testWidgets('P6 pitch-display gated on main step (entry/cooldown hidden)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(DebugApp(
      startInLesson: true,
      pitchSource: StubPitchSource(
        interval: const Duration(milliseconds: 10),
      ),
    ));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    // entry: hidden
    expect(find.byKey(const Key('pitch-display')), findsNothing);
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pump(const Duration(milliseconds: 30));
    // main: visible
    expect(find.byKey(const Key('pitch-display')), findsOneWidget);
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pump(const Duration(milliseconds: 30));
    // cooldown: hidden again
    expect(find.byKey(const Key('pitch-display')), findsNothing);
  });

  testWidgets('G3 pick unreleased genre → LessonScreen with maintenance-badge',
      (tester) async {
    _phoneViewport(tester);
    const slot = PathSlot(
      index: 0,
      cardId: 'CARD-01',
      block: 1,
      bodyVoicedRatio: 0.70,
      variationLevel: VariationLevel.blocked,
    );
    final p = Progression.from([slot], graduated: true);
    await tester.pumpWidget(DebugApp(initialProgression: p, startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('genre-musical')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('lesson-screen')), findsOneWidget);
    expect(find.byKey(const Key('maintenance-badge')), findsOneWidget);
  });

  testWidgets('G4 pick released genre → LessonScreen, no maintenance-badge',
      (tester) async {
    _phoneViewport(tester);
    const slot = PathSlot(
      index: 0,
      cardId: 'CARD-01',
      block: 1,
      bodyVoicedRatio: 0.70,
      variationLevel: VariationLevel.blocked,
    );
    final p = Progression.from([slot], graduated: true);
    p.toggleRelease(Genre.musical); // P10: 출시 토글
    await tester.pumpWidget(DebugApp(initialProgression: p, startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('genre-musical')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('lesson-screen')), findsOneWidget);
    expect(find.byKey(const Key('maintenance-badge')), findsNothing);
  });

  testWidgets('M3 last slot complete → graduated SnackBar', (tester) async {
    _phoneViewport(tester);
    const slot = PathSlot(
      index: 0,
      cardId: 'CARD-01',
      block: 1,
      bodyVoicedRatio: 0.70,
      variationLevel: VariationLevel.blocked,
    );
    final p = Progression.from([slot]);
    await tester.pumpWidget(DebugApp(initialProgression: p, startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('skip-cooldown')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('outcome-snack')), findsOneWidget);
    expect(
      find.descendant(
          of: find.byKey(const Key('outcome-snack')),
          matching: find.textContaining('완주')),
      findsOneWidget,
    );
  });

  testWidgets('M2 first complete (advanced) → no SnackBar', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('skip-cooldown')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('outcome-snack')), findsNothing);
  });

  // M1(같은 날 2차 완료 → capped SnackBar) 삭제:
  // 완료 시 홈 복귀 + 시작 비활성으로 1일1레슨 캡이 UI에서 구조화됨(H4).
  // capped outcome 분류는 R3(outcome_resolver) + progression_test가 커버.

  testWidgets('C3.5 main step shows today-variation; entry/cooldown hide it',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    // entry: 미표시
    expect(find.byKey(const Key('today-variation')), findsNothing);
    await tester.tap(find.byKey(const Key('next-button'))); // → main
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('today-variation')), findsOneWidget);
    // CARD-01 sessionPos:[워밍업,본] / blocked → 워밍업
    final t = tester.widget<Text>(find.byKey(const Key('today-variation')));
    expect(t.data, contains('워밍업'));
    await tester.tap(find.byKey(const Key('next-button'))); // → cooldown
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('today-variation')), findsNothing);
  });

  testWidgets('U3.5 main 쿨다운 스킵 chip 탭 → 오늘 완료, 홈 복귀',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // entry→main
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('skip-cooldown')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('home-screen')), findsOneWidget);
    expect(find.byKey(const Key('today-done')), findsOneWidget);
  });

  testWidgets('U3.4 cooldown 완료 → 오늘 완료, 홈 복귀',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // entry→main
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // main→cooldown
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('complete-button')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('home-screen')), findsOneWidget);
    expect(find.byKey(const Key('today-done')), findsOneWidget);
  });

  testWidgets('U3.3 tap 다음 at main → step=cooldown (쿨다운 텍스트 + 다음 버튼 사라짐)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // entry → main
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button'))); // main → cooldown
    await tester.pumpAndSettle();
    expect(find.textContaining('쿨다운:'), findsOneWidget);
    expect(find.byKey(const Key('next-button')), findsNothing);
    expect(find.byKey(const Key('complete-button')), findsOneWidget);
  });

  testWidgets('U3.2 tap 다음 at entry → step=main (워밍업 사라지고 cue 유지)',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pumpAndSettle();
    expect(find.textContaining('워밍업:'), findsNothing);
    expect(find.textContaining('바닥/의자에 편하게'), findsOneWidget);
  });

  testWidgets('A1 진입엔 본 cue 미표시·본운동엔 표시 (단계 분리)', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp(startInLesson: true));
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    // 진입: 워밍업만 — 본 cue(CARD-01) 미표시
    expect(find.textContaining('워밍업:'), findsOneWidget);
    expect(find.textContaining('바닥/의자에 편하게'), findsNothing);
    // 본운동으로 이동 → 본 cue 표시
    await tester.tap(find.byKey(const Key('next-button')));
    await tester.pumpAndSettle();
    expect(find.textContaining('바닥/의자에 편하게'), findsOneWidget);
  });

  testWidgets('LP1 진입 단계에서 진입 스테퍼가 now 상태(볼드)', (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(MaterialApp(
        home: LessonScreen(progression: Progression.beginner())));
    await tester.pumpAndSettle();
    final entry = tester.widget<Text>(find.text('진입·워밍업'));
    expect(entry.style?.fontWeight, FontWeight.w700);
  });
}


===== FILE: app/test/mic_pitch_source_test.dart =====

/// Task 5(A1) — MicPitchSource: PCM 프레임 → PitchReading 변환 골격.
library;

import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/pitch/mic_pitch_source.dart';
import 'package:vocal_athlete/lesson/pitch/pcm.dart';

List<double> _sine(double hz, int sr, int n) =>
    List<double>.generate(n, (i) => sin(2 * pi * hz * i / sr));

void main() {
  test('A1.1 voiced frame → reading with detected f0', () async {
    final src = MicPitchSource(
      frames: Stream.value(_sine(220, 16000, 2048)),
      sampleRate: 16000,
    );
    final r = await src.readings.first;
    expect(r.f0Hz, isNotNull);
    expect((r.f0Hz! - 220).abs() / 220, lessThan(0.05));
  });

  test('A1.2 silent frame → reading with null f0 (honest)', () async {
    final src = MicPitchSource(
      frames: Stream.value(List<double>.filled(2048, 0)),
      sampleRate: 16000,
    );
    final r = await src.readings.first;
    expect(r.f0Hz, isNull);
  });

  test('A1.4 pcm16ToSamples decodes little-endian int16 to [-1,1]', () {
    // 0x0000=0, 0xFFFF=-1/32768, 0x00 0x40 = 0x4000 = 16384/32768 = 0.5
    final bytes = Uint8List.fromList([0x00, 0x00, 0x00, 0x40, 0x00, 0x80]);
    final s = pcm16ToSamples(bytes);
    expect(s.length, 3);
    expect(s[0], 0.0);
    expect(s[1], closeTo(0.5, 0.001));
    expect(s[2], closeTo(-1.0, 0.001)); // 0x8000 = -32768
  });

  test('A1.3 lifecycle start/stop/dispose', () async {
    final src = MicPitchSource(
      frames: const Stream.empty(),
      sampleRate: 16000,
    );
    expect(await src.start(), isTrue);
    await src.stop();
    src.dispose();
  });
}


===== FILE: app/test/outcome_resolver_test.dart =====

/// resolveOutcome — completeLesson 분류 로직(7-state graph) 단위 검증.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/progression/outcome_resolver.dart';
import 'package:vocal_athlete/progression/progression_state.dart';

void main() {
  test('R7 active + atEnd, no maintenance/review → graduated', () {
    expect(
      resolveOutcome(
        didToday: false,
        graduated: false,
        transitionDayHit: false,
        maintenance: false,
        pendingReview: 0,
        atEnd: true,
      ),
      CompleteOutcome.graduated,
    );
  });

  test('R6 active + !atEnd, no maintenance/review → advanced', () {
    expect(
      resolveOutcome(
        didToday: false,
        graduated: false,
        transitionDayHit: false,
        maintenance: false,
        pendingReview: 0,
        atEnd: false,
      ),
      CompleteOutcome.advanced,
    );
  });

  test('R5 active + pendingReview>0 → review', () {
    expect(
      resolveOutcome(
        didToday: false,
        graduated: false,
        transitionDayHit: false,
        maintenance: false,
        pendingReview: 2,
        atEnd: false,
      ),
      CompleteOutcome.review,
    );
  });

  test('R4 active + maintenance → maintenance', () {
    expect(
      resolveOutcome(
        didToday: false,
        graduated: false,
        transitionDayHit: false,
        maintenance: true,
        pendingReview: 0,
        atEnd: false,
      ),
      CompleteOutcome.maintenance,
    );
  });

  test('R3 didToday + neither graduated nor transitionDayHit → capped', () {
    expect(
      resolveOutcome(
        didToday: true,
        graduated: false,
        transitionDayHit: false,
        maintenance: false,
        pendingReview: 0,
        atEnd: false,
      ),
      CompleteOutcome.capped,
    );
  });

  test('R2 didToday + transitionDayHit (not graduated) → transitionToNext', () {
    expect(
      resolveOutcome(
        didToday: true,
        graduated: false,
        transitionDayHit: true,
        maintenance: false,
        pendingReview: 0,
        atEnd: false,
      ),
      CompleteOutcome.transitionToNext,
    );
  });

  test('R1 didToday + graduated → transitionGraduated', () {
    expect(
      resolveOutcome(
        didToday: true,
        graduated: true,
        transitionDayHit: false,
        maintenance: false,
        pendingReview: 0,
        atEnd: false,
      ),
      CompleteOutcome.transitionGraduated,
    );
  });
}


===== FILE: app/test/path_test.dart =====

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/progression/path.dart';
import 'package:vocal_athlete/progression/progression_state.dart';

void main() {
  test('manifest = pathLength slots, contiguous 0-based index', () {
    final m = buildPlaceholderManifest();
    expect(m.length, pathLength);
    for (var i = 0; i < m.length; i++) {
      expect(m[i].index, i);
    }
  });

  test('blocks span 1..5 in order, ratio decreases monotonically', () {
    final m = buildPlaceholderManifest();
    expect(m.first.block, 1);
    expect(m.last.block, 5);
    var prevBlock = 0;
    double? prevRatio;
    for (final s in m) {
      expect(s.block, greaterThanOrEqualTo(prevBlock));
      prevBlock = s.block;
      if (prevRatio != null) {
        expect(s.bodyVoicedRatio, lessThanOrEqualTo(prevRatio));
      }
      prevRatio = s.bodyVoicedRatio;
    }
    expect(m.first.bodyVoicedRatio, 0.70);
    expect(m.last.bodyVoicedRatio, 0.20);
  });

  test('variation escalates blocked -> variable', () {
    final m = buildPlaceholderManifest();
    expect(m.first.variationLevel, VariationLevel.blocked);
    expect(m.last.variationLevel, VariationLevel.variable);
  });

  test('I2 core manifest = 32 slots, blocks 1-2, IC cards', () {
    final m = buildCoreManifest();
    expect(m.length, 32);
    expect(m.first.block, 1);
    expect(m.last.block, 2);
    expect(m.every((s) => s.cardId.startsWith('IC-')), isTrue);
    for (var i = 0; i < m.length; i++) {
      expect(m[i].index, i);
    }
  });

  test('I2 genre course manifests = core(32) + branch, contiguous', () {
    final musical = buildMusicalManifest();
    final classical = buildClassicalManifest();
    final gayo = buildGayoManifest();
    expect(musical.length, 74); // 코어32 + 뮤지컬42
    expect(classical.length, 68); // 코어32 + 성악36
    expect(gayo.length, 64); // 코어32 + 가요32
    for (final m in [musical, classical, gayo]) {
      // 첫 32은 코어(IC), 이후 분기 카드, 블록 1→4 단조 증가
      expect(m.take(32).every((s) => s.cardId.startsWith('IC-')), isTrue);
      expect(m.first.block, 1);
      expect(m.last.block, 4);
      var prev = 0;
      for (final s in m) {
        expect(s.block, greaterThanOrEqualTo(prev));
        prev = s.block;
      }
    }
    expect(musical.any((s) => s.cardId.startsWith('IM-')), isTrue);
    expect(classical.any((s) => s.cardId.startsWith('CL-')), isTrue);
    expect(gayo.any((s) => s.cardId.startsWith('GY-')), isTrue);
  });

  test('todaysLesson selector returns current slot', () {
    final p = Progression.beginner();
    expect(p.currentIndex, 0);
    expect(p.todaysLesson.index, 0);
    expect(p.total, pathLength);
    expect(p.atEnd, isFalse);

    final p2 = Progression.from(buildPlaceholderManifest(),
        currentIndex: pathLength - 1);
    expect(p2.todaysLesson.index, pathLength - 1);
    expect(p2.atEnd, isTrue);
  });
}


===== FILE: app/test/persistence_integration_test.dart =====

/// Task 2 — 영속화 통합: 재시작 복원 + 변이 저장.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocal_athlete/main.dart';
import 'package:vocal_athlete/progression/progression_state.dart';
import 'package:vocal_athlete/progression/progression_store.dart';

void main() {
  testWidgets('S3a launch restores saved streak from store', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final store = ProgressionStore();
    // 사전 저장: 며칠 진행한 상태
    final seeded = Progression.beginner();
    seeded.completeLesson(); // streak 1
    seeded.advanceDay();
    seeded.completeLesson(); // streak 2
    await store.save(seeded);

    await tester.pumpWidget(DebugApp(store: store));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    // 홈 스트릭이 복원된 2
    expect(find.text('🔥 2일'), findsOneWidget);
  });

  testWidgets('S3b completing a lesson persists to store', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final store = ProgressionStore();

    await tester.pumpWidget(DebugApp(store: store));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('start-today')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('complete-button')));
    await tester.pumpAndSettle();

    final reloaded = await store.load();
    expect(reloaded, isNotNull);
    expect(reloaded!.didToday, isTrue);
    expect(reloaded.streak, 1);
  });
}


===== FILE: app/test/pitch_display_widget_test.dart =====

/// U4 — PitchDisplay widget consumes a PitchSource and renders.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/pitch/pitch_display.dart';
import 'package:vocal_athlete/lesson/pitch/pitch_source.dart';

class _UnvoicedOnlySource implements PitchSource {
  @override
  Stream<PitchReading> get readings =>
      Stream<PitchReading>.value(const PitchReading(f0Hz: null, timestampSec: 0));
  @override
  Future<bool> start() async => true;
  @override
  Future<void> stop() async {}
  @override
  void dispose() {}
}

void main() {
  testWidgets('N5 dismiss → nudge disappears and stays gone for instance',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PitchDisplay(
            targetHz: 220,
            source: StubPitchSource(
              targetHz: 440,
              interval: const Duration(milliseconds: 5),
            ),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 60));
    expect(find.byKey(const Key('retry-nudge')), findsOneWidget);
    await tester.tap(find.byKey(const Key('nudge-dismiss')));
    await tester.pump();
    expect(find.byKey(const Key('retry-nudge')), findsNothing);
    // 추가 reading 흘러도 재노출 ❌
    await tester.pump(const Duration(milliseconds: 60));
    expect(find.byKey(const Key('retry-nudge')), findsNothing);
  });

  testWidgets('N4 sustained severe deviation → retry-nudge appears',
      (tester) async {
    // PitchDisplay target=220, stub target=440 → 모든 reading +1200 cents.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PitchDisplay(
            targetHz: 220,
            source: StubPitchSource(
              targetHz: 440,
              interval: const Duration(milliseconds: 5),
            ),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 60)); // ~10 readings
    expect(find.byKey(const Key('retry-nudge')), findsOneWidget);
  });

  testWidgets('P5 unvoiced reading (f0Hz=null) → no current dot painted',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PitchDisplay(source: _UnvoicedOnlySource()),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 30));
    expect(find.byKey(const Key('pitch-target')), findsOneWidget);
    expect(find.byKey(const Key('pitch-current')), findsNothing);
  });

  testWidgets('P4 PitchDisplay with null source → target only, no current',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: PitchDisplay(source: null)),
      ),
    );
    await tester.pump(const Duration(milliseconds: 30));
    expect(find.byKey(const Key('pitch-target')), findsOneWidget);
    expect(find.byKey(const Key('pitch-current')), findsNothing);
  });

  testWidgets('P3 PitchDisplay with stub source → target + current rendered',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PitchDisplay(
            source: StubPitchSource(
              interval: const Duration(milliseconds: 10),
            ),
          ),
        ),
      ),
    );
    // Allow the periodic stream to emit at least one reading.
    await tester.pump(const Duration(milliseconds: 30));
    expect(find.byKey(const Key('pitch-target')), findsOneWidget);
    expect(find.byKey(const Key('pitch-current')), findsOneWidget);
  });
}


===== FILE: app/test/pitch_source_test.dart =====

/// PitchSource interface + StubPitchSource — ADR-0014 swappable seam.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/pitch/pitch_source.dart';

void main() {
  test('P2 StubPitchSource hovers within ±25Hz of targetHz', () async {
    final s = StubPitchSource(targetHz: 220.0,
        interval: const Duration(milliseconds: 1));
    final batch = await s.readings.take(20).toList();
    for (final r in batch) {
      expect(r.f0Hz, isNotNull);
      expect((r.f0Hz! - 220.0).abs(), lessThanOrEqualTo(25.0),
          reason: 'reading $r out of ±25Hz band');
    }
  });

  test('L1 PitchSource lifecycle — start/stop/dispose on stub', () async {
    final s = StubPitchSource();
    expect(await s.start(), isTrue); // stub: 항상 grant
    final r = await s.readings.first;
    expect(r.f0Hz, isNotNull);
    await s.stop();
    s.dispose();
  });

  test('P1 StubPitchSource emits at least one non-null reading', () async {
    final s = StubPitchSource();
    final first = await s.readings.first;
    expect(first.f0Hz, isNotNull);
  });
}


===== FILE: app/test/progression_serialization_test.dart =====

/// Task 2 — Progression 직렬화 round-trip (순수).
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/progression/progression_state.dart';

void main() {
  test('S1 toJson → fromJson preserves mutable state', () {
    final p = Progression.beginner();
    // 며칠 진행: 완료 → 다음날 → 완료 (streak·index·day 변화)
    p.completeLesson();
    p.advanceDay();
    p.completeLesson();
    p.advanceDay();

    final restored = Progression.fromJson(p.toJson());

    expect(restored.currentIndex, p.currentIndex);
    expect(restored.day, p.day);
    expect(restored.streak, p.streak);
    expect(restored.didToday, p.didToday);
    expect(restored.graduated, p.graduated);
    expect(restored.genre, p.genre);
    expect(restored.maintenance, p.maintenance);
    expect(restored.pendingReview, p.pendingReview);
    expect(restored.total, p.total); // manifest 복원(고정 경로)
  });
}


===== FILE: app/test/progression_store_test.dart =====

/// Task 2 — ProgressionStore save→load (shared_preferences).
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocal_athlete/progression/progression_state.dart';
import 'package:vocal_athlete/progression/progression_store.dart';

void main() {
  test('S2 save then load restores progression', () async {
    SharedPreferences.setMockInitialValues({});
    final store = ProgressionStore();

    expect(await store.load(), isNull); // 최초 = 없음

    final p = Progression.beginner();
    p.completeLesson();
    p.advanceDay();
    await store.save(p);

    final loaded = await store.load();
    expect(loaded, isNotNull);
    expect(loaded!.currentIndex, p.currentIndex);
    expect(loaded.streak, p.streak);
    expect(loaded.day, p.day);
  });
}


===== FILE: app/test/progression_test.dart =====

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/card_library.dart';
import 'package:vocal_athlete/progression/path.dart';
import 'package:vocal_athlete/progression/progression_state.dart';

void main() {
  test('completeLesson advances pointer by 1', () {
    final p = Progression.beginner();
    expect(p.currentIndex, 0);
    p.completeLesson();
    expect(p.currentIndex, 1);
    expect(p.todaysLesson.index, 1);
  });

  test('completeLesson is quality-agnostic (no input to gate on)', () {
    // Structural guarantee: the API takes no quality/score argument,
    // so performance cannot block the unlock — calling it (with nothing
    // to grade) advances. (Multi-day advancement is gated by the P3 cap,
    // covered separately.)
    final p = Progression.beginner();
    p.completeLesson();
    expect(p.currentIndex, 1);
  });

  test('does not advance past the last slot (graduation = P7)', () {
    final p = Progression.from(buildPlaceholderManifest(),
        currentIndex: pathLength - 1);
    expect(p.atEnd, isTrue);
    p.completeLesson();
    expect(p.currentIndex, pathLength - 1);
  });

  test('selector reflects the new current after completion', () {
    final p = Progression.beginner();
    final before = p.todaysLesson.cardId;
    p.completeLesson();
    expect(p.todaysLesson.index, 1);
    // index moved; cardId may or may not differ but slot is the new one
    expect(p.todaysLesson, isNot(same(before)));
  });

  // --- P3: 1일 1레슨 캡 ---

  test('P3.1 first completeLesson marks didToday', () {
    final p = Progression.beginner();
    expect(p.didToday, isFalse);
    p.completeLesson();
    expect(p.didToday, isTrue);
  });

  test('P3.2 second completeLesson same day does not advance (cap)', () {
    final p = Progression.beginner();
    p.completeLesson();
    expect(p.currentIndex, 1);
    p.completeLesson(); // same day → capped
    expect(p.currentIndex, 1);
  });

  test('P3.3 advanceDay releases the cap', () {
    final p = Progression.beginner();
    p.completeLesson();
    p.completeLesson(); // capped
    expect(p.currentIndex, 1);
    p.advanceDay();
    expect(p.didToday, isFalse);
    p.completeLesson(); // next day → advances
    expect(p.currentIndex, 2);
  });

  test('P3.4 at path end: cap independent of end/unlock', () {
    final p = Progression.from(buildPlaceholderManifest(),
        currentIndex: pathLength - 1);
    expect(p.atEnd, isTrue);
    p.completeLesson();
    expect(p.didToday, isTrue); // trained today
    expect(p.currentIndex, pathLength - 1); // no advance at end
    p.completeLesson(); // same day → still capped, no crash
    expect(p.currentIndex, pathLength - 1);
  });

  test('P3.5 advanceDay alone does not change currentIndex (orthogonal)', () {
    final p = Progression.beginner();
    final i = p.currentIndex;
    p.advanceDay();
    p.advanceDay();
    expect(p.currentIndex, i);
  });

  // --- P4: 졸업/전이 메시지 ---

  test('P4.1 graduated + no genre + capped → transitionGraduated', () {
    final p = Progression.from(buildPlaceholderManifest(),
        currentIndex: pathLength - 1,
        didToday: true,
        graduated: true);
    expect(p.completeLesson(), CompleteOutcome.transitionGraduated);
  });

  test('P4.2 transitionDay == day + capped → transitionToNext', () {
    final p = Progression.from(buildPlaceholderManifest(),
        didToday: true, day: 5, transitionDay: 5);
    expect(p.completeLesson(), CompleteOutcome.transitionToNext);
  });

  test('P4.3 ordinary same-day 2nd (mid-path, no transition) → capped', () {
    final p = Progression.from(buildPlaceholderManifest(), didToday: true);
    expect(p.completeLesson(), CompleteOutcome.capped);
  });

  test('P4.4 first complete of day → advanced (regression)', () {
    final p = Progression.beginner();
    expect(p.completeLesson(), CompleteOutcome.advanced);
    expect(p.currentIndex, 1);
  });

  test('P4.5 transition not "today" after advanceDay (day increments)', () {
    final p = Progression.from(buildPlaceholderManifest(),
        day: 5, transitionDay: 5);
    p.completeLesson(); // day 5: advances (not capped yet)
    p.advanceDay(); // → day 6
    p.completeLesson(); // day 6: advances
    p.completeLesson(); // day 6 2nd: capped, transitionDay(5) != day(6)
    expect(p.completeLesson(), CompleteOutcome.capped);
  });

  // --- P5: 관대 스트릭 ---

  test('P5.1 streak 0 → 1 on first completeLesson', () {
    final p = Progression.beginner();
    expect(p.streak, 0);
    p.completeLesson();
    expect(p.streak, 1);
  });

  test('P5.2 +1 per active day', () {
    final p = Progression.beginner();
    p.completeLesson();
    p.advanceDay();
    p.completeLesson();
    expect(p.streak, 2);
  });

  test('P5.3 capped same-day 2nd does not increment streak', () {
    final p = Progression.beginner();
    p.completeLesson();
    p.completeLesson(); // capped
    expect(p.streak, 1);
  });

  test('P5.4 gap does not reset streak (lenient, no freeze)', () {
    final p = Progression.beginner();
    p.completeLesson();
    p.completeLesson(); // build to streak 1
    p.advanceDay();
    p.completeLesson();
    expect(p.streak, 2);
    p.advanceDay();
    p.advanceDay();
    p.advanceDay(); // 3-day gap, no completion
    expect(p.streak, 2); // not reset
    p.completeLesson(); // resume
    expect(p.streak, 3);
  });

  test('P5.5 streak increments at path end, capped after stays', () {
    final p = Progression.from(buildPlaceholderManifest(),
        currentIndex: pathLength - 1);
    expect(p.atEnd, isTrue);
    p.completeLesson();
    expect(p.streak, 1); // trained today even with no advance
    p.completeLesson(); // capped
    expect(p.streak, 1);
  });

  // --- P6: 복귀 복습 ---

  test('P6.1 gap >= 7 → return review, no advance', () {
    final p = Progression.from(buildPlaceholderManifest(),
        lastActiveDay: 1, day: 9); // gap = 9 - 1 - 1 = 7
    final i = p.currentIndex;
    expect(p.completeLesson(), CompleteOutcome.review);
    expect(p.currentIndex, i); // review consumes the day, no new unlock
  });

  test('P6.2 gap 7-14 → owed 1: review then next day advances', () {
    final p = Progression.from(buildPlaceholderManifest(),
        lastActiveDay: 1, day: 10); // gap = 8
    final i = p.currentIndex;
    expect(p.completeLesson(), CompleteOutcome.review);
    expect(p.currentIndex, i);
    p.advanceDay();
    expect(p.completeLesson(), CompleteOutcome.advanced);
    expect(p.currentIndex, i + 1);
  });

  test('P6.3 gap > 14 → owed 2: two review days then advance', () {
    final p = Progression.from(buildPlaceholderManifest(),
        lastActiveDay: 1, day: 22); // gap = 20
    final i = p.currentIndex;
    expect(p.completeLesson(), CompleteOutcome.review); // owed 2 → 1 left
    p.advanceDay();
    expect(p.completeLesson(), CompleteOutcome.review); // 1 → 0
    p.advanceDay();
    expect(p.completeLesson(), CompleteOutcome.advanced);
    expect(p.currentIndex, i + 1);
  });

  test('P6.4 gap < 7 → no review trigger', () {
    final p = Progression.from(buildPlaceholderManifest(),
        lastActiveDay: 1, day: 5); // gap = 3
    expect(p.completeLesson(), CompleteOutcome.advanced);
  });

  test('P6.5 streak still +1 on a review day (lenient)', () {
    final p = Progression.from(buildPlaceholderManifest(),
        lastActiveDay: 1, day: 9);
    final s = p.streak;
    p.completeLesson(); // review day
    expect(p.streak, s + 1);
  });

  test('P6.6 graduated → no review trigger', () {
    final p = Progression.from(buildPlaceholderManifest(),
        lastActiveDay: 1, day: 22, graduated: true);
    // graduated + !didToday path: gap large but excluded → not review
    expect(p.completeLesson(), isNot(CompleteOutcome.review));
  });

  // --- P7: 졸업 감지 ---

  test('P7.1 completing the last slot graduates', () {
    final p = Progression.from(buildPlaceholderManifest(),
        currentIndex: pathLength - 1);
    expect(p.graduated, isFalse);
    final i = p.currentIndex;
    expect(p.completeLesson(), CompleteOutcome.graduated);
    expect(p.graduated, isTrue);
    expect(p.currentIndex, i); // no advance past end
  });

  test('P7.2 mid-path completion does not graduate', () {
    final p = Progression.beginner();
    expect(p.completeLesson(), CompleteOutcome.advanced);
    expect(p.graduated, isFalse);
  });

  test('P7.3 graduation only on path completion (not before)', () {
    final p = Progression.from(buildPlaceholderManifest(),
        currentIndex: pathLength - 2);
    expect(p.completeLesson(), CompleteOutcome.advanced); // → last slot
    expect(p.graduated, isFalse);
    p.advanceDay();
    expect(p.completeLesson(), CompleteOutcome.graduated);
    expect(p.graduated, isTrue);
  });

  test('P7.4 post-graduation fresh day is idempotent (no advance)', () {
    final p = Progression.from(buildPlaceholderManifest(),
        currentIndex: pathLength - 1, graduated: true);
    final i = p.currentIndex;
    p.advanceDay();
    expect(p.completeLesson(), CompleteOutcome.graduated);
    expect(p.graduated, isTrue);
    expect(p.currentIndex, i);
  });

  test('P7.5 graduated + same-day 2nd → transitionGraduated (P4 regress)', () {
    final p = Progression.from(buildPlaceholderManifest(),
        currentIndex: pathLength - 1, didToday: true, graduated: true);
    expect(p.completeLesson(), CompleteOutcome.transitionGraduated);
  });

  // --- P8: 비구속 장르 선택 ---

  test('P8.1 graduated → chooseGenre records genre', () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    expect(p.genre, isNull);
    p.chooseGenre(Genre.musical);
    expect(p.genre, Genre.musical);
  });

  test('P8.2 chooseGenre ignored before graduation', () {
    final p = Progression.beginner();
    expect(p.graduated, isFalse);
    p.chooseGenre(Genre.musical);
    expect(p.genre, isNull);
  });

  test('P8.3 nonbinding — genre can be changed', () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    p.chooseGenre(Genre.musical);
    p.chooseGenre(Genre.gayo);
    expect(p.genre, Genre.gayo);
  });

  test('P8.4 choosing genre does not penalize progression', () {
    final p = Progression.from(buildPlaceholderManifest(),
        currentIndex: 5, graduated: true);
    final i = p.currentIndex;
    final s = p.streak;
    p.chooseGenre(Genre.classical);
    p.chooseGenre(Genre.musical);
    expect(p.currentIndex, i);
    expect(p.streak, s);
    expect(p.graduated, isTrue);
  });

  // --- P9: 유지 모드 ---

  test('P9.1 graduated → chooseGenre enters maintenance (V1: no course)', () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    expect(p.maintenance, isFalse);
    p.chooseGenre(Genre.musical);
    expect(p.maintenance, isTrue);
  });

  test('P9.2 maintenance lesson: maintenance outcome, no new unlock', () {
    final p = Progression.from(buildPlaceholderManifest(),
        currentIndex: 5, graduated: true);
    p.chooseGenre(Genre.musical);
    final i = p.currentIndex;
    expect(p.completeLesson(), CompleteOutcome.maintenance);
    expect(p.currentIndex, i); // 신규 해금 없음
  });

  test('P9.3 maintenance lesson still counts streak (lenient P5)', () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    p.chooseGenre(Genre.musical);
    final s = p.streak;
    p.completeLesson();
    expect(p.streak, s + 1);
  });

  test('P9.4 1/day cap holds in maintenance', () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    p.chooseGenre(Genre.musical);
    p.completeLesson(); // maintenance lesson today
    final s = p.streak;
    final i = p.currentIndex;
    p.completeLesson(); // same day → capped
    expect(p.streak, s); // no extra increment
    expect(p.currentIndex, i);
  });

  test('P9.5 maintenance only via genre choice after graduation', () {
    final pre = Progression.beginner();
    pre.chooseGenre(Genre.musical); // not graduated → ignored
    expect(pre.maintenance, isFalse);
    final grad =
        Progression.from(buildPlaceholderManifest(), graduated: true);
    expect(grad.maintenance, isFalse); // graduated but no genre yet
  });

  // --- P10: 출시 자동연결 (V1 stub) ---

  test('P10.2 released genre → chooseGenre enters course directly', () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    p.toggleRelease(Genre.musical);
    p.chooseGenre(Genre.musical);
    expect(p.maintenance, isFalse); // 직접 진입(유지 모드 아님)
    expect(p.graduated, isFalse); // 다음 코스로 이동
  });

  test('P10.3 auto-connect: release while waiting in maintenance', () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    p.chooseGenre(Genre.musical);
    expect(p.maintenance, isTrue);
    p.toggleRelease(Genre.musical); // 출시 → 자동연결
    expect(p.maintenance, isFalse);
    expect(p.graduated, isFalse);
  });

  test('P10.1 not released → maintenance (V1 default, regression-safe)', () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    p.chooseGenre(Genre.musical);
    expect(p.maintenance, isTrue);
  });

  test('P10.4 release of other genre / no genre → no auto-connect', () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    p.chooseGenre(Genre.musical);
    p.toggleRelease(Genre.gayo); // 다른 장르
    expect(p.maintenance, isTrue); // 자동연결 없음
    final q = Progression.from(buildPlaceholderManifest(), graduated: true);
    q.toggleRelease(Genre.musical); // 장르 미선택
    expect(q.maintenance, isFalse);
    expect(q.graduated, isTrue); // 전이 없음
  });

  test('P10.5 after auto-connect, same-day cap → transitionToNext (P4)', () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    p.chooseGenre(Genre.musical);
    p.completeLesson(); // maintenance lesson (didToday=true)
    p.toggleRelease(Genre.musical); // auto-connect (graduated=false, txnDay=day)
    expect(p.completeLesson(), CompleteOutcome.transitionToNext);
  });

  // --- I3: 졸업→분기 코스 manifest 로드 ---

  test('I3.1 released musical → course manifest loaded (total 74, index 0)',
      () {
    final p = Progression.from(buildPlaceholderManifest(),
        currentIndex: 5, graduated: true, safetyApproved: true);
    expect(p.total, 48); // 초급
    p.toggleRelease(Genre.musical);
    p.chooseGenre(Genre.musical);
    expect(p.total, 74); // 뮤지컬 코스(코어32+분기42), 사인오프 시 전체
    expect(p.currentIndex, 0); // 새 코스 1과
    expect(p.maintenance, isFalse);
    expect(p.todaysLesson.cardId, startsWith('IC-')); // 코어부터
  });

  test('I3.2 each genre loads its course length', () {
    for (final (g, len) in [
      (Genre.musical, 74),
      (Genre.classical, 68),
      (Genre.gayo, 64),
    ]) {
      final p = Progression.from(buildPlaceholderManifest(),
          graduated: true, safetyApproved: true);
      p.toggleRelease(g);
      p.chooseGenre(g);
      expect(p.total, len, reason: '$g course length');
    }
  });

  test('I3.3 course progression: complete advances within loaded course', () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    p.toggleRelease(Genre.gayo);
    p.chooseGenre(Genre.gayo);
    expect(p.completeLesson(), CompleteOutcome.advanced);
    expect(p.currentIndex, 1);
  });

  // --- I4: 분기 완주 → 고급 미생성 → 유지 모드 ---

  test('I4.1 finishing genre course → graduated + maintenance (advanced 미생성)',
      () {
    final p = Progression.from(buildPlaceholderManifest(), graduated: true);
    p.toggleRelease(Genre.gayo);
    p.chooseGenre(Genre.gayo); // 가요 코스 로드(64), index 0
    // 마지막 슬롯까지 진행: 매일 1레슨(advanceDay로 캡 해제)
    while (!p.atEnd) {
      p.completeLesson();
      p.advanceDay();
    }
    expect(p.completeLesson(), CompleteOutcome.graduated); // 마지막 슬롯 완주
    expect(p.graduated, isTrue);
    expect(p.maintenance, isTrue); // 고급 미생성 → 유지 모드
    expect(p.genre, Genre.gayo); // 장르 유지
  });

  test('I5.1 safetyApproved=false → gated cards excluded from course', () {
    final locked = Progression.from(buildPlaceholderManifest(),
        graduated: true); // safetyApproved 기본 false
    locked.toggleRelease(Genre.gayo);
    locked.chooseGenre(Genre.gayo);
    final approved = Progression.from(buildPlaceholderManifest(),
        graduated: true, safetyApproved: true);
    approved.toggleRelease(Genre.gayo);
    approved.chooseGenre(Genre.gayo);
    // 가요 분기 GY-04/05/06/09 게이트 → 잠금 코스가 더 짧음
    expect(approved.total, 64); // 사인오프 시 전체
    expect(locked.total, lessThan(approved.total));
    // 잠금 코스를 순회해도 게이트 카드(pending)는 등장하지 않음
    final gated = safetyGatedCardIds();
    final seen = <String>{};
    while (true) {
      seen.add(locked.todaysLesson.cardId);
      if (locked.atEnd) break;
      locked.completeLesson();
      locked.advanceDay();
    }
    expect(seen.intersection(gated), isEmpty,
        reason: '잠금 코스에 게이트 카드 등장: ${seen.intersection(gated)}');
  });

  test('I5.2 safetyApproved=true → gated cards present in course', () {
    final p = Progression.from(buildPlaceholderManifest(),
        graduated: true, safetyApproved: true);
    p.toggleRelease(Genre.gayo);
    p.chooseGenre(Genre.gayo);
    final gated = safetyGatedCardIds();
    final seen = <String>{};
    while (true) {
      seen.add(p.todaysLesson.cardId);
      if (p.atEnd) break;
      p.completeLesson();
      p.advanceDay();
    }
    expect(seen.intersection(gated), isNotEmpty); // belt/트웽/런 등장
  });

  test('I4.2 beginner graduation (genre 미선택) → NOT maintenance (picker로)',
      () {
    const slot = PathSlot(
      index: 0,
      cardId: 'CARD-01',
      block: 1,
      bodyVoicedRatio: 0.70,
      variationLevel: VariationLevel.blocked,
    );
    final p = Progression.from([slot]); // 1슬롯 초급
    expect(p.completeLesson(), CompleteOutcome.graduated);
    expect(p.graduated, isTrue);
    expect(p.maintenance, isFalse); // genre 미선택 → 유지 모드 아님(picker)
    expect(p.genre, isNull);
  });
}


===== FILE: app/test/release_config_test.dart =====

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/progression/progression_state.dart';

void main() {
  // fromJson용 최소 유효 JSON(졸업·장르 미선택 상태). released는 일부러 'musical'을
  // 넣어 — 체크인 config가 비어 있으면 *config가 이긴다*(persisted 무시)는 걸 검증.
  Map<String, dynamic> graduatedJson({List<String> released = const []}) => {
        'currentIndex': 0,
        'didToday': false,
        'day': 1,
        'graduated': true,
        'transitionDay': 0,
        'lastActiveDay': 0,
        'streak': 0,
        'pendingReview': 0,
        'genre': null,
        'maintenance': false,
        'released': released,
        'lastCalendarDay': 0,
      };

  test('W2.0 체크인된 기본 롤아웃 config는 비어 있음 (AI 자가 롤아웃 0)', () {
    expect(kReleasedGenres, isEmpty);
  });

  test('W2.1 신규 사용자(beginner) 출시상태 == 체크인 config (전 장르)', () {
    final p = Progression.beginner();
    for (final g in Genre.values) {
      expect(p.isReleased(g), kReleasedGenres.contains(g),
          reason: '$g: beginner 출시상태가 config와 불일치');
    }
  });

  test('W2.2 fromJson은 config를 권위로 — persisted released 무시(세션 독립)', () {
    // 저장본엔 musical이 출시된 것처럼 기록돼 있어도, 체크인 config가 비어 있으면
    // 복원된 진행 상태는 config를 따른다(미연결).
    final p = Progression.fromJson(graduatedJson(released: ['musical']));
    for (final g in Genre.values) {
      expect(p.isReleased(g), kReleasedGenres.contains(g),
          reason: '$g: 복원 시 config가 권위여야');
    }
  });

  test('W2.3 빈 config → 졸업 후 장르 픽 = 유지 모드(코스 미연결)', () {
    for (final g in Genre.values) {
      final p = Progression.fromJson(graduatedJson());
      p.chooseGenre(g);
      // config에 없으면 유지 모드, 있으면 코스 진입.
      expect(p.maintenance, !kReleasedGenres.contains(g),
          reason: '$g: config↔라우팅 불일치');
    }
  });
}


===== FILE: app/test/safety_signoff_test.dart =====

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/card.dart';
import 'package:vocal_athlete/lesson/card_library.dart';
import 'package:vocal_athlete/safety/safety_signoff.dart';

void main() {
  // HITL-SIGNOFF 안전 카드(belt/트웽/cover/messa/런) — pending 집합.
  const pending = {
    'IM-02', 'IM-03', 'IM-05', 'IM-12',
    'CL-01', 'CL-08',
    'GY-04', 'GY-05', 'GY-06', 'GY-09',
  };

  test('W1.0 체크인된 기본 레코드는 비어 있음 (AI 자가 승인 0)', () {
    // 빈 레코드 = belt/cover/messa/런 전부 잠금 유지. AI가 채우면 안 됨.
    expect(kSafetySignoff, isEmpty);
  });

  test('W1.1 빈 레코드 → pending 카드 전부 잠금', () {
    expect(safetyGatedCardIds(const {}), pending);
  });

  test('W1.2 기본 게이트(레코드 인자 생략) = 빈 레코드와 동일', () {
    // 하위 호환: 기존 호출부(_enterCourse 등)는 인자 없이 호출.
    expect(safetyGatedCardIds(), pending);
  });

  test('W1.3 특정 카드 유효 사인오프 주입 → 그 카드만 해제', () {
    const record = {
      'IM-02': SafetySignoff(
        reviewer: '김발성(SLP)',
        date: '2026-06-04',
        evidence: 'HITL-SIGNOFF.md#IM-02',
      ),
    };
    final gated = safetyGatedCardIds(record);
    expect(gated.contains('IM-02'), isFalse, reason: 'IM-02 해제돼야');
    expect(gated, pending.difference({'IM-02'}),
        reason: '나머지 9개는 잠금 유지');
  });

  test('W1.4 검토자명 누락 → 무효 → 잠금 유지', () {
    const record = {
      'IM-02': SafetySignoff(
        reviewer: '', // 사람 검토자 신원 누락 = 무효
        date: '2026-06-04',
        evidence: 'HITL-SIGNOFF.md#IM-02',
      ),
    };
    expect(safetyGatedCardIds(record), pending,
        reason: '검토자명 없으면 사인오프 무효, 카드 잠금 유지');
  });

  test('W1.5 일자/근거 누락도 무효', () {
    const noDate = {
      'CL-01': SafetySignoff(
          reviewer: '김발성', date: '', evidence: 'pkt'),
    };
    const noEvidence = {
      'CL-01': SafetySignoff(
          reviewer: '김발성', date: '2026-06-04', evidence: ''),
    };
    expect(safetyGatedCardIds(noDate).contains('CL-01'), isTrue);
    expect(safetyGatedCardIds(noEvidence).contains('CL-01'), isTrue);
  });

  test('W1.6 SafetySignoff.isValid — 세 필드 모두 채워야 유효', () {
    const valid = SafetySignoff(
        reviewer: '김발성', date: '2026-06-04', evidence: 'pkt');
    expect(valid.isValid, isTrue);
    const blank = SafetySignoff(reviewer: ' ', date: ' ', evidence: ' ');
    expect(blank.isValid, isFalse, reason: '공백만 = 무효');
  });

  test('W1.7 none 카드는 사인오프와 무관하게 잠기지 않음', () {
    // pending 아닌 카드(예: CARD-01)는 게이트 대상이 아님.
    expect(safetyGatedCardIds(const {}).contains('CARD-01'), isFalse);
    expect(kCardLibrary['CARD-01']!.safetyReview, SafetyReview.none);
  });
}


===== FILE: app/test/settings_screen_widget_test.dart =====

/// Task 4 — 설정 화면 위젯 테스트.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/home_screen.dart';
import 'package:vocal_athlete/main.dart';
import 'package:vocal_athlete/progression/path.dart';
import 'package:vocal_athlete/progression/progression_state.dart';

void _phoneViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(1260, 2700);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

Future<void> _toHome(WidgetTester tester) async {
  await tester.pumpWidget(const DebugApp());
  await tester.pumpAndSettle();
  await tester.tap(find.widgetWithText(FilledButton, '확인'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('SET1 home gear → settings, back → home', (tester) async {
    _phoneViewport(tester);
    await _toHome(tester);
    await tester.tap(find.byKey(const Key('home-settings')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('settings-screen')), findsOneWidget);
    expect(find.byType(HomeScreen), findsNothing);
    await tester.tap(find.byKey(const Key('settings-back')));
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('SET2 settings shows mic permission + version', (tester) async {
    _phoneViewport(tester);
    await _toHome(tester);
    await tester.tap(find.byKey(const Key('home-settings')));
    await tester.pumpAndSettle();
    expect(find.textContaining('마이크'), findsOneWidget);
    expect(find.textContaining('버전'), findsOneWidget);
  });

  testWidgets('GC1 graduated → settings 장르 변경 → re-pick changes genre',
      (tester) async {
    _phoneViewport(tester);
    const slot = PathSlot(
      index: 0,
      cardId: 'CARD-01',
      block: 1,
      bodyVoicedRatio: 0.70,
      variationLevel: VariationLevel.blocked,
    );
    final p = Progression.from([slot], graduated: true);
    await tester.pumpWidget(DebugApp(initialProgression: p));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    // 졸업 화면 → 뮤지컬 선택(미출시 → 유지 모드, genre=musical)
    await tester.tap(find.byKey(const Key('genre-musical')));
    await tester.pumpAndSettle();
    expect(p.genre, Genre.musical);
    // 홈 → 설정 → 장르 변경 → 가요 재선택
    await tester.tap(find.byKey(const Key('home-settings')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('settings-change-genre')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('genre-gayo')));
    await tester.pumpAndSettle();
    expect(p.genre, Genre.gayo);
  });
}


===== FILE: app/test/today_hero_widget_test.dart =====

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/today_hero.dart';
import 'package:vocal_athlete/progression/progression_state.dart';

void main() {
  Widget host(Progression p, {VoidCallback? onStart}) => MaterialApp(
      home: Scaffold(body: TodayHero(progression: p, onStart: onStart ?? () {})));

  testWidgets('TH1 오늘 — 제목(anatomyMain)·시작 버튼 활성', (tester) async {
    await tester.pumpWidget(host(Progression.beginner()));
    expect(find.textContaining('6점 정렬 관찰'), findsOneWidget); // CARD-01 anatomyMain
    final btn = tester.widget<FilledButton>(find.byKey(const Key('start-today')));
    expect(btn.onPressed, isNotNull);
  });

  testWidgets('TH2 시작 탭 → onStart 호출', (tester) async {
    var tapped = false;
    await tester.pumpWidget(host(Progression.beginner(), onStart: () => tapped = true));
    await tester.tap(find.byKey(const Key('start-today')));
    expect(tapped, isTrue);
  });

  testWidgets('TH3 오늘 완료 — today-done 표시·시작 비활성', (tester) async {
    final p = Progression.beginner()..completeLesson();
    await tester.pumpWidget(host(p));
    expect(find.byKey(const Key('today-done')), findsOneWidget);
    final btn = tester.widget<FilledButton>(find.byKey(const Key('start-today')));
    expect(btn.onPressed, isNull);
  });
}


===== FILE: app/test/variation_test.dart =====

/// C3 — 변주 엔진 테스트.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/card_library.dart';
import 'package:vocal_athlete/lesson/variation.dart';
import 'package:vocal_athlete/progression/path.dart';

void main() {
  test('C3.4 CARD-12 (variable) rotates all axes by day', () {
    final card = kCardLibrary['CARD-12']!;
    const slot = PathSlot(
      index: 45,
      cardId: 'CARD-12',
      block: 5,
      bodyVoicedRatio: 0.20,
      variationLevel: VariationLevel.variable,
    );
    final d0 = selectVariation(card, slot, 0);
    final d1 = selectVariation(card, slot, 1);
    final diffs = d0.keys.where((k) => d0[k] != d1[k]).toList();
    expect(diffs.length, greaterThanOrEqualTo(2),
        reason: 'variable should rotate ≥2 axes: d0=$d0 d1=$d1');
  });

  test('C3.3 CARD-08 (lightVariable) rotates first axis only by day', () {
    final card = kCardLibrary['CARD-08']!;
    const slot = PathSlot(
      index: 25,
      cardId: 'CARD-08',
      block: 3,
      bodyVoicedRatio: 0.40,
      variationLevel: VariationLevel.lightVariable,
    );
    final d0 = selectVariation(card, slot, 0);
    final d1 = selectVariation(card, slot, 1);
    expect(d0.length, greaterThanOrEqualTo(2));
    final diffs = d0.keys.where((k) => d0[k] != d1[k]).toList();
    expect(diffs.length, 1,
        reason: 'lightVariable should rotate exactly one axis: diffs=$diffs');
    expect(diffs.first, card.variableAxes.keys.first,
        reason: 'lightVariable should rotate the FIRST axis');
  });

  test('C3.2 CARD-01 (blocked) day-invariant first values', () {
    final card = kCardLibrary['CARD-01']!;
    const slot = PathSlot(
      index: 0,
      cardId: 'CARD-01',
      block: 1,
      bodyVoicedRatio: 0.70,
      variationLevel: VariationLevel.blocked,
    );
    expect(selectVariation(card, slot, 0), {'sessionPos': '워밍업'});
    expect(selectVariation(card, slot, 5), {'sessionPos': '워밍업'});
  });

  test('C3.1 CARD-13 (empty axes) → selectVariation == {}', () {
    final card = kCardLibrary['CARD-13']!;
    const slot = PathSlot(
      index: 0,
      cardId: 'CARD-13',
      block: 5,
      bodyVoicedRatio: 0.20,
      variationLevel: VariationLevel.variable,
    );
    expect(selectVariation(card, slot, 0), isEmpty);
    expect(selectVariation(card, slot, 7), isEmpty);
  });
}


===== FILE: app/test/verification_harness_test.dart =====

// W5 — 독립 재검증 하네스.
//
// 신규 세션이 *대화 맥락 없이* `flutter test`만 돌려도 인간 게이트 항목의 현재
// 진실을 정확히 재확인하게 한다. 두 축을 강제한다:
//   1) 코드에서 진실 재도출: 게이트==사인오프 레코드, 라우팅==롤아웃 config.
//   2) 단일 소스 정합: verification-status.json이 라이브 코드 상수와 일치.
// JSON만 올리고 코드가 안 따르면(또는 반대) 이 테스트가 실패 → 세션 독립 정확성 보장.
//
// 기기·인간 사인오프의 *내용 진위*는 사람 몫이라, 그 항목은 "기록 존재·형식"만 검증.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/card.dart';
import 'package:vocal_athlete/lesson/card_library.dart';
import 'package:vocal_athlete/progression/progression_state.dart';
import 'package:vocal_athlete/safety/safety_signoff.dart';

void main() {
  // 단일 소스(JSON)는 repo의 docs/verification 아래. flutter test cwd=app/.
  File statusFile() {
    for (final p in [
      '../docs/verification/verification-status.json',
      'docs/verification/verification-status.json',
    ]) {
      final f = File(p);
      if (f.existsSync()) return f;
    }
    return File('../docs/verification/verification-status.json');
  }

  Map<String, dynamic> readStatus() =>
      jsonDecode(statusFile().readAsStringSync()) as Map<String, dynamic>;

  Map<String, dynamic> graduatedJson() => {
        'currentIndex': 0,
        'didToday': false,
        'day': 1,
        'graduated': true,
        'transitionDay': 0,
        'lastActiveDay': 0,
        'streak': 0,
        'pendingReview': 0,
        'genre': null,
        'maintenance': false,
        'released': <String>[],
        'lastCalendarDay': 0,
      };

  // 코드가 진실 — 라이브에서 재도출한 값들.
  Set<String> livePendingInLibrary() => {
        for (final e in kCardLibrary.entries)
          if (e.value.safetyReview == SafetyReview.pending) e.key,
      };
  Set<String> liveSignedOff() => {
        for (final e in kSafetySignoff.entries)
          if (e.value.isValid) e.key,
      };

  // --- 축 1: 코드에서 진실 재도출 ---

  test('W5.1 게이트 == 사인오프 레코드 (코드에서 재도출)', () {
    // 잠긴 카드 = pending 카드 - 유효 사인오프된 카드. 빈 레코드면 pending 전부.
    expect(safetyGatedCardIds(),
        livePendingInLibrary().difference(liveSignedOff()));
  });

  test('W5.2 라우팅 == 롤아웃 config (졸업 후 픽)', () {
    for (final g in Genre.values) {
      final p = Progression.fromJson(graduatedJson());
      p.chooseGenre(g);
      expect(p.maintenance, !kReleasedGenres.contains(g),
          reason: '$g: config↔라우팅 불일치');
    }
  });

  // --- 축 2: 단일 소스(JSON) ↔ 라이브 코드 정합 ---

  test('W5.3 단일 소스 파일이 존재하고 스키마가 맞다', () {
    expect(statusFile().existsSync(), isTrue,
        reason: 'verification-status.json 누락 — 경로/체크인 확인');
    final j = readStatus();
    expect(j['schema'], 'vocal-athlete/verification-status@1');
    expect(j['items'], isA<Map<String, dynamic>>());
    expect((j['statusEnum'] as List).cast<String>().toSet(),
        {'VERIFIED', 'UNVERIFIED', 'BLOCKED', 'OUT_OF_SCOPE'});
  });

  test('W5.4 STATUS.safetySignoff == 라이브 사인오프/게이트', () {
    final j = readStatus();
    final s = (j['items'] as Map)['safetySignoff'] as Map<String, dynamic>;
    final enumv = (j['statusEnum'] as List).cast<String>().toSet();
    expect((s['signedOffCardIds'] as List).cast<String>().toSet(),
        liveSignedOff(),
        reason: 'JSON이 주장한 사인오프와 코드(kSafetySignoff)가 불일치');
    expect((s['stillGatedCardIds'] as List).cast<String>().toSet(),
        safetyGatedCardIds(),
        reason: 'JSON이 주장한 잠금 카드와 라이브 게이트가 불일치');
    expect(enumv.contains(s['status']), isTrue);
  });

  test('W5.5 STATUS.rollout == 라이브 롤아웃 config', () {
    final j = readStatus();
    final r = (j['items'] as Map)['rollout'] as Map<String, dynamic>;
    final enumv = (j['statusEnum'] as List).cast<String>().toSet();
    expect((r['releasedGenres'] as List).cast<String>().toSet(),
        kReleasedGenres.map((g) => g.name).toSet(),
        reason: 'JSON이 주장한 출시 장르와 코드(kReleasedGenres)가 불일치');
    expect((r['allGenres'] as List).cast<String>().toSet(),
        Genre.values.map((g) => g.name).toSet());
    expect(enumv.contains(r['status']), isTrue);
  });

  test('W5.6 기기·고급 항목은 기록 존재·형식만 검증(진위는 사람)', () {
    final j = readStatus();
    final items = j['items'] as Map<String, dynamic>;
    final enumv = (j['statusEnum'] as List).cast<String>().toSet();
    for (final k in ['deviceMic', 'advancedTrack']) {
      final it = items[k] as Map<String, dynamic>;
      expect(enumv.contains(it['status']), isTrue, reason: '$k status enum 위반');
      expect((it['source'] as String).trim(), isNotEmpty,
          reason: '$k source 누락');
    }
  });
}
