/// v18 — 녹음 A/B 컨트롤러와 생성 당시 로컬 날짜 메타데이터.
///
/// UI는 이 컨트롤러만 호출한다. 실제 마이크 캡처/재생, 파일 삭제, 메타데이터 저장을
/// 분리하여 테스트 가능성과 privacy boundary를 유지한다.
library;

import 'audio_io.dart';
import 'recording_ab.dart';
import 'recording_store.dart';

class RecordingPermissionException implements Exception {
  const RecordingPermissionException(this.message);
  final String message;
  @override
  String toString() => 'RecordingPermissionException($message)';
}

class RecordingController {
  RecordingController({
    required this.capture,
    required this.playback,
    required this.repository,
    this.pathResolver,
  });

  factory RecordingController.local() => RecordingController(
        capture: RecordAudioCaptureAdapter(),
        playback: AudioplayersPlaybackAdapter(),
        repository: LazyFileRecordingRepository(),
      );

  factory RecordingController.fake({RecordingFilePathResolver? pathResolver}) =>
      RecordingController(
        capture: FakeAudioCaptureAdapter(),
        playback: FakeAudioPlaybackAdapter(),
        repository: InMemoryRecordingRepository(),
        pathResolver: pathResolver,
      );

  final AudioCaptureAdapter capture;
  final AudioPlaybackAdapter playback;
  final RecordingRepository repository;
  final RecordingFilePathResolver? pathResolver;

  RecordingFilePathResolver? _lazyResolver;
  _PendingTake? _pending;

  bool get isRecording => _pending != null;

  Future<RecordingFilePathResolver> _resolver() async {
    final injected = pathResolver;
    if (injected != null) return injected;
    final cached = _lazyResolver;
    if (cached != null) return cached;
    final created = await RecordingFilePathResolver.create();
    _lazyResolver = created;
    return created;
  }

  Future<List<RecordingTake>> listTakes({String? cardId, RecordingPurpose? purpose}) =>
      repository.listTakes(cardId: cardId, purpose: purpose);

  Future<void> startTake({
    required String cardId,
    required RecordingPurpose purpose,
    required RecordingSlot slot,
    required int sequence,
  }) async {
    if (_pending != null) return;
    final id = nextTakeId(cardId, sequence);
    final resolver = await _resolver();
    final path = await resolver.nextPath(
      cardId: cardId,
      purpose: purpose,
      slot: slot,
      takeId: id,
    );
    final ok = await capture.start(path);
    if (!ok) throw const RecordingPermissionException('마이크 권한이 필요합니다.');
    _pending = _PendingTake(id: id, cardId: cardId, purpose: purpose, slot: slot);
  }

  Future<RecordingTake?> stopAndSave({
    required List<ToneTag> toneTags,
    required int comfortRating,
    required bool sameConditionConfirmed,
    String memo = '',
  }) async {
    final pending = _pending;
    if (pending == null) return null;
    final result = await capture.stop();
    _pending = null;
    if (result == null) return null;
    final take = RecordingTake(
      id: pending.id,
      cardId: pending.cardId,
      purpose: pending.purpose,
      slot: pending.slot,
      localPath: result.path,
      createdEpochMs: result.stoppedEpochMs,
      createdLocalDateKey: localDateKeyForEpochMs(result.stoppedEpochMs),
      durationMs: result.durationMs,
      fileSizeBytes: result.fileSizeBytes,
      codec: 'm4a/aac',
      toneTags: toneTags,
      comfortRating: comfortRating,
      sameConditionConfirmed: sameConditionConfirmed,
      memo: memo,
    );
    await repository.saveTake(take);
    return take;
  }

  Future<void> saveMetadata(RecordingTake take) => repository.saveTake(take);
  Future<void> play(RecordingTake take) => playback.play(take.localPath);
  Future<void> stopPlayback() => playback.stop();

  Future<void> deleteTake(RecordingTake take) => repository.deleteTake(take.id);

  Future<void> dispose() async {
    await capture.cancel();
    await capture.dispose();
    await playback.dispose();
  }
}

class LazyFileRecordingRepository implements RecordingRepository {
  FileRecordingRepository? _inner;

  Future<FileRecordingRepository> _repo() async =>
      _inner ??= await FileRecordingRepository.create();

  @override
  Future<void> saveTake(RecordingTake take) async => (await _repo()).saveTake(take);

  @override
  Future<List<RecordingTake>> listTakes({String? cardId, RecordingPurpose? purpose}) async =>
      (await _repo()).listTakes(cardId: cardId, purpose: purpose);

  @override
  Future<void> deleteTake(String id) async => (await _repo()).deleteTake(id);

  @override
  Future<void> clearAll() async => (await _repo()).clearAll();
}

class _PendingTake {
  const _PendingTake({required this.id, required this.cardId, required this.purpose, required this.slot});
  final String id;
  final String cardId;
  final RecordingPurpose purpose;
  final RecordingSlot slot;
}
