/// U7 — 단계 전이 화면.
///
/// R4: 초급 완주 직후 장르 픽커를 없애고 Universal Vocal Core로 보낸다.
/// 장르 선택은 곡 적용 훈련 완주 후 Advanced Genre Lab에서 열린다.
library;

import 'package:flutter/material.dart';

import '../progression/progression_state.dart';
import '../theme/app_theme.dart';

class GraduationScreen extends StatelessWidget {
  const GraduationScreen({
    super.key = const Key('graduation-screen'),
    required this.progression,
    required this.onStartUniversalCore,
    required this.onStartRepertoireApplication,
    required this.onPick,
  });

  final Progression progression;
  final VoidCallback onStartUniversalCore;
  final VoidCallback onStartRepertoireApplication;
  final void Function(Genre) onPick;

  @override
  Widget build(BuildContext context) {
    final p = progression;
    if (p.canStartUniversalCore) {
      return _TransitionScaffold(
        title: '🎉 초급 완주!',
        subtitle: '이제 모든 장르에 필요한 중급 공통 코어로 이어갑니다.',
        children: [
          _ActionButton(
            keyName: const Key('start-universal-core'),
            label: '중급 공통 코어 시작',
            onTap: onStartUniversalCore,
          ),
        ],
      );
    }
    if (p.canStartRepertoireApplication) {
      return _TransitionScaffold(
        title: '🎉 중급 공통 코어 완주!',
        subtitle: '이제 배운 호흡·발성·음정·리듬·음색을 짧은 프레이즈와 곡 구간에 연결합니다.',
        children: [
          _ActionButton(
            keyName: const Key('start-repertoire-application'),
            label: '곡 적용 훈련 시작',
            onTap: onStartRepertoireApplication,
          ),
        ],
      );
    }
    return _TransitionScaffold(
      title: '🎉 곡 적용 훈련 완주!',
      subtitle:
          '연습할 고급 장르 Lab을 선택하세요. "준비 중" Lab을 고르면, 열릴 때까지 지금 실력을 가볍게 유지하는 훈련을 이어갑니다.',
      children: [
        _GenreButton(
            keyName: const Key('genre-gayo'),
            emoji: '🎤',
            label: '가요 / K-pop',
            comingSoon: !p.isReleased(Genre.gayo),
            onTap: () => onPick(Genre.gayo)),
        const SizedBox(height: 10),
        _GenreButton(
            keyName: const Key('genre-musical'),
            emoji: '🎭',
            label: '뮤지컬',
            comingSoon: !p.isReleased(Genre.musical),
            onTap: () => onPick(Genre.musical)),
        const SizedBox(height: 10),
        _GenreButton(
            keyName: const Key('genre-classical'),
            emoji: '🎼',
            label: '성악',
            comingSoon: !p.isReleased(Genre.classical),
            onTap: () => onPick(Genre.classical)),
        const SizedBox(height: 10),
        _GenreButton(
            keyName: const Key('genre-rb-soul'),
            emoji: '🎷',
            label: 'R&B / Soul',
            comingSoon: !p.isReleased(Genre.rbSoul),
            onTap: () => onPick(Genre.rbSoul)),
        const SizedBox(height: 10),
        _GenreButton(
            keyName: const Key('genre-rock-band'),
            emoji: '🎸',
            label: 'Rock / Band',
            comingSoon: !p.isReleased(Genre.rockBand),
            onTap: () => onPick(Genre.rockBand)),
        const SizedBox(height: 10),
        _GenreButton(
            keyName: const Key('genre-ccm'),
            emoji: '🙏',
            label: 'CCM',
            comingSoon: !p.isReleased(Genre.ccm),
            onTap: () => onPick(Genre.ccm)),
        const SizedBox(height: 10),
        _GenreButton(
            keyName: const Key('genre-user-song'),
            emoji: '🎙️',
            label: '내 곡 프로젝트',
            comingSoon: !p.isReleased(Genre.userSong),
            onTap: () => onPick(Genre.userSong)),
      ],
    );
  }
}

class _TransitionScaffold extends StatelessWidget {
  const _TransitionScaffold({
    required this.title,
    required this.subtitle,
    required this.children,
  });
  final String title;
  final String subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Scaffold(
        key: const Key('course-transition-screen'),
        backgroundColor: Sun.bg,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Sun.ink,
                      fontSize: 22,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(color: Sun.inkMid, fontSize: 14),
                ),
                const SizedBox(height: 28),
                ...children,
              ],
            ),
          ),
        ),
      );
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.keyName, required this.label, required this.onTap});
  final Key keyName;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: SunsetCta(
          buttonKey: keyName,
          label: label,
          onPressed: onTap,
        ),
      );
}

class _GenreButton extends StatelessWidget {
  const _GenreButton({
    required this.keyName,
    required this.emoji,
    required this.label,
    required this.onTap,
    this.comingSoon = false,
  });
  final Key keyName;
  final String emoji;
  final String label;
  final VoidCallback onTap;
  final bool comingSoon;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: FilledButton(
          key: keyName,
          onPressed: onTap,
          style: FilledButton.styleFrom(
            backgroundColor: Sun.surface,
            foregroundColor: comingSoon ? Sun.inkMid : Sun.ink,
            elevation: 0,
            minimumSize: const Size.fromHeight(54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.pill),
              side: const BorderSide(color: Sun.hairline),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$emoji '),
              Text(label),
              if (comingSoon) ...[
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
              ],
            ],
          ),
        ),
      );
}
