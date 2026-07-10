# v8 Imported Research Source

> **v8 source status — SOURCE_LINKED:** 원문에 URL/서지 링크가 포함되어 있다. v8은 출처 형식과 근거 등급을 정규화했지만 모든 링크의 전문·현재 상태를 개별 재검증한 것은 아니다.

- 원본 파일: `18. Vocal Load - Safety - Recovery #Ub9ac#Uc11c#Uce58.md`
- canonical 역할: `18-vocal-load-safety-recovery.md`

---

# 1. Executive Summary

본 검토는 NIH/NIDCD, ASHA, AAO-HNS 임상 가이드라인, Voice Foundation, 대학 보이스 클리닉 자료와 동료심사 연구를 우선하여 **28개 핵심 출처**를 비교했다.

## 제품팀이 채택해야 할 최상위 결론

**[A·Consensus] 보편적으로 안전한 ‘하루 발성 시간’이나 belt·full take의 ‘안전 반복 횟수’는 확립되어 있지 않다.** 발성 부하는 단순 시간뿐 아니라 음높이, 음압, 발성 지속시간, 반복 밀도, 사용자의 상태와 외부 음성 사용량에 따라 달라진다. 따라서 앱은 “몇 분까지 안전하다”가 아니라 다음 우선순위로 작동해야 한다. ([PMC][1])

> **상태 게이트 → 증상 기반 중단 → 외부 부하 차감 → 강도별 제한 → 시간 제한 → streak**

**[A/B·Consensus] 새로 발생한 쉰목소리, 거칠거나 숨 새는 음질, 갑작스러운 음역·고음 손실, 음성 끊김, 발성통, 증가하는 노력감은 그날의 예산과 무관하게 발성 중단 신호로 취급해야 한다.** NIDCD는 쉰 상태나 피곤한 상태에서 말하거나 노래하지 말 것을 권고한다. ([NIDCD][2])

**[B/C·Consensus 기반 제품정책] `tired`는 음질과 음역이 기준선에 가깝고 통증 없이 노력감만 증가한 상태로 운영상 정의한다. `hoarse`는 거침·숨 샘·눌림·낮아짐·약해짐·음역 손실 같은 음성 변화가 있는 상태로 정의한다.** 이는 의학적 감별이 아니라 보수적인 라우팅 규칙이다. 불확실하면 hoarse 쪽, 즉 Orange로 올린다. ([NIDCD][3])

**[A·Controversy] SOVT는 일부 음성치료와 발성 효율에 유용하지만 ‘성대를 회복시키는 치료’ 또는 ‘쉰 상태에서도 계속 노래하게 해주는 구조 장치’로 볼 수 없다.** 메타분석에서는 일부 개선이 보고됐지만 다른 치료보다 일관되게 우월하지 않았고, 치료 연구를 급성 고강도 노래 후 회복 보장으로 일반화할 수 없다. ([PubMed][4])

**[D·Insufficient Evidence] 아래의 일간·주간 반복 상한은 연구가 밝힌 생물학적 안전선이 아니다.** 이는 위험 노출을 제한하기 위한 **보수적 출시 기본값**이며, 후두과 전문의·singing voice SLP가 참여하는 임상 자문과 출시 후 안전 데이터로 조정해야 한다.

**[C·제품정책] 듣기-only, 악보·가사 분석, 리듬 매핑, 운동 심상은 학습과 streak로 100% 인정한다.** 다만 이를 발성 지구력이나 고강도 기술 졸업의 증거로 사용해서는 안 된다. 신체 연습을 일부 심상·청각 연습으로 대체하는 것은 수행 학습을 보조할 수 있지만, 성대 조건화를 증명하는 자료는 아니다. ([Frontiers][5])

### 근거 표기

* **A:** 강한 연구 근거 또는 근거 기반 임상 가이드라인
* **B:** 반복적으로 관찰되는 임상·교육 현장 합의
* **C:** 전문가 의견 또는 근거에 기초한 제품 안전 추론
* **D:** 제한적·간접 근거 또는 검증이 필요한 제품 기본값

이는 정식 GRADE 평가가 아니라 본 제품 문서의 운영 태그다.

---

# 2. Evidence Review

## 2.1 Evidence Review Table

