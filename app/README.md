# vocal_athlete — Flutter 앱 (V1)

설계: 리포 루트 `CONTEXT-MAP.md` · `docs/adr/` · `docs/curriculum/beginner/` · 슬라이스 `.scratch/beginner-v1/`.
스택 = Flutter (ADR-0013, 조건부: F1 오디오 지연 스파이크). 피치 = pYIN V1 (ADR-0014).

## 실행 / 검증 (1-커맨드)

```
flutter pub get          # 의존성
flutter analyze          # lint
flutter test             # 단위테스트(pitch_naive 등)
flutter run              # 기기/에뮬에서 실행
```

> Flutter SDK는 `C:\src\flutter`(PATH 등록됨). 새 터미널에서 `flutter` 바로 사용.
> 에뮬/기기 빌드는 `flutter doctor` 통과 + Android Studio/SDK + `flutter doctor --android-licenses` 필요.

## 현재 상태: F1 — 오디오 지연 스파이크 (throwaway)

`lib/main.dart` + `lib/spike/pitch_naive.dart` = **던져버릴 스파이크**. 목적: 마이크→F0→화면
end-to-end 지연을 실기기에서 측정해 ADR-0013 조건부 채택을 검증(불충족 시 폴백 = 네이티브 1종).

측정 방법: 기기에서 `flutter run` → "시작(마이크)" → 발성 → `avg latency` 관찰.
판정 후 결과를 `.scratch/beginner-v1/issues/02-scaffold-boots.md`에 기록하고 스파이크 폐기,
검증된 구조로 P1/U1 본구현 진입. `pitch_naive`는 A1에서 실제 pYIN으로 교체(U4 seam).
