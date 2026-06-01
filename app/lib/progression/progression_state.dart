/// P1 — 진행 상태 + "오늘의 레슨" 셀렉터 (순수, Flutter import 없음).
///
/// P1 범위 = 경로 + 셀렉터만. 완료→해금(advance)은 P2(별도 슬라이스).
/// progression.py 검증 패턴의 실코드 거처.
library;

import 'outcome_resolver.dart';
import 'path.dart';

/// P8 — 장르 트랙(CONTEXT 글로서리). 졸업 후 비구속 선택.
enum Genre { musical, classical, gayo }

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

/// ADR-0010 보강 문구. UI(U7) 표시용 — 캡 에러가 아닌 *전이 화면*.
const Map<CompleteOutcome, String> kOutcomeMessage = {
  CompleteOutcome.advanced: '',
  CompleteOutcome.capped: '오늘 레슨은 끝났어요. 내일 또 만나요.',
  CompleteOutcome.transitionGraduated:
      '🎉 경로 완주! 오늘은 여기까지 — 장르를 고르고 내일부터 다음 코스',
  CompleteOutcome.transitionToNext: '🎉 전이 완료 — 내일 다음 코스 1과부터',
  CompleteOutcome.review: '↩ 오랜만이에요 — 가볍게 복습부터. 신규는 내일부터.',
  CompleteOutcome.graduated: '🎉 초급 완주! 잘 해냈어요.',
  CompleteOutcome.maintenance: '오늘도 가볍게 유지. 새 코스 열리면 이어가요.',
};

class Progression {
  final List<PathSlot> _manifest;
  int _currentIndex; // 0-based, 현재(오늘) 슬롯
  bool _didToday; // P3 — 1일 1레슨 캡
  int _day; // P4 — 달력일(advanceDay에서 증가)
  bool _graduated; // P4 — 실설정=P7
  int _transitionDay; // P4 — 코스 전이 발생일(실설정=P8/P10)
  int _streak; // P5 — 관대 스트릭(0 리셋·freeze 없음)
  int _lastActiveDay; // P6 — 마지막 활동일(0=없음), 공백 계산용
  int _pendingReview; // P6 — 남은 복귀 복습일
  Genre? _genre; // P8 — 졸업 후 선택(null=미선택), 비구속
  bool _maintenance; // P9 — 유지 모드(자유 연습 모드와 별개)
  final Set<Genre> _released; // P10 — 출시된 장르 중급(V1 기본 빔=스텁)
  int _lastCalendarDay; // Task3 — 마지막 동기화한 실 날짜(epoch day, 0=미설정)

