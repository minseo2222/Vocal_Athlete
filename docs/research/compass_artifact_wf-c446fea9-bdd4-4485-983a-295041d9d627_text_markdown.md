# Evidence-Graded Literature Review: Self-Directed mHealth Singing/Voice Training App for Intermediate–Advanced Musical Theatre Learners

## TL;DR
- **Only one of the six clinical/safety questions has anything approaching strong (A/B) evidence to act on**, and even that (twang/epilaryngeal narrowing acoustics) cannot be safely measured phone-only. Belt dose/recovery numbers, app-alone overload metrics, twang fatigue thresholds, and "character timbre without constriction" graduation criteria are all **D/E-grade** — pedagogically asserted but empirically unvalidated, and the key physiological measures (formant tuning, spectral tilt, EGG contact quotient, supraglottic compression) are **NOT reliable on a consumer phone microphone**.
- **The phone can reliably do exactly three things: track F0/pitch, track timing, and collect structured self-report.** It cannot validly measure SPL (absolute loudness), formants (R1/R2 tuning — the acoustic definition of belt), spectral tilt/H1-H2, or vocal-fold contact. Therefore every belt-safety, overload, and constriction claim must be implemented as **education + self-report + conservative time/rest scheduling**, NOT as a measured "you are safe / you are overloading" score.
- **Verdict: 5 of 6 questions REQUIRE GATING (human-in-the-loop / expert sign-off) for any high-risk technique decision; only Question 6 (belt→mix/legit fallback as a taught de-escalation strategy) is partially SAFE TO IMPLEMENT phone-only**, because reducing load at a climax is supported by convergent physiology and carries low downside risk.

## Key Findings (with evidence grades)

- **No validated belt dose-recovery numbers exist.** The vocal-dose framework (Titze, Švec & Popolo 2003, *J Speech Lang Hear Res* — time dose, cycle dose, distance dose) is **Grade A** as a measurement *construct*, but every belt-specific musical-theatre dosimetry study explicitly states that no safe baseline has been established. Belt-specific per-session/per-week allowable repetitions and rest intervals are **Grade D/E**.
- **Vocal-fold tissue recovery from acute phonotrauma takes longer than a typical overnight rest** (rabbit model: inflammatory→restorative shift between 24h and 3 days; secondary subjective fatigue peak 24–72h post-load in humans). This is **Grade B/C** mechanistic evidence supporting *rest scheduling*, but it does not yield a belt-specific number.
- **CPP (cepstral peak prominence) is well-validated for dysphonia severity (Grade A) but is NOT a validated marker of vocal fatigue/overload (Grade C, mixed/null)** — and in singers it is confounded by loudness and vibrato. After vocal loading, studies show CPP decreasing, increasing, OR not changing.
- **Twang/epilaryngeal narrowing acoustics are real and convergent across schools (Grade B)**, but the claim that twang *reduces* vocal effort/load is **not established for CCM belt** — one study found twang-like phonation required *higher* air pressure, not lower.
- **There is no terminology consensus on "mix," "belt mix," or "high belt" (Grade A finding of non-consensus).** The chest-dominant vs. mixed-registration debate is genuinely unresolved by EMG data.
- **No objective, phone-measurable metric distinguishes "healthy character timbre" from "constricted/squeezed" production.** Supraglottic compression — the obvious candidate — does NOT reliably distinguish disordered from healthy voices and requires laryngoscopy. **Grade D for any objective graduation criterion.**

---

## Question 1 — Belt Safety: Quantitative Dose & Recovery

**What the evidence says.** The foundational construct is Titze, Švec & Popolo (2003, *J Speech Lang Hear Res* 46(4):919–932), defining three vocal doses — **time dose** (cumulative phonation time), **cycle dose** (number of vocal-fold vibration cycles), and **distance dose** (distance vocal-fold tissue travels, combining time, F0 and SPL). They derived a safe limit verbatim as: "the safe distance dose was derived to be about 500 m. This limit was found rather low for vocalization; it was related to a comparable time dose of about 17 min of continuous vocalization, or about 35 min of continuous reading with normal breathing and unvoiced segments." **This was extrapolated from industrial hand-transmitted-vibration limits, not from vocal-fold outcome data** (Grade C as a heuristic; the belt-specific application is D).

