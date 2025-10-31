#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
REPORT_DIR="$PROJECT_ROOT/coverage"

pushd "$PROJECT_ROOT" >/dev/null

fvm flutter test --coverage --no-pub

# Convert to LCOV if needed (Flutter already outputs lcov.info)
mkdir -p "$REPORT_DIR"
if [[ -f "coverage/lcov.info" ]]; then
  echo "Coverage report generated at coverage/lcov.info"
else
  echo "Expected coverage/lcov.info not found" >&2
  exit 1
fi

popd >/dev/null
