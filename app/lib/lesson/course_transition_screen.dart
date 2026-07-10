/// R3 — 코스 전이 화면.
/// 초급 완주 후 장르 선택 없이 중급 Universal Core로, Universal Core 완주 후 Repertoire Application(곡 적용 훈련)으로 이동한다.
library;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CourseTransitionScreen extends StatelessWidget {
  const CourseTransitionScreen({
    super.key = const Key('course-transition-screen'),
    required this.title,
    required this.body,
    required this.cta,
    required this.onStart,
  });

  final String title;
  final String body;
  final String cta;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) => Scaffold(
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
                const SizedBox(height: 12),
                Text(
                  body,
                  style: const TextStyle(color: Sun.ink, fontSize: 15, height: 1.45),
                ),
                const Spacer(),
                SunsetCta(
                  buttonKey: Key(cta.contains('중급')
                      ? 'start-universal-core'
                      : cta.contains('곡 적용') || cta.contains('Repertoire Application')
                          ? 'start-repertoire-application'
                          : 'course-transition-start'),
                  label: cta,
                  onPressed: onStart,
                ),
              ],
            ),
          ),
        ),
      );
}
