/// v7 — 설정 화면. 마이크 권한 상태·버전·녹음 리뷰/관리 진입점.
library;

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../theme/app_theme.dart';
import 'glossary_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key = const Key('settings-screen'),
    required this.onBack,
    this.micGranted = false,
    required this.version,
    this.onChangeGenre,
    this.onOpenStandardSamples,
    this.onOpenToneProfile,
    this.onOpenRecordingLibrary,
    this.onOpenRepertoireReview,
    this.onOpenLearningEvidence,
    this.onOpenReviewQueue,
    this.onOpenReviewEvidence,
    this.onOpenLearningDataManagement,
    this.onOpenVocalFatigueCheck,
    this.onOpenRangeBoundaryCheck,
    this.onOpenVocalScreening,
  });

  final VoidCallback onBack;
  final bool micGranted;
  final String version;

  /// 고급 장르 Lab 선택 이후에만 비-null — 장르 변경 진입점.
  final VoidCallback? onChangeGenre;
  final VoidCallback? onOpenStandardSamples;
  final VoidCallback? onOpenToneProfile;
  final VoidCallback? onOpenRecordingLibrary;
  final VoidCallback? onOpenRepertoireReview;
  final VoidCallback? onOpenLearningEvidence;
  final VoidCallback? onOpenReviewQueue;
  final VoidCallback? onOpenReviewEvidence;
  final VoidCallback? onOpenLearningDataManagement;
  final VoidCallback? onOpenVocalFatigueCheck;
  final VoidCallback? onOpenRangeBoundaryCheck;
  final VoidCallback? onOpenVocalScreening;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Sun.bg,
      appBar: AppBar(
        backgroundColor: Sun.bg,
        foregroundColor: Sun.ink,
        elevation: 0,
        leading: IconButton(
          key: const Key('settings-back'),
          tooltip: '뒤로',
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: const Text('설정', style: TextStyle(fontSize: 18)),
      ),
      body: Entrance(
        child: ListView(
          children: [
            ListTile(
              key: const Key('settings-notify'),
              title: const Text('알림', style: TextStyle(color: Sun.inkMid)),
              subtitle: const Text(
                '매일 훈련 리마인더 — 곧 추가됩니다',
                style: TextStyle(color: Sun.inkLow, fontSize: 12),
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Sun.surfaceSoft,
                  borderRadius: BorderRadius.circular(AppRadii.pill),
                  border: Border.all(color: Sun.hairline),
                ),
                child: const Text(
                  '준비 중',
                  style: TextStyle(
                    color: Sun.inkLow,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            if (widget.onOpenVocalFatigueCheck != null) ...[
              const _SectionHeader('컨디션'),
              ListTile(
                key: const Key('settings-vocal-fatigue-check'),
                title: const Text(
                  '음성 컨디션 자가점검',
                  style: TextStyle(color: Sun.ink),
                ),
                subtitle: const Text(
                  '오늘의 목 상태를 점검하고 강도 조절 신호 받기',
                  style: TextStyle(color: Sun.inkLow, fontSize: 12),
                ),
                trailing: const Icon(Icons.chevron_right, color: Sun.inkLow),
                onTap: widget.onOpenVocalFatigueCheck,
              ),
              if (widget.onOpenRangeBoundaryCheck != null)
                ListTile(
                  key: const Key('settings-range-boundary-check'),
                  title: const Text(
                    '음역 확장 기록',
                    style: TextStyle(color: Sun.ink),
                  ),
                  subtitle: const Text(
                    '새로 넓힌 음의 회복·음질·안정 점검',
                    style: TextStyle(color: Sun.inkLow, fontSize: 12),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: Sun.inkLow),
                  onTap: widget.onOpenRangeBoundaryCheck,
                ),
              if (widget.onOpenVocalScreening != null)
                ListTile(
                  key: const Key('settings-vocal-screening'),
                  title: const Text(
                    '목 건강 적신호 자가점검',
                    style: TextStyle(color: Sun.ink),
                  ),
                  subtitle: const Text(
                    '전문가 상담이 필요한 신호인지 스스로 확인',
                    style: TextStyle(color: Sun.inkLow, fontSize: 12),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: Sun.inkLow),
                  onTap: widget.onOpenVocalScreening,
                ),
            ],
            const _SectionHeader('리뷰 · 기록'),
            if (widget.onOpenStandardSamples != null)
              ListTile(
                key: const Key('settings-standard-samples'),
                title: const Text('표준샘플 리뷰', style: TextStyle(color: Sun.ink)),
                subtitle: const Text(
                  'Day 1 / 24 / 48 녹음 비교',
                  style: TextStyle(color: Sun.inkLow, fontSize: 12),
                ),
                trailing: const Icon(Icons.chevron_right, color: Sun.inkLow),
                onTap: widget.onOpenStandardSamples,
              ),
            if (widget.onOpenToneProfile != null)
              ListTile(
                key: const Key('settings-tone-profile'),
                title: const Text('내 음색 팔레트', style: TextStyle(color: Sun.ink)),
                subtitle: const Text(
                  '내가 고른 톤·편안함·Best take 요약',
                  style: TextStyle(color: Sun.inkLow, fontSize: 12),
                ),
                trailing: const Icon(Icons.chevron_right, color: Sun.inkLow),
                onTap: widget.onOpenToneProfile,
              ),
            if (widget.onOpenRepertoireReview != null)
              ListTile(
                key: const Key('settings-repertoire-review'),
                title: const Text(
                  '곡 적용 훈련 리뷰',
                  style: TextStyle(color: Sun.ink),
                ),
                subtitle: const Text(
                  '프레이즈/곡 구간 녹음 다시 듣기',
                  style: TextStyle(color: Sun.inkLow, fontSize: 12),
                ),
                trailing: const Icon(Icons.chevron_right, color: Sun.inkLow),
                onTap: widget.onOpenRepertoireReview,
              ),
            if (widget.onOpenLearningEvidence != null)
              ListTile(
                key: const Key('settings-learning-evidence'),
                title: const Text('학습 기록', style: TextStyle(color: Sun.ink)),
                subtitle: const Text(
                  '내 연습 일지 — 시도·자기점검 기록',
                  style: TextStyle(color: Sun.inkLow, fontSize: 12),
                ),
                trailing: const Icon(Icons.chevron_right, color: Sun.inkLow),
                onTap: widget.onOpenLearningEvidence,
              ),
            if (widget.onOpenReviewQueue != null)
              ListTile(
                key: const Key('settings-review-queue'),
                title: const Text('복습 큐', style: TextStyle(color: Sun.ink)),
                subtitle: const Text(
                  '앞으로 복습할 항목',
                  style: TextStyle(color: Sun.inkLow, fontSize: 12),
                ),
                trailing: const Icon(Icons.chevron_right, color: Sun.inkLow),
                onTap: widget.onOpenReviewQueue,
              ),
            if (widget.onOpenReviewEvidence != null)
              ListTile(
                key: const Key('settings-review-evidence'),
                title: const Text('복습 기록', style: TextStyle(color: Sun.ink)),
                subtitle: const Text(
                  '지난 복습 내역',
                  style: TextStyle(color: Sun.inkLow, fontSize: 12),
                ),
                trailing: const Icon(Icons.chevron_right, color: Sun.inkLow),
                onTap: widget.onOpenReviewEvidence,
              ),
            const _SectionHeader('데이터'),
            if (widget.onOpenLearningDataManagement != null)
              ListTile(
                key: const Key('settings-learning-data-management'),
                title: const Text(
                  '학습 데이터 관리',
                  style: TextStyle(color: Sun.ink),
                ),
                subtitle: const Text(
                  '진행·학습·복습 메타데이터 확인 및 초기화',
                  style: TextStyle(color: Sun.inkLow, fontSize: 12),
                ),
                trailing: const Icon(Icons.chevron_right, color: Sun.inkLow),
                onTap: widget.onOpenLearningDataManagement,
              ),
            if (widget.onOpenRecordingLibrary != null)
              ListTile(
                key: const Key('settings-recording-library'),
                title: const Text('녹음 관리', style: TextStyle(color: Sun.ink)),
                subtitle: const Text(
                  '저장량, 메타데이터 미리보기, 전체 삭제',
                  style: TextStyle(color: Sun.inkLow, fontSize: 12),
                ),
                trailing: const Icon(Icons.chevron_right, color: Sun.inkLow),
                onTap: widget.onOpenRecordingLibrary,
              ),
            if (widget.onChangeGenre != null) ...[
              const _SectionHeader('훈련'),
              ListTile(
                key: const Key('settings-change-genre'),
                title: const Text(
                  '고급 장르 Lab 변경',
                  style: TextStyle(color: Sun.ink),
                ),
                subtitle: const Text(
                  '연습할 장르를 바꿉니다',
                  style: TextStyle(color: Sun.inkLow, fontSize: 12),
                ),
                trailing: const Icon(Icons.chevron_right, color: Sun.inkLow),
                onTap: widget.onChangeGenre,
              ),
            ],
            const _SectionHeader('도움 · 정보'),
            ListTile(
              key: const Key('settings-glossary'),
              title: const Text('용어 도움말', style: TextStyle(color: Sun.ink)),
              subtitle: const Text(
                'SOVT·글라이드·A/B 등 훈련 용어 풀이',
                style: TextStyle(color: Sun.inkLow, fontSize: 12),
              ),
              trailing: const Icon(Icons.chevron_right, color: Sun.inkLow),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      GlossaryScreen(onBack: () => Navigator.of(context).pop()),
                ),
              ),
            ),
            ListTile(
              key: const Key('settings-mic-permission'),
              title: const Text('마이크 권한', style: TextStyle(color: Sun.ink)),
              subtitle: widget.micGranted
                  ? null
                  : const Text(
                      '녹음을 쓰려면 마이크 권한이 필요해요. 탭하면 기기 설정으로 이동해요.',
                      style: TextStyle(color: Sun.danger, fontSize: 12),
                    ),
              trailing: widget.micGranted
                  ? const Text('허용됨', style: TextStyle(color: Sun.inkMid))
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          '설정 열기',
                          style: TextStyle(
                            color: Sun.danger,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Icon(Icons.chevron_right, color: Sun.danger),
                      ],
                    ),
              onTap: widget.micGranted
                  ? null
                  : () {
                      // ignore: discarded_futures
                      openAppSettings();
                    },
            ),
            ListTile(
              title: const Text('버전', style: TextStyle(color: Sun.ink)),
              trailing: Text(
                widget.version,
                style: const TextStyle(
                  color: Sun.inkLow,
                  fontFeatures: Sun.tnum,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 설정 항목 그룹 구분 헤더.
class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.label);
  final String label;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 18, 16, 6),
    child: Text(
      label,
      style: const TextStyle(
        color: Sun.inkLow,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      ),
    ),
  );
}
