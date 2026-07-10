# FEEDBACK-UPDATE-2026-06-16-R4

## 반영 범위

1. `Song Builder` 사용자-facing 명칭을 폐기하고 `Repertoire Application / 곡 적용 훈련`으로 정리했다.
2. 코드 경로는 `LearningStage.repertoireApplication`, `repertoireApplicationLength`, `buildRepertoireApplicationManifest()`를 canonical로 사용한다.
3. R3 저장값/테스트 호환을 위해 `stage: songBuilder`, `songBuilderLength`, `buildSongBuilderManifest()` alias는 내부 호환용으로 보존했다.
4. `RA-01~08` 카드 prefix를 곡 적용 훈련 카드로 고정했다.
5. 고급 장르 release gate는 미출시 장르 선택 시 advanced 진입이 아니라 maintenance/wait 상태로 보낸다.
6. pending high-risk 카드는 fallback/cap metadata를 갖고, safety filter는 삭제만 하지 않고 가능한 경우 fallback으로 대체한다.
7. 목 상태 check를 `LessonScreen`의 light/recovery 모드로 연결했다. `쉰 느낌`은 피치 표시와 voiced task를 차단하고, `조금 피곤함`은 반복 축소 문구와 안전한 라이트 모드로 전환한다.
8. 평가 루브릭, 보컬 부하 예산, 포트폴리오, 녹음 A/B MVP 문서를 추가했다.

## Canonical Route

Beginner Foundation → Universal Vocal Core → Repertoire Application → Advanced Genre Labs → Portfolio/Performance Mode

## 제품 포지셔닝 메모

Repertoire Application은 노래 제작/작곡 기능이 아니다. Universal Vocal Core에서 배운 호흡·발성·음정·리듬·음색·딕션을 짧은 프레이즈와 곡 구간에 적용하는 보컬 트레이닝 단계다.