Musical-theatre dosimetry studies (Zuim, Stewart & Titze 2021, *J Voice*, "Vocal Dose and Vocal Demands in Contemporary Musical Theatre"; and the 2023 *Nine* dosimetry study, PMID 37951817) measured real rehearsal loads. The 2023 study of five female student-singers in the musical *Nine* (using a KayPENTAX APM dosimeter) found **time doses ranging from 4% to 7% of rehearsal time** and concluded verbatim: **"Researchers have yet to establish a safe baseline vocal dose for singers."** No per-vocal-range, per-session, or per-week belt repetition/rest numbers are evidence-based (Grade **D/E**).

Recovery: Rousseau et al. (Vanderbilt, rabbit model, *Cells Tissues Organs* 2017) found vocal-fold epithelium shifts from inflammatory to restorative repair **between 24 hours and 3 days** after raised-intensity phonation. Hunter & Titze's recovery-trajectory work found a **secondary subjective fatigue peak ~24–72 hours post-loading**, and that a typical weekend may be inadequate after heavy loading (Grade **B/C** mechanistically). RCT evidence on voice *rest* exists only for post-phonosurgery (favoring shorter 3-day over 7-day absolute rest) — not transferable to belt dosing.

**Convergence vs. single-school:** Pedagogy converges (Grade B) that belt should be "paced," interleaved with lighter production, and not done cold — but specific numbers are not pedagogically convergent either.

**Phone feasibility:** Time dose and F0 are phone-measurable; **cycle dose and distance dose require SPL, which is NOT reliable on a phone mic.** Smartphone sound-level-meter validation work shows substantial error: Murphy & King's multi-device testing found significant inter-device variability (standard deviation ~6.81 dB) with mean deviations near 2.8–2.9 dBA even on iOS/Android, and Robinson & Tingay found uncalibrated apps differed by an average of ~12 dB from a Type 1 sound level meter; the ASHA-published smartphone SLM study (2018_AJSLP-17-0171, PMID 30398549) found app measures only accurate above 40–50 dB *when calibrated* and inaccurate/overestimating below 50 dB even with calibration. So the app can estimate *phonation time and pitch range* but cannot compute true vocal dose.

**APP VERDICT: REQUIRES GATING.** The app may implement **conservative, self-report-and-timer-based pacing** (e.g., capped belt practice duration, mandatory rest blocks informed by the 24–72h recovery literature) framed explicitly as precautionary, not as a validated safe dose. Any individualized belt dose prescription requires HITL/expert sign-off.

---

## Question 2 — App-Alone Belt Safety Decision Metrics (no EGG)

