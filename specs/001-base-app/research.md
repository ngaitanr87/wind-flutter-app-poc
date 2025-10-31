# Research: Base App - Hello World

Created: 2025-10-31
Branch: 001-base-app
Spec: /Users/ngaitan/Documents/FlutterApp/wind-flutter-app-poc/specs/001-base-app/spec.md

## Decisions

- Flutter SDK version: 3.24.0 (Stable) pinned via FVM (.fvm/fvm_config.json).
- Outputs layout: All app code resides under outputs/flutter/ (Flutter constitution §2.1, §2.3; global §30).
- Submodule: outputs/flutter is a Git submodule pinned to a dedicated remote (initialized when remote URL is provided).
- Project initialization: `flutter create --platforms=android,ios` executed inside outputs/flutter.
- DI & bootstrap: Use get_it and a single bootstrap entry to prepare for future layers (Flutter §12, §9.1).
- State management: Prepare for flutter_bloc; not strictly required for the static Hello World page.
- Localization: Enable localization plumbing; provide en key for "Hello World". All text must be localizable (global §10; Flutter §15).
- Themes: Provide light/dark theme to ensure readable contrast (global §12; Flutter §10).
- Testing: Add a widget test asserting the "Hello World" text is rendered (global §3; Flutter §5).
- Analytics/Crash Reporting: Defer Crashlytics/Analytics for this slice; record ADR-0001 to add with first real feature (global §14; Flutter §16).
- Platforms: Android minSdk 21; iOS 15+.

## Rationale

- Pinned SDK and outputs directory ensure reproducibility and enforcement by CI and hooks.
- Submodule separation isolates platform code, allows independent releases and versioning.
- DI + bootstrap scaffolding avoids later architectural rewrites as features are added.
- Localization and theming ensure compliance with accessibility and internationalization rules.
- Widget test verifies spec’s primary outcome quickly and guards regressions.

## Alternatives Considered

- No submodule, place Flutter app at repo root
  - Rejected: violates constitutions (global §30, Flutter §2.3, §2.4) and weakens isolation.
- Skip DI scaffolding for a static page
  - Rejected: short-term convenience but conflicts with mandatory DI rules and layering.
- Use another framework (React Native, native Swift/Kotlin)
  - Rejected: Flutter constitution governs this project; team direction favors Flutter.

## Unknowns Resolved

- Remote URL for submodule will be provided by maintainers at initialization time; quickstart documents the commands. No further blockers for this feature’s scope.

## Output

- Proceed with structure and scripts defined in plan.md and quickstart.md.
- No remaining NEEDS CLARIFICATION items for this slice.
