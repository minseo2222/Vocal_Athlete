/// v14 — 로컬 학습 메타데이터 migration 상태와 초기화 관리.
///
/// 녹음 원음은 별도 녹음 관리 화면에서 삭제한다. 이 화면은 진행 상태,
/// 학습 evidence, 복습 큐/기록 같은 작은 메타데이터만 다룬다.
library;

import 'package:flutter/material.dart';

import '../storage/app_metadata_store.dart';
import '../theme/app_theme.dart';

class LearningDataManagementScreen extends StatefulWidget {
  const LearningDataManagementScreen({
    super.key = const Key('learning-data-management-screen'),
    required this.metadataStore,
    required this.onBack,
    required this.onCleared,
  });

  final AppMetadataStore metadataStore;
  final VoidCallback onBack;
  final VoidCallback onCleared;

  @override
  State<LearningDataManagementScreen> createState() =>
      _LearningDataManagementScreenState();
}

class _LearningDataManagementScreenState
    extends State<LearningDataManagementScreen> {
  MetadataInventory? _inventory;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final inventory = await widget.metadataStore.inventory();
    if (!mounted) return;
    setState(() => _inventory = inventory);
  }

  Future<void> _clear() async {
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Sun.elevated,
            title: const Text('전체 진행을 초기화할까요?',
                style: TextStyle(color: Sun.ink, fontSize: 17)),
            content: const Text(
              '지금까지의 모든 단계 진행과 연속 일수(streak)가 사라지고 1일차 초급부터 다시 시작합니다. '
              '학습 기록·복습 큐·복습 기록도 함께 삭제됩니다. 되돌릴 수 없습니다.\n\n'
              '녹음 원음은 삭제되지 않으며 녹음 관리에서 별도로 지울 수 있습니다.',
              style: TextStyle(color: Sun.inkMid, fontSize: 14, height: 1.45),
            ),
            actions: [
              TextButton(
                key: const Key('learning-data-clear-cancel'),
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('취소', style: TextStyle(color: Sun.inkMid)),
              ),
              FilledButton(
                key: const Key('learning-data-clear-confirm'),
                style: FilledButton.styleFrom(
                  backgroundColor: Sun.danger,
                  foregroundColor: Sun.ink,
                ),
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('전체 초기화'),
              ),
            ],
          ),
        ) ??
        false;
    if (!confirmed) return;
    setState(() => _busy = true);
    await widget.metadataStore.clearAllLearningMetadata();
    if (!mounted) return;
    setState(() {
      _busy = false;
      _inventory = const MetadataInventory(
        schemaVersion: 0,
        migrationCompleted: false,
        presentKeys: <String>[],
        quarantinedKeys: <String>[],
      );
    });
    widget.onCleared();
  }

  @override
  Widget build(BuildContext context) {
    final inventory = _inventory;
    return Scaffold(
      backgroundColor: Sun.bg,
      appBar: AppBar(
        backgroundColor: Sun.bg,
        foregroundColor: Sun.ink,
        elevation: 0,
        leading: IconButton(
          key: const Key('learning-data-back'),
          tooltip: '뒤로',
          onPressed: widget.onBack,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('학습 데이터 관리'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            '메타데이터 스키마: ${inventory?.schemaVersion ?? '확인 중'}',
            key: const Key('learning-data-schema-version'),
            style: const TextStyle(color: Sun.inkMid, fontFeatures: Sun.tnum),
          ),
          const SizedBox(height: 6),
          Text(
            inventory == null
                ? '저장소 상태 확인 중'
                : inventory.migrationCompleted
                    ? 'Async 저장소 migration 완료'
                    : 'migration 기록 없음',
            key: const Key('learning-data-migration-status'),
            style: const TextStyle(color: Sun.inkMid),
          ),
          const SizedBox(height: 6),
          Text(
            inventory == null
                ? '저장 키 확인 중'
                : '저장된 학습 영역 ${inventory.presentCount}개 · 격리된 손상 영역 ${inventory.quarantinedCount}개',
            key: const Key('learning-data-key-count'),
            style: const TextStyle(color: Sun.inkLow, fontSize: 12, fontFeatures: Sun.tnum),
          ),
          if ((inventory?.quarantinedKeys.isNotEmpty ?? false)) ...[
            const SizedBox(height: 8),
            Text(
              '격리됨: ${inventory!.quarantinedKeys.join(', ')}',
              key: const Key('learning-data-quarantine-list'),
              style: const TextStyle(color: Sun.coral, fontSize: 11),
            ),
          ],
          const SizedBox(height: 12),
          const Text(
            '이 화면은 진행 상태와 학습·복습 기록만 관리합니다. '
            '녹음 파일은 녹음 관리에서 별도로 삭제합니다.',
            style: TextStyle(color: Sun.inkLow, height: 1.5),
          ),
          const SizedBox(height: 24),
          FilledButton.tonalIcon(
            key: const Key('learning-data-clear'),
            onPressed: _busy ? null : _clear,
            style: FilledButton.styleFrom(
              backgroundColor: Sun.surfaceSoft,
              foregroundColor: Sun.ink,
              elevation: 0,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadii.pill),
                side: const BorderSide(color: Sun.hairline),
              ),
            ),
            icon: const Icon(Icons.delete_outline),
            label: Text(_busy ? '초기화 중…' : '학습 메타데이터 전체 초기화'),
          ),
        ],
      ),
    );
  }
}
