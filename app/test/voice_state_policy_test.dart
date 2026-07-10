import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/card_library.dart';
import 'package:vocal_athlete/lesson/voice_state.dart';

void main() {
  test('R4 hoarse voice state switches any card to recovery mode', () {
    final card = kCardLibrary['TONE-08']!;
    final a = adaptLessonForVoiceState(card, VoiceState.hoarse);
    expect(a.recoveryMode, isTrue);
    expect(a.showPitch, isFalse);
    expect(a.microWin.contains('streak'), isTrue);
  });

  test('R4 tired voice state hides pitch for moderate/gated cards', () {
    final moderate = kCardLibrary['TONE-08']!;
    final low = kCardLibrary['CARD-01']!;
    expect(adaptLessonForVoiceState(moderate, VoiceState.tired).showPitch, isFalse);
    expect(adaptLessonForVoiceState(low, VoiceState.tired).showPitch, isTrue);
  });
}
