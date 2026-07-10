# TONE-PROFILE-SPEC — v16 내 음색 팔레트

## 정의

Tone Profile은 AI가 추정한 성대·음색 유형이 아니다. 저장된 녹음에서 **사용자가 직접 고른 tag, 편안함, Best 선택, 동일 조건 확인**을 로컬에서 다시 계산한 요약이다.

## v16 집계 원칙

반복 녹음량과 재현성을 구분한다.

```text
observedTakeCount              # tag가 있는 원본 take 수
practiceDayCount               # 날짜가 유효한 서로 다른 학습일 수
dayTagContributionCount        # 학습일 × tag 기여 수
undatedTakeCount               # 안정 빈도에서 제외한 날짜 미상 take
sameConditionTakeCount         # 같은 조건 확인 원본 take 수
sameConditionPracticeDayCount  # 같은 조건을 확인한 서로 다른 날 수
referenceTakeCount             # Best/표준샘플 reference 수
tagCounts                      # 학습일 × tag 빈도
comfortableTagCounts           # 편안함 4–5인 학습일 × tag
lowComfortTagCounts            # 편안함 1–2 또는 effortful/tired인 학습일 × tag
referenceTakeIds
```

## 왜 학습일 단위인가

같은 날 clean take를 8번 남기고 warm take를 1번 남겼다고 해서 clean이 8배 더 안정된 tone이라는 뜻은 아니다. 따라서 같은 날 같은 tag는 1회만 안정 팔레트에 기여한다. 원본 take 수는 별도로 보여줘 사용자 기록을 숨기지 않는다.

같은 날 같은 tag에 편안함이 엇갈리면 낮은 편안함 신호를 보존한다. 이는 위험 진단이 아니라 다음 시도에서 부하를 낮출 참고다.

## 화면 원칙

- “내가 자주 고른 톤”과 “편안했던 톤”을 분리한다.
- 최소 3개의 서로 다른 학습일 전에는 해석하지 않고 기록 부족을 표시한다.
- 낮은 편안함 tag를 의료 경고나 고정 음색 유형으로 표현하지 않는다.
- 날짜 미상 legacy take는 안정 빈도에서 제외했음을 표시한다.
- 새로고침과 녹음 삭제 후 남은 take로 다시 계산한다.
- 서버 업로드·음성 생체식별·유명 가수 비교를 하지 않는다.

## 한계

- 사용자의 tag 이해도와 일관성이 검증되지 않았다.
- 다른 마이크·거리·방 조건은 직접 비교하기 어렵다.
- 세 학습일 기준은 제품 가설이며 학습효과 기준이 아니다.
- tone profile은 가창 등급, 건강 상태, 장르 적합도를 증명하지 않는다.


## v17 curation update

Users can correct a tone tag or exclude a take from palette aggregation without deleting the original recording. This supports user agency and avoids turning Tone Profile into a fixed voice-type label.

New fields:

- `toneProfileExcluded`
- `toneTagEditedEpochMs`
- `toneTagEditMemo`

Aggregation remains day-weighted. Excluded takes are counted as raw observations but skipped from stable palette signals.

Forbidden interpretations remain unchanged: no AI timbre score, no vocal-fold health inference, no singer-match percentage, no clinical acoustic score.

## v18 multi-tag and date stability update

- One take can retain multiple self-selected tags.
- Individual chips add/remove only that tag; users may clear all explicitly.
- `createdLocalDateKey` stores the recording-time local calendar date on new takes so later timezone changes do not move the take to another practice day.
- Legacy takes continue to use epoch fallback and are disclosed conservatively.
- `editedTakeCount` distinguishes user curation from unedited observations.

These changes improve diary consistency; they do not create a timbre classifier or quality score.
