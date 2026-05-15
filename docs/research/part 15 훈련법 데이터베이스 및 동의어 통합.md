# 파트 15. 훈련법 통합 데이터베이스 (Master Training Database)

> **이 문서는 part 1–8의 카드를 통합한 마스터 DB이며, 각 카드의 세부 프로토콜·수행법·dosage·연구 인용은 원본 part(1–8)와 BIBLIOGRAPHY.md를 참조하라.** 본 파트는 카드의 위치, 카테고리 매핑, 동의어, 학파, 안전 트리거를 한눈에 보기 위한 **인덱스/크로스워크** 역할이다. 모든 인용 키는 `[CITE: KEY]` 형식이며 BIBLIOGRAPHY.md에 정의되어 있다.

---

## 1. 카테고리 분류 체계 (Taxonomy)

본 데이터베이스는 음성과학·보컬 페다고지 문헌에서 통용되는 기능적 분류를 따라 다음 8개 상위 카테고리로 정리한다. 카테고리는 **기능(function)** 기반이며, 동일 훈련이 둘 이상에 걸쳐 있을 경우 **주(主) 기능**으로 분류하고 보조 카테고리를 "관련 part" 열에 표기한다.

| 코드 | 카테고리 (KR) | English | 핵심 목표 |
|------|--------------|---------|----------|
| **A** | 호흡·자세·신체정렬 | Breath / Posture / Alignment | 호기 압력(Psub) 안정, 흉곽 이동성, 코어-호흡 동기화 |
| **B** | 발성·온셋·내전 | Phonation / Onset / Adduction | 성대 내전 균형(CQ 적정화), onset 정밀도, phonation threshold pressure 감소 |
| **C** | SOVT (반폐쇄 성도) | Semi-Occluded Vocal Tract | 역압(back-pressure) 제공으로 성대 진동 효율↑, 부하↓ |
| **D** | 공명·포먼트·플레이스먼트 | Resonance / Formant / Placement | F1·F2 튜닝, singer's formant cluster (F3-F4-F5), 마스크/돔 감각 |
| **E** | 레지스터·믹스·벨트·트웽 | Register / Mix / Belt / Twang | M1↔M2 전환, passaggio 협상, AES narrowing, belt acoustic 모드 |
| **F** | 딕션·조음 | Diction / Articulation | 자음 정밀도, legato 모음 연결, 다국어 IPA |
| **G** | 평가·자기모니터링 | Assessment / Self-monitoring | VHI, CAPE-V, EGG/CQ, 청지각 훈련, 음향 분석 |
| **H** | 워밍업·쿨다운·회복·위생 | Warm-up / Cool-down / Recovery / Hygiene | 부하관리(vocal dose), 수분, 음성휴식, 세션 디자인 |

**카드 명명 규칙:** 원본 part의 `P{n}-{nn}` 식별자를 그대로 보존하며, 본 파트 신규 추가 카드는 `P15-{nn}`으로 부여한다.

---

## 2. 통합 카드 데이터베이스

각 표의 컬럼은 다음과 같다.

`ID` · `훈련명 (KR / EN)` · `카테고리` · `주요 학파/원전` · `동의어` · `음향/생리 목표` · `권장 dosage` · `근거 등급 (OCEBM)` · `출처 [CITE]` · `위험·금기` · `관련 part`

OCEBM(Oxford Centre for Evidence-Based Medicine) 등급: **1** = 체계적 고찰/메타분석, **2** = RCT, **3** = 비무작위 비교연구, **4** = 사례군/사례연구, **5** = 전문가 의견·기전 추론.

---

### A. 호흡·자세·신체정렬 (Breath / Posture)

| ID | 훈련명 (KR / EN) | 카테고리 | 학파/원전 | 동의어 | 음향/생리 목표 | dosage | 근거 | 출처 | 위험·금기 | 관련 part |
|----|----------------|---------|---------|--------|--------------|--------|------|------|---------|---------|
| P1-01 | 구성적 휴식 / Constructive Rest | A | Alexander Technique | semi-supine | 흉곽·요추 중립, 부속근 이완 | 5–10분 × 1–2회/일 | 5 | [CITE: ALEXANDER_FM] | 급성 요통 시 무릎 각도 조정 | 8 |
| P1-02 | 신체매핑 / Body Mapping | A | Conable | anatomy of intention | 해부학적 자기상 정확화 | 10–15분 | 5 | [CITE: CONABLE_BODYMAP] | 없음 | – |
| P1-03 | 알렉산더 테크닉 / Alexander Technique | A | F.M. Alexander | primary control | head-neck-back 관계 재교육 | 30–45분/세션, 주 1회 | 4 | [CITE: ALEXANDER_FM] | 수업 필수 | 8 |
| P1-04 | 횡격막 호흡 / Diaphragmatic Breathing | A | 일반 음성치료 | 복식호흡, belly breathing | 횡격막 하강, 늑간근 협응 | 5–10분, 4-4-8 ratio | 3 | [CITE: HIXON_RESP] | 과호흡 어지럼 주의 | 1, 8 |
| P1-05 | Appoggio | A | 이탈리안 벨칸토 (Lamperti, Miller) | "기댐 호흡", lutta vocale | 흡기근-호기근 길항으로 호기 지연 | 매 vocalise 적용 | 4 | [CITE: MILLER_STRUCTURE] | "앉아앉는 호흡" 오역 주의 | 1 |
| P1-06 | 7-7-7 호흡 / Box Breathing | A | 일반 호흡훈련 | square breathing | 호흡 리듬·자율신경 안정 | 4–8 사이클 | 5 | – | 어지럼 시 중단 | 1, 8 |
| P1-07 | Inspiratory/Expiratory Resistive (IMS/ISRV) | A | 호흡근 훈련 | resistive breathing | 호흡근 근력·지구력 | 부하 30–60% MIP, 5×5 | 2 | [CITE: SAPIENZA_EMST] | COPD 감독 필요 | 8 |
| **P15-01** | **EMST150 / RMST** | **A** | **Sapienza, Wingate** | expiratory muscle strength training | MEP↑, subglottal pressure 안정 | **5회 × 5세트, 주 5일, 4–8주** | **2** | **[CITE: SAPIENZA_EMST]** | 고혈압·녹내장 주의 | 8 |
| P1-08 | Rib Cage Expansion | A | Estill, Linklater | "rib reserve" | 늑간 가동성↑, 흡기 용적↑ | 좌우 10회 × 2 | 5 | [CITE: LINKLATER_FREEING] | 늑간 통증 시 중단 | 1 |
| P1-09 | Hiss SOVT timed exhale | A | speech-language pathology | sustained /s/ | 호기 조절, MPT 측정 | /s/ 15–25초 | 3 | [CITE: COLTON_CASPER] | – | 7 |
| P1-10 | Suspension/Pause 연습 | A | Caruso lineage | "fermata respiratoria" | 흡기 후 잠시 정지로 후두 안정 | 3–5초 | 5 | [CITE: MILLER_STRUCTURE] | – | 1 |

