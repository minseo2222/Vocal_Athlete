/// Task 5(A1) — 실 마이크 PitchSource 골격 (ADR-0014 pYIN 자리).
///
/// PCM 프레임 stream을 주입받아 각 프레임을 F0 검출 → PitchReading으로 변환.
/// 실 마이크 캡처(권한·오디오 패키지)는 이 `frames` stream을 채우는 *어댑터*가
/// 담당 — 본 클래스는 패키지 의존 없이 변환·라이프사이클만 책임(테스트 가능).
/// 골전도 착각 차단: 출력은 시각용 F0뿐(ADR-0014 honest, 저신뢰=null).
library;

import 'f0.dart';
import 'pitch_source.dart';

class MicPitchSource implements PitchSource {
  MicPitchSource({required this.frames, this.sampleRate = 16000});

  /// 마이크에서 들어오는 모노 PCM 프레임(정규화 [-1,1]).
  final Stream<List<double>> frames;
  final int sampleRate;

  @override
  Stream<PitchReading> get readings async* {
    var t = 0.0;
    await for (final frame in frames) {
      yield PitchReading(
        f0Hz: estimateF0(frame, sampleRate),
        timestampSec: t,
      );
      t += frame.length / sampleRate;
    }
  }

  // 실 마이크 캡처 시작/정지는 frames 어댑터가 처리 — 골격은 no-op success.
  // 권한 요청도 어댑터 책임(start가 Future<bool>인 이유).
  @override
  Future<bool> start() async => true;

  @override
  Future<void> stop() async {}

  @override
  Future<void> dispose() async {}
}
