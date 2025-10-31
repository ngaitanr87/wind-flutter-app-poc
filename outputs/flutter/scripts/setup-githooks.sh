#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
HOOKS_DIR="$REPO_ROOT/.githooks"

mkdir -p "$HOOKS_DIR"

cat >"$HOOKS_DIR/pre-commit" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

fvm flutter format --set-exit-if-changed .
fvm flutter analyze
EOF
chmod +x "$HOOKS_DIR/pre-commit"

cat >"$HOOKS_DIR/pre-push" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

fvm flutter test
EOF
chmod +x "$HOOKS_DIR/pre-push"

GIT_DIR="$(git rev-parse --git-dir)"
mkdir -p "$GIT_DIR/hooks"
rm -f "$GIT_DIR/hooks/pre-commit" "$GIT_DIR/hooks/pre-push"
ln -s "../../.githooks/pre-commit" "$GIT_DIR/hooks/pre-commit"
ln -s "../../.githooks/pre-push" "$GIT_DIR/hooks/pre-push"

echo "Git hooks installed via .githooks directory."
