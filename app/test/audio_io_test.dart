import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/recording/audio_io.dart';

void main() {
  test('v6 fake capture adapter returns captured file metadata', () async {
    final adapter = FakeAudioCaptureAdapter(fakeSizeBytes: 321);
    expect(await adapter.start('/tmp/vocal_take.m4a'), isTrue);
    final captured = await adapter.stop();
    expect(captured, isNotNull);
    expect(captured!.path, '/tmp/vocal_take.m4a');
    expect(captured.fileSizeBytes, 321);
  });

  test('v6 fake capture adapter can deny permission', () async {
    final adapter = FakeAudioCaptureAdapter(permission: false);
    expect(await adapter.hasPermission(), isFalse);
    expect(await adapter.start('/tmp/deny.m4a'), isFalse);
  });

  test('v10 fake training audio adapter records bundled asset playback', () async {
    final adapter = FakeTrainingAudioPlaybackAdapter();
    await adapter.playAsset('assets/training/prompt.wav');
    await adapter.stop();
    expect(adapter.playedAssets, ['assets/training/prompt.wav']);
    expect(adapter.stopCalls, 1);
  });
}