| 질문                    | 검색·비교 결과                                                                                                                                   | 비판적 해석                                                      | 분류·근거                    | 앱 결정                                             |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------- | ------------------------ | ------------------------------------------------ |
| 무엇이 stop signal인가     | NIDCD와 ASHA는 쉰목소리, 거침·숨 샘·눌림, 고음·음역 손실, 음성 끊김, 노력 증가, 목의 통증·불편 등을 문제 신호로 제시한다. ([NIDCD][2])                                                | 하나의 신호만으로 원인을 진단할 수는 없지만, 훈련 중단에는 진단 확정이 필요하지 않다.           | **Consensus A/B**        | 새 음질 변화·통증·음역 손실은 즉시 발성 종료                       |
| 언제 의료평가가 필요한가         | NIDCD는 3주를 넘는 쉰목소리와 객혈, 삼킴 곤란, 목의 덩이, 발성·삼킴 통증, 호흡 곤란 등을 진료 조건으로 제시한다. AAO-HNS는 4주 안에 호전되지 않거나 심각한 원인이 의심되면 더 일찍 후두 평가를 권고한다. ([NIDCD][3]) | 전문 음성 사용자는 경미한 변화도 직업 기능에 큰 영향을 주므로 조기 평가 경로가 필요하다.         | **Consensus A**          | 3주 시점 강한 상담 안내, 4주를 넘기지 않는 평가 안내; red flag는 즉시   |
| Vocal fatigue란 무엇인가   | 대표적 정의는 시간 경과에 따른 발성 노력감 증가와 기능 저하다. 객관적 지표는 연구마다 일관되지 않고 기전도 복합적이다. ([PubMed][6])                                                         | “피로 점수 하나”를 성대 상태의 객관적 진실로 취급하면 안 된다.                       | **Consensus A / 측정 논쟁**  | 노력감·기능 변화·회복 상태를 함께 수집                           |
| 시간만으로 부하를 계산할 수 있는가   | Vocal dose 연구는 발성시간 외에 주파수, 음압, 진동 거리와 에너지 노출을 구분한다. NIDCD도 음도·크기·기간을 함께 고려하는 dosimetry 연구를 소개한다. ([PMC][7])                               | “오늘 20분이므로 안전” 같은 표현은 근거가 없다.                               | **Consensus A**          | 시간 제한은 강도·반복·상태 게이트 뒤의 보조 제한                     |
| 회복시간은 얼마인가            | 2시간 낭독 연구에서 90% 회복은 약 4–6시간, 완전 회복은 12–18시간으로 관찰됐다. ([PMC][8])                                                                             | 낭독 연구이며 고강도 노래·belt의 회복시간으로 직접 변환할 수 없다. 개인 차도 크다.          | **A 연구 / D 일반화**         | 고강도 블록 간격 설정의 보수적 참고값으로만 사용                      |
| 개인차를 어떻게 다룰까          | Vocal demand에 대한 생리적·지각적 반응은 이질적이며, 단일 객관 지표가 피로를 안정적으로 포착하지 못한다. ([PubMed][9])                                                            | 집단 평균으로 개인의 안전 임계값을 정하면 false reassurance가 생길 수 있다.         | **Consensus A**          | 개인 14일 기준선과 다음날 회복 추적                            |
| 자기보고는 사용할 수 있는가       | VFI와 EASE는 음성 피로 또는 현재 노래 상태를 평가하는 신뢰도 있는 자기보고 도구로 개발됐다. ([PubMed][10])                                                                    | 선별·추적 도구이지 병변 진단 도구가 아니다.                                   | **Consensus A**          | 축약형 상태 체크는 가능하나 “진단 결과”로 표시 금지                   |
| SOVT는 recovery인가      | SOVT RCT와 메타분석은 음성치료·발성 기능 개선 가능성을 지지하지만, 다른 치료보다 일관되게 우월하지는 않다. ([PubMed][4])                                                             | 치료 효과를 급성 조직 손상 회복이나 계속 발성 허가로 해석하면 과장이다.                   | **Controversy A**        | Green의 기술 과제, 일부 Yellow의 짧은 옵션; Orange/Red 기본 금지 |
| 워밍업은 부상을 막는가          | 일부 연구에서 편안함·음성 변수 변화가 보고되지만 작은 표본, 높은 개인차, 일관되지 않은 객관 결과가 있다. ([PubMed][11])                                                               | 준비도·감각 보정과 손상 예방 보장은 별개다. 긴 워밍업 자체가 발성 부하가 될 수 있다.          | **Controversy B/D**      | 워밍업은 안전 면허가 아니며 발성 예산에 포함                        |
| 쿨다운은 회복을 빠르게 하는가      | 가수들은 주관적 이득을 보고했지만 객관적 결과는 불명확하거나 유의하지 않았다. ([PubMed][12])                                                                                 | 선택적 편안함 활동으로는 가능하지만 필수 회복 처치로 설계할 근거는 부족하다.                 | **Insufficient D**       | 선택 기능; streak·안전 판정과 연결 금지                       |
| 수분 섭취는 보호·치료인가        | 체계적 문헌고찰과 임상 가이드는 수분 상태를 vocal hygiene에 포함하지만 실제 투여량과 효과 크기는 이질적이다. ([PubMed][13])                                                         | 수분은 지원 요인이지 쉰목소리나 손상을 상쇄하는 치료가 아니다.                         | **Consensus B / 효과량 논쟁** | 알림은 제공하되 stop signal을 해제하지 않음                    |
| Voice rest는 얼마나 필요한가  | Voice Foundation은 voice rest가 특정 상황에서 계획의 일부일 뿐 대부분의 원인에 대한 단독 치료는 아니라고 설명한다. 수술 후 절대 음성휴식 기간 역시 연구가 제한적이다. ([Voice Foundation][14])       | 건강한 앱 사용자에게 의료적 “절대 침묵”을 처방해서는 안 된다.                        | **Controversy C/D**      | “오늘 앱 발성 훈련을 하지 않기”로 표현                          |
| 고음압은 왜 별도 관리해야 하나     | in-vivo 연구에서 vocal fold collision speed는 음성 강도가 커질수록 강하게 증가했다. ([PubMed][15])                                                              | 조직 손상을 직접 예측하는 개인별 임계값은 아니다. 그래도 고강도 노출을 별도 계량할 기계적 근거가 된다. | **A 기전 / D 임계값**         | G3·G4에 별도 일간·주간 예산 적용                            |
| Belt는 본질적으로 위험한가      | 연구들은 belt의 생리·음향 특성을 기술하지만 안전 반복 횟수나 손상률을 확립하지 않았다. ([PubMed][16])                                                                         | 기술 이름만으로 위험 등급을 고정하면 안 된다. 음압·음역·지속·반복·숙련도를 봐야 한다.          | **Controversy B/D**      | 가벼운 belt는 G2일 수 있고, 근최대 belt는 G4                 |
| 듣기·심상은 학습인가           | 일부 음악 수행 연구에서 신체 연습 일부를 청각·심상 연습으로 대체해도 수행 학습이 유지될 수 있었다. ([Frontiers][5])                                                                 | 성악 발성 지구력에 대한 직접 연구가 아니며 조직 적응을 만들었다고 볼 수 없다.               | **C/D**                  | 인지·청각 학습과 streak는 인정, 발성 conditioning 인정 금지      |
| 앱 오디오가 쉰목소리를 판정할 수 있나 | ASHA는 의료적 후두 병리 진단이 후두 영상과 전문 평가를 필요로 하며, 녹음 장비·거리·환경 잡음도 음향 측정에 오차를 만든다고 명시한다. ([ASHA][17])                                               | 오디오 모델은 기준선 변화 탐지 보조 기능일 뿐 의료 판정기가 아니다.                     | **Consensus A**          | 사용자 보고를 모델보다 우선; “변화 감지”만 표시                     |
| 정확한 반복 제한은 알려져 있는가    | vocal dose, belt, warm-up, recovery 문헌 어디에도 full take·belt·run의 보편적 안전 횟수는 제시되지 않는다. ([PMC][1])                                            | 수치를 제시하더라도 안전선이 아니라 제품의 노출 제한값이어야 한다.                       | **Insufficient D**       | 보수적 출시 cap + 안전 데이터 기반 재검증                       |

---

# 3. Consensus

## 3.1 전문가들이 대체로 동의하는 내용

1. **[A/B·Consensus] 증상은 예산보다 우선한다.** 계획된 시간과 반복 수가 남아 있어도 새 쉰목소리, 통증, 음역 손실, 음성 끊김, 갑작스러운 변화가 생기면 중단한다. ([NIDCD][2])

2. **[A·Consensus] Vocal load는 시간 하나가 아니다.** 음압, 음높이, 발성시간, 반복 및 개인 반응을 함께 봐야 한다. ([PMC][7])

3. **[A·Consensus] 개인 기준선이 인구 평균보다 중요하다.** 같은 과제에도 피로 반응과 회복 궤적이 크게 다르다. ([PMC][18])

4. **[B·Consensus] 말하기도 음성 부하다.** speaking-only 레슨은 회복 모드의 무성 과제가 아니다. 속삭임도 자동으로 안전한 대체 수단이 아니다. ([NIDCD][2])

5. **[B·Consensus] 질병이나 쉰 상태에서는 고강도 발성을 하지 않는다.** NIDCD는 아프거나 목소리가 쉰·피곤한 상태에서 음성 사용을 줄이도록 권고한다. ([NIDCD][2])

6. **[A·Consensus] 앱은 병변을 진단할 수 없다.** 기질적 후두 병리의 판정은 후두과 평가 영역이다. ([ASHA][17])

7. **[A/B·Consensus] SOVT, 워밍업, 수분 섭취는 stop signal을 무효화하지 않는다.** 이들은 특정 상황에서 유용한 지원 전략이지만 “계속 노래해도 안전하다”는 증거가 아니다. ([PubMed][4])

8. **[C·제품 합의] 안전한 중단·회복 선택도 성공 행동으로 보상해야 한다.** streak가 추가 발성을 유도하면 학습 시스템이 안전 시스템과 충돌한다.

---

# 4. Controversies