---

### B. 발성·온셋·내전 (Phonation / Onset / Adduction)

| ID | 훈련명 (KR / EN) | 카테고리 | 학파/원전 | 동의어 | 음향/생리 목표 | dosage | 근거 | 출처 | 위험·금기 | 관련 part |
|----|----------------|---------|---------|--------|--------------|--------|------|------|---------|---------|
| P3-01 | Balanced (simultaneous) onset | B | Vennard, Miller | coordinated onset | 호기·내전 동시 개시, CQ 0.45–0.55 | 매 phrase 시작 | 4 | [CITE: VENNARD_MECH] | – | 3 |
| P3-02 | Aspirate onset | B | speech therapy | breathy onset, /h/-attack | 내전 지연으로 부하↓ | 결절 회복기 도구 | 3 | [CITE: COLTON_CASPER] | 만성 누설 시 정착 위험 | 3, 7 |
| P3-03 | Glottal (hard) onset | B | Estill, Sundberg | coup de glotte | 강한 내전, 명료 시작 | 진단·수정용 소량 | 4 | [CITE: SUNDBERG_SCIENCE] | 결절·출혈·염증 시 금기 | 3 |
| P3-04 | Messa di voce | B | Caccini, Garcia II | 메사 디 보체 | crescendo–decrescendo로 내전·압력 동적 제어 | 5음 × 8–12초 × 5 | 4 | [CITE: GARCIA_TRAITE] | 단일 카드로 분리 권장 | 3, 5 |
| P3-05 | Pressed-to-flow continuum | B | Titze | "flow phonation" | press↔flow 스펙트럼 인지 | 5단계 sweep | 3 | [CITE: TITZE_PRINCIPLES] | press 고착 주의 | 3 |
| P3-06 | Half-occluded /v/ /z/ /ʒ/ | B/C | SLP | voiced fricative SOVT | 약한 역압 + 내전 균형 | 30–60초 × 3 | 3 | [CITE: TITZE_SOVT] | – | 3 |
| **P15-02** | **PhoRTE (Phonation Resistance Training Exercise)** | **B** | **Ziegler & Verdolini Abbott 2014** | "phonation resistance" | presbyphonia 내전 강화, loud phonation tolerance | **8주, 주 4–5회, 4 단계 vocal task** | **2 (RCT)** | **[CITE: ZIEGLER2014_PHORTE]** | 급성 염증 시 보류 | 7, 8 |
| **P15-03** | **Casper-Stone Confidential Voice** | **B** | **Casper & Stone** | confidential voice therapy | low-impact phonation, post-surgical 회복 | 일상 사용 + 5분 drill | 3 | [CITE: STONE_CONFIDENTIAL] | 장기 사용 시 누설 정착 | 7, 8 |
| **P15-04** | **Stretch-and-Flow (4단계)** | **B/C** | **Watts & Hamilton; Stone** | SAF, "kazoo→phrase" | (1) 무성 흐름 (2) 유성 흐름 (3) phrase (4) song로 단계 전이 | 단계별 5분 × 4 | 3 | [CITE: STONE_STRETCHFLOW] | – | 3, 7 |
| **P15-05** | **Accent Method** | **A/B** | **Smith & Thyme-Frøkjær (Denmark)** | "악센트 기법" | 호흡 리듬·CCM rhythmic phonation 통합 | 3 phase, 점진적 증강 | 2 | [CITE: SMITH_THYME] | 율동 어지럼 주의 | 1, 7 |
| **P15-06** | **Messa di voce (독립 카드)** | **B/D** | **벨칸토 전 학파** | swell-and-taper | 동일 음에서 dB·F1·CQ 동시 제어 | C4–G4, 8–12초 × 5 | 4 | [CITE: GARCIA_TRAITE] | 호흡 부족 시 단축 | 3, 5 |
| **P15-07** | **LMRVT 4단계** (Lessac-Madsen Resonant Voice Therapy) | **B/D** | **Verdolini Abbott** | RVT, "resonant voice ladder" | barely abducted/barely adducted 진동 → 마스크 진동 → 회화 → 노래 4 사다리 | 단계당 1–2주 | 2 | [CITE: VERDOLINI_LMRVT] | 단계 건너뛰기 금지 | 3, 7 |
| P3-07 | Yawn-sigh | B/D | Boone | 하품-한숨 | 후두 하강·이완, 부하 감소 | 5–10회 | 4 | [CITE: BOONE_VOICE] | – | 3, 8 |
| P3-08 | Vocal function exercises (VFE) | B | Stemple | "Stemple VFE" | 4 task: warm-up, stretch, contract, power | 매일 2회, 4 task | 1 | [CITE: STEMPLE_VFE] | – | 7, 8 |
| **P15-08** | **Vocal fry / pulse register** | **B** | **Hollien; Blomgren** | M0, creaky voice, glottal fry | 진단(CQ 매우 높음) 및 치료적 부하 0에 가까운 phonation 도입 | 5–15초 × 5 | 4 | [CITE: HOLLIEN_REGISTERS] | 만성 fry 정착·부적절한 스타일 사용 주의 | 3, 5 |
| **P15-09** | **Manual Laryngeal Therapy / Circumlaryngeal Massage** | **B** | **Aronson; Roy & Leeper** | MCT, laryngeal manipulation | MTD(근긴장성 발성장애)에서 후두 주변근 이완 | 임상가 시행 5–15분 | 2 | [CITE: ARONSON1990], [CITE: ROY_LEEPER] | 비전문가 자가 마사지 금지 | 7, 8 |

