/// v18 — Recording A/B 도메인 모델 + stable local-date/tone curation metadata.
///
/// 표준 샘플·음색 A/B·곡 적용 훈련의 녹음 산출물을 local-first로
/// 저장/삭제/비교하기 위한 순수 도메인 계층이다. 실제 마이크 캡처와
/// 재생은 `audio_io.dart`의 어댑터가 담당한다.
library;

/// 녹음이 생성된 시점의 로컬 달력 날짜를 고정한다.
///
/// 이후 사용자가 다른 시간대로 이동해도 동일 take가 다른 학습일로 재분류되지
/// 않도록 새 녹음에 저장한다. legacy take는 빈 문자열을 유지하고 집계 시 epoch
/// fallback을 사용한다.
String localDateKeyForEpochMs(int epochMs) {
  if (epochMs <= 0) return '';
  final date = DateTime.fromMillisecondsSinceEpoch(epochMs).toLocal();
  String two(int value) => value.toString().padLeft(2, '0');
  return '${date.year.toString().padLeft(4, '0')}-${two(date.month)}-${two(date.day)}';
}

/// yyyy-MM-dd 키를 비교/집계 가능한 yyyyMMdd 정수로 변환한다.
/// 잘못된 키는 null이며 epoch fallback을 허용한다.
int? localDateOrdinalFromKey(String key) {
  final match = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch(key.trim());
  if (match == null) return null;
  final year = int.tryParse(match.group(1)!);
  final month = int.tryParse(match.group(2)!);
  final day = int.tryParse(match.group(3)!);
  if (year == null || month == null || day == null) return null;
  try {
    final date = DateTime(year, month, day);
    if (date.year != year || date.month != month || date.day != day) return null;
  } catch (_) {
    return null;
  }
  return year * 10000 + month * 100 + day;
}

enum RecordingPurpose {
  standardSample,
  toneAB,
  repertoirePhrase,
  portfolio,
}

enum RecordingSlot {
  baseline,
  midpoint,
  graduation,
  a,
  b,
  c,
  best,
}

enum ToneTag {
  clean,
  bright,
  warm,
  clear,
  soft,
  speechLike,
  round,
  micFriendly,
  airyFeeling,
  effortful,
  comfortable,
  tired,
}

extension ToneTagLabel on ToneTag {
  String get label => switch (this) {
        ToneTag.clean => '깨끗함',
        ToneTag.bright => '밝음',
        ToneTag.warm => '따뜻함',
        ToneTag.clear => '선명함',
        ToneTag.soft => '부드러움',
        ToneTag.speechLike => '말하듯',
        ToneTag.round => '둥글게',
        ToneTag.micFriendly => '녹음 친화',
        ToneTag.airyFeeling => '숨 섞임 느낌',
        ToneTag.effortful => '힘이 든 느낌',
        ToneTag.comfortable => '편안함',
        ToneTag.tired => '피곤함',
      };

  /// 목표 음색이 아니라 사용자가 남긴 주의 느낌이다. AI 판정에 쓰지 않는다.
  bool get isCautionFeeling =>
      this == ToneTag.airyFeeling ||
      this == ToneTag.effortful ||
      this == ToneTag.tired;
}

/// 카드 메타데이터의 snake_case/camelCase tag 이름을 안전한 자기 태그로 변환한다.
/// 알 수 없는 이름은 null이며 자동 음색 판정으로 대체하지 않는다.
ToneTag? toneTagFromName(String name) {
  final normalized = name
      .trim()
      .toLowerCase()
      .replaceAll('_', '')
      .replaceAll('-', '')
      .replaceAll(' ', '');
  return switch (normalized) {
    'clean' => ToneTag.clean,
    'bright' => ToneTag.bright,
    'warm' => ToneTag.warm,
    'clear' => ToneTag.clear,
    'soft' => ToneTag.soft,
    'speechlike' => ToneTag.speechLike,
    'round' => ToneTag.round,
    'micfriendly' => ToneTag.micFriendly,
    'airyfeeling' || 'breathyfeeling' => ToneTag.airyFeeling,
    'effortful' || 'effortfulfeeling' || 'pressedfeeling' => ToneTag.effortful,
    'comfortable' => ToneTag.comfortable,
    'tired' => ToneTag.tired,
    _ => null,
  };
}

class RecordingTake {
  const RecordingTake({
    required this.id,
    required this.cardId,
    required this.purpose,
    required this.slot,
    required this.localPath,
    required this.createdEpochMs,
    this.createdLocalDateKey = '',
    this.toneTags = const [],
    this.comfortRating = 0,
    this.sameConditionConfirmed = false,
    this.durationMs = 0,
    this.fileSizeBytes = 0,
    this.codec = 'm4a/aac',
    this.memo = '',
    this.isBest = false,
    this.toneProfileExcluded = false,
    this.toneTagEditedEpochMs = 0,
    this.toneTagEditMemo = '',
  });