**What can a phone mic validly measure?** Convergent reliability hierarchy from smartphone-validation studies (Jannetts, Schaeffler & Beck 2019, *Int J Lang & Communication Disorders*; Awan et al. 2024 *JSLHR*; Maryn et al.):
- **F0 / pitch: RELIABLE** (systematic error <2 Hz, random error ~±5 Hz on phones). **Grade A.**
- **CPP / CPPS: moderately robust to recording device** (better than jitter/shimmer/spectral tilt), and validated for **dysphonia severity** (Murton, Hillman & Mehta 2020; ASHA 2018 expert panel recommends CPP as the primary acoustic measure for voice assessment). **Grade A for dysphonia severity.** BUT as a **vocal fatigue/overload marker, CPP is NOT validated (Grade C, mixed)**: after vocal-loading tasks, studies report CPP **decreasing** (in disordered/fatigued patients — e.g., the Comprehensive Index of Vocal Fatigue validation cohort, and a hyperfunctional-voice case-control study, PMID 32184054), **increasing** (driven by higher SPL — a J Voice short-term VLT study found Fo and CPP *rose* after loading), and **no change at all** (40-min choral-conductor VLT, PMID 35272881; Nature *Sci Rep* 2025 reported no significant CPPs change; a temple-priest pilot found no correlation with fatigue ratings). In singers specifically, CPPS is confounded by SPL (louder phonation raises CPP) and vibrato "smearing" of the smoothed cepstrum.
- **Jitter / shimmer: NOT reliable enough** on phones (large random errors; Jannetts et al. 2019) and become invalid above ~5% jitter / ~10% shimmer (Titze threshold — cycle-identification failure); heavily SPL-dependent (Brockmann-Bauser et al. found voice SPL is the single biggest source of variability). **Grade D for phone use.**
- **SPL / intensity: NOT phone-reliable** without per-device calibration (multi-dB deviation, automatic gain control on Android). **Grade D.**
- **Spectral tilt / H1-H2 / alpha ratio: NOT phone-reliable.** Schaeffler, Jannetts & Beck (2019, Interspeech) found spectral-tilt random error of ~21–51% of range across phones with significant device-dependent negative bias; H1-H2 (and corrected H1\*-H2\*) showed large bias and high random error; Awan et al. (2024) found a strong recording-method effect on the L/H spectral-tilt ratio; Marsano-Cornejo & Roco-Videla (2022) concluded phone-derived parameters (including alpha ratio) are not comparable to a professional microphone. **Grade D/E for phone use.**
- **Contact quotient (EGG surrogate): requires EGG hardware.** The EGG closed quotient correlates strongly with vocal-fold impact stress (r≈0.81–0.96, excised-larynx work) — but there is **no validated acoustic-only phone surrogate for contact quotient.** **Grade D for phone.**

**Bottom line:** There is **no validated phone-measurable acoustic proxy for vocal hyperfunction/overload.** The measures that *would* index overload (contact quotient, SPL, spectral tilt) are precisely the ones phones cannot measure reliably.

**APP VERDICT: REQUIRES GATING.** The app must NOT display any "overload detected / you are safe to belt" decision based on phone acoustics. It may track F0 accuracy and phonation timing, and use **structured self-report of vocal effort/discomfort** (e.g., validated Vocal Fatigue Index–style items) as the primary safety signal — with escalation to expert review on symptom flags.

---

## Question 3 — Twang Intensity → Laryngeal Load Curve