| 쟁점                   | 견해가 갈리는 지점                                              | 현재 판단                   | 제품 해석                                           |
| -------------------- | ------------------------------------------------------- | ----------------------- | ----------------------------------------------- |
| 워밍업                  | 준비도·편안함을 높인다는 관찰 vs 손상 예방을 입증하지 못한 연구                   | **Controversy B/D**     | “준비 상태 확인”으로 설명하고 안전 보장 문구 금지                   |
| 쿨다운                  | 주관적 회복감 보고 vs 객관적 효과의 불일치                               | **Insufficient D**      | 선택형 편안함 과제; 필수 졸업조건 금지                          |
| SOVT recovery        | 효율 개선·치료 효과 vs 급성 피로나 손상 회복 증거 부족                       | **Controversy A**       | Yellow에서 제한적 micro-check만; hoarse 상태의 구조 과제로 금지 |
| 휴식일                  | 회복을 위한 휴식 필요성에는 동의하지만 보편적인 주간 횟수는 없음                    | **Insufficient D**      | G4 비연속일 정책은 보수적 제품값으로 운영                        |
| Belt 위험              | 특정 belt는 높은 음압·접촉 요구를 가질 수 있지만 belt라는 이름 자체가 손상을 뜻하지 않음 | **Controversy B/D**     | 기술명 대신 실제 강도·음역·반복으로 등급화                        |
| `tired`와 `hoarse` 구분 | 지각적 구분은 가능하지만 동일 원인·병변 여부를 앱에서 알 수 없음                   | **Consensus B / 진단 불가** | 라우팅 구분만 사용하고 의학적 감별 문구 금지                       |
| 수분 섭취량               | hydration의 일반적 가치는 지지되나 정확한 양과 즉각적 치료 효과는 불확실           | **Controversy B/D**     | 일반적 건강 알림만 제공                                   |
| 오디오 AI               | 개인 기준선 변화 탐지 가능성 vs 기기·환경 오차 및 병리 진단 불가                 | **Controversy A/C**     | 위험 축소에 사용하지 않고 추가 확인을 요청하는 방향으로만 사용             |
| 정확한 반복 cap           | 근거 기반 수치가 필요하다는 제품 요구 vs 연구상 보편 수치 부재                   | **Insufficient D**      | 수치를 “안전 한계”가 아닌 출시 노출 제한값으로 표시                  |

---

# 5. Curriculum Design Implications

커리큘럼의 단위는 “무엇을 가르칠 것인가”가 아니라 **사용자가 어떤 안전 행동을 독립적으로 수행할 수 있는가**로 정의해야 한다.

| 학습목표: 사용자가 할 수 있게 될 것         | 훈련과제                                        | 앱 피드백                   | 졸업기준                                | 근거      |
| ----------------------------- | ------------------------------------------- | ----------------------- | ----------------------------------- | ------- |
| 자신의 평소 음성과 오늘 상태의 차이를 식별한다    | 60초 pre-check: 노력감, 음질 변화, 통증, 음역·반응, 외부 부하 | 개인 기준선과의 차이만 표시. 진단명 금지 | 7회 연속 체크 누락 없음; 위험 시나리오에서 안전한 등급 선택 | **A/C** |
| stop signal이 생기면 즉시 세트를 종료한다  | 짧은 시나리오 또는 저강도 세트에 “중단” 버튼 포함               | “중단은 실패가 아니라 오늘의 목표 달성” | stop signal 시나리오 100% 중단 선택         | **A/C** |
| `tired`와 `hoarse`를 안전하게 라우팅한다 | 음질 변화 유무, 통증, 음역 손실을 비교하는 예시                | 불확실하면 Orange를 선택하도록 안내  | 위험도를 낮춰 선택하는 오류 0회                  | **B/C** |
| 앱 밖 음성 사용량을 예산에 반영한다          | 수업·회의·공연·리허설·응원·장시간 통화 기록                   | 외부 부하를 반영한 남은 앱 예산 표시   | 14일 동안 외부 부하 기록 완료                  | **A/D** |
| 듣기-only로도 기술 학습을 진행한다         | 리듬 탭, 가사·모음 매핑, 프레이즈 분석, 녹음 비교              | 청각·인지 정확도 피드백           | 퀴즈 또는 구간 식별 정확도 80% 이상              | **C/D** |
| SOVT가 가능한 상태와 불가능한 상태를 구분한다   | Yellow/Orange/Red 사례 분류                     | “SOVT도 발성 부하”라고 피드백     | hoarse·통증·갑작스러운 변화 사례에서 SOVT 선택 0회  | **A/C** |
| 고강도 기술을 소수 반복과 분석 사이클로 연습한다   | `시도 1–2회 → 무성 분석 → 다음 결정`                   | HIU 차감과 다음날 회복 체크       | 6회 세션 동안 cap 미초과, stop signal 무시 0회 | **D**   |
| 의료적 경고 신호를 인식하고 레슨을 끝낸다       | 호흡 곤란, 갑작스러운 음성 소실, 객혈 등 시나리오               | 레슨 종료 및 진료 경로 제공        | Red 시나리오 100% 정확                    | **A/C** |

**졸업의 의미는 “이 과제를 세게 수행했다”가 아니라 “상태를 판별하고, 제한을 지키며, 필요할 때 중단했다”여야 한다.**

---

# 6. App Implementation Implications

## 6.1 반드시 답해야 할 10개 질문

### 1. 어떤 상태를 stop signal로 볼 것인가?

**[A/B·Consensus] 즉시 해당 세트를 끝내는 신호**

* 새로 생긴 거칠고, 숨 새고, 눌리거나 약해진 음질
* 평소보다 목소리가 낮아지거나 고음·음역이 사라짐
* 반복적인 voice break 또는 음정·발성 반응의 갑작스러운 저하
* 발성 중 통증, 타는 느낌, raw/achy feeling
* 반복할수록 노력감이 계속 상승
* 갑작스러운 음성 소실 또는 고강도 사용 직후 급격한 변화
* 호흡 곤란, 객혈, 삼킴 곤란 등 Red 신호

NIDCD는 갑작스러운 격한 음성 사용 중 음성을 잃는 경우 성대출혈 가능성을 포함해 즉각적인 평가가 필요한 상황으로 설명한다. 앱은 이를 진단해서는 안 되지만, **즉시 중단 신호**로 처리해야 한다. ([NIDCD][2])

**[C·제품정책] 경고가 발생하면 잠시 쉬었다 좋아졌다는 이유로 같은 고강도 과제를 다시 열어주지 않는다.** 그날은 Orange 또는 Red 규칙을 유지한다.

---

### 2. `tired`와 `hoarse` 상태를 어떻게 구분할 것인가?

| 구분                  | 운영상 정의                                      | 등급     | 루틴 변경                             |
| ------------------- | ------------------------------------------- | ------ | --------------------------------- |
| 일반적 몸의 피곤함, 음성은 기준선 | 수면 부족·전신 피로가 있으나 음질·음역·통증 변화 없음             | Yellow | G0 중심, 필요 시 매우 짧은 G1              |
| Vocal tired         | 평소보다 노력감·지구력 저하가 있으나 음질과 음역은 대체로 기준선, 통증 없음 | Yellow | 기본은 G0; 익숙한 SOVT micro-check만 조건부 |
| Hoarse              | 거침·숨 샘·눌림·약해짐·낮아짐, break, 고음·음역 손실 중 하나 이상  | Orange | 모든 앱 발성 종료                        |
| 통증·갑작스러운 소실·호흡 문제   | 심한 통증, 급격한 변화 또는 전신 경고 신호                   | Red    | 레슨 종료 및 의료 안내                     |

**[C] “tired라고 답했으므로 안전하다”는 판정은 금지한다.** 사용자가 tired라고 표현해도 음질·음역 변화가 동반되면 Orange로 올린다. 오디오가 정상으로 들려도 사용자의 변화 보고를 무시하지 않는다. ([PubMed][6])

---

### 3. High-intensity 카드의 daily/weekly cap은 어떻게 설계할 수 있는가?

**[D·보수적 출시 기본값]**

* 신규·교정 기간: G4 잠금, G3 최대 **4 HIU/일, 8 HIU/주**
* Advanced Lab 졸업 후: G3+G4 최대 **8 HIU/일, 20 HIU/주**
* 고강도일: 최대 **주 3일**
* G4: **연속일 금지**, G4 하위 예산 최대 **4 HIU/일, 8 HIU/주**
* 공연·고강도 리허설이 있었던 날: 앱 G3/G4 예산 **0**
* Yellow/Orange/Red: G3/G4 예산 **0**
* stop signal은 남은 HIU와 관계없이 예산을 즉시 0으로 만든다.