---

### C. SOVT (Semi-Occluded Vocal Tract)

| ID | 훈련명 (KR / EN) | 카테고리 | 학파/원전 | 동의어 | 음향/생리 목표 | dosage | 근거 | 출처 | 위험·금기 | 관련 part |
|----|----------------|---------|---------|--------|--------------|--------|------|------|---------|---------|
| P3-09 | Lip trill | C | Boone, CCM 공통 | lip buzz, brrr | 입술 진동 역압, 진성대 부하↓ | 3–5분, glide | 3 | [CITE: TITZE_SOVT] | 입술 마비·구순열 시 대체 | 3, 8 |
| P3-10 | Tongue trill | C | 공통 | rolled-R, /r̃/ | 혀끝 진동 역압 | 3–5분 | 3 | [CITE: TITZE_SOVT] | 설소대 단축 시 대체 | 3 |
| P3-11 | Hum (m, n, ŋ) | C/D | Verdolini, 일반 | 허밍 | 비강·구강 공명 통합, low-impact | 5분 워밍업 | 3 | [CITE: VERDOLINI_LMRVT] | 비강 폐색 시 효과↓ | 3, 4, 8 |
| **P15-10** | **Straw phonation – cocktail stirrer 2.5 mm** | **C** | **Titze; Guzman** | narrow straw, "small bore" | 강한 역압, 부하 큰 진성대 mass 인지 | 30–60초 × 3 | 3 | [CITE: TITZE_SOVT] | 어지럼·과압 시 중단 | 3 |
| **P15-11** | **Straw phonation – standard 5 mm** | **C** | **Titze** | regular straw | 중간 역압, 일반 워밍업 | 1–3분 | 3 | [CITE: TITZE_SOVT] | – | 3, 8 |
| **P15-12** | **Straw phonation – wide 7 mm** | **C** | **Titze** | wide bore | 약한 역압, 회복기 | 1–3분 | 3 | [CITE: TITZE_SOVT] | – | 3, 8 |
| **P15-13** | **Resonance tube in water (LaxVox) – 1 cm 침수** | **C** | **Sovijärvi; Sihvo (LaxVox)** | water-resistance, "phonation into water" | 진동·기포로 이중 역압, 점막파 자극 | 1–3분 | 3 | [CITE: SIHVO_LAXVOX] | 흡인 위험 자세 주의 | 3, 8 |
| **P15-14** | **LaxVox – 3 cm 침수** | **C** | **Sihvo** | LaxVox standard | 표준 역압 | 1–3분 | 3 | [CITE: SIHVO_LAXVOX] | – | 3, 8 |
| **P15-15** | **LaxVox – 5 cm 침수** | **C** | **Sihvo** | LaxVox heavy | 강한 역압, 고부하 | 30–60초 | 3 | [CITE: SIHVO_LAXVOX] | 고혈압 주의 | 3, 8 |
| **P15-16** | **LaxVox – 7 cm 침수** | **C** | **Sihvo** | LaxVox max | 최대 역압, 단시간 | 15–30초 | 4 | [CITE: SIHVO_LAXVOX] | 어지럼·기침 즉시 중단 | 3, 8 |
| P3-12 | /vʊ/ /zʊ/ semi-occlusion | C | Verdolini | voiced SOVT 변형 | 가벼운 역압 + 모음 통합 | 3분 | 3 | [CITE: VERDOLINI_LMRVT] | – | 3 |
| P3-13 | Y-buzz (Lessac) | C/D | Lessac | "y-buzz" | 마스크 진동 감각 유도 | 1–2분 | 4 | [CITE: LESSAC_USE] | – | 4 |
| P3-14 | Bilabial fricative /β/ | C | Guzman et al. | "bilabial trill 변형" | 입술 마찰 역압 | 1–2분 | 3 | [CITE: GUZMAN_SOVT] | – | 3 |

---

### D. 공명·포먼트·플레이스먼트 (Resonance / Formant / Placement)

