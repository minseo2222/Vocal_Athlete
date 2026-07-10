import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocal_athlete/lesson/settings_screen.dart';
import 'package:vocal_athlete/main.dart';

void main() {
  test('uses the platform package version when lookup succeeds', () async {
    final version = await loadAppVersion(loader: () async => '9.8.7');

    expect(version, '9.8.7');
  });

  testWidgets(
    'lookup failure still permits startup and shows a safe fallback',
    (tester) async {
      final version = await loadAppVersion(
        loader: () async => throw StateError('platform channel unavailable'),
      );

      await tester.pumpWidget(DebugApp(appVersion: version));
      expect(find.byType(MaterialApp), findsOneWidget);

      await tester.pumpWidget(
        MaterialApp(
          home: SettingsScreen(version: version, onBack: () {}),
        ),
      );
      expect(find.textContaining(appVersionFallback), findsOneWidget);
    },
  );
}
