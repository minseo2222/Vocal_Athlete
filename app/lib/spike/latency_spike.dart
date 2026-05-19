/// F1 SPIKE screen (throwaway). 마이크→F0→화면 지연 측정(ADR-0013 조건부).
/// 지연 실측은 마이크 가능 시점에 — 현재 pending.
library;

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:record/record.dart';

import 'pitch_naive.dart';

class LatencySpikeScreen extends StatefulWidget {
  const LatencySpikeScreen({super.key});
  @override
  State<LatencySpikeScreen> createState() => _LatencySpikeScreenState();
}

class _LatencySpikeScreenState extends State<LatencySpikeScreen> {
  final _rec = AudioRecorder();
  StreamSubscription<Uint8List>? _sub;
  static const _sr = 16000;

  bool _running = false;
  double? _f0;
  double _lastMs = 0;
  double _avgMs = 0;
  int _frames = 0;

  Future<void> _start() async {
    if (!await _rec.hasPermission()) return;
    final stream = await _rec.startStream(
      const RecordConfig(
        encoder: AudioEncoder.pcm16bits,
        sampleRate: _sr,
        numChannels: 1,
      ),
    );
    setState(() => _running = true);
    _sub = stream.listen((bytes) {
      final tCapture = DateTime.now().microsecondsSinceEpoch;
      final pcm = bytes.buffer.asInt16List();
      final samples =
          List<double>.generate(pcm.length, (i) => pcm[i] / 32768.0);
      final f0 = estimateF0(samples, _sr);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final ms =
            (DateTime.now().microsecondsSinceEpoch - tCapture) / 1000.0;
        _frames++;
        _avgMs += (ms - _avgMs) / _frames;
        if (mounted) {
          setState(() {
            _f0 = f0;
            _lastMs = ms;
          });
        }
      });
    });
  }

  Future<void> _stop() async {
    await _sub?.cancel();
    await _rec.stop();
    if (mounted) setState(() => _running = false);
  }

  @override
  void dispose() {
    _sub?.cancel();
    _rec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0F13),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text('F1 지연 스파이크'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('마이크→F0→화면 지연 · ADR-0013 검증(throwaway)',
                  style: TextStyle(color: Colors.white38, fontSize: 12)),
              const Spacer(),
              _row('F0', _f0 == null ? '—' : '${_f0!.toStringAsFixed(1)} Hz'),
              _row('last latency', '${_lastMs.toStringAsFixed(1)} ms'),
              _row('avg latency', '${_avgMs.toStringAsFixed(1)} ms'),
              _row('frames', '$_frames'),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _running ? _stop : _start,
                  child: Text(_running ? '정지' : '시작 (마이크)'),
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
                    const TextStyle(color: Colors.white, fontSize: 20)),
          ],
        ),
      );
}
