import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/curriculum/lesson_blueprint.dart';
import 'package:vocal_athlete/progression/path.dart';

void main() {

  test('v16 Beginner timbre slice matches Days 37 and 38', () {
    final source = File('assets/curriculum/beginner_timbre_slice_v16.json')
        .readAsStringSync();
    final bundle = LessonBlueprintBundle.fromJsonString(source);
    final path = buildPlaceholderManifest();

    expect(bundle.version, 'v16');
    expect(bundle.track, 'beginnerFoundation');
    expect(bundle.lessons.map((e) => e.day).toList(), [37, 38]);
    expect(bundle.lessons.map((e) => e.cardId).toList(),
        [path[36].cardId, path[37].cardId]);
    expect(bundle.lessons.every((e) => e.audioCues.length == 2), isTrue);
    expect(bundle.lessons.every((e) => e.recoveryAlternative.isNotEmpty),
        isTrue);
  });

  test('v16 Universal Core cycle 1 blueprint matches the first 12 path slots',
      () {
    final source = File('assets/curriculum/universal_core_cycle_01.json')
        .readAsStringSync();
    final bundle = LessonBlueprintBundle.fromJsonString(source);
    final path = buildUniversalCoreManifest().take(12).toList();

    expect(bundle.version, 'v16');
    expect(bundle.track, 'universalCore');
    expect(bundle.lessons.length, 12);
    expect(bundle.lessons.map((e) => e.cardId).toList(),
        path.map((e) => e.cardId).toList());
    expect(bundle.lessons.every((e) => e.steps.length >= 3), isTrue);
    expect(bundle.lessons.every((e) => e.attempts >= 1 && e.attempts <= 4),
        isTrue);
  });

  test('v16 Repertoire project 1 blueprint matches the first 12 path slots',
      () {
    final source = File('assets/curriculum/repertoire_project_01.json')
        .readAsStringSync();
    final bundle = LessonBlueprintBundle.fromJsonString(source);
    final path = buildRepertoireApplicationManifest().take(12).toList();

    expect(bundle.track, 'repertoireApplication');
    expect(bundle.lessons.length, 12);
    expect(bundle.lessons.map((e) => e.cardId).toList(),
        path.map((e) => e.cardId).toList());
    expect(bundle.lessons.every((e) => e.assetId == 'neutral_001'), isTrue);
    expect(bundle.lessons.first.guideState, 'full');
    expect(bundle.lessons.last.guideState, 'transfer');
  });

  test('v17 content manifest pins beginner/core/repertoire SHA-256 files', () {
    final source = File('assets/curriculum/content_manifest_v18.json')
        .readAsStringSync();
    final manifest = CurriculumContentManifest.fromJsonString(source);
    final beginner = manifest.fileFor(
      'assets/curriculum/beginner_timbre_slice_v16.json',
    );
    final core = manifest.fileFor(
      'assets/curriculum/universal_core_cycle_01.json',
    );
    final repertoire = manifest.fileFor(
      'assets/curriculum/repertoire_project_01.json',
    );

    expect(manifest.version, 'v18');
    expect(manifest.algorithm, 'sha256');
    expect(beginner?.sha256, hasLength(64));
    expect(core?.sha256, hasLength(64));
    expect(repertoire?.sha256, hasLength(64));
    expect(beginner?.bundleVersion, 'v16');
    expect(core?.bundleVersion, 'v16');
    expect(repertoire?.bundleVersion, 'v10');
  });

}
