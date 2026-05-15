# 파트 QI 정량 인덱스 (Quantitative Indexes)

> 본 chapter는 part 1–16 전체에 흩어져 있는 음향·생리·임상 수치들을 한 곳에 모은 reference index이다. 모든 표의 수치는 1차 출처(또는 광범위하게 채택된 표준 교과서)를 명시하며, 출처 키는 `BIBLIOGRAPHY.md`를 참조한다. 학파별 통칭과 합의 수치는 part 14(용어 disambiguation)와 cross-reference 가능하도록 정렬되어 있다.

---

## 1. 레지스터 분류 — Henrich/Roubeau M0–M3

성대 진동의 물리적 mode 기반 분류(laryngeal vibratory mechanism)는 Henrich와 Roubeau가 EGG·고속카메라·근전도 동기 측정으로 정립하였다. perceptual label(chest/head/falsetto 등)과 1:1 대응되지 않으므로 주의해야 한다.

| Mode | 통칭 (학파별) | f0 범위 (Hz) | 근육 활성 | EGG CQ | Mucosal Wave | 주요 특성 | 출처 |
|------|---------------|-------------|----------|--------|--------------|----------|------|
| M0 | vocal fry / pulse / Strohbass | ~30–80 | TA strong, CT relaxed | 변동 큼 | 불규칙 | irregular pulses, 이중주기 가능 | [CITE: HENRICH2006] [CITE: ROUBEAU2009] |
| M1 | modal / chest | 남 80–600, 여 150–800 | TA dominant **with CT contribution** | 0.45–0.65 | full vibration | thick fold, full glottal closure | [CITE: ROUBEAU2009] |
| M2 | falsetto / loft / head (high) | 남 300–800, 여 400–1500 | CT dominant | 0.30–0.45 | reduced amplitude | thin fold, partial closure 가능 | [CITE: ROUBEAU2009] |
| M3 | whistle / flageolet | 1500–2500+ | extreme stretch | 측정 어려움 | minimal | membrane only vibration | [CITE: HENRICH2006] |

**주의:** chest = M1 단순 등치는 부분적이다. chest는 perceptual label이며, M1 내에서 thick/thin 발화 모든 범위를 포함한다. head voice 역시 일부 학파에서는 M1의 thin 영역을, 다른 학파는 M2를 지칭한다 → part 14 disambiguation 참조.

---

## 2. EGG / Contact Quotient (CQ)

Electroglottography(EGG)는 갑상연골 양측에 표면 전극을 부착해 성대 접촉 면적의 변화를 임피던스로 환산한다. CQ(contact quotient)는 한 cycle 중 접촉 비율로, closure phase 비중을 나타낸다.

| 발성 양식 | CQ 범위 | 비고 |
|-----------|---------|------|
| breathy phonation | 0.20–0.35 | 후두 후방 chink 잔존 |
| modal speech | 0.40–0.55 | 정상 회화 기준 |
| pressed / belt | 0.55–0.70 | belt 상한선; 안전성 한계 |
| falsetto / M2 | 0.30–0.45 | thin fold, partial closure |

**측정 도구:** EGG (Glottal Enterprises EG2-PCX2, Laryngograph Ltd.), VoceVista Video 5(EGG 통합), Praat의 `Voice → EGG` plug-in.
**기준값 출처:** [CITE: BAKEN_ORLIKOFF] (Clinical Measurement of Speech and Voice).

**한국어 분류 매핑 (2025 추가)**: 김형미 (2025). "보컬리스트의 효율적 발성을 위한 성대접지 메커니즘 연구," *한국산학기술학회논문지* 26(10):756-763. KCI. **성대접지(成帶接地, vocal-fold contact) 3분류** = *균형 (balanced)* / *저접지 (hypo-adduction)* / *과접지 (hyper-adduction)*. 본 표의 modal speech ≈ *균형*, breathy ≈ *저접지*, pressed/belt 상한 ≈ *과접지*. 한국 1차 동료심사 매핑. [CITE: KOR_KIM2025]

---

## 3. Vocal Dose 4변수 (Hunter & Titze 2003)

