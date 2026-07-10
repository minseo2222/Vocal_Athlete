# ADR-0020 — 음색 강화 훈련을 전체 커리큘럼 축으로 통합

Date: 2026-06-16
Status: Accepted

## Context

사용자는 업로드한 음색 리서치를 바탕으로 음색 강화 훈련을 커리큘럼에 넣기를 원했다. 음색은 호흡, phonation, resonance, vowel, register, diction, style, microphone/recording 조건이 결합된 결과이므로 독립 옵션 코스보다 전체 경로에 분산 배치하는 편이 안전하다.

## Decision

- 초급: `TONE-02 Hum-to-Vowel`, `TONE-03 Vowel Color Taste`만 낮은 부하로 삽입. `CARD-13` 표준샘플에 tone tag를 추가한다.
- 중급 Universal Core: `Resonance & Timbre Control` 모듈을 정식 배치한다.
- Repertoire Application: `TONE-11 Mic Tone Check`, `TONE-12 Same Phrase Three Tones`로 phrase 적용을 시작한다.
- 고급 Genre Labs: `TONE-13 Genre Tone Lab`으로 장르별 tone preset을 다룬다.
- 사용자-facing 음색 피드백은 점수화하지 않는다. 녹음 A/B, tone tag, comfort rating, mic quality 중심이다.

## Consequences

- `Card` 모델에 timbre/tone 관련 metadata를 추가한다.
- `card_library.dart`에 `TONE-01~13`을 추가한다.
- spectral centroid, CPPS, formant 등은 research/internal only로 둔다.
- rasp, growl, scream, pushed belt, celebrity voice matching은 앱 단독 금지다.
