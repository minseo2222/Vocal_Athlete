# 추가 외부 리서치 필요 영역 — 2026-06-16

> 목적: 현재 프로젝트 문서가 강한 영역과, 제품 출시 전 외부 검증이 더 필요한 영역을 분리한다.

## 1. 이미 제품 설계에 반영 가능한 근거

| 영역 | 현재 적용 | 제품 반영 |
|---|---|---|
| SOVT | 초급 핵심 루틴 | 빨대·립트릴·허밍 중심 저부하 루틴 유지 |
| 습관 형성 | 짧은 반복 루프 | 1일 1레슨, 복귀 복습, 낮은 마찰 |
| 분산·복습 | 복귀 복습 | 공백 후 review day |
| 모바일 음향 한계 | F0 중심, perturbation 숨김 | jitter/shimmer/HNR 비표시 |
| 보컬 건강 | 통증·쉰목·과사용 경고 | stop signal 및 중급 safety gate |
| 게임화 | 행동 반복 보상 | 안전 완료·쿨다운·복귀 보상 |

## 2. 제품 적용 전 검증이 필요한 주장

| 주장/기능 | 현재 상태 | 필요한 검증 |
|---|---|---|
| 3분류 발성 AI | 문서상 아이디어/후보 | 초보자 음성 데이터셋, 라벨 일치도, 기기별 성능 |
| 한국어 모음 /ㅏㅣㅜ/ 식별 | 목표 수준 | 가창 데이터셋, 방 소음, 남녀/음역별 정확도 |
| 온보딩 없음 | 철학은 명확 | 첫 사용자 이탈/권한 허용률 A/B |
| 표준 샘플 A/B | 강한 제품 아이디어 | 사용자가 성장 체감으로 받아들이는지 UX 테스트 |
| 관대한 streak | 보컬 안전과 정합 | 복귀율·과사용 억제 효과 검증 |
| belt/cover/messa/run cap | 안전상 필요 | 전문가 수치 확정, canary, AE 모니터링 |

## 3. 추가 조사 우선순위

### P0 — 출시 전 필수

1. Android 기기별 마이크/F0 검증.
2. 마이크 권한 거부 UX 테스트.
3. 초보자 첫 레슨 usability test.
4. 녹음 저장·삭제·업로드 정책 법무 검토.

### P1 — V1 안정화

1. streak/복귀 복습 retention 실험.
2. 표준 샘플 A/B의 성장 체감 인터뷰.
3. 저신뢰 pitch null 표시 문구 테스트.
4. completion under 60s 원인 분석.

### P2 — 중급 출시 전

1. belt/twang/cover/messa/run 전문가 cap 확정.
2. 고위험 카드 fallback path 설계.
3. 장르별 canary rollout 기준.
4. 가요/K-pop 코호트 안전 데이터.

## 4. 참고한 외부 근거 URL

- SOVT RCT: https://pmc.ncbi.nlm.nih.gov/articles/PMC4610291/
- NIDCD voice care: https://www.nidcd.nih.gov/health/taking-care-your-voice
- Habit formation review: https://pmc.ncbi.nlm.nih.gov/articles/PMC3505409/
- UCL habit formation summary: https://www.ucl.ac.uk/news/2009/aug/how-long-does-it-take-form-habit
- Mobile acoustic features: https://eresearch.qmu.ac.uk/items/d429911b-a923-4496-9767-677a82bc46b9
- Gamification meta-analysis: https://link.springer.com/article/10.1007/s11423-023-10337-7
- Retrieval practice: https://pubmed.ncbi.nlm.nih.gov/16507066/


- Google Play Data safety: https://support.google.com/googleplay/android-developer/answer/10787469?hl=en
