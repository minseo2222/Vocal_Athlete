/// v13 — 지연 복습 수행 흔적.
///
/// 복습 완료 버튼만 누른 것을 학습 달성으로 간주하지 않는다. 사용자가 어떤
/// 목 상태에서 몇 번 시도했고, 어떤 자기점검을 남겼으며, 원 콘텐츠와 현재
/// 콘텐츠 revision이 같은지 local-first 메타데이터로 기록한다.
library;

import 'dart:convert';

import '../storage/app_metadata_store.dart';

import 'learning_evidence.dart';
import 'review_queue.dart';

class ReviewPracticeSnapshot {
  const ReviewPracticeSnapshot({
    this.attemptsUsed = 0,
    this.selfCheckIndexes = const <int>[],
    this.selectedKey,
    this.recordedTakeIds = const <String>[],
    this.playedSourceTakeIds = const <String>[],
    this.bestTakeId,
  });

  final int attemptsUsed;
  final List<int> selfCheckIndexes;
  final String? selectedKey;
  final List<String> recordedTakeIds;
  final List<String> playedSourceTakeIds;
  final String? bestTakeId;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'attemptsUsed': attemptsUsed,
        'selfCheckIndexes': selfCheckIndexes,
        'selectedKey': selectedKey,
        'recordedTakeIds': recordedTakeIds,
        'playedSourceTakeIds': playedSourceTakeIds,
        'bestTakeId': bestTakeId,
      };

  factory ReviewPracticeSnapshot.fromJson(Map<String, dynamic> json) =>
      ReviewPracticeSnapshot(
        attemptsUsed: (json['attemptsUsed'] as int?) ?? 0,
        selfCheckIndexes: List<int>.from(
          (json['selfCheckIndexes'] as List<dynamic>?) ?? const <int>[],
        ),
        selectedKey: json['selectedKey'] as String?,
        recordedTakeIds: List<String>.from(
          (json['recordedTakeIds'] as List<dynamic>?) ?? const <String>[],
        ),
        playedSourceTakeIds: List<String>.from(
          (json['playedSourceTakeIds'] as List<dynamic>?) ?? const <String>[],
        ),
        bestTakeId: json['bestTakeId'] as String?,
      );
}

class ReviewEvidenceRecord {
  const ReviewEvidenceRecord({
    required this.id,
    required this.reviewTaskId,
    required this.sourceEvidenceId,
    required this.track,
    required this.cycle,
    required this.day,
    required this.cardId,
    required this.kind,
    required this.targetEvidence,
    required this.completedEpochMs,
    required this.voiceState,
    required this.adaptationMode,
    required this.sourceContentRevision,
    required this.currentContentRevision,
    required this.snapshot,
  });

  final String id;
  final String reviewTaskId;
  final String sourceEvidenceId;
  final String track;
  final int cycle;
  final int day;
  final String cardId;
  final ReviewTaskKind kind;

  /// 복습이 목표로 삼는 증거 수준. 자동 성취 판정이나 품질 점수가 아니다.
  final LearningEvidenceLevel targetEvidence;
  final int completedEpochMs;
  final String voiceState;
  final String adaptationMode;
  final String sourceContentRevision;
  final String currentContentRevision;
  final ReviewPracticeSnapshot snapshot;

  bool get revisionMatched =>
      sourceContentRevision != 'unknown' &&
      currentContentRevision != 'unknown' &&
      sourceContentRevision == currentContentRevision;

  bool get isRecovery => adaptationMode == 'recovery';

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'reviewTaskId': reviewTaskId,
        'sourceEvidenceId': sourceEvidenceId,
        'track': track,
        'cycle': cycle,
        'day': day,
        'cardId': cardId,
        'kind': kind.name,
        'targetEvidence': targetEvidence.name,
        'completedEpochMs': completedEpochMs,
        'voiceState': voiceState,
        'adaptationMode': adaptationMode,
        'sourceContentRevision': sourceContentRevision,
        'currentContentRevision': currentContentRevision,
        'snapshot': snapshot.toJson(),
      };

  factory ReviewEvidenceRecord.fromJson(Map<String, dynamic> json) =>
      ReviewEvidenceRecord(
        id: json['id'] as String,
        reviewTaskId: json['reviewTaskId'] as String,
        sourceEvidenceId: json['sourceEvidenceId'] as String,
        track: json['track'] as String,
        cycle: (json['cycle'] as int?) ?? 0,
        day: (json['day'] as int?) ?? 0,
        cardId: json['cardId'] as String,
        kind: reviewTaskKindFromLabel((json['kind'] as String?) ?? 'retention'),
        targetEvidence: evidenceLevelFromLabel(
          (json['targetEvidence'] as String?) ?? 'e2',
        ),
        completedEpochMs: (json['completedEpochMs'] as int?) ?? 0,
        voiceState: (json['voiceState'] as String?) ?? 'unreported',
        adaptationMode: (json['adaptationMode'] as String?) ?? 'normal',
        sourceContentRevision:
            (json['sourceContentRevision'] as String?) ?? 'unknown',
        currentContentRevision:
            (json['currentContentRevision'] as String?) ?? 'unknown',
        snapshot: ReviewPracticeSnapshot.fromJson(
          (json['snapshot'] as Map<String, dynamic>?) ??
              const <String, dynamic>{},
        ),
      );
}

