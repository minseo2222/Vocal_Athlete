/// P1 — 진행 상태 + "오늘의 레슨" 셀렉터 (순수, Flutter import 없음).
///
/// R4: 초급 Foundation → Universal Vocal Core → Repertoire Application → Advanced Genre Labs.
/// 장르 선택은 곡 적용 훈련 완주 후 열린다.
library;

import '../lesson/card_library.dart' show safetyGatedCardIds, safetyFallbackCardId;
import 'outcome_resolver.dart';
import 'path.dart';

/// 고급 장르 Lab. 초급/Universal Core/Repertoire Application에서는 장르를 학습 경로로 사용하지 않는다.
enum Genre { musical, classical, gayo, rbSoul, rockBand, ccm, userSong }

/// 장르 표시 이름(사용자 노출용).
const Map<Genre, String> kGenreLabel = {
  Genre.musical: '뮤지컬',
  Genre.classical: '성악',
  Genre.gayo: '가요 / K-pop',
  Genre.rbSoul: 'R&B / Soul',
  Genre.rockBand: 'Rock / Band',
  Genre.ccm: 'CCM',
  Genre.userSong: '내 곡 프로젝트',
};

/// 현재 학습 단계.
enum LearningStage {
  beginnerFoundation,
  universalCore,
  repertoireApplication,
  advancedGenre,
  maintenance
}

/// W2 — 고급 장르 Lab 롤아웃 설정. 사람이 안전 cap·fallback·HITL를 확인하기 전까지 비어 있다.
const Set<Genre> kReleasedAdvancedGenres = {};

/// 하위 호환 alias. R3부터 `kReleasedGenres`는 고급 장르 Lab 출시 config를 의미한다.
const Set<Genre> kReleasedGenres = kReleasedAdvancedGenres;

/// P4 — 캡된 완료의 보고. 전진/캡 동작은 불변, *보고*만 분기.
enum CompleteOutcome {
  advanced,
  capped,
  transitionGraduated,
  transitionToNext,
  review,
  graduated,
  maintenance
}

const Map<CompleteOutcome, String> kOutcomeMessage = {
  CompleteOutcome.advanced: '',
  CompleteOutcome.capped: '오늘 레슨은 끝났어요. 내일 또 만나요.',
  CompleteOutcome.transitionGraduated:
      '🎉 단계 완주! 오늘은 여기까지 — 다음 단계는 내일부터',
  CompleteOutcome.transitionToNext: '🎉 전이 완료 — 내일 다음 코스 1과부터',
  CompleteOutcome.review: '↩ 오랜만이에요 — 가볍게 복습부터. 신규는 내일부터.',
  CompleteOutcome.graduated: '🎉 완주! 잘 해냈어요.',
  CompleteOutcome.maintenance: '오늘도 가볍게 유지. 새 코스 열리면 이어가요.',
};

class Progression {
  List<PathSlot> _manifest;
  int _currentIndex;
  bool _didToday;
  int _day;
  bool _graduated;
  int _transitionDay;
  int _streak;
  int _lastActiveDay;
  int _pendingReview;
  Genre? _genre;
  LearningStage _stage;
  bool _maintenance;
  int _advancedCycle;
  final Set<Genre> _released;
  int _lastCalendarDay;

  /// I5 — 안전 사인오프 여부. false(기본)면 pending 카드를 고급 Lab에서 제외.
  final bool safetyApproved;

  void syncToToday(int todayEpochDay) {
    if (_lastCalendarDay == 0) {
      _lastCalendarDay = todayEpochDay;
      return;
    }
    if (todayEpochDay <= _lastCalendarDay) return;
    final elapsed = todayEpochDay - _lastCalendarDay;
    for (var i = 0; i < elapsed; i++) {
      advanceDay();
    }
    _lastCalendarDay = todayEpochDay;
  }

  static Genre? _genreByName(String? n) {
    if (n == null) return null;
    for (final g in Genre.values) {
      if (g.name == n) return g;
    }
    // R3 migration alias.
    if (n == 'rnbSoul') return Genre.rbSoul;
    return null;
  }

  static LearningStage _stageByName(String? n) {
    if (n == null) return LearningStage.beginnerFoundation;
    if (n == 'beginner') return LearningStage.beginnerFoundation;
    if (n == 'advanced') return LearningStage.advancedGenre;
    // R4 migration alias: persisted R3 states used `songBuilder`.
    if (n == 'songBuilder') return LearningStage.repertoireApplication;
    for (final s in LearningStage.values) {
      if (s.name == n) return s;
    }
    return LearningStage.beginnerFoundation;
  }

  static List<PathSlot> _manifestForStage(LearningStage stage, Genre? genre,
          {bool safetyApproved = false}) =>
      switch (stage) {
        LearningStage.beginnerFoundation => buildPlaceholderManifest(),
        LearningStage.universalCore => buildUniversalCoreManifest(),
        LearningStage.repertoireApplication => buildRepertoireApplicationManifest(),
        LearningStage.advancedGenre => safetyApproved
            ? _advancedManifest(genre ?? Genre.gayo)
            : _safetyFilteredStatic(_advancedManifest(genre ?? Genre.gayo)),
        LearningStage.maintenance => buildPlaceholderManifest(),
      };

