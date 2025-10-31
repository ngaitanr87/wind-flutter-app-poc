# ADR-0002: Defer flutter_bloc Adoption for Static Slice

Date: 2025-10-31
Status: Accepted (temporary deferral)
Feature: 001-base-app
Related: plan.md (Constitution Deviations), tasks.md (T034)

## Context

Flutter Constitution §13 mandates the use of `flutter_bloc` (Bloc/Cubit) for presentation state management. The base app feature renders a static "Hello World" screen with no mutable state or user interactions. Introducing Bloc scaffolding for a static widget would add boilerplate without exercising the pattern in a meaningful way.

## Decision

Postpone creating Bloc scaffolding until the first interactive feature. Keep the dependency pinned in `pubspec.yaml` to signal the chosen pattern and ensure follow-up work can wire blocs quickly.

## Consequences

Positive:
- Minimizes boilerplate in the initial POC while keeping the dependency available.
- Avoids designing Bloc contracts prematurely without real state transitions.

Negative:
- No executable reference implementation of Bloc exists yet.
- Additional work required when introducing the first interactive flow.

## Mitigations

- Document this exception and revisiting criteria within this ADR.
- Ensure future features add Bloc-based presentation before release.
- Maintain directory structure (`lib/presentation/`) ready for Bloc modules.

## Expiry / Follow-up

- Revisit by **2026-01-31** or when the next feature introduces stateful behavior—whichever comes first.
- This ADR is superseded once a Bloc-based screen is added and tested.
