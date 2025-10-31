<!--
Sync Impact Report (Flutter Constitution)
Version: (previous unspecified) -> v1.0.1
Change Type: PATCH (metadata + governance alignment + submodule isolation rules)
Added: Version metadata, Governance Alignment section
Templates Impact: None (inherits global templates)
Follow-up TODO: Confirm initial ratification date from repo history.
-->

# Flutter Constitution [MANDATORY]

Constitution Version: v1.0.1  
Ratification Date: TODO(RATIFICATION_DATE_FLUTTER): Determine from first Flutter project commit.  
Last Amended Date: 2025-10-23  
Parent Constitution Version: v1.1.0

_This constitution extends the shared constitution (`.specify/memory/constitution.md`). All global mandatory rules apply. Platform-specific rules here MAY be stricter but MUST NOT weaken global rules without an ADR granting a time-bound exception._

**SpecKit Integration Guidance (Flutter):**

- All sections and requirements are machine-readable and structured to support SpecKit toolchain automation.
- Outputs under `outputs/flutter/` must conform to structure for SpecKit inspection, enforcement, and artifact generation.
- Section numbering and mandatory rule formatting are maintained specifically for parsing by SpecKit.
- Any changes to enforced layouts, compliance gates, or setup instructions must be reflected in SpecKit templates and module configurations.
- SpecKit is expected to validate submodule state, enforce directory conventions, run CI gate checks, and provide compliance reporting for Flutter via automation.

## 0. Project Initialization [MANDATORY]

- The initial project structure MUST be created using the official Flutter CLI command:

  ```shell
  flutter create --platforms=android,ios <project_name>
  ```

- All modifications and architectural improvements MUST be applied on top of this generated base.
- Agents and contributors MUST NOT generate the project structure from scratch; always start from the official template.

### 0.1 Outputs as Git Submodule [MANDATORY]

- The Flutter output (`outputs/flutter/`) MUST be a **Git submodule** pointing to an **independent repository** dedicated to the base mobile architecture.
- All entry points, sources, tests, assets, scripts, and CI files for the app MUST live **inside** the submodule. The root SpecKit repository MUST NOT contain app sources.
- The submodule repository owns its **issues, releases, and tags** independently (e.g., `flutter-arch-base-vX.Y.Z`).
- FVM config (`.fvm/fvm_config.json`), `pubspec.yaml`, lockfiles, and tool configs belong to the submodule.
- Changes to the output MUST be authored and merged in the submodule repo; the SpecKit repo only advances the pinned submodule commit.
- SpecKit repository MUST vendor the submodule at `outputs/flutter` and pin a **specific commit** (no floating branches).

## 1. Flutter SDK Version [MANDATORY]

- Pinned Stable Flutter Version: 3.24.0 (update monthly).
- Version MUST be managed via FVM and committed (`.fvm/fvm_config.json`).
- CI MUST verify local Flutter matches pinned version.
- Any upgrade MUST include:
  - Changelog review.
  - Regression test run (all layers).
  - ADR documenting rationale and impact.
- No feature development may start on an unapproved SDK version.

## 2. Architecture [MANDATORY]

- Clean Architecture is MANDATORY for all Flutter projects.
- Layers MUST be organized as Dart packages or folders: presentation, domain, data.
- Presentation layer SHOULD use MVVM or Bloc for state management.
- Domain and data layers MUST be framework-agnostic and not depend on Flutter-specific APIs.
- Clean Architecture layer isolation MUST be enforced (presentation → domain → data only).
- Data layer MUST host repositories, native plugins, third-party services, and offline caching.
- Use cases in domain MUST apply functional patterns (pure functions, explicit Result/Either error models).
- No Flutter framework types (BuildContext, Widgets) allowed in domain or data.

### 2.1 Modular Package Layout (Project Output Convention) [MANDATORY]

All generated code MUST reside under `./outputs/flutter/` rather than directly under repository root `lib/`. Presentation lives inside the root app `lib/` folder; domain and data are isolated pure Dart packages with individual `pubspec.yaml` files enabling extraction.

```shell
outputs/flutter/
  pubspec.yaml                 # Root app aggregator (Flutter)
  main_dev.dart
  main_staging.dart
  main_prod.dart
  lib/
    app_environment.dart
    app_config.dart
    bootstrap/
      bootstrap.dart
    presentation/
      bloc/
      pages/
  packages/
    domain/
      pubspec.yaml
      lib/
        domain.dart
        src/
          entities/
          failures/
          result/
          repositories/        # Interfaces only
          usecases/
    data/
      pubspec.yaml
      lib/
        data.dart
        src/
          repositories/        # Implementations (in-memory, remote, cache)
          datasources/ (future)
          mappers/ (future)
  test/
    widget/
    integration/
```

