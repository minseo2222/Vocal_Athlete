/// v11 — 레슨 수행 메타데이터와 지연 재현/전이 체크포인트 기록.
///
/// 이 모델은 가창 품질을 자동 채점하지 않는다. 사용자가 실제로 수행한 시도 수,
/// 자기점검, 선택한 키, 회복 모드, 녹음 산출물 유무를 local-first로 남겨
/// completion과 learning evidence를 구분하기 위한 메타데이터 계층이다.
library;

import 'dart:convert';

import '../storage/app_metadata_store.dart';

enum LearningEvidenceLevel { e0, e1, e2, e3, e4, e5 }

LearningEvidenceLevel evidenceLevelFromLabel(String value) {
  final normalized = value.trim().toLowerCase();
  return LearningEvidenceLevel.values.firstWhere(
    (level) => level.name == normalized,
    orElse: () => LearningEvidenceLevel.e0,
  );
}

class LessonPracticeSnapshot {
  const LessonPracticeSnapshot({
    this.attemptsUsed = 0,
    this.selfCheckIndexes = const <int>[],
    this.playedAudioPaths = const <String>[],
    this.selectedKey,
    this.recordedTakeCount = 0,
    this.bestTakeSelected = false,
    this.recordedTakeIds = const <String>[],
    this.bestTakeId,
  });

  final int attemptsUsed;
  final List<int> selfCheckIndexes;
  final List<String> playedAudioPaths;
  final String? selectedKey;
  final int recordedTakeCount;
  final bool bestTakeSelected;
  final List<String> recordedTakeIds;
  final String? bestTakeId;

  LessonPracticeSnapshot copyWith({
    int? attemptsUsed,
    List<int>? selfCheckIndexes,
    List<String>? playedAudioPaths,
    String? selectedKey,
    bool clearSelectedKey = false,
    int? recordedTakeCount,
    bool? bestTakeSelected,
    List<String>? recordedTakeIds,
    String? bestTakeId,
    bool clearBestTakeId = false,
  }) =>
      LessonPracticeSnapshot(
        attemptsUsed: attemptsUsed ?? this.attemptsUsed,
        selfCheckIndexes: selfCheckIndexes ?? this.selfCheckIndexes,
        playedAudioPaths: playedAudioPaths ?? this.playedAudioPaths,
        selectedKey:
            clearSelectedKey ? null : (selectedKey ?? this.selectedKey),
        recordedTakeCount: recordedTakeCount ?? this.recordedTakeCount,
        bestTakeSelected: bestTakeSelected ?? this.bestTakeSelected,
        recordedTakeIds: recordedTakeIds ?? this.recordedTakeIds,
        bestTakeId: clearBestTakeId ? null : (bestTakeId ?? this.bestTakeId),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'attemptsUsed': attemptsUsed,
        'selfCheckIndexes': selfCheckIndexes,
        'playedAudioPaths': playedAudioPaths,
        'selectedKey': selectedKey,
        'recordedTakeCount': recordedTakeCount,
        'bestTakeSelected': bestTakeSelected,
        'recordedTakeIds': recordedTakeIds,
        'bestTakeId': bestTakeId,
      };

  factory LessonPracticeSnapshot.fromJson(Map<String, dynamic> json) =>
      LessonPracticeSnapshot(
        attemptsUsed: (json['attemptsUsed'] as int?) ?? 0,
        selfCheckIndexes: List<int>.from(
            (json['selfCheckIndexes'] as List<dynamic>?) ?? const <int>[]),
        playedAudioPaths: List<String>.from(
            (json['playedAudioPaths'] as List<dynamic>?) ?? const <String>[]),
        selectedKey: json['selectedKey'] as String?,
        recordedTakeCount: (json['recordedTakeCount'] as int?) ?? 0,
        bestTakeSelected: (json['bestTakeSelected'] as bool?) ?? false,
        recordedTakeIds: List<String>.from(
            (json['recordedTakeIds'] as List<dynamic>?) ?? const <String>[]),
        bestTakeId: json['bestTakeId'] as String?,
      );
}

class LearningEvidenceRecord {
  const LearningEvidenceRecord({
    required this.id,
    required this.track,
    required this.cycle,
    required this.day,
    required this.cardId,
    required this.targetEvidence,
    required this.completedEpochMs,
    required this.voiceState,
    required this.adaptationMode,
    required this.snapshot,
    this.contentRevision = 'unknown',
  });

  final String id;
  final String track;
  final int cycle;
  final int day;
  final String cardId;

  /// 커리큘럼이 목표로 삼는 증거 수준. 자동 달성 판정이 아니다.
  final LearningEvidenceLevel targetEvidence;
  final int completedEpochMs;
  final String voiceState;
  final String adaptationMode;
  final LessonPracticeSnapshot snapshot;

  /// Asset blueprint version/revision used when this evidence was recorded.
  /// This is not a quality score; it prevents comparing old and revised content
  /// as if they were identical.
  final String contentRevision;

