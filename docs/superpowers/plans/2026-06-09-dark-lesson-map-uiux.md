# 다크 레슨맵 UI/UX 구현 계획

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 전 화면 다크 레슨맵 톤으로 폴리시하고, 홈을 여정 맵으로 재구성한다(탭 불가, 오늘 노드만 시작).

**Architecture:** 색상/간격을 `app_theme.dart` 토큰으로 추출(픽셀 동일 치환) → 홈의 5블록 바를 `LessonMap` 위젯으로 교체 → 레슨·졸업·설정 폴리시 → 테스트-안전한(설정 가능, 한 번에 끝나는) 마이크로애니메이션. 기존 위젯 Key·동작 보존, 마이크/피치/진행/안전 코드 불변.

**Tech Stack:** Flutter 3.44 / Dart 3.12, flutter_test 위젯 테스트, 기존 `Progression`/`Card` 모델.

---

## 파일 구조

- Create: `app/lib/theme/app_theme.dart` — 색·간격·라운드 토큰(`AppColors`, `AppRadii`).
- Create: `app/lib/lesson/lesson_map.dart` — 홈 여정 맵 위젯(`LessonMap`).
- Create: `app/test/lesson_map_widget_test.dart` — 맵 노드 상태/탭불가 테스트.
- Modify: `app/lib/progression/progression_state.dart` — `slots` 읽기 getter 추가.
- Modify: `app/lib/lesson/home_screen.dart` — 5블록 바 → `LessonMap`, 토큰 적용.
- Modify: `app/test/home_screen_widget_test.dart` — H3 갱신(blocks → map).
- Modify: `app/lib/lesson/lesson_screen.dart` — 토큰·스테퍼 강조·cue 페이드·피치 자리표시.
- Modify: `app/lib/lesson/graduation_screen.dart`, `settings_screen.dart` — 토큰 적용.
- Modify: `app/lib/lesson/pitch/pitch_display.dart` — 토큰 적용(색만).

**검증 명령(공통):**
- 단일 테스트: `C:/src/flutter/bin/flutter.bat test test/<file>.dart`
- 전체: `C:/src/flutter/bin/flutter.bat test` (현재 159 green)
- analyze: `C:/src/flutter/bin/flutter.bat analyze` (작업 디렉터리 `app/`)

---

## Task 1: 디자인 토큰 (`app_theme.dart`) — 회귀 안전 치환

**Files:**
- Create: `app/lib/theme/app_theme.dart`
- Modify: `app/lib/lesson/home_screen.dart` (색 리터럴 → 토큰)
- Test: 기존 `test/home_screen_widget_test.dart` (변경 없음, 회귀 가드)

순수 리팩터(동작·픽셀 불변) → TDD 예외: 기존 테스트가 before/after green이면 통과.

- [ ] **Step 1: 토큰 파일 생성**

```dart
// app/lib/theme/app_theme.dart
/// 앱 공통 색·라운드 토큰. 화면 전역 하드코딩 색을 1곳으로.
library;

import 'package:flutter/material.dart';

class AppColors {
  static const bg = Color(0xFF0E0F13);       // 배경
  static const surface = Color(0xFF171922);  // 카드/시트
  static const surfaceAlt = Color(0xFF222637); // pill
  static const done = Color(0xFF39D98A);     // 완료(green)
  static const now = Color(0xFF6C8CFF);      // 현재(blue)
  static const locked = Color(0xFF3A3F55);   // 잠금/미래
  static const lockedSurface = Color(0xFF2C3142);
  static const textHi = Colors.white;
  static const textMid = Colors.white60;
  static const textLow = Colors.white38;
}

class AppRadii {
  static const card = 12.0;
  static const sheet = 22.0;
  static const pill = 999.0;
}
```

- [ ] **Step 2: 전체 테스트 green 확인(치환 전 기준선)**

Run: `C:/src/flutter/bin/flutter.bat test`
Expected: All tests passed! (159)

- [ ] **Step 3: home_screen.dart 색 리터럴을 토큰으로 치환**

`home_screen.dart` 상단에 `import '../theme/app_theme.dart';` 추가 후, 색 리터럴 1:1 치환(값 동일):
`Color(0xFF0E0F13)`→`AppColors.bg`, `Color(0xFF171922)`→`AppColors.surface`,
`Color(0xFF39D98A)`→`AppColors.done`, `Color(0xFF6C8CFF)`→`AppColors.now`,
`Color(0xFF3A3F55)`→`AppColors.locked`, `Colors.white60`→`AppColors.textMid`,
`Colors.white38`→`AppColors.textLow`. **레이아웃/텍스트/키 변경 없음.**