성대 부하의 정량화 표준 framework이다. 4개 dose 모두 의미가 다르며, 특히 De가 phonotrauma 위험과 가장 직접 연관된다.

| 변수 | 정의 | 단위 | 임상 의미 |
|------|------|------|-----------|
| **Dt** (time dose) | 누적 발성 시간 | 초 (s) | 총 phonation 시간 |
| **Dc** (cycle dose) | 누적 진동 cycle 수 | count | f0 × Dt |
| **Dd** (distance dose) | 성대 진동 누적 거리 | m | 진폭 × cycle |
| **De** (energy dissipation dose) | 단위 부피당 누적 에너지 소산 | J/m³ | phonotrauma 위험과 가장 직접 연관 |

[CITE: HUNTER_TITZE2003]

**임상 dosimeter 도구:**
- Asentic VoxLog (Wearable accelerometer, 스웨덴)
- KayPENTAX APM (Ambulatory Phonation Monitor)
- MIT-CCRMA neck-skin accelerometer prototype
- **Northwestern 피부 인터페이스 무선 dosimeter (Nair et al. 2023, *PNAS* 120(11))** — closed-loop 사용자 피드백. *PNAS top-tier 등재*. 학술 단계, 컨슈머 미발매. 본 표의 *2020년대 후반 표준 후보*. [CITE: NAIR2023PNAS]
- Rosen, R. et al. (2022) *J Voice* — 신규 도시미터 도입 [CITE: ROSEN2022DOSI].

---

## 4. Phonation Threshold Pressure (PTP) / Closure Threshold Pressure (CTP)

PTP는 진동을 시작·유지하는 데 필요한 최소 subglottal pressure이다. CTP는 onset 시 완전 closure를 유도하는 데 필요한 임계값으로 PTP보다 약간 높다.

| 음역 | PTP (kPa) | CTP (kPa) |
|------|-----------|-----------|
| comfortable speech (남) | 0.2–0.4 | +0.05 |
| comfortable speech (여) | 0.3–0.5 | +0.05 |
| upper pitch (남 F4 이상) | 0.5–1.0 | +0.10 |
| upper pitch (여 C5 이상) | 0.6–1.2 | +0.10 |

**측정:** /pa/ repetition을 통한 intraoral pressure peak로 subglottal pressure 추정 (Smitheran-Hixon method). [CITE: TITZE2000] (Principles of Voice Production).

PTP 상승은 보컬 피로, 점막 부종, 탈수의 조기 지표로 사용된다.

---

## 5. F1/F2 모음별 평균 (Hillenbrand 1995, 미국 영어 성인)

모음 식별·formant tuning 전략의 baseline reference. Peterson & Barney 1952의 후속 데이터로, sample size·녹음 환경 면에서 표준으로 채택된다.

| 모음 (IPA) | 남 F1 (Hz) | 남 F2 (Hz) | 여 F1 (Hz) | 여 F2 (Hz) |
|------------|-----------|------------|-----------|------------|
| /i/ | 342 | 2322 | 437 | 2761 |
| /ɪ/ | 427 | 2034 | 483 | 2365 |
| /ɛ/ | 580 | 1799 | 731 | 2058 |
| /æ/ | 588 | 1952 | 669 | 2349 |
| /ɑ/ | 768 | 1333 | 936 | 1551 |
| /ɔ/ | 652 | 997 | 781 | 1136 |
| /ʊ/ | 469 | 1122 | 519 | 1225 |
| /u/ | 378 | 997 | 459 | 1105 |
| /ʌ/ | 623 | 1200 | 753 | 1426 |
| /ɝ/ | 474 | 1379 | 523 | 1588 |

[CITE: HILLENBRAND1995]
**비교 reference:** [CITE: PETERSON_BARNEY1952] (남/여/소아 모음 데이터, 33명 화자).

한국어 모음의 평균 formant는 별도 (Yang 1996 등) 참조 필요. 본 표는 영어 lyric 분석용 baseline이다.

