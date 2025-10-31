import 'package:flutter/material.dart';

ThemeData createLightTheme() {
  final base = ThemeData.light();
  return base.copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    scaffoldBackgroundColor: Colors.white,
    textTheme: base.textTheme.apply(
      bodyColor: Colors.black,
      displayColor: Colors.black,
    ),
  );
}

ThemeData createDarkTheme() {
  final base = ThemeData.dark();
  return base.copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey, brightness: Brightness.dark),
    scaffoldBackgroundColor: Colors.black,
    textTheme: base.textTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
  );
}