- [ ] **Step 4: 전체 테스트 + analyze green 확인(치환 후 동일)**

Run: `C:/src/flutter/bin/flutter.bat test` → All tests passed! (159)
Run: `C:/src/flutter/bin/flutter.bat analyze` → No issues found!

- [ ] **Step 5: Commit**

```bash
git add app/lib/theme/app_theme.dart app/lib/lesson/home_screen.dart
git commit -m "UI1 — 디자인 토큰 app_theme.dart 추출 + 홈 치환(픽셀 동일)"
git push
```

---

## Task 2: 홈 여정 맵 (`LessonMap`) — 5블록 바 교체

**Files:**
- Modify: `app/lib/progression/progression_state.dart` (slots getter)
- Create: `app/lib/lesson/lesson_map.dart`
- Create: `app/test/lesson_map_widget_test.dart`
- Modify: `app/lib/lesson/home_screen.dart` (`_ProgressBlocks` → `LessonMap`)
- Modify: `app/test/home_screen_widget_test.dart` (H3 갱신)

- [ ] **Step 1: Progression에 slots getter 추가 (먼저, 맵이 블록 정보 필요)**

`progression_state.dart`의 `int get total => _manifest.length;` 아래에 추가:

```dart
  /// UI — 여정 맵용 읽기 전용 슬롯 뷰(블록·인덱스 표시).
  List<PathSlot> get slots => List.unmodifiable(_manifest);
```

- [ ] **Step 2: 실패 테스트 작성 — 맵 노드 상태 매핑**

```dart
// app/test/lesson_map_widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/lesson_map.dart';
import 'package:vocal_athlete/progression/progression_state.dart';
import 'package:vocal_athlete/progression/path.dart';

void main() {
  Widget host(Progression p) => MaterialApp(
        home: Scaffold(body: LessonMap(progression: p)),
      );

  testWidgets('LM1 맵 렌더 + 섹션 라벨(토대·졸업) 존재', (tester) async {
    await tester.pumpWidget(host(Progression.beginner()));
    expect(find.byKey(const Key('lesson-map')), findsOneWidget);
    expect(find.text('토대'), findsOneWidget);
    expect(find.text('졸업'), findsOneWidget);
  });

  testWidgets('LM2 완료/오늘/미래 노드 수 = currentIndex 정합', (tester) async {
    final p = Progression.from(buildPlaceholderManifest(), currentIndex: 3);
    await tester.pumpWidget(host(p));
    // 완료 노드 3개(인덱스 0..2), 오늘 1개(인덱스 3).
    expect(find.byKey(const Key('node-done')), findsNWidgets(3));
    expect(find.byKey(const Key('node-today')), findsOneWidget);
  });
}
```

- [ ] **Step 3: 실패 확인**

Run: `C:/src/flutter/bin/flutter.bat test test/lesson_map_widget_test.dart`
Expected: FAIL — `lesson_map.dart` / `LessonMap` 미존재(컴파일 에러).

- [ ] **Step 4: LessonMap 구현**

```dart
// app/lib/lesson/lesson_map.dart
/// 홈 여정 맵 — 슬롯을 블록 섹션으로 묶어 세로로. 탭 불가(여정 시각화).
/// 완료=초록 ✓ / 오늘=파랑 ▶ / 미래=잠금 🔒. 상태는 currentIndex 기준.
library;

import 'package:flutter/material.dart';

import '../progression/progression_state.dart';
import '../theme/app_theme.dart';

class LessonMap extends StatelessWidget {
  const LessonMap({super.key = const Key('lesson-map'), required this.progression});

  final Progression progression;

  static const _blockLabels = ['토대', 'SOVT', '발성', '감각', '졸업'];

  String _label(int block) =>
      (block >= 1 && block <= _blockLabels.length) ? _blockLabels[block - 1] : '블록 $block';

  @override
  Widget build(BuildContext context) {
    final slots = progression.slots;
    final today = progression.currentIndex;
    // 블록별 슬롯 그룹(등장 순서 유지).
    final blocks = <int, List<int>>{};
    for (var i = 0; i < slots.length; i++) {
      blocks.putIfAbsent(slots[i].block, () => []).add(i);
    }
    final orderedBlocks = blocks.keys.toList()..sort();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final b in orderedBlocks) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 14, 4, 8),
              child: Text(
                _label(b),
                style: const TextStyle(
                    color: AppColors.textMid, fontSize: 12, letterSpacing: 1),
              ),
            ),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final i in blocks[b]!)
                  _Node(
                    state: i < today
                        ? _NodeState.done
                        : i == today
                            ? _NodeState.today
                            : _NodeState.future,
                    // 윈딩 느낌: 짝/홀로 좌우 여백.
                    offset: (i - blocks[b]!.first).isEven ? 0 : 28,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

enum _NodeState { done, today, future }

class _Node extends StatelessWidget {
  const _Node({required this.state, required this.offset});
  final _NodeState state;
  final double offset;

  @override
  Widget build(BuildContext context) {
    final (bg, border, glyph, glyphColor, key) = switch (state) {
      _NodeState.done => (
          const Color(0xFF1D3A2C),
          AppColors.done,
          '✓',
          AppColors.done,
          const Key('node-done')
        ),
      _NodeState.today => (
          AppColors.now,
          AppColors.now,
          '▶',
          Colors.white,
          const Key('node-today')
        ),
      _NodeState.future => (
          AppColors.surface,
          AppColors.lockedSurface,
          '🔒',
          AppColors.locked,
          const Key('node-future')
        ),
    };
    return Padding(
      padding: EdgeInsets.only(left: offset),
      child: Container(
        key: key,
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          border: Border.all(color: border, width: 2),
          boxShadow: state == _NodeState.today
              ? [BoxShadow(color: AppColors.now.withValues(alpha: 0.35), blurRadius: 10, spreadRadius: 2)]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(glyph, style: TextStyle(color: glyphColor, fontSize: 18)),
      ),
    );
  }
}
```

