# Tasks: Welcome Page

**Input**: Design documents from `/Users/ngaitan/Documents/FlutterApp/wind-flutter-app-poc/specs/1-welcome-page/plan/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, quickstart.md, design-system.md

Note: Tasks use repository-root–relative paths (e.g., `outputs/flutter/...`).

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Ensure theming, localization, and asset wiring are ready for the Welcome Page.

- [X] T001 [P] Verify JPEG asset exists and optimized (≤1080p longest side) — outputs/flutter/assets/images/welcome_bg.jpg
- [X] T002 [P] Add/verify assets mapping in pubspec (`assets/images/`) — outputs/flutter/pubspec.yaml
- [X] T003 Add localization keys `welcomeTagline`, `exploreHeroes` — outputs/flutter/lib/l10n/intl_en.arb
- [X] T004 Ensure Material 3 theme via `ColorScheme.fromSeed` and `useMaterial3: true` — outputs/flutter/lib/app/theme/app_theme.dart

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Centralize constants and routes used by the page.

- [X] T005 [P] Create assets constant file exposing `Assets.welcomeBg` — outputs/flutter/lib/app/assets.dart
- [X] T006 Create routes constants exposing `AppRoutes.welcome` and `AppRoutes.heroes` — outputs/flutter/lib/app/app_routes.dart

## Phase 3: User Stories

### Phase 3 — [US1] See Welcome Page with background, logo, tagline, and CTA

- [X] T007 [US1] Scaffold page file `WelcomePage` — outputs/flutter/lib/presentation/pages/welcome/welcome_page.dart
- [X] T008 [P] [US1] Implement full-screen background with `Image.asset(Assets.welcomeBg, fit: BoxFit.cover)` — outputs/flutter/lib/presentation/pages/welcome/welcome_page.dart
- [X] T009 [P] [US1] Add centered logo + tagline text (localized) and `FilledButton` labeled "Explore Heroes" — outputs/flutter/lib/presentation/pages/welcome/welcome_page.dart
- [X] T010 [P] [US1] Add semantics labels and ensure 60 min hit targets — outputs/flutter/lib/presentation/pages/welcome/welcome_page.dart
- [X] T011 [US1] Set initial route/home to `WelcomePage` — outputs/flutter/lib/app/root_app.dart

### Phase 4 — [US2] Proceed from Welcome to Heroes list via CTA

- [X] T012 [US2] Ensure `AppRoutes.heroes` route exists (create stub page if needed) — outputs/flutter/lib/presentation/pages/heroes/heroes_page.dart
- [X] T013 [US2] Wire CTA `onPressed` to navigate (replace) to `AppRoutes.heroes` — outputs/flutter/lib/presentation/pages/welcome/welcome_page.dart
- [X] T014 [P] [US2] Verify back stack: Welcome not returned to after navigation — outputs/flutter/lib/presentation/pages/welcome/welcome_page.dart

### Phase 5 — [US3] Accessibility & Performance

- [X] T015 [P] [US3] Widget test: renders background, logo, tagline, CTA (light/dark) — outputs/flutter/test/widget/welcome_page_test.dart
- [X] T016 [P] [US3] Integration test: launch app → tap CTA → lands on Heroes list — outputs/flutter/test/integration/welcome_flow_test.dart
- [X] T017 [US3] Precache background in `initState` and ensure first render under 1s after first frame — outputs/flutter/lib/presentation/pages/welcome/welcome_page.dart
- [X] T018 [P] [US3] A11y audit: large text resilience, focus order, contrast via theme roles — outputs/flutter/lib/presentation/pages/welcome/welcome_page.dart

## Final Phase: Polish & Cross-Cutting

- [X] T019 [P] Run `flutter analyze` and fix lints — outputs/flutter/
- [X] T020 [P] Validate no hardcoded strings/colors; constants and localization used — outputs/flutter/
- [X] T021 Update planning docs with any deviations/notes — specs/1-welcome-page/plan/

---

## Dependencies (Story Order)
1. Phase 1 Setup → 2. Phase 2 Foundational → 3. US1 → 4. US2 → 5. US3 → 6. Polish

## Parallel Execution Examples
- T001, T002 can run in parallel.
- Within US1: T008, T009, T010 can run in parallel after T007.
- US3 tests (T015, T016) can run in parallel once US2 is complete.

## Implementation Strategy (MVP First)
- MVP: Complete US1 and US2 (T007–T014) to deliver a functional Welcome → Heroes flow.
- Then add US3 tests/performance/a11y (T015–T018).
- Finish with polish tasks (T019–T021).
