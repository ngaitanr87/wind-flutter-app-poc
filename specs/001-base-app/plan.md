# Implementation Plan: Base App - Hello World

**Branch**: `001-base-app` | **Date**: 2025-10-31 | **Spec**: [/Users/ngaitan/Documents/FlutterApp/wind-flutter-app-poc/specs/001-base-app/spec.md]
**Input**: Feature specification from [/Users/ngaitan/Documents/FlutterApp/wind-flutter-app-poc/specs/001-base-app/spec.md]

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

Deliver a minimal cross‑platform mobile app that shows only the text "Hello World" on launch, with no interactive elements. The app must run on Android and iOS, display centered readable text in light/dark themes, and require no network or permissions.

Technical approach (aligned with constitutions):
- Initialize a Flutter project pinned to Flutter 3.24.0 via FVM, placed under `outputs/flutter/`.
- Adopt modular layout: presentation in `outputs/flutter/lib/`, with scaffolding for domain and data packages (empty for this feature).
- Add localization scaffolding and provide an English key for "Hello World".
- Provide a DI bootstrap (get_it) prepared for future layers, even if unused by this static screen.
- Provide a basic widget test to verify the text is rendered.

## Technical Context

**Language/Version**: Dart 3.x (via Flutter 3.24.0 pinned by FVM)  
**Primary Dependencies**: Flutter SDK 3.24.0; `flutter_lints`; `get_it` (DI); `flutter_bloc` (presentation pattern, minimal use for this feature)  
**Storage**: N/A (no data)  
**Testing**: `flutter_test` (widget test to verify "Hello World"); optional golden test for baseline rendering  
**Target Platform**: Android (minSdk 21); iOS 15+  
**Project Type**: mobile  
**Performance Goals**: Cold start renders Hello World < 2 seconds on mid‑range simulator/device (aligns with spec SC‑001)  
**Constraints**: Offline‑capable; no runtime permissions; readable in light/dark themes  
**Scale/Scope**: Single screen, zero navigation, zero network

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

Compliance gates derived from global Mobile App Constitution and Flutter Constitution:

- Architecture layering (Presentation → Domain → Data, isolation) — Status: Planned. Domain/data packages scaffolded (empty in this feature) to enforce structure.
- DI container per layer — Status: Planned. Initialize `get_it` in bootstrap; no registrations needed yet.
- English-only specs/docs — Status: PASS. All docs in English.
- Output directory convention `./outputs/flutter/` — Status: Planned. All app sources placed under outputs.
- Flutter SDK pinned via FVM 3.24.0 — Status: PASS upon setup.
- Static analysis (flutter analyze) 0 errors — Status: PASS criterion for PR.
- Testing coverage: 100% for domain/data (N/A in this feature); widget test present — Status: PASS for scope.
- Monitoring & Analytics integration (Crashlytics/Analytics) — Status: Deferred via ADR-0001 (temporary exception for base skeleton; to be implemented in a future monitoring feature).
- Submodule requirement (`outputs/flutter` as Git submodule) — Status: Ignored for this project (exception). We will use a plain directory at `outputs/flutter/` without a Git submodule. See Constitution Deviations for justification.

No blocking errors for planning. One temporary exception (monitoring/analytics) is justified via ADR-0001 with expiry tied to the first production‑ready release gate.

## User Story Coverage

- **US1 – View Hello World (P1)**
  - Implementation: Single screen using `Scaffold` → `Center` → text widget displaying "Hello World". Respect SafeArea and theme; no interactive widgets.
  - Tests: Widget test asserting the text is found and that no tappable semantics nodes exist. Verify readability under light/dark themes.

- **US2 – Cross‑platform Run (P2)**
  - Implementation: Initialize `outputs/flutter` via `flutter create --platforms=android,ios` with environment mains (`main_dev.dart`, `main_staging.dart`, `main_prod.dart`). Avoid any platform‑specific code paths.
  - Tests: Build/run smoke validation on one Android device/emulator and one iOS simulator/device. CI job to run `flutter analyze` and `flutter test` on both platforms’ toolchains.

- **US3 – Responsive Display (P3)**
  - Implementation: Centered layout that adapts to orientation and text scale (uses `Center` + `Text` with proper `textAlign`; respects `MediaQuery.textScaleFactor`). Ensure no clipping on common sizes; if necessary allow wrapping.
  - Tests: Widget tests pumping with different `MediaQuery` sizes and `textScaleFactor` values; rotate orientation in tests to confirm the text remains visible and centered without clipping.

## Constitution Deviations

- Monitoring & Analytics (Global §14, Flutter §16): Deferred for this base slice. Will add via ADR‑0001 with expiry aligned to first production‑ready release feature.
- State management (Flutter §13 – flutter_bloc required): Not applicable for this static slice (no state). Will enforce on first stateful feature; record ADR‑0002 noting N/A rationale.
- Outputs as Git submodule (Flutter §0.1, §2.3; Global §30): Ignored for this project; `outputs/flutter/` will be a normal directory. Rationale: simplify POC setup and avoid extra remote. Risk: weaker isolation/compliance; Mitigation: maintain layout and CI checks without submodule; ADR‑0003 documents this time‑boxed exception.
- All other gates are planned to PASS within this feature’s scope (SDK pin via FVM, DI bootstrap, English‑only docs, lint/analyze, localization readiness, theming, minimal tests).

## Project Structure

### Documentation (this feature)

```text
specs/001-base-app/
├── plan.md              # This file (/speckit.plan output)
├── research.md          # Phase 0 output (decisions + rationale)
├── data-model.md        # Phase 1 output (N/A entities for this feature)
├── quickstart.md        # Phase 1 output (setup + run)
├── contracts/           # Phase 1 output (stub; no APIs)
└── tasks.md             # Phase 2 output (/speckit.tasks – not created here)
```

### Source Code (repository root)

```text
outputs/flutter/            # Flutter app (NOT a Git submodule for this project)
├── .fvm/
├── pubspec.yaml
├── lib/
│   ├── env/
│   │   └── app_environment.dart
│   ├── bootstrap/
│   │   └── bootstrap.dart
│   ├── app/
│   │   └── root_app.dart
│   ├── presentation/
│   │   └── pages/
│   │       └── hello_world_page.dart
│   ├── main_dev.dart
│   ├── main_staging.dart
│   └── main_prod.dart
├── packages/
│   ├── domain/             # Empty skeleton in this feature
│   └── data/               # Empty skeleton in this feature
└── test/
    └── widget/
        └── hello_world_test.dart
```

**Structure Decision**: Use the Flutter outputs layout under `outputs/flutter/` without a Git submodule (project-level exception). Presentation lives under `outputs/flutter/lib/`, with environment‑specific mains and a single page rendering localized "Hello World". Domain and data packages are created as empty skeletons to enforce layering from the outset. The exception is documented in Constitution Deviations (ADR‑0003).

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| Monitoring & Analytics deferred (Flutter §16) | Base skeleton has no flows or data; monitoring tooling adds weight with no user value in this slice | Adding tooling now increases setup time and noise; will implement with first feature that emits events (ADR‑0001, time‑boxed) |
