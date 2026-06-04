import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/progression/progression_state.dart';

void main() {
  // fromJson용 최소 유효 JSON(졸업·장르 미선택 상태). released는 일부러 'musical'을
  // 넣어 — 체크인 config가 비어 있으면 *config가 이긴다*(persisted 무시)는 걸 검증.
  Map<String, dynamic> graduatedJson({List<String> released = const []}) => {
        'currentIndex': 0,
        'didToday': false,
        'day': 1,
        'graduated': true,
        'transitionDay': 0,
        'lastActiveDay': 0,
        'streak': 0,
        'pendingReview': 0,
        'genre': null,
        'maintenance': false,
        'released': released,
        'lastCalendarDay': 0,
      };

  test('W2.0 체크인된 기본 롤아웃 config는 비어 있음 (AI 자가 롤아웃 0)', () {
    expect(kReleasedGenres, isEmpty);
  });

  test('W2.1 신규 사용자(beginner) 출시상태 == 체크인 config (전 장르)', () {
    final p = Progression.beginner();
    for (final g in Genre.values) {
      expect(p.isReleased(g), kReleasedGenres.contains(g),
          reason: '$g: beginner 출시상태가 config와 불일치');
    }
  });

  test('W2.2 fromJson은 config를 권위로 — persisted released 무시(세션 독립)', () {
    // 저장본엔 musical이 출시된 것처럼 기록돼 있어도, 체크인 config가 비어 있으면
    // 복원된 진행 상태는 config를 따른다(미연결).
    final p = Progression.fromJson(graduatedJson(released: ['musical']));
    for (final g in Genre.values) {
      expect(p.isReleased(g), kReleasedGenres.contains(g),
          reason: '$g: 복원 시 config가 권위여야');
    }
  });

  test('W2.3 빈 config → 졸업 후 장르 픽 = 유지 모드(코스 미연결)', () {
    for (final g in Genre.values) {
      final p = Progression.fromJson(graduatedJson());
      p.chooseGenre(g);
      // config에 없으면 유지 모드, 있으면 코스 진입.
      expect(p.maintenance, !kReleasedGenres.contains(g),
          reason: '$g: config↔라우팅 불일치');
    }
  });
}