**한국어 가창 측 1차 자료**:
- 한국 소프라노 성악 발성 음향학적 특징 *한국음향학회지* — 한국 소프라노 포먼트·비브라토 데이터의 한국 1차 자료 [CITE: KOR_SOPRANO_ACOUSTIC].
- 성악가 성별·성종(Fach) 발성 차이 KCI [CITE: KOR_FACH_GENDER].
- 한국어 발화 속도 코퍼스 *말소리와 음성과학* (DBpia) [CITE: KOR_SPEECHRATE].

**잔존 갭** `[근거 부족]`: *한국어 가창자의 성종별·음역별 F1/F2 표준 데이터셋*은 영문·국문 모두 부재. Hillenbrand 1995 표준이 사실상 차용되고 있으며, Lee 2017 CGU 박사논문이 IPA 매핑은 다루지만 측정 데이터셋은 미공개 [CITE: LEE2017CGU]. part 6-KR §"잔존 갭"·part 9-KR §"갭" 1번과 동기화.

---

## 6. Passaggio 음고 (Miller 표준)

Miller(English, French, German and Italian Techniques of Singing)의 학파 비교에서 정리된 voice type별 passaggio 표준. 개인차 ±2 semitone 허용.

| Voice type | Primo passaggio | Secondo passaggio |
|------------|-----------------|-------------------|
| Bass | F3 (175 Hz) | B♭3 (233 Hz) |
| Baritone | A3 (220 Hz) | D4 (294 Hz) – E4 (330 Hz) |
| Tenor | C4 (262 Hz) – D4 (294 Hz) | F4 (349 Hz) – F#4 (370 Hz) |
| Counter-tenor | E4 – F#4 | C5 – D5 |
| Contralto | E4 (330 Hz) | C5 (523 Hz) |
| Mezzo | E4 – F#4 | D5 (587 Hz) |
| Soprano | E4 – F#4 (330–370 Hz) | F#5 – G5 (740–784 Hz) (또는 D5–E5) |

[CITE: MILLER1986] [CITE: MILLER1996]

**해석 주의:** primo는 R1:H2 → R1:H1 transition 영역, secondo는 mechanism shift(M1→M2) 영역과 대체로 일치하지만, CCM/belt 발성에서는 secondo를 의도적으로 raise한다.

---

## 7. Belt / Twang / Singer's Formant Cluster

소리의 brilliance·power 영역에 관여하는 formant tuning·epilarynx 조절 수치.

| 현상 | 주파수 범위 | 핵심 메커니즘 | 측정 도구 | 출처 |
|------|-------------|---------------|-----------|------|
| Singer's formant cluster (남 클래식) | 2.5–3.5 kHz | F3-F4-F5 클러스터링 + epilarynx tube : pharynx 단면적 비 ≥ 1:6 | LTAS spectrum peak | [CITE: SUNDBERG1987] |
| Speaker's formant (여 actor) | 3.0–3.5 kHz | AES narrowing 단독 (F3-F4 clustering 약함) | LTAS | [CITE: YANAGISAWA1989] |
| Belt R1:H2 tuning | R1 ≈ 800–1500 Hz at f0 400–750 Hz | 턱·입술 개구로 R1 raise, H2와 매칭 | spectrogram H2 위치 | [CITE: BOURNE_GARNIER2012] |
| Twang AES narrowing | 2.5–3.5 kHz cluster | epilaryngeal narrowing (aryepiglottic sphincter) | nasendoscopy + LTAS | [CITE: YANAGISAWA1989] |
| Soprano whistle F1=H1 (C6+) | f0 = R1 | 턱 벌림으로 R1 = f0 강제 매칭 | spectrogram | [CITE: JOLIVEAU2004] |
| Soprano R2:2f0 (vocalise) | R2 ≈ 2 × f0 | 혀 위치로 R2 조정 | spectrogram | [CITE: SUNDBERG1987] |

**LTAS analysis window:** 일반적으로 30 s 이상의 노래·연속 발화에서 0–8 kHz 범위로 산출. 1/3 octave smoothing 권장.