Enforcement:

- Domain and data packages MUST NOT import Flutter SDK.
- Presentation layer MUST depend only on domain interfaces (use cases) and receive implementations via DI.
- Pinned versions REQUIRED in every pubspec (no caret, ranges, any).
- DI registrations MUST occur in a single bootstrap path (`lib/bootstrap/bootstrap.dart`).
- No feature may add additional top-level packages without ADR justification.

### 2.2 Package Dependency Rules

```shell
domain <- data <- (presentation consumes domain only)
```

- Presentation MUST NOT directly import data implementations; access them through injected domain use cases.
- Tests inside packages test unit logic; cross-layer tests live in `outputs/flutter/test/`.

### 2.3 Output Directory Compliance

- CI and pre-commit hooks MUST verify that Dart/Flutter source for the app exists only under `outputs/flutter/` and not under arbitrary new root folders.
- Generated or auxiliary code (build scripts, coverage reports) MUST remain scoped to this directory or standard Flutter locations.

- `outputs/flutter/` is a **repository boundary**: cross-repo relative imports (e.g., `../../`) are PROHIBITED.
- CI MUST verify the submodule is present, initialized, and checked out at the pinned commit (`git submodule status` clean).
- CI MUST fail if the submodule has uncommitted changes in the workspace (dirty tree).

### 2.4 Submodule Layout (Reference)

```shell
outputs/flutter/              # <Git submodule root>
  .gitmodules?               # (lives in parent repo; submodule itself has its own .git directory)
  .fvm/
  pubspec.yaml
  pubspec.lock
  lib/
    bootstrap/
    env/
    presentation/
  packages/
    domain/
      pubspec.yaml
    data/
      pubspec.yaml
  test/
  tool/                      # CI/build scripts for the submodule
```

## 3. Dependency Management [MANDATORY]

- Use only approved package managers: `pub`.
- All dependencies MUST be declared in `pubspec.yaml`.
- Native plugins and third-party services MUST be referenced only in the data layer.
- Flutter version management MUST be handled using FVM (`fvm`), and all contributors MUST use the specified version for consistency.
- All versions in `pubspec.yaml` MUST be pinned (e.g., 1.2.3) — caret (`^`), ranges, and `any` are PROHIBITED.
- FVM MUST define and lock the Flutter SDK version; contributors MUST use it.
- License compliance scan MUST pass before merge.
- Dependency declarations and lockfiles are maintained **inside the submodule**; the parent SpecKit repo MUST NOT duplicate or shadow them.

## 4. Code Style & Static Analysis [MANDATORY]

- Follow Dart and Flutter official style guides.
- Use `flutter analyze` for static code analysis.
- All code MUST pass analysis before merging.
- Naming conventions MUST follow Dart best practices.
- `flutter analyze` MUST return zero errors.
- Lints MUST be enforced (recommend using `flutter_lints` extended with project rules).

## 5. Testing [MANDATORY]

- Minimum 80% unit test coverage is REQUIRED.
- Include unit, widget, and integration tests.
- Use `flutter_test` and `mockito` or equivalent for testing.
- 100% unit test coverage REQUIRED (domain + data + critical presentation logic).
- Widget tests MUST cover rendering, state transitions, and theming (light/dark).
- Integration tests MUST validate navigation and core flows.
- Coverage reports (lcov) SHOULD be generated (`flutter test --coverage` + convert to lcov).

## 6. Documentation [MANDATORY]

- Inline comments are REQUIRED for complex logic.
- Update `README.md` and API docs with every major change.
- Public-facing APIs (services, use cases, repositories) MUST have doc comments.

## 7. Error Handling [MANDATORY]

- Use functional error handling (e.g., `Either`, `Result` types) in domain and data layers.
- Exceptions MUST be handled gracefully in the presentation layer with user feedback.
- Network/service failures MUST map to domain-level failure types (no raw exceptions crossing layers).
- Presentation MUST convert domain failures into localized user messages.

## 8. Security & Privacy [MANDATORY]

- Sensitive data MUST use secure storage (e.g., `flutter_secure_storage`).
- All network calls MUST use HTTPS.
- Interceptors MUST strip or mask sensitive headers before logging.
- Sensitive storage MUST use platform-secure mechanisms (e.g., Keychain/Keystore via `flutter_secure_storage`).

## 9. Release & Environments [MANDATORY]

