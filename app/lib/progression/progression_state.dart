/// P1 — 진행 상태 + "오늘의 레슨" 셀렉터 (순수, Flutter import 없음).
///
/// P1 범위 = 경로 + 셀렉터만. 완료→해금(advance)은 P2(별도 슬라이스).
/// progression.py 검증 패턴의 실코드 거처.
library;

import 'path.dart';

class Progression {
  final List<PathSlot> _manifest;
  int _currentIndex; // 0-based, 현재(오늘) 슬롯

  Progression._(this._manifest, this._currentIndex);

  factory Progression.beginner() =>
      Progression._(buildPlaceholderManifest(), 0);

  /// 테스트용: 임의 매니페스트/위치.
  factory Progression.from(List<PathSlot> manifest, {int currentIndex = 0}) =>
      Progression._(manifest, currentIndex);

  int get currentIndex => _currentIndex;
  int get total => _manifest.length;
  bool get atEnd => _currentIndex >= _manifest.length - 1;

  /// "오늘의 레슨" 셀렉터 — 현재 슬롯 반환.
  PathSlot get todaysLesson => _manifest[_currentIndex];
}
