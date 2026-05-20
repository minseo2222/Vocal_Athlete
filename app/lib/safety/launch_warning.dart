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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text('시작 전 안내',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              const SizedBox(height: 24),
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
