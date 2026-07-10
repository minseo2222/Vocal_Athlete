# TIMBRE-RESEARCH-ADDENDUM — 음색 리서치 반영 기록

작성일: 2026-06-16  
입력: `/mnt/data/붙여넣은 마크다운(1).md` — 전문 보컬 교육기관 기반 “음색 개선 훈련” 통합 리서치 보고서

## 1. 채택한 핵심 결론

음색 개선은 타고난 목소리를 평가하는 것이 아니라, 성대 접촉·호흡 압력·airflow·onset·성도/모음·레지스터·딕션·장르 표현·마이크/녹음 환경을 안전하게 조절해 원하는 tone을 반복 가능하게 만드는 훈련이다.

## 2. 제품 반영 방식

| 리서치 결론 | 제품 반영 |
|---|---|
| 음색은 단일 능력이 아니라 source/filter/style/safety의 복합 결과 | `TIMBRE-TRAINING-SPEC.md`의 4층 모델 |
| SOVT, 허밍, 모음 색채, 녹음 A/B는 앱 친화적 | TONE-01~13, UC-10/11, SB phrase loop |
| Estill/CVT류는 음색 구조화에 유용하나 고유 체계 복제 주의 | 밝음/따뜻함/말하듯/둥글게 등 일반 표현만 사용 |
| 스마트폰 지표는 절대 점수보다 상대 비교 | `TONE-FEEDBACK-SPEC.md`: A/B replay, self tag 중심 |
| 벨트, 강한 twang, rasp, growl, scream은 앱 단독 위험 | Advanced Lab + HITL + cap 전 잠금 |
| K-pop은 복제가 아니라 로컬라이징 | Advanced Gayo Lab의 한국어 diction, mic-friendly tone, hook phrase |

## 3. 커리큘럼 반영

- 초급: `CARD-13` 표준샘플에 Tone Snapshot seed를 결합.
- Universal Core: Module 6 `Resonance & Timbre Control` 추가.
- Repertoire Application: `TONE-11` Mic Tone Check, `TONE-12` Same Phrase Three Tones 추가.
- Advanced Genre Labs: `TONE-13` Genre Tone Lab과 장르별 tone preset 추가.

## 4. 측정 정책

사용자-facing 허용:

- 녹음 품질
- clipping/noise
- A/B replay
- 사용자가 고른 tone tag
- comfort rating
- pitch/timing support

사용자-facing 금지:

- 음색 점수
- 성대 접촉률 판정
- 성대 건강 점수
- celebrity/아이돌 매칭률
- shimmer/jitter/HNR 기반 건강 피드백

연구/전문가 모드 후보:

- spectral centroid trend
- CPPS/CPP
- formant 추정
- onset shape

## 5. 근거 정렬 메모

- 보이스 페다고지 커리큘럼은 respiration, phonation, resonation/resonance, registration, articulation을 공통 기능 축으로 다룬다. 본 프로젝트의 Universal Core 모듈 구조와 정렬된다.
- 음색은 source-filter 상호작용과 성도/모음/공명 조절의 결과로 다뤄야 한다. 앱은 이를 직접 진단하지 않고 사용자가 조절 가능한 작은 cue와 A/B 비교로 변환한다.
- 스마트폰 녹음은 F0·일부 상대 비교에는 쓸 수 있으나, 기기·거리·환경에 민감한 음향 지표는 연구/전문가 보조로 제한한다.
- 음성 안전은 하드스톱과 피로/쉰 느낌 micro-check에 연결한다. 고강도 tone은 고급에서도 cap과 HITL 전 공개하지 않는다.

## 6. Negative findings

- “좋은 음색 공식”은 채택하지 않는다.
- 유명 가수/아이돌 음색 복제는 채택하지 않는다.
- 음색 자동 점수는 MVP/R3 사용자 표시에서 제외한다.
- K-pop tone은 한국어·마이크·hook·녹음 UX로 로컬라이징하고, 원곡자 음색·원곡 key 강제는 금지한다.