| ID | 훈련명 (KR / EN) | 카테고리 | 학파/원전 | 동의어 | 음향/생리 목표 | dosage | 근거 | 출처 | 위험·금기 | 관련 part |
|----|----------------|---------|---------|--------|--------------|--------|------|------|---------|---------|
| P4-01 | Vowel modification (커버링) | D | Miller, Coffin | aggiustamento, modification | 모음 F1·F2를 음역에 맞게 조정 | 음역별 매핑 | 3 | [CITE: MILLER_STRUCTURE] | 과커버 → 답답함 | 4, 5 |
| P4-02 | Singer's formant cluster (F3-F4-F5) | D | Sundberg | "singing formant" | 2.5–3.5 kHz 공명 클러스터, 무반주 ovrride | 분석 + 모음 튜닝 | 1 | [CITE: SUNDBERG_FORMANT] | "Italian Formant" 오기 정정 | 4 |
| P4-03 | Mask resonance | D | Miller, Garcia | "in the mask", maschera | 비/부비동 진동 감각 → 전방 공명 | 매 워밍업 | 4 | [CITE: MILLER_STRUCTURE] | 비강 의존 → 비음 과다 | 4 |
| P4-04 | Open throat / gola aperta | D | 벨칸토 | "throat space" | 인두강 확장, 후두 안정 하강 | 모음별 점검 | 5 | [CITE: MILLER_STRUCTURE] | 과확장 → 어두운 톤 | 4 |
| P4-05 | NG → vowel transfer | D | Estill, SLP | "ng-to-vowel" | 연구개·비강 폐쇄 인지, twang 도입 | 5분 | 4 | [CITE: ESTILL_PRIMER] | – | 4, 5 |
| P4-06 | Tongue position mapping | D | Miller | "tongue arch" | F2 정확화 (전설/후설) | 모음 표 | 4 | [CITE: MILLER_STRUCTURE] | – | 4, 6 |
| P4-07 | Larynx height calibration | D | Estill, Sundberg | larynx tilt/height | 후두 수직 위치(낮음/중립/높음) 의도적 사용 | 단계 5단 | 4 | [CITE: ESTILL_PRIMER] | 과긴장 주의 | 4, 5 |
| **P15-17** | **F1=H1 tuning (high soprano, C6+)** | **D** | **Sundberg; Joliveau et al.** | "first formant tuning", whistle/flute 조정 | C6 이상에서 F1을 H1에 맞추기 위해 모음 [a]/[ɔ]로 이동 | 음역별 모음 표 | 2 | [CITE: SUNDBERG_FORMANT], [CITE: JOLIVEAU2004] | 무리한 [i] 유지 시 음정·음질 붕괴 | 4 |
| **P15-18** | **Bozeman acoustic passage ("turning the vowel")** | **D** | **Kenneth Bozeman** | "vowel turn", first formant crossing | passaggio에서 H2가 F1을 통과하면서 발생하는 음향 전환 인지·활용 | 분석 + scale | 4 | [CITE: BOZEMAN_PRACTICAL] | – | 4, 5 |
| P4-08 | /i/-/u/ 대비 훈련 | D | Coffin | 모음 극성 | F2 양극을 통한 공명 인지 | 3분 | 5 | [CITE: COFFIN_OVERTONES] | – | 4 |
| P4-09 | Spectrogram-based formant tuning | D/G | 음향분석 | "real-time spectrogram" | LTAS·F1·F2 시각 피드백 | 10–20분 | 3 | [CITE: SUNDBERG_SCIENCE] | – | 4, 7 |
| P4-10 | Nasal continuum (open–closed VP) | D | Estill | velopharyngeal port control | 비/구강 균형 의도적 제어 | 5단계 | 4 | [CITE: ESTILL_PRIMER] | – | 4 |

---

### E. 레지스터·믹스·벨트·트웽 (Register / Mix / Belt / Twang)

| ID | 훈련명 (KR / EN) | 카테고리 | 학파/원전 | 동의어 | 음향/생리 목표 | dosage | 근거 | 출처 | 위험·금기 | 관련 part |
|----|----------------|---------|---------|--------|--------------|--------|------|------|---------|---------|
| P5-01 | M1 (chest/modal) isolation | E | Henrich, Roubeau | thick fold, TA-dominant | M1 특성 인지 (CQ 높음, H1<H2) | 5분 | 2 | [CITE: HENRICH_REGISTERS] | 고음 강압 주의 | 5 |
| P5-02 | M2 (head/falsetto) isolation | E | Henrich | thin fold, CT-dominant | M2 인지 (CQ 낮음) | 5분 | 2 | [CITE: HENRICH_REGISTERS] | – | 5 |
| P5-03 | Passaggio negotiation (zona di passaggio) | E | Miller | primo/secondo passaggio | 전이구간 모음·resonance 조정 | scale × 5 | 4 | [CITE: MILLER_STRUCTURE] | 과압력 시 crack | 5 |
| P5-04 | Mix voice (mixed registration) | E | CCM, Estill | belt-mix, head-mix | TA/CT 협응으로 부드러운 전환 | 1.5 옥타브 scale | 4 | [CITE: ESTILL_PRIMER] | 정의 모호 → "mix" 학파별 차이 인지 | 5 |
| **P15-19** | **Belt 안전 단계 훈련 (step-up)** | **E** | **Bourne; LeBorgne** | progressive belt | (1) speech-level call (2) call on pitch (3) sustained belt; F1 dominance, larynx high but free | scale 단계별, 주 3회, 2–4주 | 3 | [CITE: BOURNE_BELT], [CITE: LEBORGNE_DOSAGE] | 부적절 시 결절·출혈; 사전 평가 필수 | 5, 8 |
| **P15-20** | **Twang 단계 훈련 (oral twang first → belt 결합)** | **E** | **Estill; Lombard** | AES narrowing progression | (1) oral twang (밝고 효율) (2) nasal twang (3) belt와 결합 | 5분 × 3단계 | 4 | [CITE: ESTILL_PRIMER] | "코소리"로 오역 금지 — twang ≠ nasal | 4, 5 |
| **P15-21** | **AES narrowing 단독 훈련 ("witch laugh", duck call, "nyae nyae")** | **E** | **Estill (Aryepiglottic Sphincter)** | epilarynx narrowing | epilaryngeal tube 좁힘으로 singer's formant cluster 강화 | 30초 × 5 | 3 | [CITE: ESTILL_PRIMER], [CITE: TITZE_PRINCIPLES] | 과긴장 → press | 4, 5 |
| P5-05 | Speech-like singing | E | Bel canto → CCM | parlando, "speech-level" | 회화 톤으로 phonation threshold↓ | 매 phrase | 4 | [CITE: MILLER_STRUCTURE] | – | 5 |
| **P15-22** | **Distortion / growl / false-fold engagement (안전 훈련)** | **E** | **Sakakibara et al.; Anne-Maria Laukkanen** | rough voice, ventricular phonation, fry-belt | ventricular fold/aryepiglottic vibration의 의도적·간헐적 사용; 진성대 보호 | 5–15초 × 3, 충분한 SOVT 회복 | 3 | [CITE: SAKAKIBARA_GROWL] | 만성 사용·통증·출혈 시 즉시 중단; 의학 평가 | 5, 8 |
| **P15-23** | **Yodel (M1↔M2 flip)** | **E** | **알프스 민속, CCM** | break-flip, voice break drill | 의도적 레지스터 전환으로 협응 다양성 확보 | 1–2 옥타브 scale | 4 | [CITE: HENRICH_REGISTERS] | crack 통증 시 중단 | 5 |
| P5-06 | Sirens (octave glide) | E | Estill, SLP | "sirening" | 부드러운 register 통과 | 5분 | 4 | [CITE: ESTILL_PRIMER] | – | 3, 5 |
| P5-07 | Whistle register intro (소프라노) | E | CCM | M3, flute register | M3 진입·종료 안전 | 짧게 × 5 | 4 | [CITE: HENRICH_REGISTERS] | 과긴장 시 중단 | 5 |

