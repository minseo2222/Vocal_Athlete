import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/recording_ab_panel.dart';
import 'package:vocal_athlete/recording/audio_io.dart';
import 'package:vocal_athlete/recording/audio_session_coordinator.dart';
import 'package:vocal_athlete/recording/recording_ab.dart';

/// 실제 파일 I/O는 testWidgets의 fake-async에서 완료되지 않아(runAsync 필요)
/// 테스트를 멈추게 한다. 경로만 합성하고 디스크를 건드리지 않는 resolver.
class _NoIoPathResolver implements RecordingFilePathResolver {
  @override
  Directory get rootDirectory => Directory('fake');

  @override
  Future<String> nextPath({
    required String cardId,
    required RecordingPurpose purpose,
    required RecordingSlot slot,
    required String takeId,
  }) async =>
      'fake/${slot.name}_$takeId.m4a';

  @override
  Future<File> metadataFile() async => File('fake/recording_index.json');
}

void main() {
  test('v11 coordinator emits ordered stop events', () {
    final coordinator = AudioSessionCoordinator();
    final sequences = <int>[];
    coordinator.addListener(() => sequences.add(coordinator.event.sequence));
    coordinator.signal(
      AudioSessionAction.trainingStopped,
      AudioSessionStopReason.recordingStarted,
    );
    coordinator.signal(
      AudioSessionAction.allStopped,
      AudioSessionStopReason.appLifecycle,
    );
    expect(sequences, <int>[1, 2]);
    expect(coordinator.event.reason, AudioSessionStopReason.appLifecycle);
    coordinator.dispose();
  });

  testWidgets('v11 external capture cancel resets recording panel UI',
      (tester) async {
    tester.view.physicalSize = const Size(1200, 3600);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final capture = FakeAudioCaptureAdapter();
    final coordinator = AudioSessionCoordinator();
    addTearDown(coordinator.dispose);

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: RecordingAbPanel(
          cardId: 'TONE-12',
          repository: InMemoryRecordingRepository(),
          captureAdapter: capture,
          pathResolver: _NoIoPathResolver(),
          audioSessionCoordinator: coordinator,
        ),
      ),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('add-ab-take-button')));
    await tester.pumpAndSettle();
    expect(find.text('녹음 종료'), findsOneWidget);

    coordinator.signal(
      AudioSessionAction.captureCancelled,
      AudioSessionStopReason.trainingAudioStarted,
    );
    await tester.pump();
    expect(find.text('녹음 시작'), findsOneWidget);
    expect(find.textContaining('녹음을 취소했습니다'), findsOneWidget);
  });
}
