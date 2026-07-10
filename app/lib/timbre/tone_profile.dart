/// v18 — 사용자가 직접 선택한 tone tag와 편안함 기록을 생성 당시 학습일 기준으로 요약한다.
///
/// 음향 분석이나 성대 상태 추정이 아니다. 같은 날 여러 take를 반복해도 하나의
/// tone tag가 팔레트를 과도하게 지배하지 않도록 `학습일 × tag` 단위로 집계한다.
/// 녹음 take가 삭제되면 남아 있는 take만으로 다시 계산하는 파생 모델이다.
library;

import '../recording/recording_ab.dart';

class ToneProfile {
  const ToneProfile({
    required this.observedTakeCount,
    required this.practiceDayCount,
    required this.dayTagContributionCount,
    required this.undatedTakeCount,
    required this.excludedTakeCount,
    required this.editedTakeCount,
    required this.sameConditionTakeCount,
    required this.sameConditionPracticeDayCount,
    required this.referenceTakeCount,
    required this.tagCounts,
    required this.comfortableTagCounts,
    required this.lowComfortTagCounts,
    required this.referenceTakeIds,
  });

  factory ToneProfile.empty() => const ToneProfile(
        observedTakeCount: 0,
        practiceDayCount: 0,
        dayTagContributionCount: 0,
        undatedTakeCount: 0,
        excludedTakeCount: 0,
        editedTakeCount: 0,
        sameConditionTakeCount: 0,
        sameConditionPracticeDayCount: 0,
        referenceTakeCount: 0,
        tagCounts: {},
        comfortableTagCounts: {},
        lowComfortTagCounts: {},
        referenceTakeIds: {},
      );

  /// tone tag가 하나 이상 있는 원본 take 수. 반복 take도 포함한다.
  final int observedTakeCount;

  /// 유효한 생성 시각이 있는 서로 다른 로컬 학습일 수.
  final int practiceDayCount;

  /// `학습일 × tag` 기여 수. 같은 날 같은 tag는 take 수와 무관하게 1회다.
  final int dayTagContributionCount;

  /// 생성 시각이 없어 안정 집계에서 제외된 이전/손상 metadata take 수.
  final int undatedTakeCount;

  /// 사용자가 팔레트 집계에서 제외한 take 수. 원음 삭제가 아니라 자기 태그
  /// 철회/정정권을 위한 제외다.
  final int excludedTakeCount;

  /// 사용자가 tone tag 또는 팔레트 포함 여부를 한 번 이상 정정한 take 수.
  final int editedTakeCount;

  /// 같은 녹음 조건을 사용자가 확인한 원본 take 수.
  final int sameConditionTakeCount;

  /// 같은 녹음 조건이 한 번 이상 확인된 서로 다른 학습일 수.
  final int sameConditionPracticeDayCount;

  final int referenceTakeCount;

  /// 아래 세 count는 take 수가 아니라 각 tag가 관찰된 서로 다른 학습일 수다.
  final Map<ToneTag, int> tagCounts;
  final Map<ToneTag, int> comfortableTagCounts;
  final Map<ToneTag, int> lowComfortTagCounts;
  final Map<ToneTag, List<String>> referenceTakeIds;

  /// 하루에 take를 몰아 만든 profile이 아니라, 최소 세 학습일의 관찰이 필요하다.
  bool get hasEnoughData => practiceDayCount >= 3;

  List<ToneTag> topTags(Map<ToneTag, int> source, {int limit = 4}) {
    final entries = source.entries.where((entry) => entry.value > 0).toList()
      ..sort((a, b) {
        final count = b.value.compareTo(a.value);
        if (count != 0) return count;
        return a.key.index.compareTo(b.key.index);
      });
    return [for (final entry in entries.take(limit)) entry.key];
  }

  List<ToneTag> get frequentlySelected => topTags(tagCounts);
  List<ToneTag> get comfortableTags => topTags(comfortableTagCounts);
  List<ToneTag> get lowComfortTags => topTags(lowComfortTagCounts);