`HIU`는 아래처럼 제품 내부에서 계량한다.

* G3 target set 1개: **1 HIU**
* G4 target event 또는 near-max set 1개: **2 HIU**
* 70–85% submax full take: 최소 **3 HIU**
* performance-intensity full take: 최소 **4 HIU**
* full take 안의 G3/G4 이벤트 합산값이 더 크면 더 큰 값을 사용

이 수치는 임상적 안전선이 아니다. **“제품이 허용하는 최대 노출”**이라고 정의해야 한다.

---

### 4. Recovery mode에는 무엇만 허용해야 하는가?

* **Yellow:** 듣기·분석·심상 중심. 음질 변화·통증·음역 손실이 없고 사용자에게 이미 익숙한 경우에만 60–90초의 편안한 G1/SOVT 확인 과제
* **Orange:** G0 무성 과제만 허용
* **Red:** 레슨 콘텐츠 없이 안전 안내와 streak 보호만 제공
* speaking-only, humming, lip trill, straw phonation은 모두 phonation이므로 Orange/Red의 무성 회복 과제가 아니다.

**[C] Yellow의 SOVT micro-check가 노력감이나 음질을 조금이라도 악화시키면 즉시 G0로 전환한다.** SOVT를 완료해야 회복 모드를 졸업하도록 설계하지 않는다.

---

### 5. 듣기-only 레슨을 학습으로 인정할 수 있는가?

**그렇다. [C/D]** 다음 역량의 학습으로 인정할 수 있다.

* 음정·리듬·프레이즈 식별
* 가사·모음·자음 배치
* dynamic contour와 호흡 위치 분석
* 자신의 녹음과 reference take 비교
* 운동 심상과 공연 순서 기억

다만 다음으로는 인정하지 않는다.

* 발성 지구력 증가
* G3/G4 신체 적응
* belt 또는 high-note gate 통과
* hoarse 상태가 회복됐다는 증거

따라서 데이터 모델에서 `lesson_completed`와 `voiced_capacity_verified`를 별도 필드로 관리해야 한다.

---

### 6. 고급 장르 Lab의 반복 수는 어떻게 제한해야 하는가?

정확한 생물학적 임계값은 없으므로 아래는 **D등급 제품 상한**이다.

| 과제                              |  세트 상한 |        일간 상한 |    주간 상한 | Green fallback               |
| ------------------------------- | -----: | -----------: | -------: | ---------------------------- |
| 70–85% full take                | 블록당 1회 |           2회 |       4회 | 구간별 60–70%, 듣기·주석            |
| Performance-intensity full take | 블록당 1회 |           1회 | 2회, 비연속일 | submax take 또는 무성 분석         |
| 고강도 belt phrase                 |  연속 2회 | 동일 phrase 6회 |      12회 | 중간 강도, 낮은 조성·옥타브, 리듬 분석      |
| Full-tempo/full-voice run       | 세트당 3회 |  pattern당 6회 |      12회 | 속도 축소, 리듬 탭, 저강도 부분 연습       |
| 큰 dynamic contrast              | 세트당 2회 |           4회 |       8회 | 중간 dynamic으로 구조 연습           |
| High phrase                     | 세트당 2회 |           6회 |      12회 | 조옮김, 낮은 음역 mark, 심상          |
| Near-max sustained high note    | 세트당 1회 |           3회 |       6회 | 짧은 duration, 낮은 강도·음고        |
| Distortion·extended effect      | 세트당 1회 |           3회 |       6회 | clean low-intensity 대체 또는 듣기 |

**적용 규칙**

1. 과제별 상한과 총 HIU 중 **먼저 도달한 제한**을 적용한다.
2. belt·run이라는 이름만으로 등급을 정하지 않는다. 낮은 음압·느린 속도의 run은 G1/G2가 될 수 있다.
3. 한 번이라도 stop signal이 발생하면 표의 남은 횟수는 소멸한다.
4. fallback은 Green에서만 발성형으로 허용한다. Yellow/Orange에서는 G0 fallback으로 바꾼다.

---

### 7. Streak 때문에 무리하지 않게 하는 UX 문구는 무엇인가?

권장 문구:

* **“오늘의 목표는 더 부르는 것이 아니라 목소리를 보호하는 것입니다.”**
* **“노래하지 않아도 오늘의 streak는 유지됩니다.”**
* **“회복 레슨 완료 — 안전한 선택도 훈련입니다.”**
* **“고강도 예산을 모두 사용했습니다. 듣기·분석 레슨으로 계속 학습할 수 있습니다.”**
* **“여기서 중단하면 오늘의 안전 목표를 달성합니다.”**
* **“목소리 변화가 보고되어 발성 과제를 종료했습니다. 이는 실패가 아닙니다.”**

피해야 할 문구:

* “조금만 더 하면 목표 달성”
* “기록을 잃지 마세요”
* “하루 쉬면 실력이 떨어집니다”
* “통증을 이겨내세요”
* “워밍업했으니 안전합니다”
* “마지막 한 번만”
* “오늘의 노래 시간이 부족합니다”

**[C] streak freeze를 희소 아이템이나 유료 기능으로 만들지 않는다.** Yellow·Orange는 G0 레슨으로 완전 인정하고, Red는 아무 과제 없이 자동 보호한다.

---

### 8. SOVT-only 루틴은 언제 적절한가?

**적절할 수 있는 상황 [A/C]**

* Green에서 발성 효율·감각 보정을 학습할 때
* Yellow에서 음질 변화, 통증, 음역 손실, 급성 질환이 없고 단지 가벼운 노력감만 있을 때
* 이전에 정상 상태에서 배운 익숙한 SOVT를 매우 짧게 확인할 때
* 의료진이 개인별로 처방한 계획을 앱이 단순히 지원할 때

**부적절한 상황**

* 새 쉰목소리 또는 갑작스러운 음질 변화
* 발성통·삼킴통
* 갑작스러운 고음·음역 손실
* 급성 상기도 질환·후두염 의심
* 강한 발성 중 갑작스러운 음성 소실
* Red 신호
* “SOVT 후 괜찮아졌으니 belt를 재개하기” 위한 readiness test

SOVT도 발성시간과 진동 노출에 포함해야 한다. ([PubMed][4])

---

### 9. “오늘은 노래하지 않는 것이 최선”인 상황은 무엇인가?

**[A/B·Consensus]**

* 새로 발생한 쉰목소리
* 평소와 다른 거침·숨 샘·눌림·낮아짐
* 고음 또는 음역 손실
* voice break의 증가
* 발성통이나 raw/achy feeling
* 감기·급성 상기도 질환과 음성 변화
* 전날 고강도 사용 후 기준선으로 회복되지 않음
* 강한 외부 공연·리허설로 그날의 부하가 이미 높은 경우
* 갑작스러운 음성 소실이나 Red 신호

NIDCD는 쉰 상태나 피곤한 상태에서 말하거나 노래하지 않고, 아플 때 목소리를 쉬게 하도록 권고한다. ([NIDCD][2])

---

### 10. 의료적 판단처럼 보이지 않으려면 어떤 문구를 피해야 하는가?

