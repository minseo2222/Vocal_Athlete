/// U7 — 졸업 화면 + 장르 픽커 (P8 chooseGenre 진입).
///
/// 절벽 아닌 *전이*(ADR-0010). 비구속 — 픽 결과는 호출자(_AppShell)가 라우팅.
library;

import 'package:flutter/material.dart';

import '../progression/progression_state.dart';

class GraduationScreen extends StatelessWidget {
  const GraduationScreen({super.key = const Key('graduation-screen'),
                          required this.onPick});

  final void Function(Genre) onPick;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFF0E0F13),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  '🎉 초급 완주!',
                  style: TextStyle(
                      color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                const Text(
                  '이어갈 장르를 골라요.',
                  style: TextStyle(color: Colors.white54, fontSize: 14),
                ),
                const SizedBox(height: 28),
                _GenreButton(
                    keyName: const Key('genre-musical'),
                    label: '뮤지컬',
                    onTap: () => onPick(Genre.musical)),
                const SizedBox(height: 10),
                _GenreButton(
                    keyName: const Key('genre-classical'),
                    label: '성악',
                    onTap: () => onPick(Genre.classical)),
                const SizedBox(height: 10),
                _GenreButton(
                    keyName: const Key('genre-gayo'),
                    label: '가요',
                    onTap: () => onPick(Genre.gayo)),
              ],
            ),
          ),
        ),
      );
}

class _GenreButton extends StatelessWidget {
  const _GenreButton({required this.keyName, required this.label, required this.onTap});
  final Key keyName;
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: FilledButton(
          key: keyName,
          onPressed: onTap,
          child: Text(label),
        ),
      );
}