- Define dev, staging, and production flavors using `flutter build` targets.
- Use CI/CD pipelines for build, QA, and deployment.
- Flavors MUST at least include: dev, staging, production.
- CI/CD MUST build and test all flavors.
- **All paths below are relative to the submodule root `outputs/flutter/`.**
- Entry points MUST be split per environment:
  - lib/main_dev.dart
  - lib/main_staging.dart
  - lib/main_prod.dart
- Each main file MUST do only: set environment enum + call bootstrap().
- Bootstrap MUST initialize bindings, configure dependencies, load initial services, then run the root widget.
- Environment selection MUST NOT rely on runtime string parsing; use explicit enum.

### 9.1 Bootstrap Pattern [MANDATORY]

- Provide a single bootstrap function (e.g., bootstrap.dart) used by all main_*.dart files.
- DI registrations MUST be environment-aware (e.g., different API base URLs).
- No business logic or navigation inside main files.

### 9.2 Sample Structure

```shell
lib/
  bootstrap.dart
  env/
    app_environment.dart
  main_dev.dart
  main_staging.dart
  main_prod.dart
```

### 9.3 Sample Snippets

```dart
// lib/env/app_environment.dart
enum AppEnvironment { dev, staging, prod }

// lib/bootstrap.dart
import 'package:flutter/widgets.dart';
import 'env/app_environment.dart';
import 'di/container.dart';
import 'app/root_app.dart';

Future<void> bootstrap(AppEnvironment env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(env); // register per-layer modules
  runApp(RootApp(env: env));
}

// lib/main_dev.dart
import 'bootstrap.dart';
import 'env/app_environment.dart';
void main() => bootstrap(AppEnvironment.dev);

// lib/main_staging.dart
import 'bootstrap.dart';
import 'env/app_environment.dart';
void main() => bootstrap(AppEnvironment.staging);

// lib/main_prod.dart
import 'bootstrap.dart';
import 'env/app_environment.dart';
void main() => bootstrap(AppEnvironment.prod);
```

## 10. Accessibility & Theming [MANDATORY]

- Light and dark themes MUST be fully supported.
- Theming tokens (colors, spacing, typography, animation durations, asset maps) MUST live under `src/app/theme`.
- No hard-coded style values inside widgets (use theme accessors only).
- Widgets MUST be accessible (semantics labels, contrast, screen reader hints).

## 11. Performance [MANDATORY]

- Apps MUST be responsive and optimized for resource usage.
- Use Flutter performance tools to identify and resolve bottlenecks.
- Startup time MUST be profiled; expensive async initializations SHOULD be deferred.
- Rebuilds MUST be minimized (prefer const widgets / composition).

## 12. Dependency Injection & Bootstrap [MANDATORY]

- Use a bootstrap file (e.g., `main.dart`) to initialize modules and configure dependency injection.
- Dependency injection MUST be managed by dedicated containers per layer.
- Use an abstraction for dependency injection. Default implementation MUST use `get_it`, but abstraction SHOULD allow swapping for `provider` or other DI solutions if needed.
- A root bootstrap MUST register layer-specific modules (data → domain → presentation).
- DI abstraction MUST wrap `get_it` implementation; swapping MUST not affect layer contracts.
- All environment-specific differences (API base URL, feature toggles) MUST be resolved inside bootstrap before runApp().
- main_* files MUST NOT duplicate DI logic.

## 13. Presentation Layer Pattern [MANDATORY]

- Use `flutter_bloc` for state management (Bloc/Cubit).
- Screen/page MUST be a stateless wrapper; internal content widget receives injected Bloc.
- Business logic MUST not reside in UI widgets.

## 14. API Service Calls [MANDATORY]

- `dio` MUST be used for HTTP calls.
- Interceptors MUST handle: auth headers, retry (with exponential backoff), logging (sanitized), error mapping.
- Timeouts MUST be defined globally.

## 15. Localization & Formatting [MANDATORY]

- All user-visible strings MUST use localization keys.
- Fallback locale MUST be defined.
- Formatting (numbers, currencies, dates) MUST use dedicated formatters + extension methods.
- Model → view text transformations MUST reside in extensions (not in entities).

## 16. Monitoring & Analytics [MANDATORY]

- MUST integrate crash reporting (e.g., Sentry, Crashlytics) + analytics.
- MUST track: launches, feature usage, performance (frame drops, HTTP latency), handled/unhandled errors.
- Analytics events MUST exclude PII.
- Regular review of dashboards REQUIRED.

## 17. Backward Compatibility [MANDATORY]

- Persistent data migrations MUST be versioned and tested.
- Removal/refactor of features MUST provide graceful fallback or toggle.
- App upgrades MUST not lose user state.

## 18. Open Source Compliance [MANDATORY]