| 피해야 할 표현             | 안전한 대체                                     |
| -------------------- | ------------------------------------------ |
| “성대가 부었습니다.”         | “평소와 다른 음성 변화가 보고되었습니다.”                   |
| “성대가 손상되었습니다.”       | “앱은 원인이나 조직 상태를 판단할 수 없습니다.”               |
| “결절인 것 같습니다.”        | “지속되는 변화는 ENT/후두과 평가가 필요할 수 있습니다.”         |
| “현재 안전합니다.”          | “현재 입력에서는 stop signal이 보고되지 않았습니다.”        |
| “SOVT가 성대를 회복시킵니다.”  | “SOVT는 일부 상황에서 낮은 부하의 발성 과제로 사용됩니다.”       |
| “이 루틴으로 치료됩니다.”      | “이 콘텐츠는 교육용이며 진단·치료를 제공하지 않습니다.”           |
| “계속 노래해도 됩니다.”       | “편안함이 유지되고 변화가 없을 때만 제한된 과제를 진행합니다.”       |
| “병원에 갈 필요가 없습니다.”    | “앱 결과는 의료평가 필요성을 배제하지 않습니다.”               |
| “오늘 절대 음성휴식을 처방합니다.” | “오늘 앱 내 발성 훈련을 하지 않는 경로를 권장합니다.”           |
| “오디오 분석에서 정상입니다.”    | “녹음에서는 큰 변화가 감지되지 않았지만, 사용자 증상 보고가 우선합니다.” |

---

# 7. Safety Considerations

## 7.1 임상 경계

**[A] 앱은 organic pathology, 성대출혈, 결절, 부종, 염증을 진단하거나 배제해서는 안 된다.** 의료적 후두 병리 진단에는 후두과 전문 평가와 필요한 경우 후두 영상이 필요하다. ([ASHA][17])

## 7.2 False reassurance 방지

* 오디오 모델의 “정상” 결과로 사용자 보고를 덮어쓰지 않는다.
* hydration, warm-up, SOVT 완료 여부로 위험 단계를 낮추지 않는다.
* 잠깐 좋아진 것을 조직 회복의 증거로 취급하지 않는다.
* cap 미도달을 “안전”으로 표시하지 않는다.
* 과거에 성공한 음역이라고 오늘도 허용하지 않는다.

## 7.3 의료상담 권장 조건

**긴급 도움**

* 호흡 곤란·stridor 또는 기도 문제가 의심되는 상황
* 객혈
* 심각한 삼킴 곤란
* 급격한 전신 악화

**신속한 ENT/후두과 평가**

* 격한 발성 중 갑작스러운 음성 소실
* 갑작스럽고 뚜렷한 음역 손실
* 심한 발성통
* 최근 삽관, 머리·목·가슴 수술 이후 음성 변화
* 목의 덩이
* 전문 음성 사용자의 반복·지속되는 변화

**지속성 증상**

* NIDCD: 쉰목소리가 3주를 넘으면 진료 권고
* AAO-HNS: 4주 이내 호전되지 않으면 후두 평가, 심각한 원인이 의심되면 더 일찍 평가 ([NIDCD][3])

## 7.4 제외 또는 별도 경로가 필요한 사용자

**[C]** 수술 후, 진단된 성대 병변, 신경학적 음성질환, 현재 음성치료 중인 사용자에게는 일반 앱 cap을 적용하지 않는다. 의료진 계획을 입력하는 별도 `clinician-guided mode`가 필요하다.

## 7.5 안전 지표

제품 KPI에 단순 sung minutes 대신 다음을 포함한다.

* stop signal 이후 재시도율
* cap override 시도율
* 다음날 기준선 미회복률
* G3/G4 후 Orange 전환률
* 안전 streak 선택률
* 의료 문구가 진단으로 오인된 신고율
* 오디오 모델과 자기보고 불일치율

---

# 8. Recommended Framework

## 8.1 최종 산출물 1 — Vocal Load Budget Policy

### 정책 구조

1. **State Gate**

   * Green만 G3/G4 가능
   * Yellow는 G0 중심
   * Orange/Red는 voiced budget 0

2. **External Load Debit**

   * 장시간 회의·수업·콜센터·사회적 대화: 앱 voiced budget 축소
   * 고강도 리허설·공연·응원: 앱 G3/G4 예산 0
   * 질병·수면 부족·전신 피로: 한 단계 상향

3. **Voiced App Budget — D등급 출시값**

   * 첫 14일 calibration: 최대 **15 voiced minutes/일, 60분/주**, 5분 이하 블록
   * Green 졸업 사용자: 최대 **25 voiced minutes/일, 100분/주**, 5–7분 블록
   * Yellow: 기본 0분, 조건부 G1/SOVT **총 3분 이하**
   * Orange/Red: 0분

4. **Intensity Budget**

   * calibration: G3 최대 4 HIU/일, 8/주; G4 잠금
   * advanced: G3+G4 최대 8 HIU/일, 20/주
   * 고강도일 최대 주 3일
   * G4 연속일 금지

5. **모든 발성 포함**

   * 워밍업, 쿨다운, SOVT, humming, speech drill도 voiced minutes에 포함
   * 듣기·심상·리듬 탭은 G0

6. **Stop Override**

   * stop signal 하나라도 발생하면 그날 남은 voiced budget과 HIU를 0으로 설정

7. **Next-day Reset Gate**

   * 다음날 음질·음역·노력감이 개인 기준선으로 돌아오지 않으면 예산을 복구하지 않고 Orange 또는 Yellow 경로로 전환

**[D] 위 시간·HIU 값은 앱이 추가하는 노출을 제한하기 위한 값이며, 사용자의 하루 전체 음성 사용에 대한 의학적 안전 기준이 아니다.**

---

## 8.2 최종 산출물 2 — Evidence Review Table

Section 2의 표를 제품 요구사항 데이터베이스로 옮길 때 다음 세 상태를 필수 필드로 둔다.

* `consensus`: 그대로 안전 규칙에 채택
* `controversy`: 사용자 선택 기능 또는 보수적 기본값
* `insufficient_evidence`: 실험 플래그와 임상 자문 없이는 “근거 기반” 표기 금지

각 정책 레코드는 다음을 저장한다.

`claim → evidence_level → source → limitation → product_rule → review_date → safety_owner`

---

## 8.3 최종 산출물 3 — Intensity Grade System

| 등급     | 정의                               | 예시                                                  | 운영 규칙                   |
| ------ | -------------------------------- | --------------------------------------------------- | ----------------------- |
| **G0** | 무발성 학습                           | 듣기, 리듬 탭, 가사·악보 분석, 심상                              | 모든 회복 모드의 기본값           |
| **G1** | 편안한 중음역·낮은 노력의 짧은 발성             | 익숙한 가벼운 SOVT, 편한 음역의 짧은 패턴                          | Yellow에서 조건부 micro-dose |
| **G2** | 중간 음량·음역·지속의 기술 연습               | 중간 dynamic phrase, 느린 run                           | Green만                  |
| **G3** | 높은 음압·상부 음역·빠른 반복·긴 take 중 하나 이상 | 고강도 phrase, full-tempo run, submax full take        | HIU 적용                  |
| **G4** | near-max 음압·음역·지속 또는 복합 고위험 효과   | performance belt, near-max high note, 고강도 full take | Advanced gate, 비연속일     |

**[D] 보조 판정값:** 자각 노력도 0–10에서 G1=0–2, G2=3–4, G3=5–6, G4=7 이상으로 사용할 수 있다. 이는 임상 임계값이 아니라 UX용 휴리스틱이다.

다음 중 가장 높은 항목이 전체 등급을 결정한다.

* 음압·자각 강도
* 개인 음역 대비 음높이
* 한 번의 지속시간
* 반복 밀도
* 새로운 기술인지 여부
* full take인지 isolated phrase인지
* distortion 등 추가 효과
* 당일 외부 부하

---

## 8.4 최종 산출물 4 — Green / Yellow / Orange / Red Risk Table

