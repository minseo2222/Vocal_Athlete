/// Task 2 — ProgressionStore save→load (shared_preferences).
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocal_athlete/progression/progression_state.dart';
import 'package:vocal_athlete/progression/progression_store.dart';

void main() {
  test('S2 save then load restores progression', () async {
    SharedPreferences.setMockInitialValues({});
    final store = ProgressionStore();

    expect(await store.load(), isNull); // 최초 = 없음

    final p = Progression.beginner();
    p.completeLesson();
    p.advanceDay();
    await store.save(p);

    final loaded = await store.load();
    expect(loaded, isNotNull);
    expect(loaded!.currentIndex, p.currentIndex);
    expect(loaded.streak, p.streak);
    expect(loaded.day, p.day);
  });
}