  final String id;
  final String cardId;
  final RecordingPurpose purpose;
  final RecordingSlot slot;
  final String localPath;
  final int createdEpochMs;

  /// 녹음 생성 시점의 로컬 달력 날짜(yyyy-MM-dd).
  /// 시간대 이동 뒤에도 학습일 집계를 안정적으로 유지하기 위한 메타데이터다.
  final String createdLocalDateKey;
  final List<ToneTag> toneTags;

  /// 0 = 미기록, 1..5 = 사용자 자기평가. AI 점수 아님.
  final int comfortRating;
  final bool sameConditionConfirmed;

  /// 실제 오디오 캡처가 연결된 take의 길이. 0이면 미측정/preview.
  final int durationMs;

  /// 로컬 파일 크기. 0이면 미측정/preview.
  final int fileSizeBytes;

  /// 실제 캡처 파일 코덱/컨테이너 힌트. preview take도 기본값을 가진다.
  final String codec;
  final String memo;
  final bool isBest;

  /// 사용자가 이 take를 내 음색 팔레트 집계에서 제외했는지 여부.
  ///
  /// 원음과 원래 metadata는 삭제하지 않는다. 이 필드는 자기 태그 철회/정정권을
  /// 위한 제품 메타데이터이며, AI 판단이나 음성 건강 판정이 아니다.
  final bool toneProfileExcluded;

  /// tone tag를 나중에 수정하거나 집계 제외/복원한 시각. 0이면 미수정.
  final int toneTagEditedEpochMs;

  /// 사용자가 남긴 짧은 정정 메모. 서버 업로드나 모델 학습에 쓰지 않는다.
  final String toneTagEditMemo;

  RecordingTake copyWith({
    String? id,
    String? cardId,
    RecordingPurpose? purpose,
    RecordingSlot? slot,
    String? localPath,
    int? createdEpochMs,
    String? createdLocalDateKey,
    List<ToneTag>? toneTags,
    int? comfortRating,
    bool? sameConditionConfirmed,
    int? durationMs,
    int? fileSizeBytes,
    String? codec,
    String? memo,
    bool? isBest,
    bool? toneProfileExcluded,
    int? toneTagEditedEpochMs,
    String? toneTagEditMemo,
  }) =>
      RecordingTake(
        id: id ?? this.id,
        cardId: cardId ?? this.cardId,
        purpose: purpose ?? this.purpose,
        slot: slot ?? this.slot,
        localPath: localPath ?? this.localPath,
        createdEpochMs: createdEpochMs ?? this.createdEpochMs,
        createdLocalDateKey:
            createdLocalDateKey ?? this.createdLocalDateKey,
        toneTags: toneTags ?? this.toneTags,
        comfortRating: comfortRating ?? this.comfortRating,
        sameConditionConfirmed:
            sameConditionConfirmed ?? this.sameConditionConfirmed,
        durationMs: durationMs ?? this.durationMs,
        fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
        codec: codec ?? this.codec,
        memo: memo ?? this.memo,
        isBest: isBest ?? this.isBest,
        toneProfileExcluded: toneProfileExcluded ?? this.toneProfileExcluded,
        toneTagEditedEpochMs:
            toneTagEditedEpochMs ?? this.toneTagEditedEpochMs,
        toneTagEditMemo: toneTagEditMemo ?? this.toneTagEditMemo,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'cardId': cardId,
        'purpose': purpose.name,
        'slot': slot.name,
        'localPath': localPath,
        'createdEpochMs': createdEpochMs,
        'createdLocalDateKey': createdLocalDateKey,
        'toneTags': toneTags.map((t) => t.name).toList(),
        'comfortRating': comfortRating,
        'sameConditionConfirmed': sameConditionConfirmed,
        'durationMs': durationMs,
        'fileSizeBytes': fileSizeBytes,
        'codec': codec,
        'memo': memo,
        'isBest': isBest,
        'toneProfileExcluded': toneProfileExcluded,
        'toneTagEditedEpochMs': toneTagEditedEpochMs,
        'toneTagEditMemo': toneTagEditMemo,
      };

