# 발성안전 HITL 사인오프 패킷

> 목적: 안전-critical 카드를 *발성 전문가(이비인후과·음성치료·공인 보컬 코치)* 검토용으로
> 한 곳에 정리. **AI가 자가 승인하지 않음** — 본 문서는 *결정 필요 항목*을 제시할 뿐이다.
> 근거: ADR-0008(명시 위험수용=HITL 선례). 출시 전 본 항목 사인오프 필수.
> 안전 근거(V6 재검증): belt 고부하·k-keok 위험은 1차 출처로 확정, 손상 방향 유지·강화.
>
> **📎 입력 패킷:** 독립 리서치 2종(Claude 심층·GPT 웹Pro, 2026-06) 교차검증 결과는
> [SAFETY-EVIDENCE-DOSSIER.md](../verification/SAFETY-EVIDENCE-DOSSIER.md). 검토 전 먼저 읽을 것.
> **출시 게이트 연결:** 실제 사용자 공개 조건은 [SAFETY-RELEASE-GATE.md](../verification/SAFETY-RELEASE-GATE.md)를 따른다.
>
> **교차검증 합의(2026-06, 하드 모순 0):** 트웽·패사지오·cover 진입·messa 기초·런 = *조건부
> 가능*, belt 진입·belt 레퍼토리 = *조건부·일반공개 보류*, k-keok = *영구 제외 유지*.
> **⚠️ 사인오프 선결조건:** 두 리서치 모두 텍스트 cue만으로는 불충분 →
> **하드 캡(음역·횟수·지속·주간) + swelling check 게이트 + 다중 stop 신호**가 *앱에 강제 구현*
> 되어야 함을 전제. 즉 belt/cover/messa/런은 "전문가 ✅ **+** 강제 캡 구현 **+** 사람 롤아웃 승인" 후에만 출시.
> 캡 수치 확정은 전문가가 하고, 구현은 `docs/verification/SAFETY-RELEASE-GATE.md`와
> `docs/verification/backlog-safety-enforcement.md`의 별도 개발 슬라이스로 추적한다(자가 수치확정 ❌).

## 2026-06-16 제품 게이트 업데이트

본 패킷의 사인오프는 단독 release 조건이 아니다. 고위험 카드는 아래 두 조건을 모두 만족해야 한다.

1. 전문가 HITL 사인오프 완료.
2. `../verification/SAFETY-RELEASE-GATE.md`의 hard cap / stop signal / fallback / QA 조건 구현.

사인오프만 있고 앱 cap이 없으면 `approved_without_caps` 상태로 간주하고 출시 금지한다. pending 카드는 기본적으로 manifest에서 제외하거나 저부하 fallback 카드로 대체한다.

### 중급 고위험 카드 stop signal 최소 세트

launch warning의 hard stop(통증·어지럼·호흡곤란·각혈)에 더해, 중급 고위험 카드에서는 다음 신호를 카드 화면 또는 stop signal sheet에서 접근 가능하게 한다.

- 쉰 목소리 또는 raspy voice
- 평소보다 고음이 갑자기 안 됨
- 목이 raw/achy/strained하게 느껴짐
- 말하기가 힘들어짐
- 반복적인 목 가다듬기
- 다음날까지 쉰목 지속

정량 cap(음역·반복·지속·주간 빈도)은 AI가 확정하지 않는다. 검토자가 카드별로 승인·수정·보류를 결정한다.


## 출시 게이트 연결

본 문서는 전문가가 카드별로 “교육적으로/발성적으로 승인 가능한가”를 판단하는 입력 패킷이다. 실제 사용자 공개는 아래 3단계를 모두 통과해야 한다.

1. `HITL-SIGNOFF.md` 카드별 결정칸 ✅ 승인.
2. `SAFETY-RELEASE-GATE.md` 기준의 강제 캡 구현 및 테스트 통과.
3. `kSafetySignoff`와 `kReleasedAdvancedGenres`/`kReleasedGenres`를 사람이 갱신하고 `verification-status.json` 정합 확인.

전문가 승인만 있고 앱 강제 캡이 없으면 출시 상태가 아니다.

---

## 사인오프 방법
각 카드의 "결정 필요" 항목에 검토자가 ✅승인 / ✏️수정요청 / ❌보류 + 코멘트.
전 항목 ✅ 전까지 해당 카드 **출시 금지**.

---

