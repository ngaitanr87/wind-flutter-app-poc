# ADR-0001: Defer Monitoring & Analytics Integration

Date: 2025-10-31
Status: Accepted (temporary deferral)
Feature: 001-base-app
Related: plan.md (Constitution Deviations), tasks.md (T033)

## Context

Global Constitution §14 and Flutter Constitution §16 require integrating Crashlytics/Analytics in every feature. The base app feature is a static "Hello World" screen without navigation, state, or network traffic. Implementing monitoring at this stage provides no actionable signals, adds setup overhead, and complicates the lightweight POC.

## Decision

Delay integrating monitoring/analytics until the first feature that introduces meaningful user flows. This ADR documents the temporary deviation and its constraints.

## Consequences

Positive:
- Faster delivery of the base POC.
- Avoids premature coupling to telemetry vendor configuration.

Negative:
- No runtime crash or analytics visibility for this slice.
- Requires follow-up work before production release.

## Mitigations

- Revisit during the first production-ready feature.
- Track this ADR in the backlog with a due date.
- Define a standard monitoring template (Crashlytics + Analytics) to integrate when scope expands.

## Expiry / Follow-up

- Must be revisited by **2026-01-31** or once the next feature introduces any interactive flow—whichever comes first.
- Removal criteria: monitoring integrated, ADR marked superseded.
