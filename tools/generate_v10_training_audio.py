#!/usr/bin/env python3
"""Generate deterministic, original prototype audio for v10 neutral_001.

The files are synthetic training cues (hum-like guide, piano-like guide,
backing pad, click), not a human performance master. They are generated from
an original note sequence stored in the repository and contain no third-party
recordings.
"""
from __future__ import annotations

import hashlib
import json
import math
import wave
from pathlib import Path

import numpy as np

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "app/assets/repertoire/neutral_001"
CORE_OUT = ROOT / "app/assets/training/universal_core_cycle_01"
SR = 24_000
COUNT_IN_BEATS = 4
BARS = 4
BEATS_PER_BAR = 4
MID_NOTES = [60, 60, 62, 64, 64, 62, 60, 59, 60, 62, 64, 65, 64, 62, 60, 60]
LOW_NOTES = [n - 5 for n in MID_NOTES]
MID_CHORDS = [[48, 52, 55], [45, 48, 52], [41, 45, 48], [48, 52, 55]]
LOW_CHORDS = [[n - 5 for n in chord] for chord in MID_CHORDS]
PROTOTYPE_PEAK = 0.50


def midi_hz(note: int) -> float:
    return 440.0 * 2.0 ** ((note - 69) / 12.0)


def fade(n: int, attack_s: float = 0.025, release_s: float = 0.05) -> np.ndarray:
    env = np.ones(n, dtype=np.float64)
    a = min(n // 2, int(SR * attack_s))
    r = min(n // 2, int(SR * release_s))
    if a:
        env[:a] = np.linspace(0.0, 1.0, a, endpoint=False)
    if r:
        env[-r:] = np.linspace(1.0, 0.0, r, endpoint=True)
    return env


def hum_note(freq: float, duration: float) -> np.ndarray:
    n = max(1, int(SR * duration))
    t = np.arange(n) / SR
    # Soft harmonic stack with a tiny deterministic vibrato; deliberately subtle.
    vibrato = 1.0 + 0.0025 * np.sin(2 * np.pi * 5.2 * t)
    phase = 2 * np.pi * freq * np.cumsum(vibrato) / SR
    y = (
        0.72 * np.sin(phase)
        + 0.20 * np.sin(2 * phase)
        + 0.07 * np.sin(3 * phase)
        + 0.025 * np.sin(4 * phase)
    )
    return y * fade(n, 0.05, 0.08)


def piano_note(freq: float, duration: float) -> np.ndarray:
    n = max(1, int(SR * duration))
    t = np.arange(n) / SR
    decay = np.exp(-3.3 * t / max(duration, 0.1))
    y = (
        0.72 * np.sin(2 * np.pi * freq * t)
        + 0.20 * np.sin(2 * np.pi * 2 * freq * t)
        + 0.08 * np.sin(2 * np.pi * 3 * freq * t)
    ) * decay
    return y * fade(n, 0.008, 0.04)


def click(accent: bool) -> np.ndarray:
    duration = 0.065 if accent else 0.045
    n = int(SR * duration)
    t = np.arange(n) / SR
    freq = 1450.0 if accent else 980.0
    y = np.sin(2 * np.pi * freq * t) * np.exp(-58 * t)
    return y * (0.75 if accent else 0.5)


def render_melody(notes: list[int], bpm: int, kind: str) -> np.ndarray:
    beat = 60.0 / bpm
    total_beats = COUNT_IN_BEATS + len(notes)
    y = np.zeros(int(SR * beat * total_beats), dtype=np.float64)
    for i, note in enumerate(notes):
        start = int(SR * beat * (COUNT_IN_BEATS + i))
        duration = beat * (0.96 if kind == "hum" else 0.82)
        tone = hum_note(midi_hz(note), duration) if kind == "hum" else piano_note(midi_hz(note), duration)
        end = min(len(y), start + len(tone))
        y[start:end] += tone[: end - start]
    return y


def render_click(bpm: int) -> np.ndarray:
    beat = 60.0 / bpm
    total_beats = COUNT_IN_BEATS + BARS * BEATS_PER_BAR
    y = np.zeros(int(SR * beat * total_beats), dtype=np.float64)
    for i in range(total_beats):
        start = int(SR * beat * i)
        accent = i % BEATS_PER_BAR == 0
        c = click(accent)
        y[start : start + len(c)] += c
    return y


def render_short_click(bpm: int, beats: int = 8) -> np.ndarray:
    beat = 60.0 / bpm
    y = np.zeros(int(SR * beat * beats), dtype=np.float64)
    for i in range(beats):
        start = int(SR * beat * i)
        c = click(i % BEATS_PER_BAR == 0)
        y[start : start + len(c)] += c
    return y


def render_note_sequence(notes: list[int], seconds_per_note: float, kind: str = "hum") -> np.ndarray:
    gap = 0.08
    total = len(notes) * seconds_per_note
    y = np.zeros(int(SR * total), dtype=np.float64)
    for i, note in enumerate(notes):
        start = int(SR * i * seconds_per_note)
        duration = max(0.1, seconds_per_note - gap)
        tone = hum_note(midi_hz(note), duration) if kind == "hum" else piano_note(midi_hz(note), duration)
        end = min(len(y), start + len(tone))
        y[start:end] += tone[: end - start]
    return y


def render_backing(bpm: int, chords: list[list[int]]) -> np.ndarray:
    beat = 60.0 / bpm
    total_beats = COUNT_IN_BEATS + BARS * BEATS_PER_BAR
    y = np.zeros(int(SR * beat * total_beats), dtype=np.float64)
    bar_duration = beat * BEATS_PER_BAR
    for bar, chord in enumerate(chords):
        start = int(SR * beat * (COUNT_IN_BEATS + bar * BEATS_PER_BAR))
        n = int(SR * bar_duration)
        t = np.arange(n) / SR
        pad = np.zeros(n, dtype=np.float64)
        for note in chord:
            f = midi_hz(note)
            pad += 0.30 * np.sin(2 * np.pi * f * t)
            pad += 0.06 * np.sin(2 * np.pi * 2 * f * t)
        pad *= fade(n, 0.12, 0.18)
        end = min(len(y), start + n)
        y[start:end] += pad[: end - start]
    # Quiet click mixed in to make entry timing usable without overwhelming the phrase.
    y += 0.22 * render_click(bpm)
    return y


def normalize(y: np.ndarray, peak: float = PROTOTYPE_PEAK) -> np.ndarray:
    max_abs = float(np.max(np.abs(y))) if len(y) else 0.0
    if max_abs == 0:
        return y
    return y * (peak / max_abs)


def write_wav(path: Path, y: np.ndarray) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    pcm = np.clip(normalize(y), -1.0, 1.0)
    pcm16 = (pcm * 32767.0).astype("<i2")
    with wave.open(str(path), "wb") as wf:
        wf.setnchannels(1)
        wf.setsampwidth(2)
        wf.setframerate(SR)
        wf.writeframes(pcm16.tobytes())


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def main() -> None:
    OUT.mkdir(parents=True, exist_ok=True)
    CORE_OUT.mkdir(parents=True, exist_ok=True)
    outputs = {
        "guide_hum_low.wav": render_melody(LOW_NOTES, 72, "hum"),
        "guide_hum_mid.wav": render_melody(MID_NOTES, 72, "hum"),
        "guide_melody_piano_low.wav": render_melody(LOW_NOTES, 72, "piano"),
        "guide_melody_piano_mid.wav": render_melody(MID_NOTES, 72, "piano"),
        "guide_melody_slow_low.wav": render_melody(LOW_NOTES, 60, "piano"),
        "guide_melody_slow_mid.wav": render_melody(MID_NOTES, 60, "piano"),
        "backing_track_low.wav": render_backing(72, LOW_CHORDS),
        "backing_track_mid.wav": render_backing(72, MID_CHORDS),
        "click_72bpm.wav": render_click(72),
    }
    for old in OUT.glob("*.wav"):
        old.unlink()
    for name, data in outputs.items():
        write_wav(OUT / name, data)

    core_outputs = {
        "reference_pitch_low.wav": render_note_sequence([55], 2.0, "hum"),
        "reference_pitch_mid.wav": render_note_sequence([60], 2.0, "hum"),
        "three_note_arch_low.wav": render_note_sequence([55, 59, 55], 0.85, "hum"),
        "three_note_arch_mid.wav": render_note_sequence([60, 64, 60], 0.85, "hum"),
        "sovt_contour_low.wav": render_note_sequence([55, 57, 55], 0.85, "hum"),
        "sovt_contour_mid.wav": render_note_sequence([60, 62, 60], 0.85, "hum"),
        "pulse_72bpm.wav": render_short_click(72, 8),
        "phrase_4beat_u_low.wav": render_note_sequence([55], 60.0 / 72 * 4, "hum"),
        "phrase_4beat_u_mid.wav": render_note_sequence([60], 60.0 / 72 * 4, "hum"),
        "one_note_phrase_low.wav": render_note_sequence([55] * 8, 60.0 / 72, "hum"),
        "one_note_phrase_mid.wav": render_note_sequence([60] * 8, 60.0 / 72, "hum"),
    }
    for old in CORE_OUT.glob("*.wav"):
        old.unlink()
    for name, data in core_outputs.items():
        write_wav(CORE_OUT / name, data)

    rights = {
        "assetId": "neutral_001",
        "status": "prototype_original_synthetic",
        "owner": "Vocal Athlete project",
        "thirdPartyAudio": False,
        "humanVocalRecording": False,
        "usage": "in-app vocal training prototype",
        "note": "Synthetic low/mid guide and accompaniment generated deterministically by tools/generate_v10_training_audio.py. Peak is deliberately limited for prototype playback. Replace with expert-produced masters before release.",
        "prototypePeakFullScale": PROTOTYPE_PEAK,
        "files": [
            {"path": name, "sha256": sha256(OUT / name), "sampleRate": SR, "channels": 1}
            for name in outputs
        ],
    }
    (OUT / "rights.json").write_text(json.dumps(rights, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")

    core_rights = {
        "assetId": "universal_core_cycle_01",
        "status": "prototype_original_synthetic",
        "owner": "Vocal Athlete project",
        "thirdPartyAudio": False,
        "humanVocalRecording": False,
        "usage": "short reference tones, contours, phrase and pulse cues",
        "note": "Synthetic low/mid prompts only; not a diagnostic or final pedagogic master. Peak is deliberately limited for prototype playback.",
        "prototypePeakFullScale": PROTOTYPE_PEAK,
        "files": [
            {"path": name, "sha256": sha256(CORE_OUT / name), "sampleRate": SR, "channels": 1}
            for name in core_outputs
        ],
    }
    (CORE_OUT / "rights.json").write_text(json.dumps(core_rights, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"repertoire": list(outputs), "core": list(core_outputs)}, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
