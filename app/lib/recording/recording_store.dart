/// v6 — local-first 녹음 메타데이터 저장소.
///
/// 오디오 원본은 앱 지원 디렉터리에 저장하고, 이 파일은 take 메타데이터를
/// JSON index로 유지한다. 서버 업로드나 모델 학습 동의는 포함하지 않는다.
library;

import 'dart:convert';
import 'dart:io';

import 'audio_io.dart';
import 'recording_ab.dart';

class FileRecordingRepository implements RecordingRepository {
  FileRecordingRepository(this.metadataFile);

  final File metadataFile;

  static Future<FileRecordingRepository> create({
    RecordingFilePathResolver? resolver,
  }) async {
    final r = resolver ?? await RecordingFilePathResolver.create();
    return FileRecordingRepository(await r.metadataFile());
  }

  Future<List<RecordingTake>> _readAll() async {
    if (!await metadataFile.exists()) return const [];
    final raw = await metadataFile.readAsString();
    if (raw.trim().isEmpty) return const [];
    final decoded = jsonDecode(raw);
    if (decoded is! List) return const [];
    return [
      for (final item in decoded)
        if (item is Map<String, dynamic>)
          RecordingTake.fromJson(item)
        else if (item is Map)
          RecordingTake.fromJson(Map<String, dynamic>.from(item))
    ];
  }

  Future<void> _writeAll(List<RecordingTake> takes) async {
    await metadataFile.parent.create(recursive: true);
    final encoded = const JsonEncoder.withIndent('  ')
        .convert(takes.map((take) => take.toJson()).toList());
    await metadataFile.writeAsString(encoded);
  }

  @override
  Future<void> saveTake(RecordingTake take) async {
    final list = await _readAll();
    final next = [
      for (final old in list)
        if (old.id != take.id) old,
      take,
    ]..sort((a, b) => a.createdEpochMs.compareTo(b.createdEpochMs));
    await _writeAll(next);
  }

  @override
  Future<List<RecordingTake>> listTakes({
    String? cardId,
    RecordingPurpose? purpose,
  }) async {
    final list = await _readAll();
    final filtered = list.where((take) {
      final cardOk = cardId == null || take.cardId == cardId;
      final purposeOk = purpose == null || take.purpose == purpose;
      return cardOk && purposeOk;
    }).toList()
      ..sort((a, b) => a.createdEpochMs.compareTo(b.createdEpochMs));
    return filtered;
  }

  @override
  Future<void> deleteTake(String id) async {
    final list = await _readAll();
    String? path;
    final next = <RecordingTake>[];
    for (final take in list) {
      if (take.id == id) {
        path = take.localPath;
      } else {
        next.add(take);
      }
    }
    await _writeAll(next);
    if (path != null && path.isNotEmpty && !path.startsWith('local://')) {
      final f = File(path);
      if (await f.exists()) await f.delete();
    }
  }

  @override
  Future<void> clearAll() async {
    final list = await _readAll();
    for (final take in list) {
      final path = take.localPath;
      if (path.isNotEmpty && !path.startsWith('local://')) {
        final f = File(path);
        if (await f.exists()) await f.delete();
      }
    }
    await _writeAll(const []);
  }
}
