# Implementation Plan: Welcome Page

**Branch**: 001-welcome-page | **Date**: 2025-11-05 | **Spec**: specs/1-welcome-page/spec.md
**Input**: Feature specification from `/specs/1-welcome-page/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

Replace the initial Hello World with a Material 3 Welcome Page featuring a full-bleed background, centered logo, tagline, and a single primary action “Explore Heroes” that navigates directly to the Heroes list. Use ColorScheme roles, localize user strings, and precache the background to meet the 1s render target.

## Technical Context

<!--
  ACTION REQUIRED: Replace the content in this section with the technical details
  for the project. The structure here is presented in advisory capacity to guide
  the iteration process.
-->

**Language/Version**: Flutter (FVM pinned 3.35.0)  
**Primary Dependencies**: Flutter SDK, Material 3 (ThemeData.useMaterial3), optional flutter_svg via core wrapper  
**Storage**: N/A  
**Testing**: flutter_test, integration_test  
**Target Platform**: iOS/Android  
**Project Type**: mobile  
**Performance Goals**: First UI within 1s after first frame; responsive at 60fps  
**Constraints**: No hardcoded colors/strings; 48dp min targets; localized text  
**Scale/Scope**: Single screen + navigation to Heroes list

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- Output directory convention (`outputs/flutter/`) → OK
- Material 3 theming and i18n → OK
- Pinned versions (FVM 3.35.0) → OK
- Testing (widget + integration) → Planned
- Prohibited practices (no hardcoded colors/strings; asset constants) → Planned
- Core Abstraction: If SVG kept, wrap flutter_svg behind core widget; else rasterize → Planned

## Project Structure

### Documentation (this feature)

```text
specs/1-welcome-page/
├── plan/                # Planning artifacts
│  ├── plan.md
│  ├── research.md
│  ├── data-model.md
│  ├── quickstart.md
│  └── contracts/
└── spec.md             # Feature specification
```

### Source Code (submodule root `outputs/flutter/`)

```text
outputs/flutter/
├── assets/
│  └── images/
│     └── welcome_bg.jpg
├── lib/
│  ├── app/
│  │  └── theme/
│  └── presentation/
│     └── pages/
│        └── welcome/
│           └── welcome_page.dart
└── test/
   ├── widget/
   └── integration/
```

**Structure Decision**: Mobile app structure under `outputs/flutter/` per constitutions. Feature docs live in `specs/1-welcome-page/plan/`. Assets under `outputs/flutter/assets/images/`.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| [e.g., 4th project] | [current need] | [why 3 projects insufficient] |
| [e.g., Repository pattern] | [specific problem] | [why direct DB access insufficient] |