## A. 고급 뮤지컬 Lab (advanced-musical; legacy intermediate-musical)

| 카드 | 내용 | 결정 필요 항목 | 검토 |
|---|---|---|---|
| IM-05 call-based 벨트 진입 [S] | "Hey!" 짧은 call, 밝게(크게❌) | 진입 음역 *상한*(어디까지)·세션당 *횟수*·*빈도*(주 몇 회)·지속시간 cap·중단 cue 충분성 | ☐ |
| IM-03 패사지오 처리 | 사이렌으로 전이 관리 | 고음 방향 상한·삑사리 반복 시 중단 임계 | ☐ |
| IM-02 구강 트웽 | AES 협착, 밝게 | 고음 지속 금지 경계·세션 노출량 | ☐ |
| IM-12 레퍼토리(라이트 belt 구절) | legit+라이트 belt | belt 구절 비중 상한·곡 난이도 게이트 | ☐ |

## B. 고급 가요/K-pop Lab (advanced-gayo; legacy intermediate-gayo)

| 카드 | 내용 | 결정 필요 항목 | 검토 |
|---|---|---|---|
| GY-05 라이트 belt 진입 [S] | call-based, 밝게 | IM-05와 동일 + K-pop 미감 압박 하 보수성 유지 방안 | ☐ |
| GY-04 트웽/꽥 | 마녀/오리 소리 | 고음 지속·세션 노출량 | ☐ |
| GY-06 꺽기/런 기초 | 느리게→정확히 | 고음역 런 금지 경계·정확도 게이트 | ☐ |
| GY-09 레퍼토리 | 스피치라이크+라이트 belt | belt 구절 비중 상한 | ☐ |
| **k-keok(강한 글로털 어택)** | **카드 제외** | 결절·출혈 위험으로 *영구 제외* 확인 — 고급/HITL에서도 도입 여부 별도 결정 | ☐ |

## C. 고급 성악 Lab (advanced-classical; legacy intermediate-classical)

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
2. 중단 cue("통증·다음날 쉰목→중단")가 *행동 변화*를 실제로 유도하기에 충분한가, 추가 신호가 필요한가?
   - 추가 검토 후보: 쉰 목소리/거친 목소리, 고음 상실, 갑작스러운 저음화, raw·achy·strained throat, 말하기 노력 증가, 반복 목가다듬기(NIDCD voice health warning signs).
3. 1일1레슨 캡(ADR-0003) 외에 belt 노출 *주간 상한*이 필요한가?
4. 증거강도 낮음(K-pop 코호트 부재 S갭) — 가요 belt를 더 보수화하거나 경고를 강화할까?

> **교차검증 입력(2026-06, 도시에 §2·§4 — 결정은 전문가 몫):**
> Q1·Q2 → 둘 다 **텍스트 cue만으로 불충분**. 다중 stop 신호 + swelling check(○Bastian 1990) 권고.
> Q3 → 둘 다 **주간 상한 필요** 권고(belt 주 2–3회·세션간 24–48h 회복; 단 정량 근거 부재=보수적 추정).
> Q4 → 둘 다 **더 보수화 + "서구 외삽" 명시 경고** 권고(가수 dysphonia ~46% ○Pestana 2017).
> belt 절대 상한: 여 C5/남 A4 아래(✅Bourne&Garnier 2012; 남 A4는 단일 근거 약함 — 검증 요청).

> 본 패킷의 안전 근거·인용은 CITATION-AUDIT(V6)·CITATION-KEYMAP로 검증됨(belt 고부하·
> 손상 역학 방향 확정). 인용 메타데이터 정정 8건은 안전 *방향*에 영향 없음(오히려 강화).


## F. 출시 반영 규칙 (2026-06-16 추가)

전문가가 카드에 ✅를 주더라도 바로 사용자 공개하지 않는다.

1. 본 문서에서 전문가가 카드별 범위·횟수·지속·주간 빈도·중단 신호를 확정한다.
2. `docs/verification/SAFETY-RELEASE-GATE.md`의 release state를 `signedOff`로만 올린다.
3. 강제 cap·swelling check·stop signal·fallback이 코드로 구현되어야 `caps_implemented`가 된다.
4. `DEVICE-MIC-VERIFICATION.md` 기준 검증 후 canary 가능.
5. `kSafetySignoff`와 `verification-status.json`은 사람이 확정한 사실만 반영한다. AI 자가 승인 금지.
