/// v7 — 녹음 라이브러리 관리 화면.
///
/// 모든 표준샘플·음색 A/B·곡 적용 훈련·포트폴리오 take를 local-first로
/// 요약하고, metadata-only export preview와 전체 삭제 진입점을 제공한다.
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../recording/recording_ab.dart';
import '../recording/recording_library.dart';
import '../theme/app_theme.dart';

class RecordingLibraryScreen extends StatefulWidget {
  const RecordingLibraryScreen({
    required this.onBack,
    this.repository,
    super.key = const Key('recording-library-screen'),
  });

  final VoidCallback onBack;
  final RecordingRepository? repository;

  @override
  State<RecordingLibraryScreen> createState() => _RecordingLibraryScreenState();
}

class _RecordingLibraryScreenState extends State<RecordingLibraryScreen> {
  RecordingLibrarySummary? _summary;
  String? _exportPreview;
  bool _loaded = false;
  bool _clearing = false;

  RecordingLibraryService? get _service {
    final repo = widget.repository;
    if (repo == null) return null;
    return RecordingLibraryService(repo);
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final service = _service;
    final summary = service == null
        ? const RecordingLibrarySummary(
            totalTakes: 0,
            totalBytes: 0,
            countByPurpose: {},
            bytesByPurpose: {},
            oldestEpochMs: 0,
            newestEpochMs: 0,
          )
        : await service.summarize();
    if (!mounted) return;
    setState(() {
      _summary = summary;
      _loaded = true;
    });
  }

  Future<void> _buildExportPreview() async {
    final service = _service;
    if (service == null) return;
    final json = await service.exportManifestJson(includeLocalPaths: false);
    if (!mounted) return;
    setState(() => _exportPreview = json);
  }

  Future<void> _clearAll() async {
    final service = _service;
    if (service == null || _clearing) return;
    final confirmed = await confirmDestructive(
      context,
      title: '모든 녹음을 삭제할까요?',
      message: '앱에 저장된 보컬 녹음이 모두 영구 삭제됩니다. 되돌릴 수 없습니다.',
      confirmLabel: '전체 삭제',
      confirmKey: const Key('recording-library-clear-confirm'),
      cancelKey: const Key('recording-library-clear-cancel'),
    );
    if (!confirmed || !mounted) return;
    setState(() => _clearing = true);
    await service.clearAll();
    if (!mounted) return;
    setState(() {
      _exportPreview = null;
      _clearing = false;
    });
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    final summary = _summary;
    return Scaffold(
      backgroundColor: Sun.bg,
      appBar: AppBar(
        backgroundColor: Sun.bg,
        foregroundColor: Sun.ink,
        elevation: 0,
        leading: IconButton(
          key: const Key('recording-library-back'),
          tooltip: '뒤로',
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: const Text('녹음 관리', style: TextStyle(fontSize: 18)),
      ),
      body: Entrance(
        child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          const Text(
            '앱 안에 저장된 보컬 녹음을 관리합니다. 서버 업로드, 공개 공유, 모델 학습 업로드는 포함하지 않습니다.',
            style: TextStyle(color: Sun.inkMid, fontSize: 13, height: 1.35),
          ),
          const SizedBox(height: 16),
          if (!_loaded || summary == null)
            const SkeletonList(rows: 3, shrinkWrap: true)
          else ...[
            _SummaryCard(summary: summary),
            const SizedBox(height: 12),
            _PurposeRows(summary: summary),
            const SizedBox(height: 16),
            SunsetCta(
              buttonKey: const Key('recording-library-export-preview'),
              label: '메타데이터 내보내기 미리보기',
              disabled: summary.isEmpty || widget.repository == null,
              onPressed: summary.isEmpty || widget.repository == null ? null : _buildExportPreview,
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              key: const Key('recording-library-clear-all'),
              onPressed: summary.isEmpty || widget.repository == null
                  ? null
                  : () {
                      HapticFeedback.lightImpact();
                      _clearAll();
                    },
              child: Text(_clearing ? '삭제 중...' : '모든 로컬 녹음 삭제'),
            ),
            const SizedBox(height: 16),
            if (_exportPreview != null)
              Container(
                key: const Key('recording-library-export-json'),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Sun.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Sun.hairline),
                ),
                child: SelectableText(
                  _exportPreview!,
                  style: const TextStyle(color: Sun.inkMid, fontSize: 11, height: 1.25),
                ),
              ),
          ],
        ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.summary});
  final RecordingLibrarySummary summary;

  @override
  Widget build(BuildContext context) => Container(
        key: const Key('recording-library-summary'),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Sun.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Sun.hairline),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('로컬 녹음 요약',
                style: TextStyle(
                    color: Sun.inkMid,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.0)),
            const SizedBox(height: 8),
            Text('총 ${summary.totalTakes}개 · ${formatRecordingBytes(summary.totalBytes)}',
                key: const Key('recording-library-total'),
                style: const TextStyle(
                    color: Sun.ink, fontSize: 13, fontFeatures: Sun.tnum)),
            const SizedBox(height: 6),
            const Text('삭제하면 로컬 오디오 파일과 메타데이터가 함께 삭제됩니다.',
                style: TextStyle(color: Sun.inkLow, fontSize: 12, height: 1.35)),
          ],
        ),
      );
}

class _PurposeRows extends StatelessWidget {
  const _PurposeRows({required this.summary});
  final RecordingLibrarySummary summary;

  @override
  Widget build(BuildContext context) => Container(
        key: const Key('recording-library-purpose-rows'),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Sun.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Sun.hairline),
        ),
        child: Column(
          children: [
            for (final purpose in RecordingPurpose.values)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(purpose.label,
                          style: const TextStyle(color: Sun.ink, fontSize: 13)),
                    ),
                    Text('${summary.countFor(purpose)}개 · ${formatRecordingBytes(summary.bytesFor(purpose))}',
                        key: Key('recording-library-purpose-${purpose.name}'),
                        style: const TextStyle(
                            color: Sun.inkLow,
                            fontSize: 12,
                            fontFeatures: Sun.tnum)),
                  ],
                ),
              ),
          ],
        ),
      );
}
