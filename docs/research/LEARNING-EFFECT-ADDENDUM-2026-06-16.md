# 학습 효과 보강 리서치 메모 — 2026-06-16 R2

> 목적: 초급 V1이 “안전한 발성 루틴”을 넘어 실제 노래 학습 체감으로 이어지도록, 낮은 부하의 추가 훈련과 피드백 방식 근거를 문서화한다. 이 문서는 제품 설계 근거이며 임상 효능 주장으로 쓰지 않는다.

## 1. SOVT는 초급 핵심 루틴으로 유지

SOVT(straw, lip trill, humming/NG, water resistance)는 보컬 훈련·음성치료 맥락에서 RCT와 비교 연구가 존재한다. V1은 이를 의료 치료가 아니라 낮은 부하의 초급 발성 루틴으로 사용한다.

제품 적용:

- CARD-06/07/08/09를 초급 중반의 핵심으로 유지.
- 피로/쉰 느낌 선택 시 SOVT-only light-mode를 우선 제안.
- SOVT도 과호흡·어지럼·가슴통증 cue를 유지한다.

Sources:

- Kapsner-Smith et al., “A Randomized Controlled Trial of Two Semi-Occluded Vocal Tract Voice Therapy Protocols” — https://pmc.ncbi.nlm.nih.gov/articles/PMC4610291/
- Heller-Stark et al., “Comparative Study of Two Semi-Occluded Vocal Tract Protocols” — https://pmc.ncbi.nlm.nih.gov/articles/PMC11567055/

## 2. 실시간 시각 피드백은 확인형·감쇠형으로 제한

실시간 visual feedback은 음성 교육에서 유용할 수 있지만, 수행 중 제공되는 피드백이 항상 학습에 좋은 것은 아니다. Wilson et al.의 singing pitch feedback 연구는 실시간 VFB 제공 중 수행 정확도가 pre/post보다 낮아질 수 있음을 보고했고, voice pedagogy overview도 도구의 교육적 쓰임은 피드백 설계에 달려 있음을 강조한다.

제품 적용:

- CARD-12/14/16은 `deferredVisualFeedback=true`.
- 사용자는 먼저 소리낸 뒤 `곡선 보기`를 눌러 확인한다.
- 실시간 피드백은 후속 opt-in 실험 후보로 분리.
- 목표는 perfect score가 아니라 방향 nudge와 자기관찰이다.

Sources:

- Wilson et al., “Looking at singing: Does real-time visual feedback improve the way we learn to sing?” — https://www.afpc-evta-france.com/wp-content/uploads/sites/10/2015/02/72-feeback-visuel-et-apprentissage-chant.pdf
- Lã et al., “Real-Time Visual Feedback in Singing Pedagogy: Current Developments and Future Directions” — https://www.mdpi.com/2076-3417/12/21/10781

## 3. 피치 매칭은 고정 Hz보다 relative target 우선

초보자에게 고정 Hz를 강요하면 성별·음역·컨디션에 따라 무리한 맞추기 행동을 만들 수 있다. R2에서는 CARD-12가 세션 초반의 편한 허밍 F0 median을 오늘의 기준선으로 잡고, 그 기준 주변에서 짧게 매칭한다.

제품 적용:

- `targetHz`가 없고 `relativePitchTarget=true`이면 voiced F0 seed 5개 이상으로 median target 생성.
- 저신뢰 F0는 null로 숨김.
- 목표선은 “오늘의 편한 높이”이지 음역 테스트가 아니다.

Related source:

- Fahed et al., “Comparison of Acoustic Voice Features Derived From Mobile Devices vs Studio Microphone Recordings” — https://kclpure.kcl.ac.uk/portal/en/publications/comparison-of-acoustic-voice-features-derived-from-mobile-devices/

## 4. 청음-상상-허밍 bridge 추가

초보자의 노래 정확도는 단순 발성 기계 조절만이 아니라 듣기, pitch memory, auditory imagery, vocal imitation과 연결된다. 청각 이미지를 선명하게 떠올리는 능력은 vocal pitch imitation과 관련이 있다는 연구들이 있다.

제품 적용:

- CARD-14 추가: 기준음 듣기 → 2초 상상 → /m/ 또는 /u/ 허밍 → 끝난 뒤 곡선 보기.
- 절대음감·도레미·점수화 없음.
- 잘못 맞히는 것을 “오답”으로 표시하지 않는다.

