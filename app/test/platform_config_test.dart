import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

String _read(String path) => File(path).readAsStringSync();

void main() {
  test('REL1 Android release signing does not use debug signing', () {
    final gradle = _read('android/app/build.gradle.kts');

    expect(gradle, contains('signingConfig = signingConfigs.getByName("release")'));
    expect(gradle, isNot(contains('signingConfigs.getByName("debug")')));
    expect(gradle, contains('validateReleaseSigning'));
    expect(gradle, contains('key.properties.example'));
  });

  test('REL2 Android applicationId is explicit and has no template TODO', () {
    final gradle = _read('android/app/build.gradle.kts');

    expect(gradle, contains('applicationId = "com.vocalathlete.vocal_athlete"'));
    expect(gradle, isNot(contains('TODO: Specify your own unique Application ID')));
  });

  test('REL3 microphone permissions are declared on Android and iOS', () {
    final androidManifest = _read('android/app/src/main/AndroidManifest.xml');
    final iosInfo = _read('ios/Runner/Info.plist');

    expect(androidManifest, contains('android.permission.RECORD_AUDIO'));
    expect(iosInfo, contains('NSMicrophoneUsageDescription'));
    expect(iosInfo, contains('발성 피치 피드백을 위해 마이크를 사용합니다.'));
  });

  test('REL4 signing secrets and build outputs are ignored', () {
    final gitignore = _read('../.gitignore');

    expect(gitignore, contains('app/android/key.properties'));
    expect(gitignore, contains('*.jks'));
    expect(gitignore, contains('*.keystore'));
    expect(gitignore, contains('*.apk'));
    expect(gitignore, contains('*.aab'));
  });

  test('CI pins Flutter SDK version and runs app verification commands', () {
    final workflow = _read('../.github/workflows/flutter-ci.yml');

    expect(workflow, contains("flutter-version: '3.44.0'"));
    expect(workflow, contains('working-directory: app'));
    expect(workflow, contains('flutter pub get'));
    expect(workflow, contains('flutter analyze'));
    expect(workflow, contains('flutter test'));
  });
}
