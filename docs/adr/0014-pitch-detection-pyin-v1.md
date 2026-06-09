# V1 피치 검출 = 자기상관 + 보간 + 신뢰 게이트 (2026-06 개정; 원안 pYIN)

## 개정 (2026-06) — 채택안 A

> **Status: Accepted (개정).** 원안의 "V1 = pYIN 온디바이스(C via FFI)" 단정을 대체.
> 근거·측정: `docs/superpowers/specs/2026-06-09-pitch-stack-decision.md`(특성화 실측).

**결정:** V1 피치 = **온디바이스 Dart 자기상관 + 포물선 보간 + 정규화 신뢰 게이트**.
시각 전용·비차단. **저신뢰(언보이스드·기식·잡음)는 표시하지 않음**(틀린 점 ❌). 카드별
목표음을 타깃으로 주입(220Hz 하드코딩 제거). pYIN/CREPE는 정확도 부족이 *실 기기 사용자
검증*으로 드러날 때의 **타깃**이며, `PitchSource`/`estimateF0`를 교체 seam으로 유지.

**근거(특성화 실측, `f0_characterization_test.dart`):**
- 옥타브 오류: 배음많음·잃은기음·SOVT 합성신호 전부 정확(자기상관이 강건) → 고비용
  알고리즘의 주 이점이 현 단계 결정적이지 않음.
- 고음 양자화 오차 ~23c(반음 이내) → 포물선 보간으로 <10c 해결 가능.
- 잡음 5/5 spurious f0(신뢰 게이트 부재 = **실질 최대 약점**) → 정규화(NSDF/CMNDF)
  clarity 임계로 저신뢰 null 처리. 이게 비기너 안전(틀린 피드백 회피)·본 ADR(저신뢰
  미표시)에 정확히 정합.
- **빌드 리스크 회피**: 네이티브 의존(FFI/tflite)은 이 스택에서 빌드를 깨뜨린 이력
  (record_linux). 자기상관은 순수 Dart라 리스크 0. 마이크 기기검증 미완 단계에서 pYIN/
  CREPE 고비용은 시기상조 — 인터페이스 seam으로 후일 승급.

**Consequences(개정):** 정확도 SOTA 아님 — 그러나 시각 전용 비차단엔 충분. 신뢰 게이트가
"틀린 점보다 없는 점"을 보장. 실 기기 데이터가 A의 부족을 입증하면 B(pYIN)/C(CREPE) 승급
경로가 열려 있음(인터페이스 불변). 후속 구현 plan: 결정 패킷 §4.

---

## 원안 (개정 전, 이력 보존 — V1 = pYIN)

### V1 피치 검출 = pYIN (온디바이스), CREPE-tiny는 V2 경로

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
