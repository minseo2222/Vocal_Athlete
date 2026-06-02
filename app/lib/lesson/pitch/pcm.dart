/// A1 — PCM16 디코딩 (순수). 마이크 바이트 → 정규화 샘플.
library;

import 'dart:typed_data';

/// 리틀엔디언 int16 PCM 바이트를 [-1,1] 정규화 double 샘플로 변환.
/// 홀수 바이트 꼬리는 버림.
List<double> pcm16ToSamples(Uint8List bytes) {
  final n = bytes.length ~/ 2;
  final out = List<double>.filled(n, 0);
  final bd = bytes.buffer.asByteData(bytes.offsetInBytes);
  for (var i = 0; i < n; i++) {
    out[i] = bd.getInt16(i * 2, Endian.little) / 32768.0;
  }
  return out;
}