  static int? _localEpochDay(RecordingTake take) {
    final stored = localDateOrdinalFromKey(take.createdLocalDateKey);
    if (stored != null) return stored;
    final epochMs = take.createdEpochMs;
    if (epochMs <= 0) return null;
    final date = DateTime.fromMillisecondsSinceEpoch(epochMs).toLocal();
    // legacy take만 현재 시간대 기준 epoch fallback을 쓴다. 새 take는 생성 당시
    // yyyy-MM-dd를 저장하므로 여행·시간대 변경 뒤에도 같은 학습일을 유지한다.
    return date.year * 10000 + date.month * 100 + date.day;
  }

  static ToneProfile fromTakes(Iterable<RecordingTake> takes) {
    final selectedDays = <ToneTag, Set<int>>{};
    final comfortableDays = <ToneTag, Set<int>>{};
    final lowComfortDays = <ToneTag, Set<int>>{};
    final references = <ToneTag, List<String>>{};
    final practiceDays = <int>{};
    final sameConditionDays = <int>{};
    var observed = 0;
    var undated = 0;
    var sameConditionTakes = 0;
    var referenceCount = 0;
    var excluded = 0;
    var edited = 0;

    for (final take in takes) {
      final tags = take.toneTags.toSet();
      if (tags.isEmpty) continue;
      observed += 1;
      if (take.toneTagEditedEpochMs > 0) edited += 1;
      if (take.toneProfileExcluded) {
        excluded += 1;
        continue;
      }
      if (take.sameConditionConfirmed) sameConditionTakes += 1;

      final day = _localEpochDay(take);
      if (day == null) {
        // 날짜를 복원할 수 없는 legacy take는 raw count/reference에는 남기되,
        // 반복 편향을 제어하는 학습일 기반 팔레트에는 넣지 않는다.
        undated += 1;
      } else {
        practiceDays.add(day);
        if (take.sameConditionConfirmed) sameConditionDays.add(day);
      }

      final isReference = take.isBest ||
          take.purpose == RecordingPurpose.standardSample ||
          take.slot == RecordingSlot.best;
      if (isReference) referenceCount += 1;

      for (final tag in tags) {
        if (day != null) {
          selectedDays.putIfAbsent(tag, () => <int>{}).add(day);
          final lowComfort =
              (take.comfortRating > 0 && take.comfortRating <= 2) ||
                  tag.isCautionFeeling;
          if (lowComfort) {
            lowComfortDays.putIfAbsent(tag, () => <int>{}).add(day);
          } else if (take.comfortRating >= 4) {
            comfortableDays.putIfAbsent(tag, () => <int>{}).add(day);
          }
        }
        if (isReference && !tag.isCautionFeeling) {
          final ids = references.putIfAbsent(tag, () => <String>[]);
          if (!ids.contains(take.id)) ids.add(take.id);
        }
      }
    }

    // 같은 날 같은 tag에 높은/낮은 편안함이 모두 있으면 낮은 편안함 신호를
    // 우선한다. 이는 진단이 아니라 다음 시도에서 강도를 낮추기 위한 자기기록이다.
    final comfortableCounts = <ToneTag, int>{};
    for (final entry in comfortableDays.entries) {
      final lowDays = lowComfortDays[entry.key] ?? const <int>{};
      comfortableCounts[entry.key] =
          entry.value.where((day) => !lowDays.contains(day)).length;
    }

    final tagCounts = <ToneTag, int>{
      for (final entry in selectedDays.entries) entry.key: entry.value.length,
    };
    final lowCounts = <ToneTag, int>{
      for (final entry in lowComfortDays.entries)
        entry.key: entry.value.length,
    };

    return ToneProfile(
      observedTakeCount: observed,
      practiceDayCount: practiceDays.length,
      dayTagContributionCount:
          selectedDays.values.fold<int>(0, (sum, days) => sum + days.length),
      undatedTakeCount: undated,
      excludedTakeCount: excluded,
      editedTakeCount: edited,
      sameConditionTakeCount: sameConditionTakes,
      sameConditionPracticeDayCount: sameConditionDays.length,
      referenceTakeCount: referenceCount,
      tagCounts: Map<ToneTag, int>.unmodifiable(tagCounts),
      comfortableTagCounts:
          Map<ToneTag, int>.unmodifiable(comfortableCounts),
      lowComfortTagCounts: Map<ToneTag, int>.unmodifiable(lowCounts),
      referenceTakeIds: Map<ToneTag, List<String>>.unmodifiable({
        for (final entry in references.entries)
          entry.key: List<String>.unmodifiable(entry.value),
      }),
    );
  }
}