| 단계         | 사용자 상태                                               | 허용 훈련                        | 제한 훈련                         | 금지 훈련                                                          | 앱 문구                                                       | Streak      | 상담 권장                          |
| ---------- | ---------------------------------------------------- | ---------------------------- | ----------------------------- | -------------------------------------------------------------- | ---------------------------------------------------------- | ----------- | ------------------------------ |
| **Green**  | 개인 기준선과 유사, 통증·음질 변화·음역 손실 없음, 전회복                   | G0–G2, 예산 내 G3, gate 통과 시 G4 | HIU·일/주 cap, 외부 부하 차감         | stop signal을 무시한 반복                                            | “평소 기준선에 가깝습니다. 편안함이 유지될 때만 진행합니다.”                        | 정상 완료       | 반복되는 Yellow/Orange 또는 직업적 우려 시 |
| **Yellow** | 가벼운 노력감·전신 피로·높은 외부 부하, 음질·음역 변화와 통증 없음              | G0, 조건부 60–90초의 익숙한 G1/SOVT  | voiced 총 3분 이하, 즉시 중단 가능 과제   | G2–G4, belt, full take, high phrase, speaking lesson           | “오늘은 부하를 낮춥니다. 무성 레슨도 동일하게 기록됩니다.”                         | G0 완료로 100% | 반복·악화, 회복 지연, 전문 음성 사용자        |
| **Orange** | 새 쉰목소리, 음역 손실, break 증가, 통증·raw feeling, 질환 동반 음성 변화 | 듣기·심상·리듬·가사·녹음 분석, 편안한 전신 이완 | 필요한 일상 의사소통만; 앱은 발성 과제 제공 안 함 | 노래, speaking-only, SOVT, humming, vocal warm-up/cool-down, 고강도 | “오늘은 노래하지 않는 것이 최선입니다. 무성 학습으로 전환합니다.”                     | G0로 100%    | 조기 상담 안내; 지속 시 3–4주 규칙         |
| **Red**    | 갑작스러운 음성 소실, 호흡 곤란, 객혈, 심한 삼킴 문제, 심한 통증, 목의 덩이 등     | 안전 정보와 의료 경로만                | 없음                            | 모든 앱 발성·SOVT·속삭임 과제                                            | “레슨을 중단하세요. 앱은 원인을 판단할 수 없습니다. 긴급 증상이 있으면 즉시 의료 도움을 받으세요.” | 과제 없이 자동 보호 | 응급 또는 신속한 ENT/후두과 평가           |

---

## 8.5 최종 산출물 5 — Stop Signal List

### Hard stop — 즉시 종료

* 새 hoarseness 또는 뚜렷한 음질 변화
* 발성통 또는 심한 목 불편
* 갑작스러운 음역·고음 손실
* 갑작스러운 음성 소실
* 호흡 곤란
* 객혈
* 심각한 삼킴 문제
* 반복할수록 빠르게 악화되는 노력감

### Set stop — 해당 과제 종료 및 Orange 확인

* 음성 끊김이 평소보다 증가
* 소리가 갑자기 약해지거나 낮아짐
* 같은 음을 만들기 위한 노력이 계속 증가
* 음정·onset 반응이 갑자기 무너짐
* 평소 가능한 soft/high response가 사라짐

### Precaution — Yellow 전환

* 높은 외부 음성 사용량
* 수면 부족 또는 전신 피로
* 건조감
* 잦은 throat clearing
* 가벼운 노력감
* 전날 고강도 훈련 후 완전 회복 여부 불확실

---

## 8.6 최종 산출물 6 — Tired / Hoarse Adaptation Policy

1. `tired + 음질·음역 정상 + 통증 없음` → Yellow
2. `tired + 음질 변화 또는 음역 손실` → Orange
3. `hoarse self-report` → 오디오와 관계없이 Orange
4. `오디오 변화 감지 + 사용자 무증상` → Yellow 확인, 진단 문구 금지
5. `통증 또는 갑작스러운 변화` → Orange/Red
6. `불확실` → 더 높은 위험 단계
7. `speaking-only`는 recovery가 아니라 voiced load
8. Yellow가 다음날 기준선으로 돌아오지 않으면 Green 자동 복귀 금지

---

## 8.7 최종 산출물 7 — Recovery Lesson Library

| Recovery lesson         | 사용자 학습목표                    | 과제                    | 피드백·졸업기준                         |
| ----------------------- | --------------------------- | --------------------- | -------------------------------- |
| Reference Listening     | 목표 음색·dynamic을 구별한다         | 두 take 비교             | 차이 식별 80% 이상                     |
| Rhythm Mapping          | run의 리듬 구조를 발성 없이 수행한다      | 손가락 탭·시각적 subdivision | 정해진 tempo에서 정확도                  |
| Lyric/Phonetic Mapping  | 가사·모음·자음 위치를 계획한다           | 무성 표기·색인              | 구간 순서와 모음 선택 정확                  |
| Phrase Architecture     | 호흡·dynamic·고음 위치를 예측한다      | 악보에 구간 표시             | 위험 구간을 사전 식별                     |
| Recording Review        | 자신의 피로 전후 변화를 관찰한다          | 과거 녹음 A/B 비교          | 객관적 관찰과 감정 평가 분리                 |
| Mental Rehearsal        | 신체 발성 없이 공연 순서를 회상한다        | 눈감고 cue·가사·동작 심상      | 누락 없는 순서 회상                      |
| Body Release            | 과도한 전신 긴장을 낮춘다              | 힘을 주지 않는 목·어깨·몸 움직임   | 통증·어지러움 없이 완료                    |
| Environment Check       | 외부 위험을 줄인다                  | 소음·습도·마이크·일정 확인       | 다음 세션의 부하 감소 계획                  |
| Safety Literacy         | red flag와 stop signal을 구분한다 | 사례 퀴즈                 | Red 100%, Orange 90% 이상          |
| Yellow SOVT Micro-check | 익숙한 저부하 과제를 즉시 중단할 수 있다     | 60–90초 이하             | 노력감 동일 또는 감소; 악화 시 실패가 아니라 G0 전환 |

Orange와 Red에서는 마지막 SOVT 항목을 제공하지 않는다.

---

## 8.8 최종 산출물 8 — High-risk Cap / Fallback Table

Section 6.1.6의 task별 cap을 기본 테이블로 사용한다. 추가 전역 규칙은 다음과 같다.

* 동일 과제의 연속 시도 사이에 무성 분석 단계를 삽입
* G3/G4 카드의 “다시 시도” 버튼은 무제한으로 제공하지 않음
* performance take 이후 같은 블록에서 performance take 재시도 금지
* G4 다음날 자동으로 G4 잠금
* 공연 당일 앱 G3/G4 잠금
* 외부 리허설을 기록하지 않아도 사용자가 “목소리를 많이 썼다”고 답하면 high-risk budget 0
* fallback 버튼의 첫 번째 선택지는 항상 G0
* 음높이만 낮추고 동일 음압·반복을 유지하는 fallback은 저부하로 간주하지 않음

---

## 8.9 최종 산출물 9 — Streak Safety UX

### Streak 인정 방식

* Green: 일반 레슨 완료
* Yellow: G0 recovery lesson 완료
* Orange: G0 lesson 또는 “오늘 발성하지 않기” 선택 완료
* Red: 사용자 행동을 요구하지 않고 자동 streak 보호
* 의료상담 예약·안전 교육 확인도 학습 이벤트로 인정
* sung minutes나 최고음 달성량으로 streak 가중치 부여 금지

### 보상할 행동

