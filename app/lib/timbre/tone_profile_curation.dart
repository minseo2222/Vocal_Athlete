/// v17 — 사용자가 tone tag를 정정·철회할 수 있는 음색 팔레트 큐레이션 도메인.
///
/// 이 계층은 녹음 원본을 삭제하지 않고, 사용자가 직접 고른 자기 태그를 수정하거나
/// 특정 take를 팔레트 집계에서 제외할 수 있게 한다. 자동 음색 분석, 성대 상태 진단,
/// 유명 가수 매칭에는 사용하지 않는다.
library;

import '../recording/recording_ab.dart';

class ToneProfileCurationService {
  const ToneProfileCurationService(this.repository);

  final RecordingRepository repository;

  Future<List<RecordingTake>> listToneTaggedTakes() async {
    final takes = await repository.listTakes();
    return [
      for (final take in takes)
        if (take.toneTags.isNotEmpty || take.purpose == RecordingPurpose.toneAB)
          take,
    ]..sort((a, b) => b.createdEpochMs.compareTo(a.createdEpochMs));
  }

  Future<RecordingTake?> _findTake(String id) async {
    for (final take in await repository.listTakes()) {
      if (take.id == id) return take;
    }
    return null;
  }

  Future<RecordingTake?> updateToneTags(
    String id,
    List<ToneTag> tags, {
    int? editedEpochMs,
    String memo = '',
  }) async {
    final old = await _findTake(id);
    if (old == null) return null;
    final uniqueTags = <ToneTag>[];
    for (final tag in tags) {
      if (!uniqueTags.contains(tag)) uniqueTags.add(tag);
    }
    final updated = old.copyWith(
      toneTags: uniqueTags,
      toneTagEditedEpochMs:
          editedEpochMs ?? DateTime.now().millisecondsSinceEpoch,
      toneTagEditMemo: memo,
    );
    await repository.saveTake(updated);
    return updated;
  }

  Future<RecordingTake?> setToneProfileExcluded(
    String id,
    bool excluded, {
    int? editedEpochMs,
    String memo = '',
  }) async {
    final old = await _findTake(id);
    if (old == null) return null;
    final updated = old.copyWith(
      toneProfileExcluded: excluded,
      toneTagEditedEpochMs:
          editedEpochMs ?? DateTime.now().millisecondsSinceEpoch,
      toneTagEditMemo: memo,
    );
    await repository.saveTake(updated);
    return updated;
  }
}
