import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/repertoire/repertoire_asset.dart';

void main() {
  test('v10 neutral_001 manifest references original prototype audio files', () {
    final source =
        File('assets/repertoire/neutral_001/manifest.json').readAsStringSync();
    final asset = RepertoireAsset.fromJsonString(source);

    expect(asset.id, 'neutral_001');
    expect(asset.assetStatus, 'prototype_audio_ready');
    expect(asset.bars, 4);
    expect(asset.tempoBpm, 72);
    expect(asset.countInBeats, 4);
    expect(asset.lyricTiming.length, 4);
    expect(asset.breathMarks.length, 2);
    expect(asset.recommendedKeys, ['low', 'mid']);
    expect(asset.audioAssets.length, 9);

    for (final path in asset.audioAssets.values) {
      expect(File(path.replaceFirst('assets/', 'assets/')).existsSync(), isTrue,
          reason: 'missing $path');
    }
  });

  test('v10 bundled wav files have RIFF/WAVE headers', () {
    final files = Directory('assets/repertoire/neutral_001')
        .listSync()
        .whereType<File>()
        .where((file) => file.path.endsWith('.wav'));
    expect(files.length, 9);
    for (final file in files) {
      final bytes = file.readAsBytesSync();
      expect(String.fromCharCodes(bytes.take(4)), 'RIFF');
      expect(String.fromCharCodes(bytes.skip(8).take(4)), 'WAVE');
    }
  });
}