**K-pop 음향 베이스라인 (2025 추가)**:
- Cambridge *Popular Music* — "What's behind the 'K'? Common audio features of Korean popular music before and after the rise of K-POP" — K-pop 전후 음향 특성 동료심사 음악학 분석. K-pop 시대의 *집계 음향 특징* (vocal-forward 프로덕션, harmonic-ratio 등) 베이스라인 1차 자료 [CITE: CAMBRIDGE_KPOP].
- *J Voice* 2025 — K-pop 가창자의 *neutral voice* 청지각 측정 (J Voice 최초 K-pop 전용 논문). belt 컨트라스트 음질 [CITE: JVOICE2025KPOP].
- 본 표의 belt R1:H2 tuning은 *클래식·MT 데이터*에 근거 — K-pop *neutral voice*는 동일 음역에서 *덜 metallic·덜 chest-like*한 컨트라스트로, 별도 측정 데이터셋은 미수립. `[성악·CCM 병기]`

---

## 8. Subglottal Pressure (Psub)

폐 driving pressure. 발성 양식별 기대 범위는 다음과 같다.

| 발성 양식 | Psub (kPa) | 비고 |
|-----------|-----------|------|
| comfortable speech | 0.5–0.8 | |
| projected speech (강한 말) | 1.0–1.5 | |
| classical singing (mezzo-forte) | 1.0–1.8 | |
| classical fortissimo | 1.5–2.5 | |
| belt | 1.5–2.5 | speech의 2–3배 [CITE: LEBOWITZ_BAKEN2011] |

belt에서 Psub가 일관되게 상승하는 점은 dose 부담의 정량적 근거로 사용된다. PTP 대비 Psub 비율(operating headroom)은 효율성 지표가 된다.

---

## 9. 청지각 평가지 표준

| 평가지 | 척도 | 차원 | 출처 |
|--------|------|------|------|
| GRBAS | 0–3 (4-point) | Grade · Roughness · Breathiness · Asthenia · Strain | [CITE: HIRANO1981] |
| CAPE-V | 0–100 VAS + MI/MO/MO-S + consistent/intermittent | overall severity, roughness, breathiness, strain, pitch, loudness (6 차원) | [CITE: KEMPSTER_CAPEV] |
| VHI-30 / VHI-10 | 0–4 Likert | functional · physical · emotional | [CITE: JACOBSON_VHI] |
| EASE | 22 문항 | singing-specific fatigue/tiredness | [CITE: PHYLAND_EASE] |
| VFI | 19 문항 (3 factor) | vocal fatigue, physical discomfort, recovery | [CITE: NANJUNDESWARAN_VFI] |
| RSI / RFS | 9 문항 / 8 항목 | LPR 진단 (self-report / endoscopic) | [CITE: KOUFMAN_RFS_RSI] |

**임상 사용 권장 조합:** GRBAS 또는 CAPE-V (clinician-rated) + VHI-10 (patient-rated) + EASE/VFI (singer-specific).

---

## 10. 음향 측정 변수 (Acoustic Indexes)

Praat·MDVP·VoceVista·lingWAVES 등에서 산출하는 표준 acoustic measure.

| 변수 | 정의 | 정상 범위 (성인) | 도구 | 출처 |
|------|------|------------------|------|------|
| jitter (local %) | f0 cycle-to-cycle 변동 | < 1.04% | Praat, MDVP | |
| shimmer (local %) | amplitude cycle-to-cycle 변동 | < 3.81% | Praat, MDVP | |
| HNR (dB) | Harmonics-to-Noise Ratio | > 20 dB | Praat | |
| CPP (dB) | Cepstral Peak Prominence | > 14–15 (sustained vowel) | Praat (CPPS), VoceVista | [CITE: HILLENBRAND_CPP] |
| AVQI v6.0 | 6-factor composite (CPPS, HNR, shimmer 등) | < 2.95 (Maryn cutoff) | AVQI add-on for Praat | [CITE: MARYN_AVQI] |
| ABI | Acoustic Breathiness Index | < 1.5 | Praat | |
| DSI | Dysphonia Severity Index | -5 ~ +5 (음수 = 심함) | MDVP, lingWAVES | |
| MPT | Maximum Phonation Time | 남 25–35초, 여 15–25초 | stopwatch + sustained /a/ | |
| VRP / Phonetogram | Voice Range Profile (f0 × SPL) | 정상 면적 ≈ 30 ST × 50 dB | VoceVista, lingWAVES | [CITE: SCHUTTE_VRP] |

