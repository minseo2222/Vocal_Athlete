/// v7 — 녹음 라이브러리 요약·내보내기·전체 삭제 도메인.
///
/// 실제 파일 공유/클라우드 업로드는 하지 않는다. 이 계층은 local-first
/// 저장소에 남은 take 목록을 요약하고, 사용자가 확인할 수 있는 JSON
/// manifest를 만드는 privacy boundary이다.
library;

import 'dart:convert';

import 'recording_ab.dart';

extension RecordingPurposeLabel on RecordingPurpose {
  String get label => switch (this) {
        RecordingPurpose.standardSample => '표준샘플',
        RecordingPurpose.toneAB => '음색 A/B',
        RecordingPurpose.repertoirePhrase => '곡 적용 훈련',
        RecordingPurpose.portfolio => '포트폴리오',
      };
}

String formatRecordingBytes(int bytes) {
  if (bytes <= 0) return '0 B';
  const kb = 1024;
  const mb = kb * 1024;
  if (bytes < kb) return '$bytes B';
  if (bytes < mb) return '${(bytes / kb).toStringAsFixed(1)} KB';
  return '${(bytes / mb).toStringAsFixed(1)} MB';
}

class RecordingLibrarySummary {
  const RecordingLibrarySummary({
    required this.totalTakes,
    required this.totalBytes,
    required this.countByPurpose,
    required this.bytesByPurpose,
    required this.oldestEpochMs,
    required this.newestEpochMs,
  });

  final int totalTakes;
  final int totalBytes;
  final Map<RecordingPurpose, int> countByPurpose;
  final Map<RecordingPurpose, int> bytesByPurpose;
  final int oldestEpochMs;
  final int newestEpochMs;

  bool get isEmpty => totalTakes == 0;

  int countFor(RecordingPurpose purpose) => countByPurpose[purpose] ?? 0;
  int bytesFor(RecordingPurpose purpose) => bytesByPurpose[purpose] ?? 0;

  static RecordingLibrarySummary fromTakes(List<RecordingTake> takes) {
    final countByPurpose = <RecordingPurpose, int>{};
    final bytesByPurpose = <RecordingPurpose, int>{};
    var totalBytes = 0;
    var oldest = 0;
    var newest = 0;

    for (final take in takes) {
      countByPurpose[take.purpose] = (countByPurpose[take.purpose] ?? 0) + 1;
      bytesByPurpose[take.purpose] =
          (bytesByPurpose[take.purpose] ?? 0) + take.fileSizeBytes;
      totalBytes += take.fileSizeBytes;
      if (oldest == 0 || take.createdEpochMs < oldest) oldest = take.createdEpochMs;
      if (newest == 0 || take.createdEpochMs > newest) newest = take.createdEpochMs;
    }

    return RecordingLibrarySummary(
      totalTakes: takes.length,
      totalBytes: totalBytes,
      countByPurpose: Map.unmodifiable(countByPurpose),
      bytesByPurpose: Map.unmodifiable(bytesByPurpose),
      oldestEpochMs: oldest,
      newestEpochMs: newest,
    );
  }

  Map<String, dynamic> toJson() => {
        'totalTakes': totalTakes,
        'totalBytes': totalBytes,
        'countByPurpose': {
          for (final e in countByPurpose.entries) e.key.name: e.value,
        },
        'bytesByPurpose': {
          for (final e in bytesByPurpose.entries) e.key.name: e.value,
        },
        'oldestEpochMs': oldestEpochMs,
        'newestEpochMs': newestEpochMs,
      };
}

class RecordingExportManifest {
  const RecordingExportManifest({
    required this.exportedEpochMs,
    required this.summary,
    required this.takes,
    required this.includeLocalPaths,
    this.schema = 'vocal-athlete/recording-export@1',
  });

  final String schema;
  final int exportedEpochMs;
  final RecordingLibrarySummary summary;
  final List<RecordingTake> takes;
  final bool includeLocalPaths;

  Map<String, dynamic> toJson() => {
        'schema': schema,
        'exportedEpochMs': exportedEpochMs,
        'containsAudioBytes': false,
        'includeLocalPaths': includeLocalPaths,
        'privacyNote': includeLocalPaths
            ? 'localPath included by explicit export request; files are still stored locally.'
            : 'localPath redacted; this manifest is metadata-only.',
        'summary': summary.toJson(),
        'takes': [for (final take in takes) _takeJson(take)],
      };

  Map<String, dynamic> _takeJson(RecordingTake take) {
    final j = take.toJson();
    if (!includeLocalPaths) j['localPath'] = '[local-only:redacted]';
    return j;
  }

  String toPrettyJson() => const JsonEncoder.withIndent('  ').convert(toJson());
}

class RecordingLibraryService {
  const RecordingLibraryService(this.repository);

  final RecordingRepository repository;

  Future<List<RecordingTake>> listAllSorted() async =>
      (await repository.listTakes())..sort((a, b) => a.createdEpochMs.compareTo(b.createdEpochMs));

  Future<RecordingLibrarySummary> summarize() async =>
      RecordingLibrarySummary.fromTakes(await listAllSorted());

  Future<RecordingExportManifest> buildExportManifest({
    bool includeLocalPaths = false,
    int? exportedEpochMs,
  }) async {
    final takes = await listAllSorted();
    return RecordingExportManifest(
      exportedEpochMs: exportedEpochMs ?? DateTime.now().millisecondsSinceEpoch,
      summary: RecordingLibrarySummary.fromTakes(takes),
      takes: takes,
      includeLocalPaths: includeLocalPaths,
    );
  }

  Future<String> exportManifestJson({bool includeLocalPaths = false}) async =>
      (await buildExportManifest(includeLocalPaths: includeLocalPaths)).toPrettyJson();

  Future<void> clearAll() => repository.clearAll();
}
