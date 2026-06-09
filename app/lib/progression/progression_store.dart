/// Task 2 — Progression 영속화 어댑터 (shared_preferences).
///
/// Progression(순수) ↔ 디스크 사이의 seam. 저장은 JSON 문자열 1개.
library;

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'progression_state.dart';

class ProgressionStore {
  static const _key = 'progression_v1';

  /// 저장된 진행 상태 복원. 없으면 null.
  Future<Progression?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_key);
    if (s == null) return null;
    try {
      return Progression.fromJson(jsonDecode(s) as Map<String, dynamic>);
    } catch (_) {
      return null; // 손상된 저장본 → 신규로 안전 폴백(예외 전파 ❌)
    }
  }

  Future<void> save(Progression p) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(p.toJson()));
  }
}
