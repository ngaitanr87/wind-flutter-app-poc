<!--
Sync Impact Report
Version: (previous unknown) -> v1.1.0
Modified Sections: Added Governance & Versioning; Removed duplicate Compliance Checklist (second Section 22)
Added Sections: Governance & Versioning
Removed Sections: Duplicate Compliance Checklist (second occurrence after Git Hooks)
Templates Updated: 
- .specify/templates/plan-template.md ✅ (Constitution gates list)
- .specify/templates/spec-template.md ✅ (English-only note)
- .specify/templates/tasks-template.md ✅ (English-only note)
Follow-up TODOs:
- TODO(RATIFICATION_DATE): Original adoption date not recorded; set after historical confirmation.
- Verify platform-specific constitutions (e.g., flutter) align with new governance review cadence.
-->

# Mobile App Constitution [MANDATORY]

Constitution Version: v1.1.0  
Ratification Date: TODO(RATIFICATION_DATE): Original adoption date unknown; determine from initial commit history.  
Last Amended Date: 2025-10-23

This document defines mandatory standards for designing, generating, and evolving multi-platform Clean Architecture projects (Android, iOS, React Native, Flutter). All specs MUST comply. The Flutter-specific constitution (`.specify/memory/flutter/constitution.md`) extends this base; if conflicts arise, the global constitution prevails unless an ADR explicitly grants a platform exception with expiry.

**SpecKit Integration Guidance:**

- All rules, practices, and outputs defined herein are to be optimized for programmatic evaluation and automation by SpecKit toolchain.

- The constitution MUST be maintained in a machine-parseable, single-source-of-truth Markdown format for direct consumption by SpecKit.
- Section numbering, headings, and enforcement requirements (MANDATORY/NON-NEGOTIABLE) MUST remain explicit and consistently structured for SpecKit rule extraction.
- Output directory enforcement, CI gates, template references, and compliance checks MUST be kept up-to-date for SpecKit automation compatibility.

## 1. Glossary [MANDATORY]

- Clean Architecture Layer: Logical boundary (Presentation, Domain, Data) with restricted dependency direction.
- Use Case: A single application-specific business action encapsulated in a pure/service function.
- Repository: Abstraction mediating between domain and data sources (remote, cache, local) with offline support.
- DI Container: Mechanism that wires abstractions to implementations at bootstrap.
- ADR (Architecture Decision Record): Concise document capturing a significant technical choice, context, decision, consequences.
- Offline-first: Strategy ensuring core functionality remains usable without network; sync when connectivity returns.
- Pinned Version: Exact immutable dependency version (no range/caret).
- Feature Branch: Short-lived branch implementing a single scoped change merged via squash into main.
- Core packages -> Abstractions of third party dependencies.

---

## 2. Architecture [MANDATORY]

### 2.1 Layer Model [NON-NEGOTIABLE]

- Presentation: UI + user interaction (should only reference Domain).
- Domain: Business logic (should only reference Data). Framework-agnostic.
- Data: Persistence, external services Framework-agnostic.
- Core packages: Asbtraction of any third party library ( ecapsulation enforcement)
- Core libraries must fallow engine pattern to enforce scalability.

### 2.2 Dependency Rules

- Allowed: Presentation → Domain; Domain → Data; Data → Core -> Third-party / native services.
- No other cross-layer references.

### 2.3 Isolation

- Each layer MUST be an isolated module/subpackage with explicit public contracts.

### 2.4 Repositories & Offline

- Repository layer in Data MUST exist and support offline-first strategies where relevant.

### 2.5 Plugins & Services

- Native plugins and third-party integrations MUST reside in Data only.

### 2.6 Use Cases Style

- Use cases MUST be pure where possible, prefer functional patterns (Result/Either), avoid side effects, and expose explicit error models.

---

## 3. Code Quality & Testing [MANDATORY]

### 3.1 Style & Consistency

- Formatting, naming conventions, and documented patterns MUST be enforced. Linters MUST pass.
- **Every function and class MUST be documented in code, always in English.**
- **All specification documents (feature specs, checklists, ADRs, prompts, generated outputs) MUST be written 100% in English (no mixed language).**
- **Linters for each technology MUST be configured to enforce documentation and code style rules.**

### 3.2 Static Analysis

- Static analysis MUST report zero errors before merge.

### 3.3 Testing Scope

- 100% unit test coverage.
- Unit, integration, and UI tests for all flows.
- Coverage runs MUST generate reports (lcov where supported).

### 3.4 Build Validation

