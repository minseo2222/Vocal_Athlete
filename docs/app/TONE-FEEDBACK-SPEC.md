# TONE-FEEDBACK-SPEC — v15 사용자 음색 피드백

## 핵심 원칙

앱은 음색을 채점하지 않는다. 사용자가 목표 tag를 선택하고, 짧은 take를 녹음하고, 편안함과 전달감을 비교한 뒤 다시 재현하도록 돕는다.

## take 흐름

```text
목표 tag 확인
→ 첫 take
→ 자기 tag/편안함 기록
→ 필요할 때만 재생
→ 두 번째 take
→ best take 선택
→ D+1/D+3 재현 또는 프레이즈 전이
```

`TONE-12`는 `clean → warm → speech-like` 순서의 A/B/C를 기본으로 하며 사용자가 불편하면 중간에 종료할 수 있다.

## 사용자 표시

- 사용자 선택 tone tag
- 편안함 1–5
- 같은 조건 여부
- take 목표 label
- Best 표시
- clipping/noise와 거리 조정 안내
- “이 데이터는 내 선택 기록이며 자동 음색 판정이 아님” 안내

## 자동 표시 금지

- 좋은/나쁜 음색
- 종합 점수 또는 백분율
- 성대 접촉·건강·질환
- 유명 가수 유사도
- jitter/shimmer/HNR/CPPS/formant 기반 사용자 평가

## 연구 전용

spectral centroid, CPPS, formant, onset shape, relative intensity는 실기기 검증과 전문가 검토 전까지 사용자 UI에 노출하지 않는다.
