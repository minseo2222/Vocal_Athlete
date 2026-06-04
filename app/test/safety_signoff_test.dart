import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/card.dart';
import 'package:vocal_athlete/lesson/card_library.dart';
import 'package:vocal_athlete/safety/safety_signoff.dart';

void main() {
  // HITL-SIGNOFF 안전 카드(belt/트웽/cover/messa/런) — pending 집합.
  const pending = {
    'IM-02', 'IM-03', 'IM-05', 'IM-12',
    'CL-01', 'CL-08',
    'GY-04', 'GY-05', 'GY-06', 'GY-09',
  };

  test('W1.0 체크인된 기본 레코드는 비어 있음 (AI 자가 승인 0)', () {
    // 빈 레코드 = belt/cover/messa/런 전부 잠금 유지. AI가 채우면 안 됨.
    expect(kSafetySignoff, isEmpty);
  });

  test('W1.1 빈 레코드 → pending 카드 전부 잠금', () {
    expect(safetyGatedCardIds(const {}), pending);
  });

  test('W1.2 기본 게이트(레코드 인자 생략) = 빈 레코드와 동일', () {
    // 하위 호환: 기존 호출부(_enterCourse 등)는 인자 없이 호출.
    expect(safetyGatedCardIds(), pending);
  });

  test('W1.3 특정 카드 유효 사인오프 주입 → 그 카드만 해제', () {
    const record = {
      'IM-02': SafetySignoff(
        reviewer: '김발성(SLP)',
        date: '2026-06-04',
        evidence: 'HITL-SIGNOFF.md#IM-02',
      ),
    };
    final gated = safetyGatedCardIds(record);
    expect(gated.contains('IM-02'), isFalse, reason: 'IM-02 해제돼야');
    expect(gated, pending.difference({'IM-02'}),
        reason: '나머지 9개는 잠금 유지');
  });

  test('W1.4 검토자명 누락 → 무효 → 잠금 유지', () {
    const record = {
      'IM-02': SafetySignoff(
        reviewer: '', // 사람 검토자 신원 누락 = 무효
        date: '2026-06-04',
        evidence: 'HITL-SIGNOFF.md#IM-02',
      ),
    };
    expect(safetyGatedCardIds(record), pending,
        reason: '검토자명 없으면 사인오프 무효, 카드 잠금 유지');
  });

  test('W1.5 일자/근거 누락도 무효', () {
    const noDate = {
      'CL-01': SafetySignoff(
          reviewer: '김발성', date: '', evidence: 'pkt'),
    };
    const noEvidence = {
      'CL-01': SafetySignoff(
          reviewer: '김발성', date: '2026-06-04', evidence: ''),
    };
    expect(safetyGatedCardIds(noDate).contains('CL-01'), isTrue);
    expect(safetyGatedCardIds(noEvidence).contains('CL-01'), isTrue);
  });

  test('W1.6 SafetySignoff.isValid — 세 필드 모두 채워야 유효', () {
    const valid = SafetySignoff(
        reviewer: '김발성', date: '2026-06-04', evidence: 'pkt');
    expect(valid.isValid, isTrue);
    const blank = SafetySignoff(reviewer: ' ', date: ' ', evidence: ' ');
    expect(blank.isValid, isFalse, reason: '공백만 = 무효');
  });

  test('W1.7 none 카드는 사인오프와 무관하게 잠기지 않음', () {
    // pending 아닌 카드(예: CARD-01)는 게이트 대상이 아님.
    expect(safetyGatedCardIds(const {}).contains('CARD-01'), isFalse);
    expect(kCardLibrary['CARD-01']!.safetyReview, SafetyReview.none);
  });
}
