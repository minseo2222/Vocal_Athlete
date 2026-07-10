/// Stage 0 — A2 스크리닝 결과 영속화 테스트.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/safety/vocal_screening.dart';
import 'package:vocal_athlete/safety/vocal_screening_store.dart';
import 'package:vocal_athlete/storage/app_metadata_store.dart';

AppMetadataStore _mem() =>
    AppMetadataStore(primary: InMemoryMetadataBackend(), legacy: null);

void main() {
  test('S0 빈 저장소 → null', () async {
    final store = VocalScreeningStore(metadataStore: _mem());
    expect(await store.load(), isNull);
  });

  test('S0 저장→로드 round-trip', () async {
    final store = VocalScreeningStore(metadataStore: _mem());
    final r = evaluateScreening(
      answers: {'neck_mass': true},
      todayEpochDay: 100,
    );
    await store.save(r);
    final back = await store.load();
    expect(back, isNotNull);
    expect(back!.outcome, ScreeningOutcome.hardBlock);
    expect(back.referralAdvised, isTrue);
  });

  test('S0 손상 JSON → null 폴백', () async {
    final mem = _mem();
    await mem.writeString(VocalScreeningStore.storageKey, 'not json{');
    final store = VocalScreeningStore(metadataStore: mem);
    expect(await store.load(), isNull);
  });
}
