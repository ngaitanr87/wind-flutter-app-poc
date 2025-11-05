# Research: Base App - Hello World

Created: 2025-10-31
Branch: 001-base-app
Spec: /Users/ngaitan/Documents/FlutterApp/wind-flutter-app-poc/specs/001-base-app/spec.md

## Decisions

- Flutter SDK version: 3.35.0 (Stable) pinned via FVM (.fvm/fvm_config.json).
- Outputs layout: All app code resides under outputs/flutter/ (Flutter constitution §2.1, §2.3; global §30).
- Submodule: IGNORED for this project; `outputs/flutter/` is a plain directory. See ADR-0003.
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
- DI + bootstrap scaffolding avoids later architectural rewrites as features are added.
- Localization and theming ensure compliance with accessibility and internationalization rules.
- Widget test verifies spec’s primary outcome quickly and guards regressions.

## Alternatives Considered

- Use Git submodule for outputs/flutter (per constitutions)
  - Rejected for this POC: setup overhead and separate remote management; exception recorded in ADR-0003. Isolation/versioning risks accepted short-term with CI mitigations.
- Skip DI scaffolding for a static page
  - Rejected: short-term convenience but conflicts with mandatory DI rules and layering.
- Use another framework (React Native, native Swift/Kotlin)
  - Rejected: Flutter constitution governs this project; team direction favors Flutter.

## Unknowns Resolved

- Submodule remote not applicable; exception per ADR-0003. No further blockers for this feature’s scope.

## Output

- Proceed with structure and scripts defined in plan.md and quickstart.md.
- No remaining NEEDS CLARIFICATION items for this slice.
