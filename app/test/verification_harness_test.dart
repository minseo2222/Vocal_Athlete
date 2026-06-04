// W5 — 독립 재검증 하네스.
//
// 신규 세션이 *대화 맥락 없이* `flutter test`만 돌려도 인간 게이트 항목의 현재
// 진실을 정확히 재확인하게 한다. 두 축을 강제한다:
//   1) 코드에서 진실 재도출: 게이트==사인오프 레코드, 라우팅==롤아웃 config.
//   2) 단일 소스 정합: verification-status.json이 라이브 코드 상수와 일치.
// JSON만 올리고 코드가 안 따르면(또는 반대) 이 테스트가 실패 → 세션 독립 정확성 보장.
//
// 기기·인간 사인오프의 *내용 진위*는 사람 몫이라, 그 항목은 "기록 존재·형식"만 검증.
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/card.dart';
import 'package:vocal_athlete/lesson/card_library.dart';
import 'package:vocal_athlete/progression/progression_state.dart';
import 'package:vocal_athlete/safety/safety_signoff.dart';

void main() {
  // 단일 소스(JSON)는 repo의 docs/verification 아래. flutter test cwd=app/.
  File statusFile() {
    for (final p in [
      '../docs/verification/verification-status.json',
      'docs/verification/verification-status.json',
    ]) {
      final f = File(p);
      if (f.existsSync()) return f;
    }
    return File('../docs/verification/verification-status.json');
  }

  Map<String, dynamic> readStatus() =>
      jsonDecode(statusFile().readAsStringSync()) as Map<String, dynamic>;

  Map<String, dynamic> graduatedJson() => {
        'currentIndex': 0,
        'didToday': false,
        'day': 1,
        'graduated': true,
        'transitionDay': 0,
        'lastActiveDay': 0,
        'streak': 0,
        'pendingReview': 0,
        'genre': null,
        'maintenance': false,
        'released': <String>[],
        'lastCalendarDay': 0,
      };

  // 코드가 진실 — 라이브에서 재도출한 값들.
  Set<String> livePendingInLibrary() => {
        for (final e in kCardLibrary.entries)
          if (e.value.safetyReview == SafetyReview.pending) e.key,
      };
  Set<String> liveSignedOff() => {
        for (final e in kSafetySignoff.entries)
          if (e.value.isValid) e.key,
      };

  // --- 축 1: 코드에서 진실 재도출 ---

  test('W5.1 게이트 == 사인오프 레코드 (코드에서 재도출)', () {
    // 잠긴 카드 = pending 카드 - 유효 사인오프된 카드. 빈 레코드면 pending 전부.
    expect(safetyGatedCardIds(),
        livePendingInLibrary().difference(liveSignedOff()));
  });

  test('W5.2 라우팅 == 롤아웃 config (졸업 후 픽)', () {
    for (final g in Genre.values) {
      final p = Progression.fromJson(graduatedJson());
      p.chooseGenre(g);
      expect(p.maintenance, !kReleasedGenres.contains(g),
          reason: '$g: config↔라우팅 불일치');
    }
  });

  // --- 축 2: 단일 소스(JSON) ↔ 라이브 코드 정합 ---

  test('W5.3 단일 소스 파일이 존재하고 스키마가 맞다', () {
    expect(statusFile().existsSync(), isTrue,
        reason: 'verification-status.json 누락 — 경로/체크인 확인');
    final j = readStatus();
    expect(j['schema'], 'vocal-athlete/verification-status@1');
    expect(j['items'], isA<Map<String, dynamic>>());
    expect((j['statusEnum'] as List).cast<String>().toSet(),
        {'VERIFIED', 'UNVERIFIED', 'BLOCKED', 'OUT_OF_SCOPE'});
  });

  test('W5.4 STATUS.safetySignoff == 라이브 사인오프/게이트', () {
    final j = readStatus();
    final s = (j['items'] as Map)['safetySignoff'] as Map<String, dynamic>;
    final enumv = (j['statusEnum'] as List).cast<String>().toSet();
    expect((s['signedOffCardIds'] as List).cast<String>().toSet(),
        liveSignedOff(),
        reason: 'JSON이 주장한 사인오프와 코드(kSafetySignoff)가 불일치');
    expect((s['stillGatedCardIds'] as List).cast<String>().toSet(),
        safetyGatedCardIds(),
        reason: 'JSON이 주장한 잠금 카드와 라이브 게이트가 불일치');
    expect(enumv.contains(s['status']), isTrue);
  });

  test('W5.5 STATUS.rollout == 라이브 롤아웃 config', () {
    final j = readStatus();
    final r = (j['items'] as Map)['rollout'] as Map<String, dynamic>;
    final enumv = (j['statusEnum'] as List).cast<String>().toSet();
    expect((r['releasedGenres'] as List).cast<String>().toSet(),
        kReleasedGenres.map((g) => g.name).toSet(),
        reason: 'JSON이 주장한 출시 장르와 코드(kReleasedGenres)가 불일치');
    expect((r['allGenres'] as List).cast<String>().toSet(),
        Genre.values.map((g) => g.name).toSet());
    expect(enumv.contains(r['status']), isTrue);
  });

  test('W5.6 기기·고급 항목은 기록 존재·형식만 검증(진위는 사람)', () {
    final j = readStatus();
    final items = j['items'] as Map<String, dynamic>;
    final enumv = (j['statusEnum'] as List).cast<String>().toSet();
    for (final k in ['deviceMic', 'advancedTrack']) {
      final it = items[k] as Map<String, dynamic>;
      expect(enumv.contains(it['status']), isTrue, reason: '$k status enum 위반');
      expect((it['source'] as String).trim(), isNotEmpty,
          reason: '$k source 누락');
    }
  });
}
