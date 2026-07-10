# UPDATE VALIDATION — 2026-06-16 R3

## 수행한 정적 검증

- 신규/수정 문서 존재 확인:
  - `docs/curriculum/LONG-TERM-SINGER-PATH.md`
  - `docs/curriculum/SINGER-LEVEL-OUTCOMES.md`
  - `docs/curriculum/TIMBRE-TRAINING-SPEC.md`
  - `docs/curriculum/universal-core/CURRICULUM.md`
  - `docs/curriculum/SONG-BUILDER-SPEC.md`
  - `docs/curriculum/ADVANCED-LOOP-SPEC.md`
  - `docs/curriculum/advanced-gayo/CURRICULUM.md`
  - `docs/curriculum/advanced-musical/CURRICULUM.md`
  - `docs/curriculum/advanced-classical/CURRICULUM.md`
  - `docs/curriculum/advanced-rb-soul/CURRICULUM.md`
  - `docs/curriculum/advanced-rock/CURRICULUM.md`
  - `docs/curriculum/advanced-ccm/CURRICULUM.md`
  - `docs/app/TONE-FEEDBACK-SPEC.md`
  - `docs/research/TIMBRE-RESEARCH-ADDENDUM-2026-06-16.md`
  - `docs/research/UNIVERSAL-CORE-RESEARCH-ADDENDUM-2026-06-16.md`
  - `docs/adr/0019-universal-core-advanced-genre-route.md`
  - `docs/adr/0020-timbre-training-integration.md`
- 코드 marker 확인:
  - `LearningStage`
  - `startUniversalCore()`
  - `startSongBuilder()`
  - `canPickAdvancedGenre`
  - `buildUniversalCoreManifest()`
  - `buildSongBuilderManifest()`
  - `buildAdvancedGayoManifest()`
  - `buildAdvancedRbSoulManifest()`
  - `buildAdvancedRockManifest()`
  - `buildAdvancedCcmManifest()`
  - `buildAdvancedUserSongManifest()`
  - `TONE-01~13`
  - `UC-01~17`
  - `SB-01~08`
  - `timbreTags`, `toneGoal`, `allowsToneAB`
- `path.dart`에 포함된 모든 카드 ID가 `card_library.dart`에 존재하는지 확인했다.
- 초급 manifest 48 slot과 `CARD-13` Day 1/24/48 배치를 확인했다.
- Universal Core 144, Song Builder 72, Advanced Genre Lab 40-slot cycle 상수를 확인했다.
- 전체 카드 key 98개와 path 참조 ID 96개의 정합을 확인했다.
- `card_library.dart`의 pending 카드 목록과 `docs/verification/verification-status.json`의 `stillGatedCardIds` 정합을 확인했다.
- `progression_state.dart`의 `Genre` enum과 verification JSON `allGenres` 정합을 확인했다.
- `CurriculumStage` legacy enum이 앱 코드/테스트에 남아 있지 않음을 확인했다.
- 초급 manifest가 48 slot이고, `CARD-13` 표준샘플이 Day 1/24/48에 고정된 것을 확인했다.
- Dart 파일(`app/lib`, `app/test`)의 괄호 균형을 문자열/주석 aware scanner로 정적 검사했다. 결과: `ROBUST_VALIDATION_OK`.
- `docs/verification/verification-status.json` JSON 파싱을 확인했다.
- 전체 ZIP 및 패치 ZIP 압축 무결성을 확인했다. 결과: `No errors detected in compressed data`.

## 산출물

- `pro_v_new_feedback_r3_updated_project_2026-06-16.zip`
- `pro_v_new_feedback_r3_patch_files_2026-06-16.zip`

## 수행하지 못한 검증

- `dart`/`flutter` CLI 부재를 확인했다.

현재 실행 환경에는 Flutter/Dart CLI가 없어 다음은 실행하지 못했다.

- `dart analyze`
- `flutter test`
- Android 실기기 마이크/F0/녹음 검증

로컬 개발 환경에서 위 검증은 반드시 실행해야 한다.