  bool get didToday => _didToday;
  Genre? get genre => _genre;
  LearningStage get stage => _stage;
  bool get maintenance => _maintenance;
  int get advancedCycle => _advancedCycle;
  bool isReleased(Genre g) => _released.contains(g);
  int get day => _day;
  int get streak => _streak;
  int get pendingReview => _pendingReview;
  bool get graduated => _graduated;
  bool get canStartUniversalCore =>
      _graduated && _stage == LearningStage.beginnerFoundation;
  bool get canStartRepertoireApplication =>
      _graduated && _stage == LearningStage.universalCore;

  /// R4 migration alias: R3 used `canStartSongBuilder`.
  bool get canStartSongBuilder => canStartRepertoireApplication;

  bool get canPickAdvancedGenre =>
      _graduated && _stage == LearningStage.repertoireApplication;
  bool get canChangeAdvancedGenre =>
      _stage == LearningStage.advancedGenre ||
      _stage == LearningStage.maintenance ||
      canPickAdvancedGenre;

  Progression._(this._manifest, this._currentIndex,
      {this._didToday = false,
      this._day = 1,
      this._graduated = false,
      this._transitionDay = 0,
      this._lastActiveDay = 0,
      this._streak = 0,
      this._pendingReview = 0,
      this._genre,
      this._stage = LearningStage.beginnerFoundation,
      this._maintenance = false,
      this._advancedCycle = 0,
      this._lastCalendarDay = 0,
      this.safetyApproved = false,
      Set<Genre> released = const {}})
      : _released = {...released};

  factory Progression.beginner() => Progression._(
        buildPlaceholderManifest(),
        0,
        stage: LearningStage.beginnerFoundation,
        released: kReleasedAdvancedGenres,
      );

  Map<String, dynamic> toJson() => {
        'currentIndex': _currentIndex,
        'didToday': _didToday,
        'day': _day,
        'graduated': _graduated,
        'transitionDay': _transitionDay,
        'lastActiveDay': _lastActiveDay,
        'streak': _streak,
        'pendingReview': _pendingReview,
        'genre': _genre?.name,
        'stage': _stage.name,
        'maintenance': _maintenance,
        'advancedCycle': _advancedCycle,
        'released': _released.map((g) => g.name).toList(),
        'lastCalendarDay': _lastCalendarDay,
        'safetyApproved': safetyApproved,
      };

  factory Progression.fromJson(Map<String, dynamic> j) {
    final stage = _stageByName(j['stage'] as String?);
    final genre = _genreByName(j['genre'] as String?);
    final safetyApproved = (j['safetyApproved'] as bool?) ?? false;
    final manifest = _manifestForStage(stage, genre,
        safetyApproved: safetyApproved);
    var currentIndex = (j['currentIndex'] as int?) ?? 0;
    if (currentIndex < 0) currentIndex = 0;
    if (currentIndex >= manifest.length) currentIndex = manifest.length - 1;
    return Progression._(
      manifest,
      currentIndex,
      didToday: (j['didToday'] as bool?) ?? false,
      day: (j['day'] as int?) ?? 1,
      graduated: (j['graduated'] as bool?) ?? false,
      transitionDay: (j['transitionDay'] as int?) ?? 0,
      lastActiveDay: (j['lastActiveDay'] as int?) ?? 0,
      streak: (j['streak'] as int?) ?? 0,
      pendingReview: (j['pendingReview'] as int?) ?? 0,
      genre: genre,
      stage: stage,
      maintenance: (j['maintenance'] as bool?) ?? false,
      advancedCycle: (j['advancedCycle'] as int?) ?? 0,
      lastCalendarDay: (j['lastCalendarDay'] as int?) ?? 0,
      safetyApproved: safetyApproved,
      released: kReleasedAdvancedGenres,
    );
  }

  factory Progression.from(
    List<PathSlot> manifest, {
    int currentIndex = 0,
    bool didToday = false,
    int day = 1,
    bool graduated = false,
    int transitionDay = 0,
    int lastActiveDay = 0,
    int streak = 0,
    int pendingReview = 0,
    Genre? genre,
    LearningStage stage = LearningStage.beginnerFoundation,
    bool maintenance = false,
    int advancedCycle = 0,
    int lastCalendarDay = 0,
    bool safetyApproved = false,
  }) =>
      Progression._(manifest, currentIndex,
          didToday: didToday,
          day: day,
          graduated: graduated,
          transitionDay: transitionDay,
          lastActiveDay: lastActiveDay,
          streak: streak,
          pendingReview: pendingReview,
          genre: genre,
          stage: stage,
          maintenance: maintenance,
          advancedCycle: advancedCycle,
          lastCalendarDay: lastCalendarDay,
          safetyApproved: safetyApproved,
          released: kReleasedAdvancedGenres);