**주의:** jitter·shimmer는 sustained vowel 한정. connected speech에서는 CPP/CPPS, AVQI가 더 유효하다 (continuous speech에 robust).

---

## 11. SOVT — 빨대 직경 / 침수 깊이별 backpressure

Semi-Occluded Vocal Tract exercise의 부하 dosing reference. 직경/깊이는 supraglottal back-pressure를 결정하며, 이는 vocal fold collision 감소·효율 향상에 기여한다.

| 도구 | 직경/깊이 | 추정 backpressure (cm H₂O) | 효과 비고 |
|------|-----------|---------------------------|-----------|
| Cocktail stirrer straw | 2.5 mm | ~7–10 | 고저항·압력 부하; 진보된 학습자 |
| 일반 빨대 | 5 mm | ~3–5 | 표준 워밍업 |
| 큰 빨대 (스무디용) | 7 mm | ~1–3 | 저저항·flow 훈련 |
| LaxVox 침수 | 1 cm | ~1 | 입문 |
| LaxVox 침수 | 3 cm | ~3 | 표준 |
| LaxVox 침수 | 5 cm | ~5 | 부하 |
| LaxVox 침수 | 7+ cm | ~7+ | 고급 (피로 시 회피) |

[CITE: LAUKKANEN_TITZE] [CITE: ANDRADE2014]

**임상 적용 원칙:** breathy/hypofunctional → 좁은 직경/깊은 침수로 closure 유도. pressed/hyperfunctional → 넓은 직경/얕은 침수로 flow 회복.

---

## 12. Warm-up / Cool-down / Voice Rest 프로토콜 표준

| 항목 | 권장 dosage | 근거 등급 |
|------|-------------|-----------|
| 일반 warm-up | 10–20분 (저강도 SOVT + 글라이드) | RCT [CITE: MCHENRY_WARMUP] |
| Cool-down | 5–10분 SOVT (단일 RCT — 효과 약함) | [CITE: RAGAN2016] |
| Relative voice rest | 50% 감량, 7일 이내 | 표준 권장 [CITE: BEHRMAN_SULICA2003] |
| Absolute voice rest | phonosurgery 후 24–72시간만 | 일반적으로 비권장 (deconditioning 위험) |
| Vocal nap | 15–30분 silent rest | 근거 약함 (경험적 권장) |

cool-down은 근거가 warm-up 대비 약하지만, perceived fatigue 감소 보고가 있어 routine 권장.

---

## 13. Hydration

| 항목 | 권장 | 근거 |
|------|------|------|
| Systemic water | 30–40 ml/kg/day (운동 시 추가) | 일반 권장 |
| Surface (nebulized) saline 0.9% | 3 mL × 2–4회/일 | RCT 근거 [CITE: VERDOLINI_TITZE_HYDRATION] |
| 카페인 영향 | moderate intake (≤400 mg) PTP에 유의 효과 없음 | [CITE: ERICKSON_SIVASANKAR2014] |

systemic hydration은 효과 발현까지 수 시간이 걸리는 반면, surface(nebulized) hydration은 즉각적이며 PTP 감소가 보고되었다. isotonic saline(0.9%)이 표준이며, hypotonic은 점막 자극 가능성으로 회피한다.

---

## 14. 결론 — 사용 안내

- 위 표는 **1차 출처가 있는 합의된 수치만** 수록한다. 학파 내 합의 또는 임상 경험만 있는 수치는 별도 표("learner-facing rules of thumb")로 분리할 것을 권장한다.
- 본 인덱스는 part 1–8의 모든 카드와 part 14 disambiguation, part QI를 cross-reference 가능하다.
- 모든 출처 키는 `BIBLIOGRAPHY.md`를 참조한다.
- 정량 측정은 단일 세션 비교가 아닌 longitudinal trend 분석에 사용해야 의미가 있다 (개인 baseline 확보 후 ±변동 추적).
- perceptual rating(GRBAS/CAPE-V)과 acoustic measure(AVQI/CPP)는 보완적이며, 어느 하나만으로 진단·평가하지 않는다.