- Every merge MUST validate a successful build pipeline (lint + tests + coverage + analysis).
- Include githook implementations.

---

## 4. Dependency Management [MANDATORY]

- MUST use approved package managers.
- MUST pin exact versions (e.g., "1.0.1"); MUST NOT use ranges/caret.
- MUST review/update dependencies regularly.
- MUST audit transitive dependencies for risk and licenses.

---

## 5. Documentation & Knowledge [MANDATORY]

- README, API docs, and architecture overviews MUST stay current.
- Complex logic MUST include inline explanatory comments.
- Architectural decisions MUST be recorded (ADR).
- Periodic reviews and knowledge sharing MUST occur.

---

## 6. Error Handling & Resilience [MANDATORY]

- Errors MUST be explicit (no silent failures).
- User feedback MUST be clear, actionable, localized.
- Retry, backoff, and timeout MUST be implemented for network calls ( always respecting the core abstration rules).
- Error logging MUST exclude sensitive data.

---

## 7. Security & Privacy [MANDATORY]

- Sensitive data MUST use secure storage or hardware storage like secure enclave or keystores (ask any time to the dev can chose the right option depends of the context).
- All network calls MUST use HTTPS (or approved secure transport).
- Data access MUST follow least-privilege.
- Privacy regulations (e.g., GDPR, CCPA) MUST be respected.
- MUST align with OWASP Mobile Top 10, ASVS, MASTG.
- Third-party SDKs MUST be reviewed for compliance/security.

---

## 8. Environments & Configuration [MANDATORY]

- MUST support development, staging, production.
- Bootstrap MUST initialize modules and DI cleanly.
- Environment-specific settings MUST NOT leak into Domain.

---

## 9. Dependency Injection [MANDATORY]

- Dedicated DI containers per layer REQUIRED.
- Interfaces define contracts; implementations swappable.
- Bootstrap MUST avoid cyclic dependencies.

---

## 10. Internationalization & Formatting [MANDATORY]

- All user-visible text MUST be localizable.
- Locale fallback MUST be implemented.
- Data→UI text mapping via extensions.
- Number/date/currency formatting via formatters + extensions.
- Formatters/helpers in presentation/app/common.

---

## 11. Context Isolation [MANDATORY]

- Framework context ONLY in Presentation.
- Domain/Data entities/states MUST NOT hold context.
- Use adapters/extensions for context-bound logic.

---

## 12. Theming & Resources [MANDATORY]

- Light and dark themes REQUIRED.
- Timings, dimensions, asset URLs, colors, tokens in app/theme.
- Use enums/constants (no magic values).
- Asset variants MUST match active theme.

---

## 13. Performance & Efficiency [MANDATORY]

- Monitor startup time, memory, battery.
- Optimize/offload heavy operations.
- Apply offline-first where appropriate.

---

## 14. Monitoring & Analytics [MANDATORY]

- Integrate analytics + crash reporting.
- Track launches, usage, performance, errors.
- **Firebase Crashlytics, Analytics, and Performance Monitoring MUST be integrated as minimum monitoring tools.**
- Review reports; recurring issues MUST produce action items.

---

## 15. Backward Compatibility [MANDATORY]

- Data migrations MUST be versioned, idempotent, tested.
- Deprecations MUST have timelines.
- Upgrades MUST preserve data.
- Feature removal MUST be graceful (toggles/fallback).

---

## 16. Open Source Compliance [MANDATORY]

- Licenses for all dependencies MUST be validated.
- Incompatible licenses block merge.
- Distribution acknowledgments generated when required.

---

## 17. Release Management [MANDATORY]

- Document build → QA → deploy process.
- Release notes MUST list: Added / Changed / Fixed / Removed / Security / Known Issues.
- Notes MUST reference tracking IDs & migrations.
- Tested rollback strategy REQUIRED.

---

## 18. Incident Management [MANDATORY]

- Maintain incident playbook (detection → rollback).
- Post-mortems for production-impacting incidents.
- Action items MUST have owners & timelines.

---

## 19. Continuous Improvement [MANDATORY]

- Track technical debt.
- Refactor regularly without behavior change.
- Automate repetitive tasks.
- Prefer composition over inheritance.

---

## 20. API & Public Interfaces [MANDATORY]

- Public APIs/contracts MUST be versioned.
- Follow semantic versioning where applicable.
- Breaking changes MUST include migration guidance.

---

## 21. Directory Structure (Reference) [MANDATORY]

``` shell
# Cross-platform generic (legacy layout)
src/
  app/
    common/
    theme/
  features/
    <feature_name>/
      widgets/
      <feature_root>
domain/
  ...
data/
  ...
```