---

### F. 딕션·조음 (Diction / Articulation)

| ID | 훈련명 (KR / EN) | 카테고리 | 학파/원전 | 동의어 | 음향/생리 목표 | dosage | 근거 | 출처 | 위험·금기 | 관련 part |
|----|----------------|---------|---------|--------|--------------|--------|------|------|---------|---------|
| P6-01 | IPA mapping (KR/EN/IT/DE/FR) | F | classical diction | 국제음성기호 | 모음·자음 정밀화, 다국어 호환 | 곡당 매핑 | 5 | [CITE: MARSHALL_SINGER_MANUAL] | – | 6 |
| P6-02 | Legato vowel chaining | F | 벨칸토 | "filo di voce" | 자음 시간 최소화, 모음 연속성 | phrase별 | 4 | [CITE: MILLER_STRUCTURE] | – | 6 |
| P6-03 | Consonant precision drills (plosive, fricative) | F | 연극·뮤지컬 | tongue twisters | 명료도, 자음 압력 분리 | 5분 | 4 | [CITE: LESSAC_USE] | – | 6 |
| P6-04 | Korean-specific 자모 발성 | F | 한국 발성교육 | 한국어 IPA | 평음/경음/격음 구분 정밀화 | 5분 | 5 | – | – | 6 |
| P6-05 | Italianate vowel set [i e ɛ a ɔ o u] | F | 벨칸토 | "puro" 모음 | 7모음 균질화 | 5음 × 7모음 | 4 | [CITE: MILLER_STRUCTURE] | – | 6 |
| P6-06 | French nasal vowels [ɑ̃ ɛ̃ ɔ̃ œ̃] | F | French diction | "nasalité française" | VP port 의도적 개방 | 곡 컨텍스트 | 4 | [CITE: BERNAC_FRENCH] | – | 6 |
| P6-07 | German Umlaut [y ø] training | F | German Lied | – | 전설 원순 모음 정확 | 곡 매핑 | 4 | [CITE: MARSHALL_SINGER_MANUAL] | – | 6 |
| P6-08 | Speech-Sing continuum | F | CCM, RAP | "rhythmic speech" | 리듬·다이내믹 결합 | 4–8마디 | 5 | – | – | 5, 6 |
| P6-09 | Articulator independence (jaw vs tongue) | F | Lessac | "tongue-jaw dissociation" | 턱 고정 + 혀 독립 운동 | 5분 | 4 | [CITE: LESSAC_USE] | TMJ 통증 시 중단 | 6 |
| P6-10 | Coda consonant timing | F | 뮤지컬 발음 | "late consonant" | 장단 정밀화 | phrase별 | 5 | – | – | 6 |

---

### G. 평가·자기모니터링 (Assessment / Self-monitoring)

| ID | 훈련명 (KR / EN) | 카테고리 | 학파/원전 | 동의어 | 음향/생리 목표 | dosage | 근거 | 출처 | 위험·금기 | 관련 part |
|----|----------------|---------|---------|--------|--------------|--------|------|------|---------|---------|
| P7-01 | VHI / VHI-10 자가설문 | G | Jacobson | Voice Handicap Index | 자각 음성장애 추적 | 4주 간격 | 1 | [CITE: JACOBSON_VHI] | – | 7 |
| P7-02 | CAPE-V 청지각 평가 | G | ASHA | Consensus Auditory-Perceptual Evaluation of Voice | overall, roughness, breathiness, strain 등 | 평가 시 | 1 | [CITE: KEMPSTER_CAPEV] | 훈련된 평가자 권장 | 7 |
| P7-03 | MPT (최장발성시간) | G | clinic standard | maximum phonation time | 호흡-발성 효율 지표 | 3 시도 평균 | 2 | [CITE: COLTON_CASPER] | – | 7 |
| P7-04 | s/z ratio | G | Eckel & Boone | – | 성문 효율 추정 | 3 시도 | 3 | [CITE: BOONE_VOICE] | – | 7 |
| P7-05 | Acoustic analysis (jitter, shimmer, HNR) | G | Praat | perturbation measures | 음향 안정성 정량화 | 주 1회 | 2 | [CITE: BOERSMA_PRAAT] | – | 7 |
| P7-06 | LTAS (long-term average spectrum) | G | Sundberg | spectral envelope | singer's formant 정량화 | 곡 단위 | 2 | [CITE: SUNDBERG_FORMANT] | – | 4, 7 |
| P7-07 | Pitch range profile / Voice Range Profile (phonetogram) | G | Schutte, Pabon | VRP, "phonetogram" | F0×SPL 영역 매핑 | 분기별 | 2 | [CITE: SCHUTTE_VRP] | – | 7 |
| **P15-24** | **EGG-based CQ 모니터링 (스마트폰 SingScope, VoceVista 등)** | **G** | **Henrich; Howard** | electroglottography, contact quotient | 실시간 CQ로 내전 정도 피드백 | 5–10분 | 2 | [CITE: HENRICH_REGISTERS], [CITE: HOWARD_EGG] | 전극 접지·피부 과민 주의 | 5, 7 |
| P7-08 | 청지각 훈련 (ear training for voice quality) | G | CAPE-V 기반 | "perceptual training" | 평가자 신뢰도↑ | 주 30분 | 3 | [CITE: KEMPSTER_CAPEV] | – | 7 |
| P7-09 | Self-recording 일지 | G | 일반 | recording log | 종단 변화 추적 | 매 세션 | 5 | – | – | 7, 8 |
| P7-10 | Vocal dose meter (APM/Ambulatory Phonation Monitor) | G | Hillman, Mehta | "voice accumulator" | 일일 phonation time·cycle dose 측정 | 일상 8h | 2 | [CITE: HILLMAN_APM] | – | 7, 8 |

