# UPDATE VALIDATION — v18 — 2026-06-22

## Static validation intent

`tools/validate_v18.py` checks repository structure, curriculum invariants, content hashes, local imports, Tone Profile v18 markers, source-register counts, required documents, and version markers. It does not prove Flutter compilation, device audio, vocal safety, rights clearance, user comprehension, or learning efficacy.

## Expected v18 invariants

- app version `1.18.0+18`;
- Beginner 48, Universal Core 144, Repertoire Application 72, advanced cycles 40;
- no dangling card or fallback references;
- 31 content-manifest files with fresh SHA-256 values;
- all 39 timbre sources present;
- source status counts: v15 8, v16 5, v17 6, v18 4, pending 16;
- `RecordingTake.createdLocalDateKey` round-trip;
- multi-tag edit, tag clear, exclusion/restore markers;
- teacher-guide prep and pilot files present;
- v18 workflow and runtime manifest markers.

## Runtime validation state

The project includes a Flutter validation script and CI workflow, but the current build container does not include Flutter or Dart. Runtime results must therefore remain BLOCKED until executed in the pinned SDK and a mobile test environment.

## Executed result in this workspace

```text
python -B tools/validate_v18.py: PASS
JSON files: 38
YAML files: 1
Dart delimiter files: 118
local/package imports checked: 247
card library: 126
path card IDs: 110
missing card references: 0
fallback targets: 15
missing fallback targets: 0
content manifest: 31 files / generator check PASS
research register: 39 sources / 23 checked / 16 pending
```

Flutter tool execution:

```text
./tools/run_flutter_validation.sh
exit_code=127
BLOCKED: flutter is not installed or not on PATH. Expected Flutter 3.44.x stable.
```