All modules MUST follow layering and dependency rules.

### 21.1 Modular Output Convention (Preferred) [MANDATORY]

For each technology, prefer an output-scoped, modular layout under `./outputs/<framework>/` to enforce isolation, artifact scoping, and extraction readiness:

``` shell
outputs/<framework>/
  pubspec/package manifest (or build config)
  lib/ or src/ (presentation + bootstrap for UI frameworks)
  packages/ (pure domain + data packages; no framework imports in domain/data)
  scripts/ (quality + automation for that platform only)
  .githooks/ (platform-scoped hooks overriding or complementing root hooks)
  .github/ (workflow files specific to platform if needed)
  test/ (integration + cross-package tests)
```

Rules:

- Domain & data packages MUST be framework-agnostic (no UI/context imports) [NON-NEGOTIABLE].
- Presentation/UI code MUST not import data implementations directly; use injected domain interfaces.
- Generated or tool-managed code MUST remain inside `outputs/<framework>/`.
- Platform-specific scripts/hooks MUST live inside the corresponding output directory (e.g., `outputs/<framework>/scripts/`).

---

## 22. Compliance Checklist (CI Gate) [MANDATORY]

Before merge (per platform):

- Lint: PASS
- Static Analysis: 0 errors
- Tests: Required coverage (platform baseline; 100% for domain/data critical logic)
- Build: PASS
- Local Build (pre-push hook): PASS
- Git Hooks (presence & execution): PASS (root or platform-scoped)
- Coverage Report: Generated
- License Scan: PASS
- Localization completeness: PASS
- Dependency versions: Pinned (no caret/range/any)
- Release notes (if release): Present
- Output directory convention: Enforced (`./outputs/<framework>/`)

---

## 23. Non-Functional Guarantees [MANDATORY]

- Reliability: Retry + fallback for critical flows.
- Observability: Logs, metrics, traces enable diagnosis.
- Maintainability: Decoupled modules.
- Portability: Domain free of platform APIs.
- Scalability: Data abstractions adaptable.

---

## 24. Prohibited Practices [MANDATORY]

- Cross-layer shortcuts.
- Hard-coded strings/numbers/asset paths.
- Context leakage outside Presentation.
- Unpinned versions.
- Silent catch blocks.
- Business logic in UI components.
- Global mutable shared state.
- Platform code outside `outputs/<framework>/` without ADR.

---

## 25. Enforcement [MANDATORY]

- CI MUST block violations where automated.
- Manual review covers gaps.
- Repeated violations trigger remediation.

---

## 26. Evolution [MANDATORY]

- Changes MUST be reviewed, versioned.
- Deprecations MUST define migration path & timeline.
- Historical versions accessible.

### 26.1 Governance & Versioning [MANDATORY]

- Amendment Procedure: Propose change via PR including diff + ADR rationale. Must be reviewed by 2 maintainers (or 1 maintainer + 1 platform lead) before merge.
- Version Policy (Semantic):
  - MAJOR: Backward-incompatible removal/redefinition of principles or compliance gates.
  - MINOR: Addition of new principles/sections or material expansion changing required behavior.
  - PATCH: Clarifications, wording, typo fixes, non-semantic refinements.
- Version Increment Flow: Determine bump type in PR description; reviewers MUST confirm classification.
- Review Cadence: Quarterly governance review (security, external standards, toolchain updates).
- Compliance Audits: Monthly automated report (lint, test coverage, dependency pinning, license scan). Exceptions require ADR with expiry date.
- Platform Extensions: Platform-specific constitutions MAY add stricter rules but MUST NOT weaken global ones without an ADR.
- Deferred TODOs: MUST be resolved or re-validated at next quarterly review.
- Historical Archive: Previous versions retained in Git tags referencing constitution version (e.g., `constitution-v1.1.0`).

---

## 27. Branch Strategy (Flutter Flow) [MANDATORY]

- Linear history on main (no merge commits).
- Short-lived feature branches.
- Squash merges produce single commit.
- Semantic version tags (e.g., v1.4.2) on main.
- Hotfix from latest tag; squash back with patch bump.
- Only release/tag/emergency hotfix commits directly on main.
- CI enforces squash, rebase, successful pipeline before tag.
- Conventional commit messages after squash (feat:, fix:, perf:, refactor:, docs:, test:, chore:).
- Release commit aggregates changelog since previous tag.
- Branch naming:
  - feature/<ticket-id>-<short-description>
  - fix/<ticket-id>-<short-description>
  - hotfix/<ticket-id>-<short-description>
