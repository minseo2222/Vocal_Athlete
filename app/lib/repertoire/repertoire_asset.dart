/// v10 — 곡 적용 훈련용 프레이즈 manifest 모델.
library;

import 'dart:convert';

import 'package:flutter/services.dart';

class LyricCue {
  const LyricCue({required this.bar, required this.text, required this.beat});
  final int bar;
  final String text;
  final int beat;

  factory LyricCue.fromJson(Map<String, dynamic> json) => LyricCue(
        bar: json['bar'] as int,
        text: json['text'] as String,
        beat: json['beat'] as int,
      );
}

class BreathMark {
  const BreathMark({required this.beforeBar, required this.cue});
  final int beforeBar;
  final String cue;

  factory BreathMark.fromJson(Map<String, dynamic> json) => BreathMark(
        beforeBar: json['beforeBar'] as int,
        cue: json['cue'] as String,
      );
}

class RepertoireAsset {
  const RepertoireAsset({
    required this.id,
    required this.title,
    required this.language,
    required this.bars,
    required this.tempoBpm,
    required this.countInBeats,
    required this.assetStatus,
    required this.recommendedKeys,
    required this.audioAssets,
    required this.lyricTiming,
    required this.breathMarks,
    required this.rightsRecord,
  });

  final String id;
  final String title;
  final String language;
  final int bars;
  final int tempoBpm;
  final int countInBeats;
  final String assetStatus;
  final List<String> recommendedKeys;
  final Map<String, String> audioAssets;
  final List<LyricCue> lyricTiming;
  final List<BreathMark> breathMarks;
  final String rightsRecord;

  factory RepertoireAsset.fromJson(Map<String, dynamic> json) =>
      RepertoireAsset(
        id: json['id'] as String,
        title: json['title'] as String,
        language: json['language'] as String,
        bars: json['bars'] as int,
        tempoBpm: json['tempoBpm'] as int,
        countInBeats: (json['countInBeats'] as int?) ?? 0,
        assetStatus: (json['assetStatus'] as String?) ?? 'placeholder',
        recommendedKeys: List<String>.from(
            (json['recommendedKeys'] as List<dynamic>?) ?? const ['mid']),
        audioAssets: Map<String, String>.from(
            (json['audioAssets'] as Map<String, dynamic>?) ?? const {}),
        lyricTiming: ((json['lyricTiming'] as List<dynamic>?) ?? const [])
            .map((e) => LyricCue.fromJson(e as Map<String, dynamic>))
            .toList(growable: false),
        breathMarks: ((json['breathMarks'] as List<dynamic>?) ?? const [])
            .map((e) => BreathMark.fromJson(e as Map<String, dynamic>))
            .toList(growable: false),
        rightsRecord: (json['rightsRecord'] as String?) ?? '',
      );

  factory RepertoireAsset.fromJsonString(String source) =>
      RepertoireAsset.fromJson(jsonDecode(source) as Map<String, dynamic>);

  String? audioPath(String role) => audioAssets[role];
}

class RepertoireAssetRepository {
  const RepertoireAssetRepository({this.bundle});

  final AssetBundle? bundle;

  Future<RepertoireAsset> load(String assetId) async {
    final source = await (bundle ?? rootBundle)
        .loadString('assets/repertoire/$assetId/manifest.json');
    return RepertoireAsset.fromJsonString(source);
  }
}