* 스스로 stop 누르기
* 상태를 Yellow/Orange로 올리기
* 고강도 cap 준수
* 무성 fallback 선택
* 다음날 미회복 보고
* 의료상담 안내 열기

### 보상하지 않을 행동

* 통증 속 반복
* streak 확보를 위한 마지막 take
* cap 직전의 몰아넣기
* 최고음·음량만을 기준으로 한 leaderboard
* recovery day를 건너뛴 연속 G4

---

## 8.10 최종 산출물 10 — Medical Disclaimer-safe Language

제품 전역 고정문구:

> “이 앱은 음성 상태의 원인이나 성대 조직을 진단하지 않습니다. 사용자가 보고한 변화에 따라 훈련 강도를 보수적으로 조정합니다.”

Orange 문구:

> “평소와 다른 음성 변화가 보고되어 오늘의 앱 발성 훈련을 종료합니다. 원인은 앱이 판단할 수 없습니다. 증상이 지속되거나 악화되면 ENT·후두과 또는 음성 전문 의료진에게 상담하세요.”

Red 문구:

> “지금은 레슨을 중단하세요. 호흡 곤란, 객혈, 심각한 삼킴 문제 또는 갑작스러운 음성 소실이 있으면 지역 응급 또는 신속한 의료 도움을 받으세요.”

오디오 모델 문구:

> “녹음에서 평소 기준선과의 차이가 감지되었습니다. 이는 의학적 판정이 아닙니다.”

---

## 8.11 최종 산출물 11 — Final Safety Policy

제품 요구사항을 다음의 강제 규칙으로 확정하는 것이 권장된다.

1. 앱은 모든 voiced lesson 전에 상태 체크를 시행한다.
2. stop signal은 시간·반복·HIU보다 우선한다.
3. 앱은 사용자 보고보다 오디오 모델을 우선하지 않는다.
4. 새 hoarseness·통증·음역 손실에는 고강도 fallback을 제공하지 않는다.
5. Orange에서는 SOVT와 speaking-only를 포함한 모든 앱 발성을 차단한다.
6. Red에서는 과제 없이 streak를 자동 보호한다.
7. warm-up, cool-down, SOVT, speech drill은 모두 vocal load에 포함한다.
8. 듣기-only는 학습과 streak로 인정하되 발성 conditioning으로 인정하지 않는다.
9. exact cap은 “안전 한계” 또는 “의학적 권장량”으로 표현하지 않는다.
10. high-risk unlock은 engagement·구독 기간이 아니라 안전 졸업기준으로 결정한다.
11. streak, 배지, 알림은 사용자가 stop signal을 무시하도록 유도해서는 안 된다.
12. 불확실한 상태는 더 낮은 부하·더 높은 위험 단계로 라우팅한다.
13. 공연·리허설·직업적 말하기를 앱 밖 부하로 차감한다.
14. 다음날 기준선 미회복 시 자동으로 예산을 복구하지 않는다.
15. 지속되거나 반복되는 증상에는 ENT/후두과·음성 전문 SLP 상담 경로를 제공한다.
16. post-op·진단된 병변 사용자는 일반 커리큘럼이 아니라 clinician-guided mode로 분리한다.
17. 출시 전 laryngologist, singing voice SLP, vocologist가 문구·cap·red flag flow를 검토한다.
18. 출시 후 cap을 늘리기 전에 다음날 악화율과 stop-signal override 데이터를 먼저 검토한다.

---

## 8.12 최종 산출물 12 — Recommended Framework 요약

최종 시스템은 다음 상태기계로 구현한다.

```text
Pre-check
  ├─ Red flag → Red → 레슨 종료 + 의료 경로 + 자동 streak
  ├─ Hoarseness/pain/range loss → Orange → G0 only
  ├─ Mild fatigue/high external load → Yellow → G0, 조건부 G1 micro-dose
  └─ Baseline → Green → 예산 내 훈련
                         ↓
              In-session stop check
                         ↓
              Post-session symptom check
                         ↓
              Next-day recovery check
                         ↓
        회복되지 않으면 Green budget 복구 금지
```

제품의 최종 성공지표는 “얼마나 오래 노래하게 했는가”가 아니라 다음이어야 한다.

> **사용자가 스스로 상태를 인식하고, 고강도 노출을 관리하며, 위험 신호에서 즉시 멈추고, 노래하지 않는 날에도 학습을 계속할 수 있게 되었는가.**

---

# 9. Source Bibliography

1. **NIDCD.** *Taking Care of Your Voice.* NIH/NIDCD. 쉰 상태·피곤한 상태에서 말하거나 노래하지 않기, 질병 시 휴식, 속삭임·극단 음역 회피에 관한 공식 안내. ([NIDCD][2])
2. **NIDCD.** *Hoarseness.* 쉰목소리의 특징, 3주 진료 기준, red flags, 갑작스러운 음성 소실과 성대출혈 관련 안내. ([NIDCD][3])
3. **American Speech-Language-Hearing Association.** *Voice Disorders Practice Portal.* 증상, 평가, 음성치료, 전문직 경계와 용량 개인화. ([ASHA][17])
4. **Stachler RJ, et al.** *Clinical Practice Guideline: Hoarseness (Dysphonia) (Update).* Otolaryngology–Head and Neck Surgery, 2018. ([AAO-HNS][19])
5. **The Voice Foundation.** *Possible Lessons on Recovering Your Voice.* Voice rest의 제한적 역할과 원인별 평가 필요성. ([Voice Foundation][14])
6. **University of Iowa Head and Neck Protocols.** *Voice Rest—Vocal Conservation as a Management Strategy.* 피로·음성 변화 증상과 보존 전략. ([Iowa Head and Neck Protocols][20])
7. **Hunter EJ, et al.** *Toward a Consensus Description of Vocal Effort, Vocal Load, Vocal Loading, and Vocal Fatigue.* JSLHR, 2020;63:509–532. ([PMC][1])
8. **Solomon NP.** *Vocal Fatigue and Its Relation to Vocal Hyperfunction.* International Journal of Speech-Language Pathology, 2008. ([PubMed][6])
9. **Titze IR, Švec JG, Popolo PS.** *Vocal Dose Measures: Quantifying Accumulated Vibration Exposure in Vocal Fold Tissues.* JSLHR, 2003;46:919–932. ([PMC][7])
10. **Švec JG, Popolo PS, Titze IR.** *Measurement of Vocal Doses in Speech: Experimental Procedure and Signal Processing.* Logopedics Phoniatrics Vocology, 2003;28:181–192. ([PubMed][21])
11. **Hunter EJ, Titze IR.** *Quantifying Vocal Fatigue Recovery: Dynamic Vocal Recovery Trajectories After a Vocal Loading Exercise.* Annals of Otology, Rhinology & Laryngology, 2009. ([PMC][8])
12. **Shembel AC, Nanjundeswaran C.** *Potential Biophysiological Mechanisms Underlying Vocal Fatigue.* Journal of Voice. ([PMC][18])
13. **Nanjundeswaran C, et al.** *Vocal Fatigue Index: Development and Validation.* 자기보고 피로 측정 도구. ([PubMed][10])
14. **Phyland DJ, et al.** *Development and Preliminary Validation of the EASE: A Tool to Measure Perceived Singing Voice Function.* Journal of Voice, 2013. ([PubMed][22])
15. **Phyland DJ, et al.** *Measuring Vocal Function in Professional Music Theater Singers: Construct Validation of the EASE.* Folia Phoniatrica et Logopaedica, 2015;66:100–108. ([PubMed][23])
16. **Pozzali I, et al.** *Effectiveness of Semi-Occluded Vocal Tract Exercises in Patients With Dysphonia: A Systematic Review and Meta-Analysis.* Journal of Voice, 2024. ([PubMed][4])
17. **Kapsner-Smith MR, et al.** *A Randomized Controlled Trial of Two Semi-Occluded Vocal Tract Voice Therapy Protocols.* JSLHR, 2015. ([PubMed][24])
18. **Heller-Stark A, et al.** *Comparative Study of Two Semi-Occluded Vocal Tract Exercise Protocols.* JSLHR, 2024. ([ASHA Publications][25])
19. **Milbrath RL, Solomon NP.** Vocal warm-up 및 vocal loading 후 피로 연구. 작은 표본과 높은 개인차를 보고. ([PubMed][11])
20. **Ragan K.** *The Impact of Vocal Cool-down Exercises: A Subjective Study of Singers’ and Listeners’ Perceptions.* Journal of Voice, 2016. ([PubMed][12])
21. **Alves M, et al.** *The Effect of Hydration on Voice Quality in Adults: A Systematic Review.* Journal of Voice, 2019. ([PubMed][13])
22. **DeJonckere PH, Lebacq J.** *Vocal Fold Collision Speed In Vivo: The Effect of Loudness.* Journal of Voice, 2022. ([PubMed][15])
23. **Enflo L, et al.** Prolonged loud vocalization 후 훈련자·비훈련자의 음성 변화 연구. 보편적 반복 한계는 제시하지 않음. ([PubMed][26])
24. **Lebowitz A, Baken RJ.** *Correlates of the Belt Voice: A Broader Examination.* Journal of Voice, 2011. ([PubMed][16])
25. **Steenstrup K, et al.** 음악 수행에서 physical practice와 imagery·overt singing 결합의 효과 연구. 듣기·심상 학습 설계의 간접 근거. ([Frontiers][5])
26. **Rihkanen H, Geneid A.** 음성수술 후 voice rest 기간에 관한 근거 검토. 장기간 절대 휴식의 근거 제한을 지적. ([PubMed][27])
27. **Sandage MJ, Hoch M.** *Exercise Physiology: Perspective for Vocal Training.* Journal of Singing, 2018. 발성 훈련량을 운동생리 관점에서 해석한 교육·전문가 자료. ([NATS][28])
28. **Moniz JJ.** *Managing Vocal Endurance Through Active Recovery.* Journal of Singing, 2024. 현장 적용 관점의 보조 자료이며 cap의 직접 근거로는 사용하지 않음. ([NATS][29])