- License scan MUST validate all direct + transitive dependencies.
- Non-compliant licenses MUST block merge until resolved.

## 19. Incident Management [MANDATORY]

- Production incidents MUST follow a documented playbook.
- Post-mortems MUST list root cause, impact, actions, owners, due dates.

## 20. Continuous Improvement [MANDATORY]

- ADRs MUST document major architectural decisions.
- Technical debt items MUST be logged and prioritized.

## 21. Directory Structure (Reference) [MANDATORY]

The prior generic reference applies; for this project (or any adopting the modular output convention) the following variant MUST be used:

```shell
outputs/flutter/
  lib/                      # Application presentation & bootstrap
  packages/
    domain/                 # Pure Dart domain
    data/                   # Pure Dart data implementations
  test/                     # Cross-layer/widget/integration tests
```

Global reference (for projects not using modular output convention yet):

```dart

src/
  app/
    common/
    theme/
  features/
    <feature_name>/
      widgets/
      state/
      view/
domain/
  usecases/
  entities/
  repositories/
  value_objects/
data/
  repositories/
  datasources/
  mappers/
  services/
```

## 22. Compliance Checklist (CI Gate) [MANDATORY]

- flutter analyze: PASS (0 errors)
- Lint: PASS
- Submodule initialized & pinned commit verified: PASS
- Submodule working tree clean (no uncommitted changes): PASS
- Tests: PASS (100% coverage)
- Coverage report: Generated
- Build (all flavors): PASS
- License scan: PASS
- Localization completeness: PASS
- Pinned versions: VERIFIED (root + domain + data pubspecs)
- Release notes (when releasing): PRESENT
- Environment mains present (dev, staging, prod): VERIFIED
- Bootstrap initializes DI and theme before RootApp: VERIFIED
- Flutter stable version matches pinned (3.24.0): VERIFIED
- Output directory convention (`outputs/flutter/`) enforced: VERIFIED

## 23. Prohibited Practices [MANDATORY]

- Using caret/range dependency versions.
- Business logic inside widgets.
- BuildContext inside domain/data.
- Hard-coded strings, colors, asset paths.
- Skipping error mapping (throwing raw exceptions through layers).
- Logging sensitive headers/body content.
- Uninstrumented network calls (missing interceptors).
- Ignoring failed migrations.

## 24. Enforcement & Evolution [MANDATORY]

- CI MUST block any violation automatically where tooling exists.
- Changes to this constitution MUST go through documented review.
- Deprecated patterns MUST define migration paths.
- Monthly review MUST reassess pinned Flutter version; upgrade only after passing compatibility validation.

### 24.1 Governance Alignment [MANDATORY]

- Amendment Flow: Follow global procedure (PR + ADR rationale, dual review: maintainer + platform lead).
- Versioning: Flutter constitution versions track patch/minor changes independently; any rule that modifies global principles requires coordinated bump (global MINOR/MAJOR as appropriate).
- Quarterly Review: Confirm Flutter SDK pin, dependency updates, monitoring coverage, and localization completeness.
- Exception Handling: Any temporary deviation (e.g., reduced coverage for experimental module) MUST include ADR with expiry and mitigation plan.
- English-only Enforcement: All specs, tasks, ADRs, and code comments MUST be in English (mirrors global Section 3.1). Localization concerns handled via resource keys only.
- Historical Tagging: Tag repository with `flutter-constitution-v<version>` on changes (e.g., `flutter-constitution-v1.0.1`).

## 25 Core - Abstraction [MANDATORY]

- The final solution shouldn't depends of third party packages.
- All third packages dependencies should be inside our own packages with api abstractions.
- Sujested package structure [MANDATORY]:

```shell

 core_rest_api_session
│   │   │   ├── build
│   │   │   │   ├── native_assets
│   │   │   │   ├── test_cache
│   │   │   │   └── unit_test_assets
│   │   │   ├── CHANGELOG.md
│   │   │   ├── coverage
│   │   │   │   └── lcov.info
│   │   │   ├── example
│   │   │   │   └── example.dart
│   │   │   ├── lib
│   │   │   │   ├── core_rest_api_session.dart
│   │   │   │   ├── README.md
│   │   │   │   └── src
│   │   │   ├── pubspec.lock
│   │   │   ├── pubspec.yaml
│   │   │   ├── README.md
│   │   │   └── test
│   │   │       ├── integration
│   │   │       └── unit


```

## 26. Code Quality & Testing [MANDATORY]

- should use [./analysis_options.yaml](Analysis Options);
- should degfine a core package to share between all implementations the same analysis_options.yaml preventing repetition of rules between packages.