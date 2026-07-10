/// F2 — 경량 음성 피로 자가체크 영속화 어댑터 테스트.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/safety/vocal_fatigue_store.dart';
import 'package:vocal_athlete/safety/vocal_recovery.dart';
import 'package:vocal_athlete/storage/app_metadata_store.dart';

AppMetadataStore _mem() =>
    AppMetadataStore(primary: InMemoryMetadataBackend(), legacy: null);

void main() {
  test('F2 빈 저장소 → null', () async {
    final store = VocalFatigueStore(metadataStore: _mem());
    expect(await store.load(), isNull);
  });

  test('F2 저장→로드 round-trip', () async {
    final store = VocalFatigueStore(metadataStore: _mem());
    const check = VocalFatigueSelfCheck(
      tiredness: 8,
      discomfort: 2,
      poorRecovery: 9,
      epochDay: 50,
    );
    await store.save(check);
    final back = await store.load();
    expect(back, isNotNull);
    expect(back!.tiredness, 8);
    expect(back.needsEscalation, isTrue);
  });

  test('F2 손상 JSON → null 폴백', () async {
    final mem = _mem();
    await mem.writeString(VocalFatigueStore.storageKey, 'not json{');
    final store = VocalFatigueStore(metadataStore: mem);
    expect(await store.load(), isNull);
  });

  test('F2 clear 후 null', () async {
    final store = VocalFatigueStore(metadataStore: _mem());
    await store.save(const VocalFatigueSelfCheck(
        tiredness: 1, discomfort: 1, poorRecovery: 1));
    await store.clear();
    expect(await store.load(), isNull);
  });
}