  /// Task 3 — 실 캘린더 동기화. todayEpochDay = 1970-01-01부터의 일수.
  /// 날짜가 흐른 만큼 advanceDay()를 호출해 캡 해제·gap을 기존 로직으로 처리.
  /// 같은 날 재실행은 no-op. 첫 호출은 기준만 잡음.
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
    return null;
  }

  bool get didToday => _didToday;
  Genre? get genre => _genre;
  bool get maintenance => _maintenance;
  bool isReleased(Genre g) => _released.contains(g); // P10 — 디버그/검증
  int get day => _day;
  int get streak => _streak;
  int get pendingReview => _pendingReview;
  bool get graduated => _graduated;

  Progression._(this._manifest, this._currentIndex,
      {this._didToday = false,
      this._day = 1,
      this._graduated = false,
      this._transitionDay = 0,
      this._lastActiveDay = 0,
      this._streak = 0,
      this._pendingReview = 0,
      this._genre,
      this._maintenance = false,
      this._lastCalendarDay = 0,
      Set<Genre> released = const {}})
      : _released = {...released};

  factory Progression.beginner() =>
      Progression._(buildPlaceholderManifest(), 0);

  /// Task 2 — 영속화 직렬화. manifest는 고정 경로라 저장 안 함(복원 시 재생성).
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
        'maintenance': _maintenance,
        'released': _released.map((g) => g.name).toList(),
        'lastCalendarDay': _lastCalendarDay,
      };

  factory Progression.fromJson(Map<String, dynamic> j) => Progression._(
        buildPlaceholderManifest(),
        j['currentIndex'] as int,
        didToday: j['didToday'] as bool,
        day: j['day'] as int,
        graduated: j['graduated'] as bool,
        transitionDay: j['transitionDay'] as int,
        lastActiveDay: j['lastActiveDay'] as int,
        streak: j['streak'] as int,
        pendingReview: j['pendingReview'] as int,
        genre: _genreByName(j['genre'] as String?),
        maintenance: j['maintenance'] as bool,
        lastCalendarDay: (j['lastCalendarDay'] as int?) ?? 0,
        released: ((j['released'] as List).cast<String>())
            .map(_genreByName)
            .whereType<Genre>()
            .toSet(),
      );

  /// 테스트용: 임의 매니페스트/위치/상태.
  factory Progression.from(
    List<PathSlot> manifest, {
    int currentIndex = 0,
    bool didToday = false,
    int day = 1,
    bool graduated = false,
    int transitionDay = 0,
    int lastActiveDay = 0,
  }) =>
      Progression._(manifest, currentIndex,
          didToday: didToday,
          day: day,
          graduated: graduated,
          transitionDay: transitionDay,
          lastActiveDay: lastActiveDay);

  int get currentIndex => _currentIndex;
  int get total => _manifest.length;
  bool get atEnd => _currentIndex >= _manifest.length - 1;

  /// "오늘의 레슨" 셀렉터 — 현재 슬롯 반환.
  PathSlot get todaysLesson => _manifest[_currentIndex];

  /// P2 — 레슨 완료 → 완료 기반 해금(포인터 1 전진).
  /// *인자 없음* = 수행 품질이 해금을 막지 않음(구조적 강제, ADR-0002/완료기반).
  /// 경로 끝에서는 더 전진하지 않음(졸업 처리는 P7, 별도 슬라이스).
  CompleteOutcome completeLesson() {
    // 캡 경로 — 변이 없음, 분류만.
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
    // P6 — 공백 계산 → 복귀 복습 트리거(활동 등록 전)
    final gap = _lastActiveDay == 0 ? 0 : _day - _lastActiveDay - 1;
    if (gap >= 7 && _pendingReview == 0 && !_graduated) {
      _pendingReview = gap <= 14 ? 1 : 2;
    }
    // 활동 등록(P3·P5·P6 공통 변이)
    _didToday = true;
    _streak++;
    _lastActiveDay = _day;
    // 활동 outcome 분류
    final outcome = resolveOutcome(
      didToday: false,
      graduated: _graduated,
      transitionDayHit: _transitionDay == _day,
      maintenance: _maintenance,
      pendingReview: _pendingReview,
      atEnd: atEnd,
    );
    // outcome별 후속 변이
    switch (outcome) {
      case CompleteOutcome.review:
        _pendingReview--; // P6 — 복귀일=복습, 신규 해금 ❌
      case CompleteOutcome.advanced:
        _currentIndex++;
      case CompleteOutcome.graduated:
        _graduated = true; // P7 — 마지막 슬롯 완주(점수 무관, ADR-0004)
      case CompleteOutcome.maintenance:
      case CompleteOutcome.capped:
      case CompleteOutcome.transitionGraduated:
      case CompleteOutcome.transitionToNext:
        break;
    }
    return outcome;
  }

  /// P8 — 졸업 후에만 장르 선택. 재호출=교체(비구속), 페널티 없음.
  void chooseGenre(Genre g) {
    if (!_graduated) return;
    _genre = g;
    if (_released.contains(g)) {
      _enterCourse(); // P10 — 출시됨 → 직접 진입
    } else {
      _maintenance = true; // P9 — 미출시 → 유지 모드
    }
  }

  /// P10 — (테스트/관리 스텁) 장르 중급 출시 토글.
  /// 새로 출시됐고 그 장르 대기 중(유지 모드)이면 자동 연결.
  void toggleRelease(Genre g) {
    if (!_released.add(g)) {
      _released.remove(g);
      return;
    }
    if (_maintenance && _genre == g) _enterCourse();
  }

  /// P10 — 코스 진입 공통(progression.py). V1 스텁: 중급 매니페스트 미구현 →
  /// _currentIndex 불변(실제 코스 로드는 향후 슬라이스). 메커니즘만.
  void _enterCourse() {
    _maintenance = false;
    _graduated = false;
    _transitionDay = _day;
    _pendingReview = 0;
  }

  /// P3 — 날짜 진행 = 캡 해제. P4 — 달력일 증가. 해금(_currentIndex) 불변.
  void advanceDay() {
    _didToday = false;
    _day++;
  }
}