String nextReviewEvidenceId({
  required String reviewTaskId,
  required int completedEpochMs,
}) =>
    '${reviewTaskId}_review_$completedEpochMs';

abstract class ReviewEvidenceRepository {
  Future<void> saveRecord(ReviewEvidenceRecord record);
  Future<List<ReviewEvidenceRecord>> listRecords({String? track});
  Future<ReviewEvidenceRecord?> findByReviewTaskId(String reviewTaskId);
  Future<void> clearAll();
}

class InMemoryReviewEvidenceRepository implements ReviewEvidenceRepository {
  final Map<String, ReviewEvidenceRecord> _records =
      <String, ReviewEvidenceRecord>{};

  @override
  Future<void> saveRecord(ReviewEvidenceRecord record) async {
    _records[record.id] = record;
  }

  @override
  Future<List<ReviewEvidenceRecord>> listRecords({String? track}) async {
    final records = _records.values
        .where((record) => track == null || record.track == track)
        .toList(growable: false)
      ..sort((a, b) => b.completedEpochMs.compareTo(a.completedEpochMs));
    return records;
  }

  @override
  Future<ReviewEvidenceRecord?> findByReviewTaskId(String reviewTaskId) async {
    final matches = _records.values
        .where((record) => record.reviewTaskId == reviewTaskId)
        .toList(growable: false)
      ..sort((a, b) => b.completedEpochMs.compareTo(a.completedEpochMs));
    return matches.isEmpty ? null : matches.first;
  }

  @override
  Future<void> clearAll() async => _records.clear();
}

class SharedPreferencesReviewEvidenceRepository
    implements ReviewEvidenceRepository {
  SharedPreferencesReviewEvidenceRepository({AppMetadataStore? metadataStore})
      : _metadataStore = metadataStore ?? AppMetadataStore.shared;

  static const String storageKey = 'review_evidence_v1';
  final AppMetadataStore _metadataStore;

  Future<List<ReviewEvidenceRecord>> _read() async {
    final raw = await _metadataStore.readString(storageKey);
    if (raw == null || raw.isEmpty) return <ReviewEvidenceRecord>[];
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) {
        throw const FormatException('review evidence is not a list');
      }
      return decoded
          .map((item) => ReviewEvidenceRecord.fromJson(
                Map<String, dynamic>.from(item as Map),
              ))
          .toList(growable: true);
    } catch (_) {
      await _metadataStore.quarantineCorruptValue(storageKey, raw);
      return <ReviewEvidenceRecord>[];
    }
  }

  Future<void> _write(List<ReviewEvidenceRecord> records) =>
      _metadataStore.writeString(
        storageKey,
        jsonEncode(records.map((record) => record.toJson()).toList()),
      );

  @override
  Future<void> saveRecord(ReviewEvidenceRecord record) async {
    final records = await _read();
    final index = records.indexWhere((item) => item.id == record.id);
    if (index < 0) {
      records.add(record);
    } else {
      records[index] = record;
    }
    records.sort((a, b) => a.completedEpochMs.compareTo(b.completedEpochMs));
    await _write(records);
  }

  @override
  Future<List<ReviewEvidenceRecord>> listRecords({String? track}) async {
    final records = await _read();
    final filtered = records
        .where((record) => track == null || record.track == track)
        .toList(growable: false)
      ..sort((a, b) => b.completedEpochMs.compareTo(a.completedEpochMs));
    return filtered;
  }

  @override
  Future<ReviewEvidenceRecord?> findByReviewTaskId(String reviewTaskId) async {
    final records = await _read();
    for (final record in records.reversed) {
      if (record.reviewTaskId == reviewTaskId) return record;
    }
    return null;
  }

  @override
  Future<void> clearAll() => _metadataStore.remove(storageKey);
}
