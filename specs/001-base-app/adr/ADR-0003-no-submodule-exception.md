# ADR-0003: Use outputs/flutter as a plain directory (no Git submodule)

Date: 2025-10-31
Status: Accepted (time‑boxed exception)
Feature: 001-base-app
Related: plan.md (Constitution Deviations), tasks.md (T038), quickstart.md, research.md

## Context

The Flutter Constitution (§0.1, §2.3) and Global Constitution (§30) mandate using `outputs/flutter/` as a Git submodule pinned to an independent repository. This enforces isolation, clean boundaries, and independent versioning. For this POC‑level "Hello World" slice, maintainers requested to ignore the submodule rule to simplify bootstrap and avoid creating/managing a separate remote.

## Decision

For feature 001-base-app, we will NOT use a Git submodule. Instead, we will create and maintain a plain directory at `outputs/flutter/` within this repository.

- Submodule requirement: Ignored for this project (exception)
- Directory used: `outputs/flutter/` (plain directory)
- All other constitutional rules still apply (SDK pin via FVM, structure, theming, localization readiness, lint/analyze, tests)

## Consequences

Positive:
- Simpler onboarding and faster POC bootstrap
- Fewer Git operations (no submodule init/update/pin)

Negative (Risks):
- Weaker isolation between platform app and meta repository
- Harder to version/release the Flutter app independently
- CI cannot use submodule cleanliness to detect drift

## Mitigations

- Maintain the same on‑disk layout mandated by the constitutions under `outputs/flutter/`
- Keep all Flutter sources, tests, configs, and scripts scoped under `outputs/flutter/`
- Enforce pinned Flutter SDK via FVM (`.fvm/fvm_config.json`)
- Add CI checks to ensure no Flutter sources appear outside `outputs/flutter/`
- Document this exception in plan.md (Constitution Deviations), quickstart.md Notes, and research.md Decisions

## Timebox / Expiry

- This exception applies only to the 001-base-app feature scope (Hello World POC).
- Revisit at the first production‑ready release gate or when adding the first non‑trivial feature requiring releases.
- Target review date: 2025-12-31 (or earlier if scope expands).

## Alternatives

- Use a Git submodule per constitutions (Preferred long‑term). Rejected for this POC due to setup overhead.
- Place Flutter app at repo root. Rejected as it breaks output directory rules and increases coupling.

## References

- Global Constitution: `.specify/memory/constitution.md` §30 Output Directory Convention
- Flutter Constitution: `.specify/memory/Flutter/fl-constitution.md` §0.1 Outputs as Git Submodule, §2.3 Output Directory Compliance
- Plan: `specs/001-base-app/plan.md` (Constitution Deviations section)
- Tasks: `specs/001-base-app/tasks.md` (T038)
- Quickstart: `specs/001-base-app/quickstart.md`
- Research: `specs/001-base-app/research.md`

## Implementation Notes

- tasks.md includes T038 to create this ADR.
- quickstart.md and tasks.md were updated to remove submodule steps.
