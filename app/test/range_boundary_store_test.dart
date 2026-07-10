/// F2 — 음역 경계 추적기 영속화 어댑터 테스트.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/safety/range_boundary_store.dart';
import 'package:vocal_athlete/safety/vocal_recovery.dart';
import 'package:vocal_athlete/storage/app_metadata_store.dart';

AppMetadataStore _mem() =>
    AppMetadataStore(primary: InMemoryMetadataBackend(), legacy: null);

BoundaryVerification _pass() => const BoundaryVerification(
      nextDayRecovered: true,
      qualityMaintained: true,
      f0StableNoFatigue: true,
    );

void main() {
  test('F2 빈 저장소 → 새 trial 추적기', () async {
    final store = RangeBoundaryStore(metadataStore: _mem());
    final t = await store.load();
    expect(t.status, BoundaryStatus.trial);
    expect(t.passStreak, 0);
  });

  test('F2 저장→로드 round-trip(승격 상태 보존)', () async {
    final store = RangeBoundaryStore(metadataStore: _mem());
    final promoted =
        const RangeBoundaryTracker().record(_pass()).record(_pass());
    await store.save(promoted);
    final back = await store.load();
    expect(back.status, BoundaryStatus.usable);
    expect(back.passStreak, 2);
  });

  test('F2 손상 JSON → 새 trial 추적기 폴백', () async {
    final mem = _mem();
    await mem.writeString(RangeBoundaryStore.storageKey, 'not json{');
    final store = RangeBoundaryStore(metadataStore: mem);
    expect((await store.load()).status, BoundaryStatus.trial);
  });
}