---

### H. 워밍업·쿨다운·회복·위생 (Warm-up / Cool-down / Recovery / Hygiene)

| ID | 훈련명 (KR / EN) | 카테고리 | 학파/원전 | 동의어 | 음향/생리 목표 | dosage | 근거 | 출처 | 위험·금기 | 관련 part |
|----|----------------|---------|---------|--------|--------------|--------|------|------|---------|---------|
| P8-01 | Low-impact warm-up (SOVT 중심) | H | Verdolini, Titze | "gentle warm-up" | 점막파 활성, threshold pressure↓ | 5–10분 | 2 | [CITE: TITZE_SOVT] | – | 8 |
| P8-02 | Full warm-up (10–20분) | H | 전통 | 클래식 워밍업 | 호흡 + SOVT + scale + 모음 | 10–20분 | 3 | [CITE: MCHENRY_WARMUP] | – | 8 |
| P8-03 | Cool-down (descending sirens, hum) | H | Gottliebson, Ragan | post-performance recovery | 점막 부종·근피로 회복 | 5–10분 | 2 | [CITE: RAGAN_COOLDOWN] | – | 8 |
| P8-04 | Vocal rest (relative / absolute) | H | clinic | 음성 휴식 | 조직 회복 | 24–72시간 | 3 | [CITE: COLTON_CASPER] | 절대 휴식은 단기 | 8 |
| P8-05 | Hydration (systemic / surface) | H | Verdolini | water + nebulized saline | 점막 점성↓, threshold pressure↓ | 1.5–2 L/일, neb 5–10분 | 2 | [CITE: VERDOLINI_HYDRATION] | 과도 흡입 자극 | 8 |
| P8-06 | Vocal load management (dose budget) | H | Titze, Hillman | "vocal dosimetry" | 누적 cycle dose 모니터·할당 | 일·주 단위 | 2 | [CITE: TITZE_DOSIMETRY] | – | 7, 8 |
| P8-07 | Sleep & circadian alignment | H | sports voice science | – | 점막·근 회복 | 7–9h | 2 | – | – | 8 |
| P8-08 | Reflux 관리 (LPR) | H | Koufman | "laryngopharyngeal reflux" | 후두 자극 감소 | 식이·자세·약물 | 2 | [CITE: KOUFMAN_LPR] | 자가 PPI 장기 사용 주의 | 8 |
| P8-09 | Environmental humidity 관리 | H | clinic | 가습 | 점막 건조 방지 | RH 40–60% | 3 | – | – | 8 |
| P8-10 | Pre-performance 30/60/90분 프로토콜 | H | Bourne, performance science | "warm-up timeline" | peak performance window 정렬 | 무대 전 90분 분할 | 4 | [CITE: BOURNE_BELT] | – | 8 |

---

## 3. 동의어·번역 통합표 (Synonym Crosswalk)

본 표는 part 14 disambiguation glossary와 정합되며, **명백한 오역·오기 정정**을 포함한다.

### 3.1 호흡·지지

| 표준 (KR) | English | 학파별 명칭 | 정정 사항 |
|----------|---------|------------|----------|
| 횡격막 호흡 | diaphragmatic breathing | belly breathing, abdominal breathing | – |
| 앱포지오 | appoggio | "lutta vocale", breath suspension | **"앉아앉는 호흡" 오역 — appoggio = "기댐", 앉기와 무관** |
| 지지 | support | breath support, sostegno | – |
| 호흡 멈춤 | suspension | "fermata respiratoria" | – |

### 3.2 발성·온셋

| 표준 (KR) | English | 학파별 | 정정 |
|----------|---------|-------|------|
| 균형 온셋 | balanced/coordinated/simultaneous onset | Vennard "coordinated", Estill "smooth onset" | – |
| 호기성 온셋 | aspirate / breathy onset | /h/-attack | – |
| 성문 온셋 | glottal onset | "coup de glotte" (Garcia), hard attack | – |
| Phonation Threshold Pressure | PTP | "최소 발성 압력" | – |

### 3.3 SOVT

| 표준 | English | 동의어 | K-pop 산업 명명 (1차 학술 검증 부재) |
|------|---------|--------|---|
| 반폐쇄 성도 훈련 | semi-occluded vocal tract (SOVT) | "back-pressure exercises" | (총칭 부재 — 워밍업 일반) `[K-pop 산업관행]` |
| 빨대 발성 | straw phonation | tube phonation, "phonation into a straw" | (한국 산업 일반화 미흡) |
| 립 트릴 | lip trill | lip buzz, lip bubble, "brrr" | **lip bubble / 입술 떨기** — 가장 흔한 1차 워밍업 도구 [CITE: KCONTENT_VOCAL] `[K-pop 산업관행]` |
| 혀 트릴 | tongue trill | rolled-R, /r̃/ | (한국 산업 적용 적음, 발음 특성상) |
| 허밍 | hum | M-hum, NG-hum | **사이렌 글라이드 (siren)** — NG-hum 기반 저→고→저 글라이드의 산업 명칭 [CITE: KCONTENT_VOCAL] `[K-pop 산업관행]` |
| 수중 공명관 | resonance tube in water | LaxVox, Finnish tube | (한국 산업 적용 거의 부재) |
| (별도 카테고리: hard onset 변형) | hard glottal onset drill | (Part 3 P3-04) | **k-keok / kkook** — 자음·모음 짧은 어택 드릴 (SOVT 아님, hard onset 계열) [CITE: KCONTENT_VOCAL] `[K-pop 산업관행]` |