**What the evidence says.** Twang = narrowing of the epilaryngeal tube / aryepiglottic sphincter, clustering F3–F5 into a "singer's/speaker's formant" near ~3 kHz (Sundberg's acoustic model; Lombard & Steinhauer 2007 twang-therapy work; "What is Twang?" CT/inverse-filtering studies). This physiology is **convergent across Estill, CVT and other systematic approaches (Grade B)**, and MRI (Jelinger et al. 2024) measured aryepiglottic cross-sectional area reductions of **11.8%–52.4%** vs. speech, with high inter-individual variability.

**The effort/economy claim is contested.** Titze's nonlinear source-filter theory (2008, *JASA*) predicts epilaryngeal narrowing improves impedance matching, lowering phonation threshold pressure and improving vocal economy (**Grade C — theory + modeling, not in-vivo CCM belt outcomes**). However, a CCM-singer study using the "quasi-output-cost ratio" (QOCR) found **no significant economy difference** between neutral and twang-like voices, and that **twang-like voices required significantly higher air pressure**, suggesting *increased* aerodynamic effort to compensate for supralaryngeal constriction. So "twang reduces effort" is **NOT established for loud CCM belt (Grade C, conflicting)**.

**Fatigue threshold data: none.** There are **no studies establishing a light-twang vs. strong-twang fatigue threshold or dose** (Grade **E**). Perceived effort and actual laryngeal load are known to dissociate (the muscle-tension-dysphonia literature shows poor correlation between self-perceived effort and laryngeal motor patterns), which undermines using "it feels easy" as a safety signal.

**Phone feasibility:** Twang's acoustic signature lives in the ~3 kHz formant-cluster region — **formant/spectral measurement is NOT phone-reliable.** The app cannot validly quantify twang intensity from a phone mic.

**APP VERDICT: REQUIRES GATING.** Twang can be *taught* (neutral, non-branded language: "bright, ringing focus / narrowing of the upper throat funnel") with audio modeling, but the app cannot measure twang intensity or its load, and cannot certify "safe twang." Strong-twang/belt work requires HITL.

---

## Question 4 — High Belt / Belt Mix High-Range Extension

**Terminology: explicit non-consensus (Grade A finding).** Bourne & Kenny, "Vocal Qualities in Music Theater Voice: Perceptions of Expert Pedagogues" (*J Voice* 2016, 30(5):128.e1–128.e12, PMID 25882989), interviewed 12 expert teachers internationally and found verbatim that **"teachers were not in agreement about the meaning of 'mix'"** and that, while most described belt as heavily weighted/thick-fold/TA-dominant/chest register, **"there was no consensus on an appropriate term"** for belt. "Belt mix," "mixed belt," and "high belt" are **not standardized** — flag all as non-consensus/branded where used.

**Chest-dominant vs. mixed registration debate (genuinely unresolved).** EMG evidence (Kochis-Jennings et al. 2012, 2014, *J Voice*) found chest/chestmix are thyroarytenoid (TA)-dominant and headmix/head are cricothyroid (CT)-dominant — **but only below ~300 Hz; above 300 Hz, all registers showed CT-dominant or near-equal CT:TA ratios.** Since female high belt sits above this, the "it's pure chest voice carried up" model is **not supported by EMG (Grade C against pure-chest)**. Acoustically, Bourne & Garnier (2012, *JASA* 131(2):1586–1594, PMID 22352528) found belt singers "generally tuned the first vocal tract resonance (R1) to the second harmonic (2f0) up to C5," with higher closed quotient (CQ) in belt than legit and "no significant differences between twangy belt and chesty belt, except slightly higher frequencies of R2"; female chesty belt fell in mechanism M1 (OQ ~0.43) and legit in M2 (OQ ~0.68). The practical upper limit of belt is near C5, where R1 can no longer track the rising 2nd harmonic. Male belt behaves differently (Bourne, Garnier & Samson 2016 — legit, chesty and twangy belt all in M1). EGG: heavy belt closed quotient ~0.5 with high subglottal pressure vs. classical <0.25 (Björkner; Sundberg).

**Master-teacher convergence on high belt (Grade B):** The female high belt is **narrow, built on closed vowels, mixing in some degree of head-voice function, maintaining speech-like quality** — convergent across master teachers in the Broadway-belt evolution study (NATS-hosted).

**Evidence-based prerequisite checklist** (synthesized; convergence Grade B, no RCT validation = overall C): (1) stable, balanced mix through the primary passaggio before adding chest weight up high; (2) demonstrated vowel modification / brighter-vowel facility on ascending pitches; (3) no pain/strain (self-report); (4) adequate warm-up; (5) conservative dose with rest. None of these prerequisites has been validated as *injury-preventive* by controlled trials.

**Phone feasibility:** F0 (is the singer hitting target pitch?) is reliable; the defining acoustic features (R1–2H2 tuning, closed quotient) are **NOT phone-measurable.**

**APP VERDICT: REQUIRES GATING.** High belt is a high-risk extension. The app may teach prerequisites and track pitch/timing, but **must lock high-belt extension drills behind HITL/expert sign-off** confirming the prerequisite mix competency.

---

## Question 5 — Objective Load of Character/Timbre Change ("timbre difference without throat constriction/squeeze")

**The core problem: "constriction" is not objectively, non-invasively, phone-measurably definable.**
- Supraglottic compression (the intuitive candidate for "squeeze") is measured via **laryngoscopy** and, critically, **does NOT reliably distinguish disordered from healthy voices**: mediolateral false-fold and A-P compression occur in vocally *healthy* rock and classical singers and in normal articulation (Stager et al. 2000; Behrman et al.; Sama et al.). A 2023 *J Voice* study (pMTD vs. controls, flexible laryngoscopy) found **no significant relationship between any supraglottic-compression metric and self-perceived vocal effort**, and only mediolateral compression weakly distinguished MTD patients. **Grade D for supraglottic compression as a constriction criterion.**
- The pMTD literature (multiple studies using shear-wave elastography, optical flow, motion capture, vocal-fold tracking) shows patients with muscle-tension dysphonia have **similar laryngeal motor patterns to healthy individuals** but report higher effort — i.e., **objective laryngeal measures and perceived constriction dissociate.** No single acoustic measure indexes laryngeal tension (Bhuta, Patrick & Garnett 2004).
- Even the term "constriction" lacks consensus among practitioners ("Toward Defining 'Vocal Constriction'," *J Voice* 2017): location and effects are individual and context-dependent.

**What is objectively quantifiable (but not phone-only):** EGG contact quotient (impact-stress surrogate, needs hardware), subglottal pressure (estimated via /p/-occlusion, lab task), false-fold compression (laryngoscopy). **None is a phone-measurable, validated "no-squeeze" graduation criterion.**

**Phone feasibility:** None of the constriction metrics is phone-reliable. The only phone-available signals are self-reported comfort/effort and F0 stability.

**APP VERDICT: REQUIRES GATING.** There is no objective, phone-measurable metric to certify "character timbre without constriction." Graduation on this criterion **requires expert auditory-perceptual + (ideally) laryngoscopic assessment (HITL).** The app may collect self-report and pitch-stability data as adjuncts only.

---

## Question 6 — Belt Fallback Decision (belt → mix / legit / speech-like at a climax)

**What the evidence says.** Belt is consistently associated with **higher subglottal pressure, higher SPL, longer closed phase (higher closed quotient ~0.5)** than legit/mix (Sundberg, Gramming & LoVetri 1993; Bourne & Garnier 2012; Björkner 2008). Mix qualities sit physiologically **between** legit and chesty belt (Bourne & Garnier 2012, where each singer used a different strategy to land between the two). Therefore, **substituting mix/legit/speech-like production for belt at a high-load moment reduces subglottal pressure and vocal-fold impact load** — this is a **mechanically sound, convergent inference (Grade B/C)**. CCM pedagogy and master teachers converge that not every belt must be at maximum volume and that effort can be dialed down note-to-note (Grade B pedagogical convergence).

**Important honesty:** There is **no RCT or longitudinal study directly proving that belt→mix substitution at climaxes prevents injury** (Grade **C/D** for the specific clinical claim). The downside risk of *teaching de-escalation*, however, is very low — it reduces load, which the dose literature uniformly treats as protective.

**Phone feasibility:** A belt→mix transition typically involves the *same or similar target pitch* with reduced loudness/weight — **the app can track whether the target F0 is maintained (reliable)** but **cannot verify the quality change** (mix vs belt is defined by closed quotient/resonance tuning, not phone-measurable). It also cannot verify the loudness reduction (SPL unreliable).

**APP VERDICT: PARTIALLY SAFE TO IMPLEMENT (phone-only).** Teaching belt→mix/legit/speech-like fallback as a **de-escalation strategy** is low-risk and supported by convergent physiology; the app can present it, cue it at notated climaxes, and confirm pitch is maintained via F0. It **cannot certify** that the singer correctly executed a healthy mix (that confirmation REQUIRES GATING). Net: implement the *strategy/education* phone-only; gate any *competency certification*.

---

## Recommendations (staged, with thresholds)

**Stage 0 — Architecture (do immediately).** Build the app on the three reliable phone signals only: **F0/pitch, timing/phonation-time, and structured self-report.** Treat every belt/twang/high-belt/constriction claim as **education + self-report + conservative scheduling**, never as a measured pass/fail safety score. Hard-code the "app does not score performance" and "high-risk techniques locked until HITL" rules.

**Stage 1 — Safe-to-ship phone-only features:**
- Pitch-accuracy and timing feedback (Grade A reliable).
- Phonation-time tracking with **precautionary** rest scheduling informed by the 24–72h recovery literature (label as precautionary, not validated dose).
- Education modules on belt/mix/twang in **neutral, non-branded language**, flagging single-school terms (e.g., Estill "twang," SLS "mix," CVT modes).
- Belt→mix/legit **de-escalation training** (Question 6) cued at climaxes, with F0-maintenance confirmation.
- Daily/weekly **self-report vocal-effort/discomfort check-ins** (Vocal Fatigue Index–style), with symptom-triggered escalation.

**Stage 2 — Gated features (require HITL/expert sign-off before unlock):** high-belt range extension (Q4), strong-twang/belt intensity work (Q3), any "no-constriction" timbre graduation (Q5), and any individualized belt dose prescription (Q1).

**Stage 3 — Escalation thresholds that change the plan:** Trigger mandatory expert review / lock progression if the user reports (a) pain, (b) persistent hoarseness >24–72h, (c) loss of high range, or (d) recurring effort spikes. These self-report flags — NOT phone acoustics — are the safety backbone.

**What would change these recommendations:** If a validated, phone-reliable acoustic proxy for vocal overload were established (currently absent), or if belt-specific dose-recovery RCTs produced range-specific numbers, Stages 1–2 could add measured feedback. Monitor the vocal-dose and smartphone-validation literatures for this.

## Caveats
- **The evidence base is thin and largely cross-sectional/observational.** Belt physiology studies often have very small N (single subjects to ~6–7 singers) and study trained professionals, limiting generalization to self-directed learners.
- **Pedagogy frequently outruns evidence.** Where Estill/SLS/CVT/Somatic Voicework/Bel Canto make confident claims (e.g., "twang is effortless," "belt is safe if done right"), the empirical support is partial at best; branded terminology is flagged throughout.
- **Perceived effort is an unreliable safety gauge** — it dissociates from objective laryngeal load (pMTD literature), so "it feels fine" must not be treated as proof of safety.
- **Phone-measurement limits are decisive:** the measures that define belt and index its load (formant/R1 tuning, SPL, spectral tilt, contact quotient) are exactly the ones a phone cannot capture reliably. This is the single most important constraint on the whole app.

## Summary Table: Evidence Grades & Implementation Verdicts

| # | Question | Best evidence grade | Phone-measurable? | App verdict |
|---|----------|--------------------|--------------------|-------------|
| 1 | Belt dose & recovery numbers | Dose construct A; belt-specific numbers **D/E**; recovery mechanism B/C | Time/F0 yes; SPL/dose no | **REQUIRES GATING** (precautionary scheduling only) |
| 2 | App-alone overload metrics (no EGG) | CPP for dysphonia A; CPP for fatigue **C (mixed)**; SPL/tilt/jitter **D/E** on phone | No validated overload proxy | **REQUIRES GATING** (self-report primary) |
| 3 | Twang intensity → load curve | Twang acoustics B; effort/economy **C (conflicting)**; fatigue threshold **E** | No (formant region) | **REQUIRES GATING** |
| 4 | High belt / belt mix extension | Non-consensus on terms A; registration debate C; prereqs B/C | F0 yes; tuning/CQ no | **REQUIRES GATING** |
| 5 | Objective load of timbre/character change | Constriction metrics **D**; effort-laryngeal dissociation B | No | **REQUIRES GATING** |
| 6 | Belt → mix/legit fallback | Load-reduction physiology B/C; injury-prevention proof **C/D** | F0 yes; quality no | **PARTIALLY SAFE** (teach strategy; gate certification) |