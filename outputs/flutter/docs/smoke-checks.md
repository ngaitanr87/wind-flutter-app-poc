# Smoke Checks

These commands verify that the base app runs correctly on Android and iOS after setup.

## Environment

- Flutter SDK: 3.24.0 (managed via FVM)
- Dart: 3.5.0

## Steps

1. **Static analysis**
   ```bash
   fvm flutter analyze
   ```

2. **Widget tests**
   ```bash
   fvm flutter test --no-pub
   ```

3. **Android build & run (emulator/device)**
   ```bash
   fvm flutter run -t lib/main_dev.dart -d <android-device-id>
   ```

4. **iOS build & run (simulator/device)**
   ```bash
   fvm flutter run -t lib/main_dev.dart -d <ios-device-id>
   ```

> Ensure the "Hello World" text appears centered and readable in both light and dark modes.
