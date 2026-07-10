/// F2 — 보컬 부하 ledger 영속화 어댑터 테스트.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/safety/vocal_load_budget.dart';
import 'package:vocal_athlete/safety/vocal_load_store.dart';
import 'package:vocal_athlete/storage/app_metadata_store.dart';

AppMetadataStore _mem() =>
    AppMetadataStore(primary: InMemoryMetadataBackend(), legacy: null);

VocalLoadLedger _busyLedger() => const VocalLoadLedger().add(
      intensity: VocalLoadIntensity.high,
      epochDay: 100,
      phonationSeconds: 120,
    );

void main() {
  test('F2 빈 저장소 → 빈 ledger', () async {
    final store = VocalLoadStore(metadataStore: _mem());
    final back = await store.load(todayEpochDay: 1);
    expect(back.points, 0);
    expect(back.sessionPhonationSeconds, 0);
  });

  test('F2 같은 날 저장→로드 round-trip', () async {
    final store = VocalLoadStore(metadataStore: _mem());
    final ledger = _busyLedger();
    await store.save(ledger, todayEpochDay: 100);
    final back = await store.load(todayEpochDay: 100);
    expect(back.points, ledger.points);
    expect(back.highCount, 1);
    expect(back.sessionPhonationSeconds, 120);
  });

  test('F2 날짜가 바뀌면 빈 ledger로 일일 리셋', () async {
    final store = VocalLoadStore(metadataStore: _mem());
    await store.save(_busyLedger(), todayEpochDay: 100);
    final back = await store.load(todayEpochDay: 101);
    expect(back.points, 0);
    expect(back.sessionPhonationSeconds, 0);
  });

  test('F2 일일 리셋 시 lastHighEpochDay는 보존(다일 회복 윈도우)', () async {
    final store = VocalLoadStore(metadataStore: _mem());
    final ledger = const VocalLoadLedger().add(
      intensity: VocalLoadIntensity.high,
      epochDay: 100,
      phonationSeconds: 120,
    );
    await store.save(ledger, todayEpochDay: 100);
    final back = await store.load(todayEpochDay: 101); // 다음 날
    expect(back.points, 0); // 카운트는 리셋
    expect(back.sessionPhonationSeconds, 0);
    expect(back.lastHighEpochDay, 100); // 회복 앵커는 보존
  });

  test('F2 손상 JSON → 빈 ledger 폴백', () async {
    final mem = _mem();
    await mem.writeString(VocalLoadStore.storageKey, 'not json{');
    final store = VocalLoadStore(metadataStore: mem);
    final back = await store.load(todayEpochDay: 1);
    expect(back.points, 0);
  });

  test('F2 clear 후 빈 ledger', () async {
    final store = VocalLoadStore(metadataStore: _mem());
    await store.save(_busyLedger(), todayEpochDay: 100);
    await store.clear();
    final back = await store.load(todayEpochDay: 100);
    expect(back.points, 0);
  });
}
