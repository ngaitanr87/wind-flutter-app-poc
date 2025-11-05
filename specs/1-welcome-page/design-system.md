# Material 3 Design System — Welcome Page (Marvel Heroes App)

- Figma: https://www.figma.com/design/hxNszzU4QSN87LXmjC7Wer/Marvel-heroes-app?node-id=7-512
- Scope: Entire page (metadata shows frames for App bar, Search, Hero list/cards, Buttons, Inputs, Toggles, Slider, Icon buttons, and Card demos)
- Conformance: Strict Material 3. Use only ColorScheme roles, default shapes/elevations/state layers. Avoid ad‑hoc tokens (e.g., custom spacing/color tokens) and brand-tinted glows. Follow M3 contrast guidance.

## Foundations

### Color System (Material 3)
- Use `ColorScheme.fromSeed(seedColor: Color(0xFFFF0000))` for both light and dark.
- Do not hardcode `on*` roles (e.g., `onPrimary`). Rely on computed roles for accessibility.
- Use roles consistently:
  - Primary actions: `primary` / `onPrimary`
  - Surfaces: `surface`, `onSurface`, with containers like `surfaceContainer`, `surfaceContainerLow` for Cards/Lists
  - Secondary/tertiary as needed by future features
- Dark theme: also derived from the same seed; no separate manual palette.

### Typography (Material 3 defaults)
- Keep default M3 text styles. Map Figma text usages to M3 styles instead of defining new sizes:
  - Page/section headings shown as “Heading 3/4” → use `HeadlineSmall` / `TitleLarge` appropriately.
  - Card title (e.g., “Iron Man”) → `TitleMedium` or `TitleLarge` depending on hierarchy.
  - Body copy (e.g., hero description) → `BodyMedium`.
  - Button labels → `LabelLarge`.
  - Input labels/hints → `BodySmall`/`BodyMedium` per component defaults.

### Layout, Density, and Spacing
- Use implicit 8dp baseline. Do not introduce spacing tokens.
- Minimum interactive size 48x48dp.
- Use component defaults for paddings/margins; adjust locally via widget parameters only when necessary.

### Shapes and Elevation
- Use default M3 shapes:
  - Buttons: 20dp corner radius.
  - Cards: default M3 radius (12dp in Flutter M3).
- Use default elevation scale and state layers; do not add colored shadows/glows.

## Components and Patterns (page-wide)

The page metadata shows the following structures and components. Implement each with standard M3 widgets and roles.

### 1) App Bar / Top Area
- Use `AppBar` (M3). Title or logo centered if desired.
- Colors: `surface` with `onSurface`.
- Scrolling behavior: `SliverAppBar` with `pinned` if lists are long.

### 2) Search Input
- Implement with `TextField` using `InputDecoration`:
  - Variant: filled or outlined; prefer filled for dense toolbars.
  - `prefixIcon: Icon(Icons.search)`.
  - `hintText: 'Search heroes…'` (from Figma).
  - Colors from `colorScheme`.

### 3) Hero List
- Use `ListView.separated` or `SliverList` with `separatorBuilder`.
- Each item is a Card-like row (see Hero Card below).
- Scrolling physics default; support very long lists.

### 4) Hero Card (list item)
- Structure (from Figma): thumbnail + title + body + trailing icon button.
- Implement with `Card` + `ListTile` or a custom `Row` inside `Card`.
  - Background: `surfaceContainerLow` or default Card surface.
  - Title style: `TitleMedium`/`TitleLarge`.
  - Subtitle/body: `BodyMedium` with 2-line max, ellipsis.
  - Leading: 56dp image; rounded corners optional but stay within M3 defaults.
  - Trailing: `IconButton` (standard or filled tonal as needed).
- Elevation: default (avoid tinted shadows).

### 5) Buttons (Primary/Outlined/Text)
- Map Figma “Primary Button” → `FilledButton`.
- Map “Outline Button” → `OutlinedButton`.
- Map “Ghost Button” → `TextButton`.
- Use default shapes (20dp) and sizes. If size variants (Small/Default/Large) are required for layout parity, adjust at call sites with `styleFrom(minimumSize, padding)` but do not create new size tokens.
- Colors derive from `colorScheme` roles automatically.

### 6) Icon Buttons (group demo in Figma)
- Use M3 `IconButton` variants as needed: standard, `IconButton.filled`, `IconButton.filledTonal`, `IconButton.outlined`.
- Respect 48dp target size; icons ~24dp.

### 7) Checkbox, Switch, Slider
- Use M3 widgets `Checkbox`, `Switch`, `Slider` directly.
- They take colors from `ColorScheme`; do not hardcode.
- Follow default a11y states/gestures.

### 8) Cards (demo section)
- Use `Card` with default radius and elevation.
- For “Card with Image”, place image as header (top) followed by title/body.
- Text styles per Typography mapping.

## Theming in Flutter (minimal and strictly M3)

```dart
import 'package:flutter/material.dart';

ThemeData buildAppTheme(Brightness brightness) {
  final scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFFFF0000),
    brightness: brightness,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    // Keep defaults to honor M3. Add local overrides only when needed.
  );
}
```

### Component usage examples

> Note: Keep to defaults; set parameters per-instance if layout needs slight adjustments. Avoid creating global ad‑hoc tokens.

```dart
// Search field
TextField(
  decoration: const InputDecoration(
    hintText: 'Search heroes…',
    prefixIcon: Icon(Icons.search),
    filled: true,
    border: OutlineInputBorder(),
  ),
)
```

```dart
// Hero card (compact)
Card(
  child: ListTile(
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(imageUrl, width: 56, height: 56, fit: BoxFit.cover),
    ),
    title: const Text('Iron Man'),
    subtitle: const Text(
      'Genius billionaire inventor with powered armor suit',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
    trailing: IconButton(
      icon: const Icon(Icons.more_vert),
      onPressed: onMore,
    ),
    onTap: onTap,
  ),
)
```

```dart
// Buttons
FilledButton(onPressed: onPrimary, child: const Text('Primary'));
OutlinedButton(onPressed: onOutline, child: const Text('Outlined'));
TextButton(onPressed: onText, child: const Text('Text'));
```

```dart
// Controls
Checkbox(value: checked, onChanged: onChecked);
Switch(value: enabled, onChanged: onToggled);
Slider(value: value, onChanged: onChanged);
```

## Accessibility
- Contrast: rely on `on*` roles from the ColorScheme. Do not force white/black labels.
- Hit targets: 48x48dp min; add padding/constraints at call sites if needed.
- Text scaling: ensure layouts are resilient to large fonts.
- Semantics: labels for images and buttons; avoid icon-only without `tooltip` where appropriate.

## Figma alignment notes
- Remove red glow/shadows from previous CTA samples. Use state layers/elevation.
- Button radius: 20dp (M3 default). Cards: default M3 radius.
- Use primary/containers/surface roles instead of fixed colors in Figma tokens.

## Implementation Checklist
- MaterialApp uses `buildAppTheme` for light/dark via `theme`, `darkTheme`, `themeMode`.
- Replace any hardcoded whites/reds in widgets with ColorScheme roles.
- Audit buttons/inputs in the Welcome page to ensure:
  - Mapped to Filled/Outlined/Text appropriately.
  - Default shapes/elevations are used.
  - No ad-hoc spacing/color tokens remain.

---
Status: Generated from Figma page metadata (node 7:512) with strict Material 3 guidance. If you need me to also scaffold/upsert Flutter theme and update the Welcome screen widgets, I can open a PR.
