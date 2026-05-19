/// P1 — 진행 상태 + "오늘의 레슨" 셀렉터 (순수, Flutter import 없음).
///
/// P1 범위 = 경로 + 셀렉터만. 완료→해금(advance)은 P2(별도 슬라이스).
/// progression.py 검증 패턴의 실코드 거처.
library;

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
  graduated
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
};

class Progression {
  final List<PathSlot> _manifest;
  int _currentIndex; // 0-based, 현재(오늘) 슬롯
  bool _didToday; // P3 — 1일 1레슨 캡
  int _day; // P4 — 달력일(advanceDay에서 증가)
  bool _graduated; // P4 — 실설정=P7
  int _transitionDay; // P4 — 코스 전이 발생일(실설정=P8/P10)
  int _streak = 0; // P5 — 관대 스트릭(0 리셋·freeze 없음)
  int _lastActiveDay; // P6 — 마지막 활동일(0=없음), 공백 계산용
  int _pendingReview = 0; // P6 — 남은 복귀 복습일
  Genre? _genre; // P8 — 졸업 후 선택(null=미선택), 비구속

  bool get didToday => _didToday;
  Genre? get genre => _genre;
  int get day => _day;
  int get streak => _streak;
  int get pendingReview => _pendingReview;
  bool get graduated => _graduated;

  Progression._(this._manifest, this._currentIndex,
      {this._didToday = false,
      this._day = 1,
      this._graduated = false,
      this._transitionDay = 0,
      this._lastActiveDay = 0});

  factory Progression.beginner() =>
      Progression._(buildPlaceholderManifest(), 0);

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
    if (_didToday) {
      // P3 캡 동작 불변 — P4는 *보고*만 분기.
      if (_graduated) return CompleteOutcome.transitionGraduated;
      if (_transitionDay == _day) return CompleteOutcome.transitionToNext;
      return CompleteOutcome.capped;
    }
    // P6 — 공백 계산 → 복귀 복습 트리거(활동 등록 전)
    final gap = _lastActiveDay == 0 ? 0 : _day - _lastActiveDay - 1;
    if (gap >= 7 && _pendingReview == 0 && !_graduated) {
      _pendingReview = gap <= 14 ? 1 : 2;
    }
    _didToday = true;
    _streak++; // P5 — 그날 활동 등록 시 1회(복습일 포함)
    _lastActiveDay = _day;
    if (_pendingReview > 0) {
      _pendingReview--; // P6 — 복귀일=복습이 그날 레슨, 신규 해금 ❌
      return CompleteOutcome.review;
    }
    if (!atEnd) {
      _currentIndex++;
      return CompleteOutcome.advanced;
    }
    _graduated = true; // P7 — 마지막 슬롯 완주 = 졸업(점수 무관, ADR-0004)
    return CompleteOutcome.graduated;
  }

  /// P8 — 졸업 후에만 장르 선택. 재호출=교체(비구속), 페널티 없음.
  void chooseGenre(Genre g) {
    if (!_graduated) return;
    _genre = g;
  }

  /// P3 — 날짜 진행 = 캡 해제. P4 — 달력일 증가. 해금(_currentIndex) 불변.
  void advanceDay() {
    _didToday = false;
    _day++;
  }
}
