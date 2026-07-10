#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG_DIR="$ROOT/build/validation-logs"
EXPECTED_FLUTTER_PREFIX="${EXPECTED_FLUTTER_PREFIX:-Flutter 3.44}"
mkdir -p "$LOG_DIR"

if ! command -v python >/dev/null 2>&1; then
  printf 'BLOCKED: python is not installed or not on PATH.\n' >&2
  exit 127
fi
if ! command -v flutter >/dev/null 2>&1; then
  printf 'BLOCKED: flutter is not installed or not on PATH. Expected %s.x stable.\n' "$EXPECTED_FLUTTER_PREFIX" >&2
  exit 127
fi
if ! command -v dart >/dev/null 2>&1; then
  printf 'BLOCKED: dart is not installed or not on PATH.\n' >&2
  exit 127
fi

run_logged() {
  local name="$1"
  shift
  printf '\n== %s ==\n' "$name"
  "$@" 2>&1 | tee "$LOG_DIR/${name}.log"
}

cd "$ROOT"
run_logged content-manifest-check python tools/generate_content_manifest.py --version v18 --check
run_logged repository-validator python tools/validate_v18.py
run_logged flutter-version flutter --version
if ! flutter --version | head -n 1 | grep -Fq "$EXPECTED_FLUTTER_PREFIX"; then
  printf 'BLOCKED: unexpected Flutter version. Expected prefix: %s\n' "$EXPECTED_FLUTTER_PREFIX" >&2
  exit 2
fi
run_logged flutter-doctor flutter doctor -v

cd "$ROOT/app"
run_logged flutter-pub-get flutter pub get
run_logged flutter-analyze flutter analyze --fatal-infos
run_logged flutter-test flutter test --reporter expanded
run_logged flutter-integration-test flutter test integration_test
run_logged flutter-android-debug-build flutter build apk --debug

printf '\nPASS: Flutter validation commands completed. Logs: %s\n' "$LOG_DIR"
