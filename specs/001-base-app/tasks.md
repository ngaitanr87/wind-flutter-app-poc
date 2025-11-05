# Tasks: Base App - Hello World

**Input**: Design documents from `/Users/ngaitan/Documents/FlutterApp/wind-flutter-app-poc/specs/001-base-app/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/, quickstart.md

Note: Tasks use repository-root–relative paths (e.g., `outputs/flutter/...`).

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and base structure under `outputs/flutter/` directory (not a submodule)

- [x] T001 Create outputs/flutter directory — outputs/flutter/
- [x] T002 Initialize Flutter project with official template (android, ios) — outputs/flutter/
- [x] T003 Pin Flutter SDK via FVM to 3.35.0 (creates config) — outputs/flutter/.fvm/fvm_config.json
- [x] T004 Create environment mains and bootstrap entry — outputs/flutter/lib/main_dev.dart; outputs/flutter/lib/main_staging.dart; outputs/flutter/lib/main_prod.dart
- [x] T005 [P] Create bootstrap file — outputs/flutter/lib/bootstrap/bootstrap.dart
- [x] T006 [P] Create root app widget shell — outputs/flutter/lib/app/root_app.dart
- [x] T007 [P] Initialize localization scaffolding with English key — outputs/flutter/lib/l10n/intl_en.arb
- [x] T008 [P] Configure analysis and lints — outputs/flutter/analysis_options.yaml
- [x] T009 [P] Add flutter_lints and get_it dependencies with pinned versions — outputs/flutter/pubspec.yaml
- [x] T010 [P] Add environment mains (dev, staging, prod) calling bootstrap — outputs/flutter/lib/main_dev.dart
- [x] T011 [P] Add environment main (staging) — outputs/flutter/lib/main_staging.dart
- [x] T012 [P] Add environment main (prod) — outputs/flutter/lib/main_prod.dart
- [x] T013 [P] Create scripts to install platform-scoped git hooks and set core.hooksPath — outputs/flutter/scripts/setup-githooks.sh
- [x] T014 [P] Create CI workflow skeleton for analyze + test (can be refined later) — outputs/flutter/.github/workflows/flutter-ci.yml

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before any user story work

- [x] T015 Create DI container abstraction and registration entry — outputs/flutter/lib/di/container.dart
- [x] T016 [P] Add basic theming (light/dark) ensuring readable contrast — outputs/flutter/lib/app/theme/app_theme.dart
- [x] T017 [P] Wire RootApp to use theme and route to initial page — outputs/flutter/lib/app/root_app.dart
- [x] T018 [P] Document quickstart steps and structure — /Users/ngaitan/Documents/FlutterApp/wind-flutter-app-poc/specs/001-base-app/quickstart.md
- [x] T019 [P] Add README for the Flutter project referencing quickstart — outputs/flutter/README.md

**Checkpoint**: Foundation ready — user story implementation can begin

---

## Phase 3: User Story 1 — View Hello World (Priority: P1) 🎯 MVP

**Goal**: On app launch, display only centered, readable text "Hello World" with no interactive elements

**Independent Test**: Launch on Android and iOS; verify centered text appears and is readable in light/dark

### Implementation

- [x] T020 [US1] Create Hello World page (centered layout, SafeArea, theme-aware) — outputs/flutter/lib/presentation/pages/hello_world_page.dart
- [x] T021 [US1] Localize "Hello World" string key and use it in the page — outputs/flutter/lib/l10n/intl_en.arb
- [x] T022 [US1] Set initial route in RootApp to HelloWorldPage — outputs/flutter/lib/app/root_app.dart

### Tests (minimal, per constitutions)

- [x] T023 [P] [US1] Add widget test asserting "Hello World" is rendered — outputs/flutter/test/widget/hello_world_test.dart
- [x] T024 [P] [US1] Add widget test ensuring no tappable semantics nodes exist — outputs/flutter/test/widget/hello_world_test.dart
- [x] T025 [P] [US1] Add dark-mode rendering test to ensure readability — outputs/flutter/test/widget/hello_world_test.dart

**Checkpoint**: US1 independently functional and testable

---

## Phase 4: User Story 2 — Cross‑platform Run (Priority: P2)

**Goal**: App builds and runs on Android and iOS showing the same static screen

**Independent Test**: Build and run on one Android emulator/device and one iOS simulator/device

### Implementation

- [x] T026 [US2] Set Android minSdkVersion=21 — outputs/flutter/android/app/build.gradle
- [x] T027 [P] [US2] Set iOS platform deployment target to 15.0 — outputs/flutter/ios/Runner.xcodeproj/project.pbxproj
- [x] T028 [P] [US2] Ensure environment mains compile (dev, staging, prod) — outputs/flutter/lib/main_dev.dart

### Validation Artifacts

- [x] T029 [P] [US2] Add smoke run notes (commands + screenshots/links) — outputs/flutter/docs/smoke-checks.md

**Checkpoint**: US2 independently validated by smoke runs

---

## Phase 5: User Story 3 — Responsive Display (Priority: P3)

**Goal**: Text remains centered and fully visible across orientations and text scale sizes

**Independent Test**: Rotate device and adjust system font size; text remains visible and centered with no clipping

### Implementation

- [x] T030 [US3] Ensure text respects textScaleFactor and wraps if needed — outputs/flutter/lib/presentation/pages/hello_world_page.dart

### Tests

- [x] T031 [P] [US3] Add widget test for large `MediaQuery.textScaleFactor` — outputs/flutter/test/widget/hello_world_responsive_test.dart
- [x] T032 [P] [US3] Add widget test for landscape orientation sizes — outputs/flutter/test/widget/hello_world_responsive_test.dart

**Checkpoint**: US3 independently validated for responsiveness

---

## Phase N: Polish & Cross-Cutting Concerns

- [x] T033 Create ADR-0001 deferring monitoring/analytics for base slice — /Users/ngaitan/Documents/FlutterApp/wind-flutter-app-poc/specs/001-base-app/adr/ADR-0001-monitoring-defer.md
- [x] T034 [P] Create ADR-0002 noting state management N/A for static slice — /Users/ngaitan/Documents/FlutterApp/wind-flutter-app-poc/specs/001-base-app/adr/ADR-0002-state-mgmt-na.md
- [x] T035 [P] Add coverage generation script and document usage — outputs/flutter/tool/coverage.sh
- [x] T036 [P] Install and verify git hooks via setup script — outputs/flutter/scripts/setup-githooks.sh
- [x] T037 [P] Ensure pinned versions (no caret/range) in all pubspecs — outputs/flutter/pubspec.yaml
- [x] T038 [P] Create ADR-0003 documenting outputs/flutter not being a Git submodule (exception rationale, risks, mitigation, timebox) — /Users/ngaitan/Documents/FlutterApp/wind-flutter-app-poc/specs/001-base-app/adr/ADR-0003-no-submodule-exception.md
 

---

## Dependencies & Execution Order

### Phase Dependencies

- Setup (Phase 1) → Foundational (Phase 2) → US1 (Phase 3) → US2 (Phase 4) → US3 (Phase 5) → Polish (Final)
- US phases are independently testable; may proceed in priority order

### Task Dependencies (selected)

- T001 → T002 → T003 → T004
- T004 → T009/T010/T011 → T016
- T016 → T019 → T021 → T022/T023/T024
- T025/T026/T027 depend on T002 (project created)
- T029 depends on T019

### Parallel Opportunities

- Marked [P] tasks can run concurrently (different files, no dependency conflicts)
- Within US1 and US3, widget tests (T023–T025, T031–T032) can be authored in parallel
- Environment mains (T010–T012) can be created in parallel

---

## Implementation Strategy

### MVP First (US1 Only)

1. Complete Phase 1 + Phase 2
2. Implement Phase 3 (US1) and tests
3. Validate via `flutter analyze` and widget tests

### Incremental Delivery

1. After MVP, complete US2 to verify Android/iOS builds
2. Complete US3 for responsiveness
3. Polish (ADRs, hooks, coverage)
