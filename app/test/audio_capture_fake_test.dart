import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/recording/audio_io.dart';

void main() {
  test('v6 fake audio capture returns local path and duration metadata', () async {
    final audio = FakeAudioCaptureAdapter();
    final ok = await audio.start('/tmp/CARD-13_take_01.m4a');
    final result = await audio.stop();
    expect(ok, isTrue);
    expect(result, isNotNull);
    expect(result!.path, contains('CARD-13_take_01'));
    expect(result.durationMs, greaterThan(0));
    expect(result.fileSizeBytes, greaterThan(0));
  });

  test('v6 fake audio capture surfaces permission denial', () async {
    final audio = FakeAudioCaptureAdapter(permission: false);
    expect(await audio.start('/tmp/x.m4a'), isFalse);
  });
}
