# V1 피치 검출 = pYIN (온디바이스), CREPE-tiny는 V2 경로

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
