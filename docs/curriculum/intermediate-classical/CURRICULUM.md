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
