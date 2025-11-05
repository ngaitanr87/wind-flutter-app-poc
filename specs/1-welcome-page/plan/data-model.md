# Data Model — Welcome Page

This feature introduces no persistent domain/data entities.

## UI Constants (Presentation)
- `Assets.welcomeBg`: String path to background image
- `Strings.exploreHeroes`: Localized button label key
- `Strings.welcomeTagline`: Localized tagline key
- `AppRoutes.heroes`: Route name/path for Heroes list

## Validation Rules
- Text is localized via ARB keys (no hardcoded strings)
- Contrast ensured by Material 3 color roles
- Touch targets ≥48dp

## State & Lifecycle
- Precache background image on page init
- Navigate to Heroes list on primary action
