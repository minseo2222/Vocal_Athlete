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

  test('S2b 손상된 저장본 → load는 null(예외 전파 ❌)', () async {
    SharedPreferences.setMockInitialValues({'progression_v1': '{깨진 json'});
    final store = ProgressionStore();
    expect(await store.load(), isNull); // 신규로 안전 폴백
  });

  test(
    'S2c store restores released genre course manifest after restart',
    () async {
      SharedPreferences.setMockInitialValues({});
      final store = ProgressionStore(releasedGenres: {Genre.musical});

      final p = Progression.fromJson(
        Progression.beginner().toJson()
          ..['graduated'] = true
          ..['currentIndex'] = 47,
        releasedGenres: {Genre.musical},
      );
      p.chooseGenre(Genre.musical);
      p.completeLesson();
      p.advanceDay();
      await store.save(p);

      final loaded = await store.load();
      expect(loaded, isNotNull);
      expect(loaded!.genre, Genre.musical);
      expect(loaded.maintenance, isFalse);
      expect(loaded.graduated, isFalse);
      expect(loaded.currentIndex, p.currentIndex);
      expect(loaded.total, p.total);
      expect(loaded.todaysLesson.cardId, p.todaysLesson.cardId);
    },
  );
}
