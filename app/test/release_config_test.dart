import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/progression/progression_state.dart';

void main() {
  Map<String, dynamic> repertoireApplicationDoneJson({List<String> released = const []}) => {
        'currentIndex': 71,
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
        'stage': 'repertoireApplication',
        'advancedCycle': 0,
      };

  test('W2.0 checked-in advanced rollout config is empty', () {
    expect(kReleasedAdvancedGenres, isEmpty);
    expect(kReleasedGenres, isEmpty);
  });

  test('W2.1 new user advanced release state == checked-in config', () {
    final p = Progression.beginner();
    for (final g in Genre.values) {
      expect(p.isReleased(g), kReleasedAdvancedGenres.contains(g));
    }
  });

  test('W2.2 fromJson ignores persisted advanced released list', () {
    final p = Progression.fromJson(repertoireApplicationDoneJson(released: ['gayo']));
    for (final g in Genre.values) {
      expect(p.isReleased(g), kReleasedAdvancedGenres.contains(g));
    }
  });

  test('W2.3 empty config → advanced genre pick = maintenance', () {
    for (final g in Genre.values) {
      final p = Progression.fromJson(repertoireApplicationDoneJson());
      p.chooseGenre(g);
      expect(p.maintenance, !kReleasedAdvancedGenres.contains(g));
    }
  });
}
