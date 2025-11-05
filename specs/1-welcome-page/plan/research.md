# Research — Welcome Page

## Decision: CTA widget type
- Chosen: Material 3 `FilledButton`
- Rationale: Primary action prominence aligns with M3; uses `primary`/`onPrimary` roles automatically
- Alternatives: `ElevatedButton` (legacy style), `FilledTonalButton` (lower emphasis)

## Decision: Navigation target
- Chosen: Heroes list screen
- Rationale: Immediate access to core value; scope remains focused
- Alternatives: Tabbed home defaulting to Heroes

## Decision: Show frequency
- Chosen: Every app launch
- Rationale: Consistent branding and deterministic entry; matches spec decision
- Alternatives: First launch only; until disabled in settings

## Decision: Background image performance
- Chosen: Local JPEG asset at `outputs/flutter/assets/images/welcome_bg.jpg` (≤1080p longest side). WebP also acceptable.
- Rationale: Minimal decode/render overhead; no extra dependencies needed.
- Alternatives: SVG via wrapper (adds dependency), remote image (network dependency), oversized raster (heavier)

## Decision: Localization
- Chosen: ARB keys `welcomeTagline`, `exploreHeroes`
- Rationale: Constitution requires all user text localizable
- Alternatives: Hardcoded strings (prohibited)

## Decision: Accessibility
- Chosen: Semantics labels for CTA and logo; use theme roles for contrast
- Rationale: WCAG alignment, constitution mandates
- Alternatives: Icon-only without labels (insufficient)

## Open Items
None.
