import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/recording/audio_io.dart';
import 'package:vocal_athlete/recording/recording_ab.dart';
import 'package:vocal_athlete/recording/recording_controller.dart';

void main() {
  test('v6 controller records, saves, lists, plays and deletes a take', () async {
    final tmp = await Directory.systemTemp.createTemp('vocal_controller_');
    final playback = FakeAudioPlaybackAdapter();
    final controller = RecordingController(
      capture: FakeAudioCaptureAdapter(),
      playback: playback,
      repository: InMemoryRecordingRepository(),
      pathResolver: RecordingFilePathResolver(tmp),
    );
    await controller.startTake(
      cardId: 'CARD-13',
      purpose: RecordingPurpose.standardSample,
      slot: RecordingSlot.baseline,
      sequence: 1,
    );
    expect(controller.isRecording, isTrue);
    final take = await controller.stopAndSave(
      toneTags: [ToneTag.clear],
      comfortRating: 4,
      sameConditionConfirmed: true,
    );
    expect(take, isNotNull);
    expect(take!.purpose, RecordingPurpose.standardSample);
    expect(take.localPath, contains('CARD-13_take_01'));
    expect(take.createdLocalDateKey, isNotEmpty);
    expect((await controller.listTakes(purpose: RecordingPurpose.standardSample)).single.id, take.id);
    await controller.play(take);
    expect(playback.played.single, take.localPath);
    await controller.deleteTake(take);
    expect(await controller.listTakes(purpose: RecordingPurpose.standardSample), isEmpty);
    await tmp.delete(recursive: true);
  });
}