- [ ] **Step 5: 맵 테스트 green 확인**

Run: `C:/src/flutter/bin/flutter.bat test test/lesson_map_widget_test.dart`
Expected: PASS (LM1, LM2).

- [ ] **Step 6: 홈 H3 테스트 갱신(blocks → map)**

`home_screen_widget_test.dart` H3를 교체:

```dart
  testWidgets('H3 home shows streak + lesson map with section labels',
      (tester) async {
    _phoneViewport(tester);
    await tester.pumpWidget(const DebugApp());
    await tester.tap(find.widgetWithText(FilledButton, '확인'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('home-streak')), findsOneWidget);
    expect(find.byKey(const Key('lesson-map')), findsOneWidget);
    expect(find.text('토대'), findsOneWidget);
    expect(find.text('졸업'), findsOneWidget);
  });
```

- [ ] **Step 7: 실패 확인(홈은 아직 blocks)**

Run: `C:/src/flutter/bin/flutter.bat test test/home_screen_widget_test.dart`
Expected: H3 FAIL — `lesson-map` 미발견(홈이 아직 `_ProgressBlocks`).

- [ ] **Step 8: 홈에서 `_ProgressBlocks`를 `LessonMap`으로 교체**

`home_screen.dart`:
- `import 'lesson_map.dart';` 추가.
- `// 5블록 진행도` 블록의 `_ProgressBlocks(progression: p)` + 뒤따르는 `const Spacer()`를
  다음으로 교체(맵이 가변 영역을 차지):

```dart
              // 여정 맵
              Expanded(child: LessonMap(progression: p)),
              const SizedBox(height: 12),
```

- 파일 하단의 `_ProgressBlocks` 클래스 전체 삭제(본 변경으로 미사용 — 고아 정리).

- [ ] **Step 9: 홈 + 전체 테스트 green**

Run: `C:/src/flutter/bin/flutter.bat test test/home_screen_widget_test.dart` → PASS(H1~H4)
Run: `C:/src/flutter/bin/flutter.bat test` → All tests passed!
Run: `C:/src/flutter/bin/flutter.bat analyze` → No issues found!

- [ ] **Step 10: Commit**

```bash
git add app/lib/progression/progression_state.dart app/lib/lesson/lesson_map.dart app/lib/lesson/home_screen.dart app/test/lesson_map_widget_test.dart app/test/home_screen_widget_test.dart
git commit -m "UI2 — 홈 5블록 바 → 여정 레슨맵(LessonMap), H3 갱신"
git push
```

---

## Task 3: 레슨 화면 폴리시 (토큰 + 스테퍼 강조 + cue 페이드)

**Files:**
- Modify: `app/lib/lesson/lesson_screen.dart`
- Test: `app/test/lesson_screen_widget_test.dart` (기존 보존 + 1 추가)

- [ ] **Step 1: 실패 테스트 — 단계 전환 시 현재 스테퍼 라벨 강조 확인**

`lesson_screen_widget_test.dart`에 추가(파일 상단 import에 `package:vocal_athlete/lesson/lesson_screen.dart` 이미 있음):

