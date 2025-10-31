# Quickstart: Base App - Hello World (Flutter)

Created: 2025-10-31
Branch: 001-base-app

This quickstart sets up the Flutter app skeleton under `outputs/flutter/` as a Git submodule, pins Flutter 3.24.0 via FVM, and runs the app showing only "Hello World".

## Prerequisites

- Flutter (via FVM) installed locally
- Access to create or reference a remote repository for the Flutter submodule
- Xcode (for iOS), Android SDK/Studio (for Android)

## 1) Initialize Flutter outputs submodule

Replace `<REMOTE_URL>` with your remote repository URL for the Flutter app.

```bash
# From repo root
git submodule add <REMOTE_URL> outputs/flutter
git commit -m "chore: add flutter outputs submodule"
```

If the remote repository is empty, initialize it locally and push after project creation.

## 2) Pin Flutter version with FVM (3.24.0)

```bash
# Inside outputs/flutter
fvm use 3.24.0 --force
```

This creates `.fvm/fvm_config.json` referencing the pinned version.

## 3) Create the Flutter project in the submodule

```bash
# Inside outputs/flutter
flutter create --platforms=android,ios .
```

This generates the standard Flutter structure.

## 4) Prepare environment entry points and bootstrap

Create environment mains and a single bootstrap used by all of them. Ensure `lib/bootstrap/bootstrap.dart` contains the DI/bootstrap function, and `lib/env/app_environment.dart` defines the environment enum.

```text
outputs/flutter/
  lib/
    env/app_environment.dart
    bootstrap/bootstrap.dart
    app/root_app.dart
    presentation/pages/hello_world_page.dart
    main_dev.dart
    main_staging.dart
    main_prod.dart
```

Each main file calls `bootstrap(AppEnvironment.<env>)`.

## 5) Add Hello World page

Implement a simple stateless widget that centers the text "Hello World" and respects light/dark themes.

## 6) Tests and analysis

```bash
# From outputs/flutter
flutter analyze
flutter test
```

Add a widget test that asserts the "Hello World" text is present.

## 7) Run the app

```bash
# From outputs/flutter
flutter run -t lib/main_dev.dart
```

Select an Android emulator/device or an iOS simulator/device.

## 8) Commit and pin submodule

```bash
git add .
git commit -m "feat: base Flutter app with Hello World"
# Commit and push inside the submodule, then commit the submodule pointer at the parent repo
```

## Notes

- Monitoring & Analytics (Crashlytics/Analytics) are deferred for this slice; add via ADR-0001 in a future feature.
- All user-visible strings must be localizable; for now we include only English.