  int get currentIndex => _currentIndex;
  int get total => _manifest.length;
  List<PathSlot> get slots => List.unmodifiable(_manifest);
  bool get atEnd => _currentIndex >= _manifest.length - 1;
  PathSlot get todaysLesson => _manifest[_currentIndex];

  CompleteOutcome completeLesson() {
    if (_didToday) {
      return resolveOutcome(
        didToday: true,
        graduated: _graduated,
        transitionDayHit: _transitionDay == _day,
        maintenance: _maintenance,
        pendingReview: _pendingReview,
        atEnd: atEnd,
      );
    }
    final gap = _lastActiveDay == 0 ? 0 : _day - _lastActiveDay - 1;
    if (gap >= 7 && _pendingReview == 0 && !_graduated && !_maintenance) {
      _pendingReview = gap <= 14 ? 1 : 2;
    }
    _didToday = true;
    _streak++;
    _lastActiveDay = _day;
    final outcome = resolveOutcome(
      didToday: false,
      graduated: _graduated,
      transitionDayHit: _transitionDay == _day,
      maintenance: _maintenance,
      pendingReview: _pendingReview,
      atEnd: atEnd,
    );
    switch (outcome) {
      case CompleteOutcome.review:
        _pendingReview--;
        break;
      case CompleteOutcome.advanced:
        _currentIndex++;
        break;
      case CompleteOutcome.graduated:
        if (_stage == LearningStage.advancedGenre) {
          _advancedCycle++;
          var course = _advancedManifest(_genre ?? Genre.gayo);
          if (!safetyApproved) course = _safetyFilteredStatic(course);
          _manifest = course;
          _currentIndex = 0;
          _graduated = false;
          _maintenance = false;
        } else {
          _graduated = true;
        }
        break;
      case CompleteOutcome.maintenance:
      case CompleteOutcome.capped:
      case CompleteOutcome.transitionGraduated:
      case CompleteOutcome.transitionToNext:
        break;
    }
    return outcome;
  }

  void startUniversalCore() {
    if (!canStartUniversalCore) return;
    _manifest = buildUniversalCoreManifest();
    _currentIndex = 0;
    _stage = LearningStage.universalCore;
    _graduated = false;
    _maintenance = false;
    _genre = null;
    _transitionDay = _day;
    _pendingReview = 0;
  }

  /// 하위 호환 alias.
  void enterUniversalCore() => startUniversalCore();

  void startRepertoireApplication() {
    if (!canStartRepertoireApplication) return;
    _manifest = buildRepertoireApplicationManifest();
    _currentIndex = 0;
    _stage = LearningStage.repertoireApplication;
    _graduated = false;
    _maintenance = false;
    _transitionDay = _day;
    _pendingReview = 0;
    _genre = null;
  }

  /// R4 migration alias: R3 used `startSongBuilder`.
  void startSongBuilder() => startRepertoireApplication();

  void chooseGenre(Genre g) {
    if (!canChangeAdvancedGenre) return;
    _genre = g;
    if (_released.contains(g)) {
      _enterAdvancedGenre(g);
    } else {
      _manifest = buildPlaceholderManifest();
      _currentIndex = 0;
      _stage = LearningStage.maintenance;
      _maintenance = true;
      _graduated = false;
      _transitionDay = _day;
      _pendingReview = 0;
    }
  }

  void toggleRelease(Genre g) {
    if (!_released.add(g)) {
      _released.remove(g);
      return;
    }
    if (_maintenance && _genre == g) {
      _enterAdvancedGenre(g);
    }
  }

  static List<PathSlot> _advancedManifest(Genre g) => switch (g) {
        Genre.musical => buildAdvancedMusicalManifest(),
        Genre.classical => buildAdvancedClassicalManifest(),
        Genre.gayo => buildAdvancedGayoManifest(),
        Genre.rbSoul => buildAdvancedRbSoulManifest(),
        Genre.rockBand => buildAdvancedRockManifest(),
        Genre.ccm => buildAdvancedCcmManifest(),
        Genre.userSong => buildAdvancedUserSongManifest(),
      };

  static List<PathSlot> _safetyFilteredStatic(List<PathSlot> course) {
    final gated = safetyGatedCardIds();
    final remapped = <PathSlot>[];
    for (final slot in course) {
      final replacement = gated.contains(slot.cardId)
          ? safetyFallbackCardId(slot.cardId)
          : slot.cardId;
      if (replacement == null) continue;
      remapped.add(PathSlot(
        index: remapped.length,
        cardId: replacement,
        block: slot.block,
        bodyVoicedRatio: slot.bodyVoicedRatio,
        variationLevel: slot.variationLevel,
      ));
    }
    return remapped;
  }

  void _enterAdvancedGenre(Genre g) {
    var course = _advancedManifest(g);
    if (!safetyApproved) course = _safetyFilteredStatic(course);
    _manifest = course;
    _currentIndex = 0;
    _stage = LearningStage.advancedGenre;
    _maintenance = false;
    _graduated = false;
    _transitionDay = _day;
    _pendingReview = 0;
  }

  void advanceDay() {
    _didToday = false;
    _day++;
  }
}