[1]: https://pmc.ncbi.nlm.nih.gov/articles/PMC7210446/?utm_source=chatgpt.com "Toward a Consensus Description of Vocal Effort, Vocal Load ..."
[2]: https://www.nidcd.nih.gov/health/taking-care-your-voice "Taking Care of Your Voice | NIDCD"
[3]: https://www.nidcd.nih.gov/health/hoarseness "What Is Hoarseness? — Causes, Diagnosis & Disorders | NIDCD"
[4]: https://pubmed.ncbi.nlm.nih.gov/34284924/?utm_source=chatgpt.com "Effectiveness of Semi-Occluded Vocal Tract Exercises ..."
[5]: https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2021.757052/full "https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2021.757052/full"
[6]: https://pubmed.ncbi.nlm.nih.gov/20840041/?utm_source=chatgpt.com "Vocal fatigue and its relation to vocal hyperfunction †"
[7]: https://pmc.ncbi.nlm.nih.gov/articles/PMC3158591/?utm_source=chatgpt.com "Vocal Dose Measures: Quantifying Accumulated Vibration ..."
[8]: https://pmc.ncbi.nlm.nih.gov/articles/PMC3311979/?utm_source=chatgpt.com "Quantifying vocal fatigue recovery - PMC - NIH"
[9]: https://pubmed.ncbi.nlm.nih.gov/35945099/ "https://pubmed.ncbi.nlm.nih.gov/35945099/"
[10]: https://pubmed.ncbi.nlm.nih.gov/25795356/ "https://pubmed.ncbi.nlm.nih.gov/25795356/"
[11]: https://pubmed.ncbi.nlm.nih.gov/14700383/ "https://pubmed.ncbi.nlm.nih.gov/14700383/"
[12]: https://pubmed.ncbi.nlm.nih.gov/26778328/?utm_source=chatgpt.com "The Impact of Vocal Cool-down Exercises: A Subjective ..."
[13]: https://pubmed.ncbi.nlm.nih.gov/29122414/?utm_source=chatgpt.com "The Effect of Hydration on Voice Quality in Adults"
[14]: https://voicefoundation.org/health-science/voice-disorders/introduction/62-possible-lessons-on-recovering-your-voice/?utm_source=chatgpt.com "62 Possible Lessons on Recovering Your Voice"
[15]: https://pubmed.ncbi.nlm.nih.gov/33004227/?utm_source=chatgpt.com "Vocal Fold Collision Speed in vivo: The Effect of Loudness"
[16]: https://pubmed.ncbi.nlm.nih.gov/20236798/?utm_source=chatgpt.com "Correlates of the belt voice: a broader examination"
[17]: https://www.asha.org/practice-portal/clinical-topics/voice-disorders/?srsltid=AfmBOopMRwJkHx727WQY2rQ2yM37JH8rA_6OW3511wqBAHR9_y26wns_ "Voice Disorders"
[18]: https://pmc.ncbi.nlm.nih.gov/articles/PMC9943805/?utm_source=chatgpt.com "Potential Biophysiological Mechanisms Underlying Vocal ..."
[19]: https://www.entnet.org/quality-practice/quality-products/clinical-practice-guidelines/hoarseness-dysphonia/ "Clinical Practice Guideline: Hoarseness (Dysphonia) (Update) - American Academy of Otolaryngology-Head and Neck Surgery (AAO-HNS)"
[20]: https://iowaprotocols.medicine.uiowa.edu/protocols/voice-rest-vocal-conservation-management-strategy-non-operative-and-post-op?utm_source=chatgpt.com "Voice Rest - Vocal Conservation as a Management Strategy ..."
[21]: https://pubmed.ncbi.nlm.nih.gov/14686546/?utm_source=chatgpt.com "Measurement of vocal doses in speech - PubMed - NIH"
[22]: https://pubmed.ncbi.nlm.nih.gov/23583205/?utm_source=chatgpt.com "a tool to measure perceived singing voice function"
[23]: https://pubmed.ncbi.nlm.nih.gov/25341878/?utm_source=chatgpt.com "Measuring vocal function in professional music theater ..."
[24]: https://pubmed.ncbi.nlm.nih.gov/25675335/?utm_source=chatgpt.com "A Randomized Controlled Trial of Two Semi-Occluded Vocal ..."
[25]: https://pubs.asha.org/doi/abs/10.1044/2024_JSLHR-22-00456?utm_source=chatgpt.com "Comparative Study of Two Semi-Occluded Vocal Tract ..."
[26]: https://pubmed.ncbi.nlm.nih.gov/23849684/ "https://pubmed.ncbi.nlm.nih.gov/23849684/"
[27]: https://pubmed.ncbi.nlm.nih.gov/30631900/ "https://pubmed.ncbi.nlm.nih.gov/30631900/"
[28]: https://www.nats.org/_Library/JOS_On_Point/JOS-074-4-2018-419_-_Exercise_Physiology_-_Sandage-Hoch.pdf?utm_source=chatgpt.com "Exercise Physiology: Perspective for Vocal Training"
[29]: https://www.nats.org/_Library/JOS_On_Point/JOS-080-3-2024-321.pdf?utm_source=chatgpt.com "Managing Vocal Endurance Through Active Recovery"