Sources:

- Pfordresher & Halpern, “Auditory imagery and the poor-pitch singer” — https://www.researchgate.net/publication/235630223_Auditory_imagery_and_the_poor-pitch_singer
- Halpern et al., “What do less accurate singers remember? Pitch-matching…” — https://link.springer.com/article/10.3758/s13414-021-02391-1

## 5. 리듬은 피치와 별도 bridge로 추가

노래는 음 높이만이 아니라 시간 안에서 소리를 내는 행동이다. beat synchronization과 singing은 지각·운동·감각운동 과정을 공유하며, beat synchronization 어려움은 auditory-motor mapping 문제와 연결될 수 있다.

제품 적용:

- CARD-15 추가: 4박 pulse 보기 → 손가락 tap → /m/ 리듬 허밍.
- tempo 경쟁, 랭킹, 정확도 점수 없음.
- 리듬 feedback은 “조금 빠름/느림” 수준의 nudge로 제한.

Sources:

- Dalla Bella et al., “Moving to the Beat and Singing are Linked in Humans” — https://www.frontiersin.org/journals/human-neuroscience/articles/10.3389/fnhum.2015.00663/full
- Sowiński & Dalla Bella, “Poor synchronization to the beat may result from deficient auditory-motor mapping” — https://www.semanticscholar.org/paper/15ca868610833860d17107306414ab272001e306

## 6. 짧은 contour mimic은 곡 전 단계로 추가

초급에서 곡을 부르게 하지는 않지만, 2–3음의 선율 모양을 허밍하는 훈련은 발성 루틴과 실제 노래 사이의 bridge 역할을 한다.

제품 적용:

- CARD-16 추가: 낮음→높음→낮음, 같음→높음→같음 등 contour만 허밍.
- 도레미·interval 설명 없음.
- 시각 피드백은 수행 후 확인.

## 7. 한국어 모음·자음 bridge는 차별화 요소

한국어 앱으로서 가요/뮤지컬/성악 중급으로 이어지려면 초급 후반에 한국어 소리 전이가 필요하다. 다만 V1에서 한국어 모음 AI 점수화는 데이터 검증 전까지 제외한다.

제품 적용:

- CARD-17 추가: /마-미-무/, /나-네-노/, /음-아/, /무-아/.
- 짧고 낮은 부하로 수행.
- 빠른 가사, 고음, 발음 점수는 제외.

Internal source:

- `docs/research/part 6-KR 한국어 가창 딕션과 조음.md`

## 8. 목 상태 micro-check는 streak보다 안전을 우선하게 만든다

NIDCD는 쉰 목소리나 피로한 목소리 상태에서 말하거나 노래하지 말고, 아플 때는 목소리를 쉬게 하며, 음역의 극단을 피하라고 권고한다. V1은 이를 의료 문진이 아니라 light-mode UX로 번역한다.

제품 적용:

- 진입 단계에 `괜찮음 / 조금 피곤함 / 쉰 느낌` micro-check 노출.
- 피곤함/쉰 느낌이면 SOVT-only 또는 듣기·호흡을 제안.
- streak는 유지하고 신규 해금은 품질로 차단하지 않는다.

Source:

- NIDCD, “Taking Care of Your Voice” — https://www.nidcd.nih.gov/health/taking-care-your-voice

## 9. 습관 형성 카피는 보수적으로 유지

습관 형성은 고정된 21일 규칙이 아니며, 평균 66일 같은 수치도 행동과 맥락에 따라 크게 달라진다. 48레슨은 “습관 완성 보장”이 아니라 “루틴 형성 시작”으로 표현한다.

제품 적용:

- 48일 완주 = 안전한 보컬 루틴의 기반 경험.
- 졸업 = 실력 판정이 아니라 다음 장르 트랙을 위한 최소 토대.
- 복귀는 실패가 아니라 루틴의 일부.

Sources:

- Gardner et al., “Making health habitual” — https://pmc.ncbi.nlm.nih.gov/articles/PMC3505409/
- UCL, “How long does it take to form a habit?” — https://www.ucl.ac.uk/news/2009/aug/how-long-does-it-take-form-habit
