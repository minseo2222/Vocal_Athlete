/// F2 — 앱 실행 경고 화면 (ADR-0001/0008 · 유일한 안전 장치).
///
/// 앱 실행당 1회 1-탭 확인. 문진/입력/연령 게이트/계정 없음.
library;

import 'package:flutter/material.dart';

/// 캐노니컬 문구(CONTEXT.md `앱 실행 경고` · ADR-0001).
const List<String> kHardStopSigns = ['통증', '어지럼', '호흡곤란', '각혈'];
const String kAgeLine = '만 18세 이상·변성기 종료 대상';
const String kDisclaimer = '의료·진단 도구가 아닙니다';
const String kWarningSentence =
    '통증·어지럼·호흡곤란·각혈이 있으면 즉시 멈추고 의료기관을 방문하세요. '
    '본 앱은 만 18세 이상·변성기 종료 대상이며, 의료·진단 도구가 아닙니다.';

class LaunchWarning extends StatelessWidget {
  const LaunchWarning({super.key, required this.onConfirm});

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0F13),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              // 마이크가 위에서 내려오는 진입 애니메이션(장식 — 추가 탭/게이트 아님).
              Center(
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: -80, end: 0),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOutCubic,
                  builder: (context, dy, child) =>
                      Transform.translate(offset: Offset(0, dy), child: child),
                  child: const Icon(Icons.mic_none,
                      key: Key('launch-mic'), color: Colors.white, size: 64),
                ),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text('Vocal Athlete',
                    key: Key('launch-logo'),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5)),
              ),
              const SizedBox(height: 28),
              const Text('시작 전 안내',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              const SizedBox(height: 16),
              const Text(
                kWarningSentence,
                style: TextStyle(
                    color: Colors.white, fontSize: 16, height: 1.6),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onConfirm,
                  child: const Text('확인'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