```dart
  testWidgets('LP1 진입 단계에서 진입 스테퍼가 now 상태(볼드)', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: LessonScreen(progression: Progression.beginner())));
    await tester.pumpAndSettle();
    final entry = tester.widget<Text>(find.text('진입·워밍업'));
    expect(entry.style?.fontWeight, FontWeight.w700);
  });
```

(현재 스테퍼는 '본운동'을 항상 now로 하드코딩 → 진입 단계인데 '진입·워밍업'이 w700이 아님 → 실패.)

- [ ] **Step 2: 실패 확인**

Run: `C:/src/flutter/bin/flutter.bat test test/lesson_screen_widget_test.dart --name LP1`
Expected: FAIL — fontWeight w400.

- [ ] **Step 3: 스테퍼를 `_step`에 연동 + 토큰 적용**

`lesson_screen.dart` 스테퍼 Row를 `_step` 기반으로:

```dart
            // 3단 스테퍼(진입·본운동·쿨다운) — 현재 단계 강조
            Padding(
              key: const Key('lesson-stepper'),
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 2),
              child: Row(
                children: [
                  _Step(
                      label: '진입·워밍업',
                      state: _stepStateFor(LessonStep.entry)),
                  const SizedBox(width: 8),
                  _Step(
                      label: '본운동 7–11분',
                      state: _stepStateFor(LessonStep.main)),
                  const SizedBox(width: 8),
                  _Step(
                      label: '쿨다운', state: _stepStateFor(LessonStep.cooldown)),
                ],
              ),
            ),
```

`_LessonScreenState`에 헬퍼 추가:

```dart
  _StepState _stepStateFor(LessonStep s) {
    if (s.index < _step.index) return _StepState.done;
    if (s.index == _step.index) return _StepState.now;
    return _StepState.next;
  }
```

`_Step`/`_StepState` 색 리터럴을 토큰으로(`AppColors.done/now/locked`). 파일 상단에
`import '../theme/app_theme.dart';` 추가.

- [ ] **Step 4: cue 페이드 — 단계 전환 시 부드럽게**

cue `Center`(`Key('lesson-cue')`)의 자식을 `AnimatedSwitcher`로 감싸 페이드(200ms). `_step`
변경 시 child의 `ValueKey(_step)`로 전환. 텍스트/키 보존:

```dart
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: KeyedSubtree(
                  key: ValueKey(_step),
                  child: Column( /* 기존 cue Column 그대로 */ ),
                ),
              ),
```

(AnimatedSwitcher는 유한 전환 → `pumpAndSettle` 안전.)

- [ ] **Step 5: 토큰 치환(나머지 색 리터럴)**

`lesson_screen.dart`의 `Color(0xFF0E0F13)`→`AppColors.bg`, `Color(0xFF171922)`→`AppColors.surface`,
`Color(0xFF39D98A)`→`AppColors.done`, `Color(0xFF222637)`→`AppColors.surfaceAlt`,
`Color(0xFF3A3F55)`→`AppColors.locked`. 마이크 꺼짐 자리표시: `mic-off-notice` 텍스트 보존,
그 영역 배경을 `AppColors.surface`로 채워 덜 휑하게(레이아웃·키 불변).

- [ ] **Step 6: 레슨 테스트 + 전체 green**

Run: `C:/src/flutter/bin/flutter.bat test test/lesson_screen_widget_test.dart` → PASS(LP1 + 기존)
Run: `C:/src/flutter/bin/flutter.bat test` → All tests passed!
Run: `C:/src/flutter/bin/flutter.bat analyze` → No issues found!

- [ ] **Step 7: Commit**

```bash
git add app/lib/lesson/lesson_screen.dart app/test/lesson_screen_widget_test.dart
git commit -m "UI3 — 레슨 스테퍼 단계 연동·cue 페이드·토큰 적용"
git push
```

---

## Task 4: 졸업·장르픽·설정·피치 토큰 적용

**Files:**
- Modify: `graduation_screen.dart`, `settings_screen.dart`, `pitch/pitch_display.dart`
- Test: 기존 위젯 테스트(회귀 가드, 변경 없음)

순수 색 치환(동작·키·텍스트 불변) → 기존 테스트 green 유지로 검증.

- [ ] **Step 1: 세 파일 색 리터럴 → 토큰 치환**

각 파일 상단 `import '../theme/app_theme.dart';`(pitch_display는 `'../../theme/app_theme.dart'`).
공통 매핑 적용: `0xFF0E0F13`→`bg`, `0xFF171922`→`surface`, `0xFF39D98A`→`done`,
`0xFF6C8CFF`→`now`, `0xFF3A3F55`→`locked`, `Colors.white60`→`textMid`, `Colors.white38`→`textLow`.
졸업 3장르 버튼에 작은 일러스트 악센트 이모지 추가(예: 🎭 뮤지컬 / 🎼 성악 / 🎤 가요) — 버튼
`Key('genre-*')`·탭 동작·기존 텍스트 보존(이모지는 라벨 앞 접두만).