- Tags immutable (no retagging).
- Automated changelog from conventional commits.

---

## 28. External Standards & References [MANDATORY]

- Semantic Versioning (https://semver.org/) MUST be used for all release tags and public APIs.
- Conventional Commits (https://www.conventionalcommits.org/en/v1.0.0/) MUST be used for commit messages.
- OWASP Mobile Top 10, MASTG, ASVS for security.
- WCAG for accessibility.
- GDPR/CCPA for privacy.
- ISO/IEC 25010 for software quality.
- Deviations MUST be justified in ADRs.
- References MUST be reviewed quarterly.

---

## 29. Design Patterns & Principles [MANDATORY]

- SOLID principles MUST be applied in all layers and modules.
- Abstractions/interfaces MUST be defined for all contracts; implementations MUST be swappable.
- Design patterns (e.g., Factory, Singleton, Adapter, Strategy, Observer) SHOULD be used where appropriate to improve maintainability, testability, and extensibility.
- Violations of SOLID or design pattern misuse MUST be flagged in code review and CI linting where possible.

---

## 30. Output Directory Convention [MANDATORY]

- All generated code, documentation, and artifacts MUST be placed under `./outputs/<framework>`.
- Each platform may maintain its own hooks/scripts inside `./outputs/<framework>/.githooks` and `./outputs/<framework>/scripts`.
- Root-level tooling MAY exist for shared tasks but MUST NOT duplicate platform-specific logic unnecessarily.
- CI and manual review MUST verify compliance (no stray source outside platform output except shared meta tooling).

---

## 31. Git Hooks & Local Quality Enforcement [MANDATORY]

- SpecKit MAY be configured to generate, validate, and install hooks across root and platform outputs as described.
- Hooks MAY be centralized at repo root (`.githooks/`) OR scoped per platform under `./outputs/<framework>/.githooks`.
- Required hook behaviors (irrespective of location):
  - `pre-commit`: formatting, static analysis (or subset), secret scan, license placeholder scan, English-only spec check, output directory enforcement, pinned version check.
  - `commit-msg`: Conventional Commits pattern: `^(feat|fix|perf|refactor|docs|test|chore|ci|build)(\(.+\))?: .+`.
  - `pre-push`: fast unit test subset + build (or dry-run) + coverage sanity.
- Average `pre-commit` runtime target: <5s (warn if exceeded, fail if >10s unless ADR exception).
- Platform-scoped hooks MUST set `core.hooksPath` to their directory via setup script inside `outputs/<framework>/scripts`.
- CI MUST verify hook integrity (optional hash) and that commits follow Conventional Commits.
- Exceptions MUST be recorded in ADR with justification and expiry.

### 31.1 English-only Spec Enforcement

- Same as previously defined; applies to all `specs/**/*.md` and `.specify/memory/**/*.md`.

### 31.2 Secret & Credential Scan (Placeholder)

- Required patterns enforced; platform scripts MAY extend scanning with technology-specific secrets.

### 31.3 Build Sanity

- Each platform hook MUST perform minimal build (Flutter debug build, Gradle assemble, Xcode build, etc.).

---

## Documentation Best Practices (for inclusion in README.md)

- Glossary of key terms to avoid misinterpretation.
- ADRs for significant technical choices.
- Knowledge sharing: periodic reviews, tech talks, documentation updates.
- Monitoring/analytics: review reports, recurring issues produce action items.
- Release notes: must list changes, reference tracking IDs/migrations.
- Incident management: detection→rollback, post-mortems, action items with owners/timelines.
- Continuous improvement: track/refactor technical debt, automate tasks.
- Non-functional guarantees: reliability, observability, maintainability, portability, scalability.
- Enforcement: CI/manual review, remediation for repeated violations.
- Evolution & Governance: versioned changes, migration paths, historical access, quarterly reviews.
- Branch naming: feature/fix/hotfix <ticket-id>-<short-description>.
- External standards: Semantic Versioning, Conventional Commits, OWASP, WCAG, GDPR/CCPA, ISO/IEC 25010.
- Directory structure reference for maintainability and clarity.
- Localization: support multiple languages, locale fallback strategies.
- Backward compatibility: maintain compatibility with previous app versions.
- Open source compliance: license checks for all dependencies.
- Mobile-specific guidelines: battery usage, offline-first, device compatibility testing.
- Release notes: detailed for every deployment.
- Incident management: procedures for handling production incidents and rollbacks.