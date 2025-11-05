# Quickstart — Implement Welcome Page (Material 3)

1) Assets
- Background image is available at:
  - `outputs/flutter/assets/images/welcome_bg.svg`
- Option A (keep SVG): add to `pubspec.yaml` assets and render via a core wrapper over `flutter_svg` (e.g., `VectorAssetWidget`), not directly in UI.
- Option B (rasterize): convert to `welcome_bg.webp` (≤1080p longest side), reference via `Image.asset`.
- Update `outputs/flutter/pubspec.yaml` → `assets:` include `assets/images/`

2) Strings (i18n)
- Add to ARB (e.g., `app_en.arb`):
  - `"welcomeTagline": "Heroes aren't Born. They're Built."`
  - `"exploreHeroes": "Explore Heroes"`
- Run your l10n generator as configured

3) Theme (Material 3)
- Ensure `useMaterial3: true` and `colorScheme: ColorScheme.fromSeed(...)` in app theme

4) Page
- Create `outputs/flutter/lib/presentation/pages/welcome/welcome_page.dart`
- Build layout: full-screen background (SVG wrapper or raster `Image.asset` with `BoxFit.cover`), logo, tagline, `FilledButton` labeled "Explore Heroes"
- Precache background image in `initState`

5) Navigation
- Define route for Welcome and Heroes list (if not present)
- On button press: replace route to Heroes list

6) Testing
- Widget tests for render and tap → navigation intent
- Integration test: launch app, tap CTA, verify Heroes list screen

7) Accessibility & Perf
- Provide semantics labels; verify focus order
- Ensure 48dp min targets; validate contrast via color roles
- Confirm initial render meets 1s target after first frame
