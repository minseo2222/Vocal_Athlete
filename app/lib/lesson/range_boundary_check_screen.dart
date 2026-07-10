/// F2 — 음역 경계 확장 자가기록 화면.
///
/// 새 경계음의 3중 검증(다음날 회복·음질 유지·F0 안정)을 매 시도 기록한다.
/// 연속 충족 시 trial→usable 승격, 같은 부위 통증 재발 시 확장 중단을 안내한다.
/// 점수가 아니라 안전한 확장을 위한 자기기록·게이트 신호다.
library;

import 'package:flutter/material.dart';

import '../safety/vocal_recovery.dart';
import '../theme/app_theme.dart';

const _kPainAreas = ['목', '턱', '가슴', '기타'];

class RangeBoundaryCheckScreen extends StatefulWidget {
  const RangeBoundaryCheckScreen({
    super.key = const Key('range-boundary-screen'),
    required this.tracker,
    required this.onBack,
    required this.onRecord,
  });

  final RangeBoundaryTracker tracker;
  final VoidCallback onBack;
  final ValueChanged<BoundaryVerification> onRecord;

  @override
  State<RangeBoundaryCheckScreen> createState() =>
      _RangeBoundaryCheckScreenState();
}

class _RangeBoundaryCheckScreenState extends State<RangeBoundaryCheckScreen> {
  bool _recovered = true;
  bool _quality = true;
  bool _f0Stable = true;
  String _painArea = _kPainAreas.first;

  void _record() {
    widget.onRecord(
      BoundaryVerification(
        nextDayRecovered: _recovered,
        qualityMaintained: _quality,
        f0StableNoFatigue: _f0Stable,
        // 회복됐으면 통증 부위 없음. 회복 안 됐을 때만 부위를 기록한다.
        painArea: _recovered ? null : _painArea,
      ),
    );
  }

  String _statusText(RangeBoundaryTracker t) => switch (t.status) {
    BoundaryStatus.trial =>
      '시도 중 — 연속 ${t.passStreak}/$kPromotionStreak회 충족 시 사용 음역으로 승격',
    BoundaryStatus.usable => '✅ 사용 가능한 음역으로 승격되었습니다',
    BoundaryStatus.stopped =>
      '⛔ 확장 중단 — ${t.recommendedDeloadHours}시간 경감 권장. 통증이 가시면 천천히 다시.',
  };

  @override
  Widget build(BuildContext context) {
    final t = widget.tracker;
    final stopped = t.status == BoundaryStatus.stopped;
    return Scaffold(
      backgroundColor: Sun.bg,
      appBar: AppBar(
        backgroundColor: Sun.bg,
        foregroundColor: Sun.ink,
        elevation: 0,
        leading: IconButton(
          key: const Key('rb-back'),
          tooltip: '뒤로',
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack,
        ),
        title: const Text('음역 확장 기록', style: TextStyle(fontSize: 18)),
      ),
      body: Entrance(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          children: [
            Container(
              key: const Key('rb-status'),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: stopped ? Sun.surfaceSoft : Sun.mintSoft,
                borderRadius: BorderRadius.circular(AppRadii.card),
                border: Border.all(color: Sun.hairline),
              ),
              child: Text(
                _statusText(t),
                style: TextStyle(
                  color: stopped ? Sun.danger : Sun.mint,
                  fontSize: 13,
                  height: 1.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '새로 넓힌 경계음을 오늘 점검합니다. 점수가 아니라 안전한 확장을 위한 기록입니다.',
              style: TextStyle(color: Sun.inkLow, fontSize: 12, height: 1.45),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: Sun.card(),
              child: Material(
                type: MaterialType.transparency,
                child: Column(
                  children: [
                    SwitchListTile(
                      key: const Key('rb-recovered'),
                      value: _recovered,
                      onChanged: stopped
                          ? null
                          : (v) => setState(() => _recovered = v),
                      title: const Text(
                        '다음날 통증·이물감 없이 회복됨',
                        style: TextStyle(color: Sun.ink, fontSize: 14),
                      ),
                    ),
                    if (!_recovered)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            spacing: 8,
                            children: [
                              for (final area in _kPainAreas)
                                ChoiceChip(
                                  key: Key('rb-area-$area'),
                                  label: Text(area),
                                  selected: _painArea == area,
                                  onSelected: (_) =>
                                      setState(() => _painArea = area),
                                ),
                            ],
                          ),
                        ),
                      ),
                    SwitchListTile(
                      key: const Key('rb-quality'),
                      value: _quality,
                      onChanged: stopped
                          ? null
                          : (v) => setState(() => _quality = v),
                      title: const Text(
                        '음질이 유지됨(거칠거나 새지 않음)',
                        style: TextStyle(color: Sun.ink, fontSize: 14),
                      ),
                    ),
                    SwitchListTile(
                      key: const Key('rb-f0'),
                      value: _f0Stable,
                      onChanged: stopped
                          ? null
                          : (v) => setState(() => _f0Stable = v),
                      title: const Text(
                        '음정이 안정적이고 피로하지 않음',
                        style: TextStyle(color: Sun.ink, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SunsetCta(
              buttonKey: const Key('rb-record'),
              label: '오늘 기록',
              disabled: stopped,
              onPressed: stopped ? null : _record,
            ),
          ],
        ),
      ),
    );
  }
}