> K-pop 산업 명명은 동료심사 학술 검증이 부재하다. 본 표의 매핑은 *기능적 추론*이며, 기획사 매뉴얼이 공개되면 갱신 필요. 자세한 매핑·안전 한계는 Part 9-KR §"K-pop 명명 연습 ↔ 음성과학 매핑" 참조.

### 3.4 공명·포먼트

| 표준 | English | 동의어/오기 정정 |
|------|---------|----------------|
| 가수의 포먼트 클러스터 | singer's formant cluster (F3-F4-F5) | **"Italian Formant" 오기 → singer's formant cluster로 정정** |
| 마스크 공명 | mask resonance | "in the mask", maschera, "frontal placement" |
| 모음 조정 | vowel modification | aggiustamento, "covering" (단, covering ≠ darkening 전용) |
| 후두 위치 | larynx height | low/neutral/high larynx, "larynx tilt" (Estill의 tilt는 별개) |
| 인두강 확장 | open throat | gola aperta, "throat space" |

### 3.5 레지스터·믹스·벨트·트웽

| 표준 | English | 학파별 / 정정 |
|------|---------|-------------|
| M1 (modal/chest) | thick fold, TA-dominant | Henrich M1 = chest |
| M2 (falsetto/head) | thin fold, CT-dominant | Henrich M2 |
| M3 (whistle/flute) | flute register | – |
| M0 (vocal fry) | pulse register, creak | – |
| 믹스 | mix voice | belt-mix, head-mix — **학파별 정의 상이** |
| 벨트 | belt | "chest dominant high" — F1-H2 tuning |
| 트웽 | twang | AES narrowing — **"코소리(nasal)" 오역 금지. twang은 oral twang이 기본** |
| Edge | Estill Edge | **Edge ≠ twang. Edge는 thin TBCM + AES narrowing 결합** |
| 파사지오 | passaggio | "primo/secondo passaggio", zona di passaggio |

### 3.6 딕션

| 표준 | English | 동의어 |
|------|---------|--------|
| IPA | International Phonetic Alphabet | – |
| 레가토 | legato | "filo di voce", connected |
| 명료도 | intelligibility | clarity, diction precision |
| 코다 자음 | coda consonant | "late consonant" |

### 3.7 평가

| 표준 | English | 동의어 |
|------|---------|--------|
| 음성장애지수 | VHI / VHI-10 | – |
| 청지각 평가 | CAPE-V | – |
| 최장발성시간 | MPT | – |
| 접촉지수 | CQ (contact quotient) | EGG-derived |
| 성역도 | VRP / phonetogram | "voice range profile" |

---

## 4. 학습자별 권장 시퀀스 표

각 단계는 **누적적**이다. 다음 단계로 넘어가기 전에 이전 단계의 평가 지표(P7-01~10)를 충족해야 한다.

### 4.1 초급 (0–6개월) — 기반 구축

**중심 카테고리: A · B · C**

| 주차 | 워밍업 (5–10분) | 본 훈련 (15–25분) | 쿨다운 (5분) |
|------|--------------|---------------|------------|
| 1–4주 | P1-04 횡격막호흡 → P3-09 lip trill | P1-02 body mapping, P3-01 balanced onset, P15-11 straw 5mm | P3-11 hum 하행 |
| 5–12주 | P1-05 appoggio 도입 → P3-10 tongue trill | P3-04 messa di voce (단순), P3-08 VFE | P8-03 cool-down |
| 13–24주 | P1-09 hiss timed exhale → P15-13 LaxVox 1cm | P3-11 hum→vowel transfer, P15-04 SAF 1–2단계 | P8-03 |

**평가 게이트:** MPT ≥ 15초 (성인), VHI-10 < 10, jitter < 1.0%.

### 4.2 중급 (6–24개월) — 공명·레지스터 통합

**추가 카테고리: D · E**

| 시기 | 추가 훈련 |
|------|--------|
| 7–12개월 | P4-01 vowel modification, P4-03 mask resonance, P5-06 sirens, P5-03 passaggio negotiation |
| 13–18개월 | P4-05 NG→vowel, P5-04 mix voice, P15-20 twang 1단계 (oral) |
| 19–24개월 | P15-18 Bozeman acoustic passage 도입, P4-02 singer's formant cluster 분석, P15-21 AES narrowing |

**평가 게이트:** VRP 영역 ≥ 24 ST × 25 dB, CAPE-V overall ≤ 20/100.

### 4.3 고급 (2년+) — 전 카테고리 + 부하관리

**전 카테고리 + G · H 강조**

| 시기 | 추가 훈련 |
|------|--------|
| 2–3년 | P15-19 belt 안전 단계, P15-22 distortion 안전 훈련 (장르 필요 시), P15-17 F1=H1 (소프라노), P7-10 vocal dose meter |
| 3년+ | P15-02 PhoRTE (필요 시), P15-09 manual laryngeal therapy (임상가), P8-10 pre-performance 90분 프로토콜, P15-24 EGG-CQ 모니터링 |

**평가 게이트:** 성역도 안정 + 곡 레퍼토리 dose budget 준수 + APM 일일 phonation time ≤ 권장치.

### 4.4 회복기·재활 시퀀스

성대 결절·폴립·수술 후·기능적 음성장애 회복기 권장:

1. **초기 (0–2주):** P15-03 confidential voice + P15-07 LMRVT 1단계 + P8-04 vocal rest
2. **중기 (2–6주):** P15-04 SAF + P3-06 voiced fricative SOVT + P15-12 straw 7mm (저부하)
3. **후기 (6–12주):** P15-02 PhoRTE 또는 P3-08 VFE + 점진적 부하 복귀
4. **모든 단계:** 이비인후과/SLP 정기 추적 필수.

---

## 5. 안전 트리거 일람 (Universal Safety Triggers)

