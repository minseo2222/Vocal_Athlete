/// v18 — 날짜별 학습 blueprint와 자동 생성 콘텐츠 revision.
///
/// 첫 vertical slice는 asset JSON으로 Universal Core cycle 1과
/// Repertoire Application project 1을 제공한다. 자동 생성 SHA-256 manifest를
/// 함께 읽어, 수정 전후 콘텐츠를 같은 조건으로 오인하지 않는다.
library;

import 'dart:convert';

import 'package:flutter/services.dart';

class LessonAudioCue {
  const LessonAudioCue({required this.label, required this.path});

  final String label;
  final String path;

  factory LessonAudioCue.fromJson(Map<String, dynamic> json) => LessonAudioCue(
        label: json['label'] as String,
        path: json['path'] as String,
      );
}

class LessonBlueprint {
  const LessonBlueprint({
    required this.day,
    required this.cardId,
    required this.title,
    required this.primarySkill,
    required this.secondarySkill,
    required this.objective,
    required this.attempts,
    required this.steps,
    required this.feedbackPrompt,
    required this.selfCheck,
    required this.recoveryAlternative,
    required this.evidence,
    this.audioCues = const <LessonAudioCue>[],
    this.assetId,
    this.guideState,
  });

  final int day;
  final String cardId;
  final String title;
  final String primarySkill;
  final String secondarySkill;
  final String objective;
  final int attempts;
  final List<String> steps;
  final String feedbackPrompt;
  final List<String> selfCheck;
  final String recoveryAlternative;
  final String evidence;
  final List<LessonAudioCue> audioCues;
  final String? assetId;
  final String? guideState;

  factory LessonBlueprint.fromJson(Map<String, dynamic> json) =>
      LessonBlueprint(
        day: json['day'] as int,
        cardId: json['cardId'] as String,
        title: json['title'] as String,
        primarySkill: json['primarySkill'] as String,
        secondarySkill: json['secondarySkill'] as String,
        objective: json['objective'] as String,
        attempts: json['attempts'] as int,
        steps: List<String>.from(json['steps'] as List<dynamic>),
        feedbackPrompt: json['feedbackPrompt'] as String,
        selfCheck: List<String>.from(json['selfCheck'] as List<dynamic>),
        recoveryAlternative: json['recoveryAlternative'] as String,
        evidence: json['evidence'] as String,
        audioCues: ((json['audioCues'] as List<dynamic>?) ?? const <dynamic>[])
            .map((e) => LessonAudioCue.fromJson(e as Map<String, dynamic>))
            .toList(growable: false),
        assetId: json['assetId'] as String?,
        guideState: json['guideState'] as String?,
      );
}

class LessonBlueprintEntry {
  const LessonBlueprintEntry({
    required this.blueprint,
    required this.bundleVersion,
    required this.contentRevision,
    required this.sourceSha256,
  });

  final LessonBlueprint blueprint;
  final String bundleVersion;
  final String contentRevision;
  final String sourceSha256;

  bool matchesRevision(String earlierRevision) =>
      earlierRevision != 'unknown' && earlierRevision == contentRevision;
}

class LessonBlueprintBundle {
  const LessonBlueprintBundle({
    required this.schema,
    required this.version,
    required this.track,
    required this.cycle,
    required this.title,
    required this.lessons,
  });

  final String schema;
  final String version;
  final String track;
  final int cycle;
  final String title;
  final List<LessonBlueprint> lessons;

  factory LessonBlueprintBundle.fromJson(Map<String, dynamic> json) =>
      LessonBlueprintBundle(
        schema: json['schema'] as String,
        version: json['version'] as String,
        track: json['track'] as String,
        cycle: json['cycle'] as int,
        title: json['title'] as String,
        lessons: (json['lessons'] as List<dynamic>)
            .map((e) => LessonBlueprint.fromJson(e as Map<String, dynamic>))
            .toList(growable: false),
      );

  factory LessonBlueprintBundle.fromJsonString(String source) =>
      LessonBlueprintBundle.fromJson(
        jsonDecode(source) as Map<String, dynamic>,
      );

  LessonBlueprint? lessonForDay(int day) {
    for (final lesson in lessons) {
      if (lesson.day == day) return lesson;
    }
    return null;
  }
}

class CurriculumContentFile {
  const CurriculumContentFile({
    required this.path,
    required this.sha256,
    required this.bundleVersion,
  });

