# Implementation Plan — Welcome Page

Metadata
- Feature: 1-welcome-page
- Spec: ../spec.md
- Constitutions: ../../.specify/memory/constitution.md, ../../.specify/memory/Flutter/fl-constitution.md
- Design system: ../design-system.md
- Branch: 001-welcome-page

## Technical Context
- Platform: Flutter (outputs/flutter)
- Design system: Material 3 (`ThemeData.useMaterial3 = true`, `ColorScheme.fromSeed`)
- Target screen: `WelcomePage` with background image, logo, tagline, primary action "Explore Heroes"
- Navigation: on primary action → Heroes list screen
- Internationalization: strings for tagline and button label
- Accessibility: semantics labels, 48dp min targets, contrast via `on*` roles
- Performance target: first UI under 1s after first frame; precache background image
- Assets: background image at `outputs/flutter/assets/images/welcome_bg.jpg` (provided). Register in pubspec.
- Recommendation: Optimize image size (≤1080p longest side) and use `BoxFit.cover`.

### Unknowns / Risks
- Flutter SDK pin: RESOLVED. FVM pinned to 3.35.0; constitution updated accordingly.
- Analytics baseline (Crashlytics/Analytics) required by constitution is cross-cutting. Out of scope for this feature, but ensure project baseline exists.

## Constitution Check (Pre-Design)
- Directory convention `outputs/flutter/`: Will place code and assets inside submodule → OK
- Clean Architecture: Pure UI page; no domain/data changes → OK
- Theming & Resources: Material 3 mandatory → OK (use ColorScheme roles)
- i18n: All user text must be localizable → Plan includes ARB keys → OK
- Testing: Widget + navigation tests required → Planned
- Pinned versions: FVM pin 3.35.0 → OK (ensure local env matches)
- Prohibited practices: No hardcoded colors/paths in widgets (wrap paths in constants) → Planned
- Third-party packages: None required for background (using JPEG asset).

Gate status: Proceed (SDK pin resolved).

---

## Phase 0 — Outline & Research
- Research items are captured in `research.md` with decisions, rationale, and alternatives:
  - M3 mapping for CTA → `FilledButton`
  - Background performance (precache, size)
  - i18n keys and placement
  - Accessibility labels and focus order
  - Route naming and navigation pattern

Output: ../plan/research.md

---

## Phase 1 — Design & Contracts

### Data Model
- No persistent data entities introduced.
- App constants:
  - Asset path constant for background (e.g., `Assets.welcomeBg`)
  - Route name constant for heroes list (e.g., `AppRoutes.heroes`)
  - String keys for `exploreHeroes`, `welcomeTagline`

Output: ../plan/data-model.md

### Contracts
- No external APIs introduced by this feature.
- Navigation contract: Welcome → Heroes list (replace current route).

Output: ../plan/contracts/README.md

### Agent Context Update
- Script `.specify/scripts/bash/update-agent-context.sh` not found.
- Action: Record planning deltas in this plan and design-system; skip script execution.

---

## Phase 2 — Implementation Plan (Tasks)

### A. Assets & Pubspec
- Use existing image at `outputs/flutter/assets/images/welcome_bg.jpg`.
- Update `outputs/flutter/pubspec.yaml` → `assets:` include `assets/images/`

### B. Theme & Design System
- Ensure `ThemeData` uses Material 3 with `ColorScheme.fromSeed`
- No custom tokens; use defaults per design-system.md

### C. Strings (i18n)
- Add keys to ARB (e.g., `app_en.arb`):
  - `welcomeTagline`: "Heroes aren't Born. They're Built."
  - `exploreHeroes`: "Explore Heroes"
- Generate localization artifacts if l10n already configured

### D. Welcome Page UI (Presentation)
- File: `outputs/flutter/lib/presentation/pages/welcome/welcome_page.dart`
- Layout:
  - Full-screen `Stack` with `Image.asset(Assets.welcomeBg, fit: BoxFit.cover)`
  - Centered logo (per Figma), tagline text, and `FilledButton` labeled "Explore Heroes"
  - Use semantics labels and tooltips where relevant
  - Precache background in `initState`

### E. Navigation
- Add route for Welcome and Heroes (if not present)
- On button press → navigate to Heroes list (replace)
- Ensure deep link/startup route points to Welcome

### F. Accessibility & Performance
- Verify contrast via theme roles; label controls with semantics
- 48dp min touch targets; adequate padding
- Precache background and defer heavy work until after first frame

### G. Testing
- Widget test: renders logo/tagline/button under light/dark theme
- Widget test: tapping button triggers navigation intent
- Integration test: app starts at Welcome; tapping button goes to Heroes list

### H. Compliance
- No hardcoded strings/colors in widgets
- Asset path via constants
- Validate CI gates (lint, analyze, tests)

---

## Deliverables
- UI page + navigation wiring
- Localized strings
- Asset added and referenced via constants
- Tests (widget + integration)
- Docs updated: design-system alignment preserved

## Post-Plan Next Steps
- Implement tasks on branch `1-welcome-page`
- Open PR with checklist entries referencing constitution gates
- Resolve Flutter SDK pin if mismatch remains
