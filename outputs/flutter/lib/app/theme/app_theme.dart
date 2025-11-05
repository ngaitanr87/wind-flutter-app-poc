import 'package:flutter/material.dart';

ThemeData createLightTheme() {
  final colorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFFFF0000));
  return ThemeData.from(colorScheme: colorScheme, useMaterial3: true);
}

ThemeData createDarkTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFFFF0000),
    brightness: Brightness.dark,
  );
  return ThemeData.from(colorScheme: colorScheme, useMaterial3: true);
}