  static RecordingTake fromJson(Map<String, dynamic> j) => RecordingTake(
        id: j['id'] as String,
        cardId: j['cardId'] as String,
        purpose: RecordingPurpose.values.firstWhere(
          (p) => p.name == j['purpose'],
          orElse: () => RecordingPurpose.standardSample,
        ),
        slot: RecordingSlot.values.firstWhere(
          (s) => s.name == j['slot'],
          orElse: () => RecordingSlot.a,
        ),
        localPath: j['localPath'] as String,
        createdEpochMs: (j['createdEpochMs'] as int?) ?? 0,
        createdLocalDateKey: (j['createdLocalDateKey'] as String?) ?? '',
        toneTags: ((j['toneTags'] as List?) ?? const [])
            .map((name) => toneTagFromName(name.toString()))
            .whereType<ToneTag>()
            .toList(growable: false),
        comfortRating: (j['comfortRating'] as int?) ?? 0,
        sameConditionConfirmed:
            (j['sameConditionConfirmed'] as bool?) ?? false,
        durationMs: (j['durationMs'] as int?) ?? 0,
        fileSizeBytes: (j['fileSizeBytes'] as int?) ?? 0,
        codec: (j['codec'] as String?) ?? 'm4a/aac',
        memo: (j['memo'] as String?) ?? '',
        isBest: (j['isBest'] as bool?) ?? false,
        toneProfileExcluded:
            (j['toneProfileExcluded'] as bool?) ?? false,
        toneTagEditedEpochMs: (j['toneTagEditedEpochMs'] as int?) ?? 0,
        toneTagEditMemo: (j['toneTagEditMemo'] as String?) ?? '',
      );
}

extension RecordingTakeDisplay on RecordingTake {
  bool get hasPlayableLocalFile =>
      localPath.isNotEmpty && !localPath.startsWith('local://');

  String get durationLabel {
    if (durationMs <= 0) return '길이 미측정';
    final total = (durationMs / 1000).round();
    final m = total ~/ 60;
    final sec = total % 60;
    if (m == 0) return '$sec초';
    return '$m:${sec.toString().padLeft(2, '0')}';
  }
}

class RecordingAbSession {
  const RecordingAbSession({
    required this.cardId,
    required this.purpose,
    required this.maxTakes,
    this.takes = const [],
    this.bestTakeId,
  });

  final String cardId;
  final RecordingPurpose purpose;
  final int maxTakes;
  final List<RecordingTake> takes;
  final String? bestTakeId;

  bool get canAddTake => takes.length < maxTakes;
  RecordingTake? get bestTake {
    if (bestTakeId == null) return null;
    for (final take in takes) {
      if (take.id == bestTakeId) return take;
    }
    return null;
  }

  RecordingAbSession addTake(RecordingTake take) {
    if (!canAddTake) return this;
    return RecordingAbSession(
      cardId: cardId,
      purpose: purpose,
      maxTakes: maxTakes,
      takes: [...takes, take],
      bestTakeId: bestTakeId,
    );
  }

  RecordingAbSession deleteTake(String id) => RecordingAbSession(
        cardId: cardId,
        purpose: purpose,
        maxTakes: maxTakes,
        takes: [for (final take in takes) if (take.id != id) take],
        bestTakeId: bestTakeId == id ? null : bestTakeId,
      );

  RecordingAbSession markBest(String id) {
    final exists = takes.any((take) => take.id == id);
    return RecordingAbSession(
      cardId: cardId,
      purpose: purpose,
      maxTakes: maxTakes,
      takes: takes,
      bestTakeId: exists ? id : bestTakeId,
    );
  }
}

abstract class RecordingRepository {
  Future<void> saveTake(RecordingTake take);
  Future<List<RecordingTake>> listTakes({
    String? cardId,
    RecordingPurpose? purpose,
  });
  Future<void> deleteTake(String id);
  Future<void> clearAll();
}

/// 테스트와 UI 프로토타입용 메모리 저장소.
class InMemoryRecordingRepository implements RecordingRepository {
  final Map<String, RecordingTake> _takes = {};

  @override
  Future<void> saveTake(RecordingTake take) async {
    _takes[take.id] = take;
  }

  @override
  Future<List<RecordingTake>> listTakes({
    String? cardId,
    RecordingPurpose? purpose,
  }) async {
    final list = _takes.values.where((take) {
      final cardOk = cardId == null || take.cardId == cardId;
      final purposeOk = purpose == null || take.purpose == purpose;
      return cardOk && purposeOk;
    }).toList()
      ..sort((a, b) => a.createdEpochMs.compareTo(b.createdEpochMs));
    return list;
  }

  @override
  Future<void> deleteTake(String id) async {
    _takes.remove(id);
  }

  @override
  Future<void> clearAll() async {
    _takes.clear();
  }
}

RecordingSlot? standardSampleSlotForBeginnerIndex(int index) => switch (index) {
      0 => RecordingSlot.baseline,
      23 => RecordingSlot.midpoint,
      47 => RecordingSlot.graduation,
      _ => null,
    };

String nextTakeId(
  String cardId,
  int sequence, {
  RecordingSlot? slot,
}) {
  final slotPart = slot == null ? '' : '_${slot.name}';
  return '$cardId${slotPart}_take_${sequence.toString().padLeft(2, '0')}';
}
