/// R4 — 목 상태에 따른 레슨 적응 정책.
///
/// 진단이 아니라 당일 연습 강도를 낮추는 UX/안전 정책이다.
library;

import 'card.dart';

enum VoiceState { ok, tired, hoarse }

class LessonAdaptation {
  const LessonAdaptation({
    required this.mainCue,
    required this.microWin,
    required this.showPitch,
    required this.notice,
    required this.nextLabel,
    required this.recoveryMode,
    required this.reducedMode,
  });

  final String mainCue;
  final String microWin;
  final bool showPitch;
  final String? notice;
  final String nextLabel;
  final bool recoveryMode;
  final bool reducedMode;
}

bool _isModerateOrHigher(Card card) =>
    card.safetyIntensity == 'moderate' ||
    card.safetyIntensity == 'high' ||
    card.safetyIntensity == 'gated';

bool _isGatedOrHigh(Card card) =>
    card.safetyIntensity == 'high' || card.safetyIntensity == 'gated';

LessonAdaptation adaptLessonForVoiceState(Card card, VoiceState? state) {
  final baseCue = card.cue.join('\n');
  final baseMicroWin =
      card.voicedMicroWin.isEmpty ? '가볍게 확인' : card.voicedMicroWin.first;
  if (state == VoiceState.hoarse) {
    return const LessonAdaptation(
      mainCue: '회복 모드: 오늘은 소리를 내지 않아도 됩니다.\n가이드 듣기 또는 무성 호흡 3회만 진행하세요.\n편하면 아주 가벼운 SOVT 1회만 하고 멈춥니다.',
      microWin: '듣기-only 또는 무성 호흡 3회 — streak 인정',
      showPitch: false,
      notice: '쉰 느낌: 회복 모드로 전환되었습니다. 소리내기를 건너뛰어도 완료로 인정됩니다.',
      nextLabel: '회복 쿨다운으로 가기',
      recoveryMode: true,
      reducedMode: false,
    );
  }
  if (state == VoiceState.tired) {
    final recovery = _isGatedOrHigh(card);
    if (recovery) {
      return LessonAdaptation(
        mainCue: '회복 모드: 오늘 카드는 강도가 높아 소리 과제를 쉬어갑니다.\n가이드 듣기, 무성 호흡, 아주 작은 /m/ 1회까지만 진행하세요.',
        microWin: '고강도 카드 대체: 듣기·호흡 또는 아주 작은 /m/ 1회',
        showPitch: false,
        notice: '조금 피곤함: 고강도 카드는 회복 모드로 대체됩니다.',
        nextLabel: '회복 쿨다운으로 가기',
        recoveryMode: true,
        reducedMode: false,
      );
    }
    return LessonAdaptation(
      mainCue: '라이트 모드: 반복은 절반만, 작게 진행합니다.\n$baseCue',
      microWin: '라이트 모드: $baseMicroWin 중 1–2회만',
      showPitch: !_isModerateOrHigher(card),
      notice: _isModerateOrHigher(card)
          ? '조금 피곤함: 중강도 이상 카드는 피치/강도 피드백을 줄입니다.'
          : '조금 피곤함: 반복 수를 줄여 진행합니다.',
      nextLabel: '쿨다운으로 가기',
      recoveryMode: false,
      reducedMode: true,
    );
  }
  return LessonAdaptation(
    mainCue: baseCue,
    microWin: baseMicroWin,
    showPitch: true,
    notice: null,
    nextLabel: '쿨다운으로 가기',
    recoveryMode: false,
    reducedMode: false,
  );
}