  bool get isRecovery => adaptationMode == 'recovery';
  bool get hasPracticeTrace =>
      isRecovery ||
      snapshot.attemptsUsed > 0 ||
      snapshot.selfCheckIndexes.isNotEmpty ||
      snapshot.playedAudioPaths.isNotEmpty ||
      snapshot.recordedTakeCount > 0 ||
      snapshot.recordedTakeIds.isNotEmpty ||
      snapshot.bestTakeId != null;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'track': track,
        'cycle': cycle,
        'day': day,
        'cardId': cardId,
        'targetEvidence': targetEvidence.name,
        'completedEpochMs': completedEpochMs,
        'voiceState': voiceState,
        'adaptationMode': adaptationMode,
        'snapshot': snapshot.toJson(),
        'contentRevision': contentRevision,
      };

  factory LearningEvidenceRecord.fromJson(Map<String, dynamic> json) =>
      LearningEvidenceRecord(
        id: json['id'] as String,
        track: json['track'] as String,
        cycle: (json['cycle'] as int?) ?? 0,
        day: (json['day'] as int?) ?? 0,
        cardId: json['cardId'] as String,
        targetEvidence:
            evidenceLevelFromLabel((json['targetEvidence'] as String?) ?? 'e0'),
        completedEpochMs: (json['completedEpochMs'] as int?) ?? 0,
        voiceState: (json['voiceState'] as String?) ?? 'unreported',
        adaptationMode: (json['adaptationMode'] as String?) ?? 'normal',
        snapshot: LessonPracticeSnapshot.fromJson(
            (json['snapshot'] as Map<String, dynamic>?) ??
                const <String, dynamic>{}),
        contentRevision: (json['contentRevision'] as String?) ?? 'unknown',
      );
}

String nextLearningEvidenceId({
  required String track,
  required int cycle,
  required int day,
  required String cardId,
  required int completedEpochMs,
}) =>
    '${track}_${cycle}_${day}_${cardId}_$completedEpochMs';

abstract class LearningEvidenceRepository {
  Future<void> saveRecord(LearningEvidenceRecord record);
  Future<List<LearningEvidenceRecord>> listRecords({String? track});
  Future<LearningEvidenceRecord?> findById(String id);
  Future<void> clearAll();
}

class InMemoryLearningEvidenceRepository
    implements LearningEvidenceRepository {
  final Map<String, LearningEvidenceRecord> _records =
      <String, LearningEvidenceRecord>{};

  @override
  Future<void> saveRecord(LearningEvidenceRecord record) async {
    _records[record.id] = record;
  }

  @override
  Future<List<LearningEvidenceRecord>> listRecords({String? track}) async {
    final result = _records.values
        .where((record) => track == null || record.track == track)
        .toList(growable: false)
      ..sort((a, b) => b.completedEpochMs.compareTo(a.completedEpochMs));
    return result;
  }

  @override
  Future<LearningEvidenceRecord?> findById(String id) async => _records[id];

  @override
  Future<void> clearAll() async => _records.clear();
}

class SharedPreferencesLearningEvidenceRepository
    implements LearningEvidenceRepository {
  SharedPreferencesLearningEvidenceRepository({AppMetadataStore? metadataStore})
      : _metadataStore = metadataStore ?? AppMetadataStore.shared;

  static const String storageKey = 'learning_evidence_v1';
  final AppMetadataStore _metadataStore;

  Future<List<LearningEvidenceRecord>> _read() async {
    final raw = await _metadataStore.readString(storageKey);
    if (raw == null || raw.isEmpty) return <LearningEvidenceRecord>[];
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) {
        throw const FormatException('learning evidence is not a list');
      }
      return decoded
          .map((item) => LearningEvidenceRecord.fromJson(
                Map<String, dynamic>.from(item as Map),
              ))
          .toList(growable: true);
    } catch (_) {
      await _metadataStore.quarantineCorruptValue(storageKey, raw);
      return <LearningEvidenceRecord>[];
    }
  }

  Future<void> _write(List<LearningEvidenceRecord> records) =>
      _metadataStore.writeString(
        storageKey,
        jsonEncode(records.map((record) => record.toJson()).toList()),
      );

  @override
  Future<void> saveRecord(LearningEvidenceRecord record) async {
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
  Future<List<LearningEvidenceRecord>> listRecords({String? track}) async {
    final records = await _read();
    final filtered = records
        .where((record) => track == null || record.track == track)
        .toList(growable: false)
      ..sort((a, b) => b.completedEpochMs.compareTo(a.completedEpochMs));
    return filtered;
  }

  @override
  Future<LearningEvidenceRecord?> findById(String id) async {
    final records = await _read();
    for (final record in records) {
      if (record.id == id) return record;
    }
    return null;
  }

  @override
  Future<void> clearAll() => _metadataStore.remove(storageKey);
}