  final String path;
  final String sha256;
  final String bundleVersion;
}

class CurriculumContentManifest {
  const CurriculumContentManifest({
    required this.schema,
    required this.version,
    required this.algorithm,
    required this.files,
  });

  final String schema;
  final String version;
  final String algorithm;
  final Map<String, CurriculumContentFile> files;

  factory CurriculumContentManifest.fromJson(Map<String, dynamic> json) {
    final rawFiles = (json['files'] as Map<String, dynamic>?) ??
        const <String, dynamic>{};
    return CurriculumContentManifest(
      schema: (json['schema'] as String?) ?? 'unknown',
      version: (json['version'] as String?) ?? 'unknown',
      algorithm: (json['algorithm'] as String?) ?? 'unknown',
      files: <String, CurriculumContentFile>{
        for (final entry in rawFiles.entries)
          entry.key: CurriculumContentFile(
            path: entry.key,
            sha256: ((entry.value as Map<String, dynamic>)['sha256'] as String?) ??
                'unverified',
            bundleVersion:
                ((entry.value as Map<String, dynamic>)['bundleVersion']
                        as String?) ??
                    'unknown',
          ),
      },
    );
  }

  factory CurriculumContentManifest.fromJsonString(String source) =>
      CurriculumContentManifest.fromJson(
        jsonDecode(source) as Map<String, dynamic>,
      );

  CurriculumContentFile? fileFor(String path) => files[path];
}

class LessonBlueprintAssetRepository {
  const LessonBlueprintAssetRepository({
    this.bundle,
    this.manifestPath =
        'assets/curriculum/content_manifest_v18.json',
  });

  final AssetBundle? bundle;
  final String manifestPath;

  /// 번들 에셋(blueprint·manifest)은 불변이므로 path당 1회만 읽어 파싱한다.
  /// 매 레슨 완료마다 JSON을 다시 읽지 않고, 명시적 `bundle` 주입 시에는
  /// 캐시를 우회한다(테스트가 자체 bundle을 통제할 수 있게).
  static final Map<String, String> _sourceCache = <String, String>{};

  Future<String> _loadSource(AssetBundle loader, String path) async {
    if (bundle != null) return loader.loadString(path);
    final cached = _sourceCache[path];
    if (cached != null) return cached;
    final source = await loader.loadString(path);
    _sourceCache[path] = source;
    return source;
  }

  String? assetPathFor({required String track, required int cycle}) {
    if (track == 'beginnerFoundation' && cycle == 1) {
      return 'assets/curriculum/beginner_timbre_slice_v16.json';
    }
    if (track == 'universalCore' && cycle == 1) {
      return 'assets/curriculum/universal_core_cycle_01.json';
    }
    if (track == 'repertoireApplication' && cycle == 1) {
      return 'assets/curriculum/repertoire_project_01.json';
    }
    return null;
  }

  Future<CurriculumContentManifest?> _loadManifest() async {
    try {
      final source = await _loadSource(bundle ?? rootBundle, manifestPath);
      return CurriculumContentManifest.fromJsonString(source);
    } catch (_) {
      return null;
    }
  }

  Future<LessonBlueprintEntry?> loadLessonEntry({
    required String track,
    required int cycle,
    required int day,
  }) async {
    final path = assetPathFor(track: track, cycle: cycle);
    if (path == null) return null;
    final loader = bundle ?? rootBundle;
    final source = await _loadSource(loader, path);
    final manifest = await _loadManifest();
    final parsed = LessonBlueprintBundle.fromJsonString(source);
    final lesson = parsed.lessonForDay(day);
    if (lesson == null) return null;
    final sourceFile = manifest?.fileFor(path);
    final sha256 = sourceFile?.sha256 ?? 'unverified';
    final shortHash = sha256.length >= 12 ? sha256.substring(0, 12) : sha256;
    return LessonBlueprintEntry(
      blueprint: lesson,
      bundleVersion: parsed.version,
      sourceSha256: sha256,
      contentRevision:
          '${parsed.track}:${parsed.cycle}:${parsed.version}:day_${lesson.day}:${lesson.cardId}:sha256_$shortHash',
    );
  }

  Future<LessonBlueprint?> loadLesson({
    required String track,
    required int cycle,
    required int day,
  }) async =>
      (await loadLessonEntry(track: track, cycle: cycle, day: day))?.blueprint;
}
