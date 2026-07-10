# CONTENT REVISION MANIFEST SPEC — v17

## 목적

같은 track/day/card ID라도 cue, 단계, 자기점검, 음원, 권리 기록이 변경되면 같은 학습 조건으로 간주하지 않는다. 현재 vertical slice의 blueprint, asset manifest, 권리 기록, 선언된 모든 WAV를 자동 생성 SHA-256 manifest로 고정한다.

## canonical 파일

```text
app/assets/curriculum/content_manifest_v17.json
```

현재 고정 대상:

- Beginner Timbre Day 37–38 blueprint 1개
- Universal Core Cycle 1 blueprint 1개
- Repertoire Application Project 1 blueprint 1개
- `neutral_001` asset manifest 1개
- 권리 기록 3개
- 권리 기록에 선언된 WAV 24개
- 합계 31개 파일

## 생성·검증

```bash
python tools/generate_content_manifest.py --version v17 --date YYYY-MM-DD
python tools/generate_content_manifest.py --version v17 --check
```

생성기는 다음을 실패로 처리한다.

- 권리 기록의 SHA-256과 실제 WAV 불일치
- 권리 기록이 가리키는 파일 누락
- 같은 디렉터리의 미추적 WAV
- blueprint/asset manifest가 권리 inventory 밖의 WAV를 참조함
- 생성 결과와 저장된 manifest가 다름

`tools/validate_v17.py`와 CI는 `--check`를 다시 실행한다. 파일을 바꾸고 manifest를 갱신하지 않으면 검증이 실패한다.

## revision 형식

```text
track:cycle:bundleVersion:day_N:cardId:sha256_<12자리>
```

manifest에는 전체 64자리 SHA-256을 보존한다.

## 해석 제한

- 해시는 파일 동일성을 보여줄 뿐 교육 품질, 보컬 안전, 저작권 허가, 전문가 승인을 증명하지 않는다.
- 권리 기록 자체의 존재는 법률 검토 완료를 의미하지 않는다.
- revision이 다르면 직접적인 자동 전후 점수 비교를 하지 않는다.
- 합성 prototype과 최종 강사 master는 서로 다른 revision으로 기록한다.
