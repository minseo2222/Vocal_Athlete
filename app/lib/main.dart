/// 디버그 허브 (현 단계 throwaway). P1 경로 상태 표면 + F1 스파이크 진입.
/// 실제 앱 UI(채택안 D)는 U1에서 본구현.
library;

import 'package:flutter/material.dart';

import 'progression/progression_state.dart';
import 'spike/latency_spike.dart';

void main() => runApp(const DebugApp());

class DebugApp extends StatelessWidget {
  const DebugApp({super.key});
  @override
  Widget build(BuildContext context) => const MaterialApp(
        title: 'vocal_athlete (debug)',
        debugShowCheckedModeBanner: false,
        home: DebugHome(),
      );
}

class DebugHome extends StatefulWidget {
  const DebugHome({super.key});
  @override
  State<DebugHome> createState() => _DebugHomeState();
}

class _DebugHomeState extends State<DebugHome> {
  final Progression _p = Progression.beginner();
  CompleteOutcome? _last;

  @override
  Widget build(BuildContext context) {
    final p = _p;
    final s = p.todaysLesson;
    return Scaffold(
      backgroundColor: const Color(0xFF0E0F13),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('P1/P2 디버그 — 오늘 레슨 · 완료 해금',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              const SizedBox(height: 4),
              const Text('placeholder 카드 · 실배선 = C2',
                  style: TextStyle(color: Colors.white38, fontSize: 12)),
              const SizedBox(height: 24),
              _row('index', '${p.currentIndex} / ${p.total - 1}'),
              _row('cardId', s.cardId),
              _row('block', '${s.block}'),
              _row('body:voiced',
                  '${(s.bodyVoicedRatio * 100).round()}:${(100 - s.bodyVoicedRatio * 100).round()}'),
              _row('variation', s.variationLevel.name),
              _row('atEnd', '${p.atEnd}'),
              _row('graduated', '${p.graduated}'),
              _row('day', '${p.day}'),
              _row('streak', '${p.streak}'),
              _row('pendingReview', '${p.pendingReview}'),
              _row('didToday', '${p.didToday}'),
              _row('genre', p.genre?.name ?? '—'),
              _row('lastOutcome', _last?.name ?? '—'),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () =>
                      setState(() => _last = p.completeLesson()),
                  child: const Text('레슨 완료 (해금)'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(p.advanceDay),
                  style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white70),
                  child: const Text('다음날 (캡 해제)'),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => setState(() {
                    const g = Genre.values;
                    final next = p.genre == null
                        ? g.first
                        : g[(p.genre!.index + 1) % g.length];
                    p.chooseGenre(next); // 졸업 시에만 효과
                  }),
                  style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white70),
                  child: const Text('장르 순환 (졸업 후만)'),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                        builder: (_) => const LatencySpikeScreen()),
                  ),
                  style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white70),
                  child: const Text('F1 지연 스파이크 (마이크 필요 · pending)'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String k, String v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(k, style: const TextStyle(color: Colors.white54)),
            Text(v,
                style:
                    const TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
      );
}