본 DB의 **모든 카드에 공통으로 적용**되는 의학적 의뢰 트리거. 다음 중 **하나라도** 해당하면 훈련을 즉시 중단하고 이비인후과(후두내시경 가능 기관) 또는 음성언어치료사에게 의뢰한다.

### 5.1 즉시 의뢰 (Red Flags)

| 증상 | 가능 병태 | 조치 |
|------|---------|------|
| **2주 이상 지속되는 애성(hoarseness)** | 결절, 폴립, 부종, 후두암 | 후두내시경 |
| **객혈 / 가래 혈흔** | 출혈성 폴립, 혈관 파열, 악성 | 응급 |
| **호흡곤란 / 흡기 천명(stridor)** | 성대 마비, 종괴, 후두 부종 | 응급 |
| **삼킴곤란(dysphagia) / 흡인** | 신경학적 / 종괴 | 신속 의뢰 |
| **무통성 경부 종괴** | 림프선 / 갑상선 / 악성 | 신속 의뢰 |
| **갑작스러운 음성 상실 (실성증)** | 성대 마비, 심인성 | 신속 의뢰 |
| **연하 시 통증(odynophagia) 동반 애성** | 감염, 종괴 | 의뢰 |
| **발성 시 지속적 통증** | MTD, 결절, 관절 문제 | 의뢰 |

> **고위험군(흡연자, 음주자, 50세 이상, HPV 위험)은 4주가 아니라 2주 기준 적용.**

### 5.2 훈련 중단 트리거 (해당 세션 즉시 중단)

- 어지럼증 / 시야 흐림 (과호흡)
- 가슴 통증 또는 흉부 압박감
- 피로 한계 초과 (목 무거움, 발성 압박감 증가)
- 출혈 또는 따끔거림
- 청각 변화 (이명, 이폐색감)

### 5.3 카테고리별 추가 주의사항

| 카테고리 | 특별 주의 |
|---------|----------|
| A | EMST·resistive — 고혈압·녹내장·최근 흉부 수술 시 의학적 승인 |
| B | hard glottal onset — 결절·출혈·급성 후두염 시 절대 금기 |
| C | LaxVox 5–7 cm — 단시간만, 어지럼 즉시 중단 |
| D | F1=H1 / 과커버 — 음정 붕괴·답답함 시 단계 후퇴 |
| E | Belt·twang·distortion — 사전 후두 평가, 점진적 dose, 충분한 회복 |
| F | jaw 독립 운동 — TMJ 통증 시 중단 |
| G | EGG 전극 — 피부 과민·심박조율기 사용자 주의 |
| H | LPR 자가 PPI — 4주 이상 시 의학적 평가 필수 |

### 5.4 부하관리 권장치 (vocal dose)

- **일일 phonation time:** 일반 4시간, 직업 음성사용자 6시간 (Hillman APM 기준)
- **주간 부하:** 점진적 증가, 주당 10% 이내 (sports science principle)
- **고강도(belt, distortion) 후:** 24–48시간 회복기, SOVT 중심 cool-down

### 5.5 고위험 인구 추가 권장 (2026 갱신)

- **K-pop 트레이니 (10–18세)**: 변성기 진행 중 또는 변성 직후 시기에 고강도 다중 카테고리(B-belt + E-twang/distortion + F-rapid articulation) 중복 부하가 누적될 위험. 입학(트레이니 계약) 시점에서 이미 22% 가량이 결절 보유 가능성 (Sielska-Badurek 2024 / 폴란드 CCM 학생 데이터의 외삽) [CITE: SIELSKA2024]. 본 DB의 카테고리 B·E 카드는 *트레이니 연령에서는 보수적 dose*로 운영 권고. **반드시** 입학 시 후두 베이스라인 평가, 분기별 모니터링 권고.
- **클래식 학부 1–3학년**: Bretl 2023 종단(1년차 0% → 3년차 22%)으로 *지연 발현* 확정 [CITE: BRETL2023]. 1년차 무손상이 안전 신호가 아니다 — Part 8 P8-01 컨디션 게이트를 학년·장르 무관하게 동일 적용.
- **CCM 입학 전 손상 보유자**: 입학 시점 결절 보유 22% (Sielska 2024). 입학 직후 *훈련 시작 전* 후두 평가 권고.

위 권장은 본 DB 내 모든 카드의 dose·세션 위치·금기 라인에 *상위* 적용된다.

---

## 6. 카드 수 요약

| 카테고리 | 카드 수 | 비고 |
|---------|--------|------|
| A. 호흡·자세·신체정렬 | 11 | EMST 신규 추가 |
| B. 발성·온셋·내전 | 17 | PhoRTE, Confidential Voice, SAF, Accent Method, LMRVT, fry, manual therapy 신규 |
| C. SOVT | 13 | straw 3개 직경 + LaxVox 4개 침수 깊이 분리 |
| D. 공명·포먼트·플레이스먼트 | 12 | F1=H1 tuning, Bozeman acoustic passage 신규 |
| E. 레지스터·믹스·벨트·트웽 | 12 | belt 단계, twang 단계, AES, distortion, yodel 신규 |
| F. 딕션·조음 | 10 | – |
| G. 평가·자기모니터링 | 11 | EGG-CQ 신규 |
| H. 워밍업·쿨다운·회복·위생 | 10 | – |
| **합계** | **96** | 목표 50+ 초과 달성 |

---

## 7. 사용 안내

1. **카드 ID로 원본 part 역추적:** `P3-08` → part 3의 8번 카드.
2. **신규 P15-XX 카드:** 본 파트에서 처음 도입된 카드로, 향후 part 1–8 개정 시 적절한 위치로 통합 권장.
3. **인용:** 모든 `[CITE: KEY]`는 BIBLIOGRAPHY.md에 정의되어 있다. 정의가 누락된 키는 별도 보충 작업 필요.
4. **다음 단계:** part 16(누락 점검)에서 본 DB 대비 추가 조사 우선순위를 정리한다.

---

*Master Database compiled from part 1–8. 카드 세부 프로토콜·dosage·근거 본문은 원본 part를 참조하라.*
