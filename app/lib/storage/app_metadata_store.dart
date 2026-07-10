/// v14 — 학습 메타데이터 저장소와 legacy → async 무손실 migration.
///
/// SharedPreferences는 진행 상태와 학습 흔적 같은 작은 로컬 메타데이터에만
/// 사용한다. 녹음 원음, 계정 비밀정보, 의료정보의 저장소가 아니다.
library;

import 'package:shared_preferences/shared_preferences.dart';

abstract interface class MetadataBackend {
  Future<String?> getString(String key);
  Future<int?> getInt(String key);
  Future<bool> containsKey(String key);
  Future<void> setString(String key, String value);
  Future<void> setInt(String key, int value);
  Future<void> remove(String key);
}

class SharedPreferencesAsyncMetadataBackend implements MetadataBackend {
  SharedPreferencesAsyncMetadataBackend({SharedPreferencesAsync? preferences})
      : _preferences = preferences ?? SharedPreferencesAsync();

  final SharedPreferencesAsync _preferences;

  @override
  Future<String?> getString(String key) => _preferences.getString(key);

  @override
  Future<int?> getInt(String key) => _preferences.getInt(key);

  @override
  Future<bool> containsKey(String key) => _preferences.containsKey(key);

  @override
  Future<void> setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  @override
  Future<void> setInt(String key, int value) async {
    await _preferences.setInt(key, value);
  }

  @override
  Future<void> remove(String key) async {
    await _preferences.remove(key);
  }
}

class LegacySharedPreferencesMetadataBackend implements MetadataBackend {
  LegacySharedPreferencesMetadataBackend({
    Future<SharedPreferences> Function()? preferencesFactory,
  }) : _preferencesFactory =
            preferencesFactory ?? SharedPreferences.getInstance;

  final Future<SharedPreferences> Function() _preferencesFactory;

  @override
  Future<String?> getString(String key) async =>
      (await _preferencesFactory()).getString(key);

  @override
  Future<int?> getInt(String key) async =>
      (await _preferencesFactory()).getInt(key);

  @override
  Future<bool> containsKey(String key) async =>
      (await _preferencesFactory()).containsKey(key);

  @override
  Future<void> setString(String key, String value) async {
    await (await _preferencesFactory()).setString(key, value);
  }

  @override
  Future<void> setInt(String key, int value) async {
    await (await _preferencesFactory()).setInt(key, value);
  }

  @override
  Future<void> remove(String key) async {
    await (await _preferencesFactory()).remove(key);
  }
}

class InMemoryMetadataBackend implements MetadataBackend {
  InMemoryMetadataBackend([Map<String, Object>? seed])
      : _values = <String, Object>{...?seed};

  final Map<String, Object> _values;

  Map<String, Object> get snapshot => Map<String, Object>.unmodifiable(_values);

  @override
  Future<String?> getString(String key) async => _values[key] as String?;

  @override
  Future<int?> getInt(String key) async => _values[key] as int?;

  @override
  Future<bool> containsKey(String key) async => _values.containsKey(key);

  @override
  Future<void> setString(String key, String value) async {
    _values[key] = value;
  }

  @override
  Future<void> setInt(String key, int value) async {
    _values[key] = value;
  }

  @override
  Future<void> remove(String key) async {
    _values.remove(key);
  }
}

class MetadataMigrationReport {
  const MetadataMigrationReport({
    required this.schemaVersion,
    required this.migratedKeys,
  });

  final int schemaVersion;
  final List<String> migratedKeys;
}


class MetadataInventory {
  const MetadataInventory({
    required this.schemaVersion,
    required this.migrationCompleted,
    required this.presentKeys,
    required this.quarantinedKeys,
  });

  final int schemaVersion;
  final bool migrationCompleted;
  final List<String> presentKeys;
  final List<String> quarantinedKeys;

  int get presentCount => presentKeys.length;
  int get quarantinedCount => quarantinedKeys.length;
}

/// `legacy` 인자 미전달과 명시적 `null`(레거시 백엔드 없음)을 구분하기 위한 sentinel.
const Object _legacyUnset = Object();

class AppMetadataStore {
  AppMetadataStore({
    MetadataBackend? primary,
    Object? legacy = _legacyUnset,
  })  : primary = primary ?? SharedPreferencesAsyncMetadataBackend(),
        legacy = identical(legacy, _legacyUnset)
            ? LegacySharedPreferencesMetadataBackend()
            : legacy as MetadataBackend?;

  static const int currentSchemaVersion = 2;
  static const String schemaVersionKey = 'app_metadata_schema_version';
  static const String migrationCompletedKey = 'app_metadata_migrated_v14';

  static const Set<String> knownDataKeys = <String>{
    'progression_v1',
    'learning_evidence_v1',
    'review_queue_v1',
    'review_evidence_v1',
  };

  static final AppMetadataStore shared = AppMetadataStore();

  final MetadataBackend primary;
  final MetadataBackend? legacy;
  final Set<String> _migrationAttempted = <String>{};

  String corruptBackupKey(String key) => '${key}_corrupt_backup_v14';

  Future<String?> readString(String key) async {
    final current = await primary.getString(key);
    if (current != null) return current;

    final oldStore = legacy;
    if (oldStore == null || !_migrationAttempted.add(key)) return null;
    final old = await oldStore.getString(key);
    if (old == null) return null;

    await primary.setString(key, old);
    await oldStore.remove(key);
    return old;
  }

  Future<void> writeString(String key, String value) =>
      primary.setString(key, value);

  Future<void> remove(String key) async {
    await primary.remove(key);
    await legacy?.remove(key);
  }

  Future<void> quarantineCorruptValue(String key, String raw) async {
    await primary.setString(corruptBackupKey(key), raw);
    await primary.remove(key);
    await legacy?.remove(key);
  }

  Future<MetadataMigrationReport> migrateKnownKeys() async {
    final migrated = <String>[];
    for (final key in knownDataKeys) {
      final existedInPrimary = await primary.containsKey(key);
      final value = await readString(key);
      if (!existedInPrimary && value != null) migrated.add(key);
    }
    await primary.setInt(schemaVersionKey, currentSchemaVersion);
    await primary.setInt(migrationCompletedKey, 1);
    return MetadataMigrationReport(
      schemaVersion: currentSchemaVersion,
      migratedKeys: List<String>.unmodifiable(migrated),
    );
  }

  Future<int> schemaVersion() async =>
      await primary.getInt(schemaVersionKey) ?? 0;

  Future<bool> migrationCompleted() async =>
      (await primary.getInt(migrationCompletedKey) ?? 0) == 1;

  Future<MetadataInventory> inventory() async {
    final present = <String>[];
    final quarantined = <String>[];
    for (final key in knownDataKeys) {
      if (await primary.containsKey(key)) present.add(key);
      if (await primary.containsKey(corruptBackupKey(key))) {
        quarantined.add(key);
      }
    }
    present.sort();
    quarantined.sort();
    return MetadataInventory(
      schemaVersion: await schemaVersion(),
      migrationCompleted: await migrationCompleted(),
      presentKeys: List<String>.unmodifiable(present),
      quarantinedKeys: List<String>.unmodifiable(quarantined),
    );
  }

  Future<void> clearAllLearningMetadata() async {
    for (final key in knownDataKeys) {
      await remove(key);
      await primary.remove(corruptBackupKey(key));
    }
    await primary.remove(schemaVersionKey);
    await primary.remove(migrationCompletedKey);
  }
}
