# Base App Flutter Output

This directory contains the Flutter application for feature **001-base-app**. It is intentionally kept as a plain directory (not a Git submodule) per ADR-0003 while the project remains a POC.

## Quickstart

Follow [`specs/001-base-app/quickstart.md`](../specs/001-base-app/quickstart.md) for the authoritative setup steps:

1. Pin Flutter 3.35.0 with FVM (`fvm use 3.35.0 --force`).
2. Install dependencies: `fvm dart pub get`.
3. Run static checks: `fvm flutter analyze`.
4. Execute tests: `fvm flutter test`.
5. Launch the app: `fvm flutter run -t lib/main_dev.dart`.

## Directory Highlights

- `lib/main_*.dart`: Environment entry points (dev/staging/production) routing through a shared bootstrap.
- `lib/bootstrap/`: Application bootstrap, DI wiring, and environment injection.
- `lib/presentation/pages/hello_world_page.dart`: Static Hello World screen fulfilling User Story 1.
- `lib/l10n/`: Localization scaffolding and strings.
- `lib/app/theme/`: Light/Dark theme definitions.
- `test/widget/`: Widget tests covering rendering, semantics, and responsiveness.
- `scripts/setup-githooks.sh`: Installs platform-scoped git hooks (formatting, analyze, test).

## Tooling

- Run quality checks via CI workflow at `.github/workflows/flutter-ci.yml`.
- Hooks are installed by running `./scripts/setup-githooks.sh`.