- [ ] **Step 2: 전체 테스트 + analyze green**

Run: `C:/src/flutter/bin/flutter.bat test` → All tests passed!
Run: `C:/src/flutter/bin/flutter.bat analyze` → No issues found!

- [ ] **Step 3: Commit**

```bash
git add app/lib/lesson/graduation_screen.dart app/lib/lesson/settings_screen.dart app/lib/lesson/pitch/pitch_display.dart
git commit -m "UI4 — 졸업·설정·피치 토큰 적용 + 장르 일러스트 악센트"
git push
```

---

## Task 5: 마이크로애니메이션 (테스트-안전, 한 번에 끝남)

**Files:**
- Modify: `app/lib/lesson/home_screen.dart`(시작 버튼 누름 스케일), `lesson_map.dart`(오늘 노드 등장 스케일-인)
- Test: `app/test/lesson_map_widget_test.dart`(애니 후 정착 확인)

⚠️ **무한 반복 애니메이션 금지**(`pumpAndSettle` 행 방지). 모두 **1회 실행 후 정착**.

- [ ] **Step 1: 실패 테스트 — 오늘 노드 등장 애니가 정착 후 표시 유지**

`lesson_map_widget_test.dart`에 추가:

```dart
  testWidgets('LM3 오늘 노드 등장 애니 정착 후에도 존재(pumpAndSettle 안전)',
      (tester) async {
    final p = Progression.from(buildPlaceholderManifest(), currentIndex: 2);
    await tester.pumpWidget(host(p));
    await tester.pumpAndSettle(); // 무한 반복이면 여기서 타임아웃
    expect(find.byKey(const Key('node-today')), findsOneWidget);
  });
```

- [ ] **Step 2: 실패 또는 통과 확인(기준선)**

Run: `C:/src/flutter/bin/flutter.bat test test/lesson_map_widget_test.dart --name LM3`
Expected: 현재는 애니 없음 → PASS(기준). (이 테스트는 이후 무한반복 회귀를 막는 가드.)

- [ ] **Step 3: 오늘 노드 등장 스케일-인(1회)**

`lesson_map.dart` `_Node`의 today 케이스 Container를 `TweenAnimationBuilder`로 1회 스케일-인:

```dart
    final child = Container(/* 기존 Container 그대로 */);
    if (state != _NodeState.today) return Padding(padding: EdgeInsets.only(left: offset), child: child);
    return Padding(
      padding: EdgeInsets.only(left: offset),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.85, end: 1.0),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutBack,
        builder: (_, s, c) => Transform.scale(scale: s, child: c),
        child: child,
      ),
    );
```

(`TweenAnimationBuilder`는 1회 후 정착 → `pumpAndSettle` 안전.)

- [ ] **Step 4: 시작 버튼 누름 스케일(홈)**

`home_screen.dart` `start-today` `FilledButton`을 누를 때 살짝 줄었다 복귀하는 효과는
`FilledButton` 기본 `InkWell` 피드백으로 충분 — 추가 구현 생략(YAGNI). 대신 버튼 `style`에
`animationDuration: const Duration(milliseconds: 120)` 지정(키·동작 불변).

- [ ] **Step 5: 맵 + 전체 테스트 green**

Run: `C:/src/flutter/bin/flutter.bat test test/lesson_map_widget_test.dart` → PASS(LM1~LM3)
Run: `C:/src/flutter/bin/flutter.bat test` → All tests passed!
Run: `C:/src/flutter/bin/flutter.bat analyze` → No issues found!

- [ ] **Step 6: Commit**

```bash
git add app/lib/lesson/lesson_map.dart app/lib/lesson/home_screen.dart app/test/lesson_map_widget_test.dart
git commit -m "UI5 — 테스트-안전 마이크로애니메이션(오늘 노드 스케일-인)"
git push
```

---

## 완료 기준 (전체)

- 홈이 `LessonMap`으로 렌더, 완료/오늘/미래 노드가 `currentIndex`와 정합, 시작/완료 동작 보존.
- 전 화면 토큰 기반 일관 다크 톤 + 장르 일러스트 악센트 + 절제된(정착하는) 마이크로애니메이션.
- 전 테스트 green(159 + 신규 LM1~LM3·LP1) + analyze 클린. 피치/진행/안전/키 동작 불변.
