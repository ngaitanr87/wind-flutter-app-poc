import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:base_app/app/theme/app_theme.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentation/pages/hello_world_page.dart';

Future<void> pumpResponsiveApp(
  WidgetTester tester, {
  Size? surfaceSize,
  double? textScaleFactor,
}) async {
  final binding = tester.binding;

  if (surfaceSize != null) {
    await binding.setSurfaceSize(surfaceSize);
    addTearDown(() => binding.setSurfaceSize(null));
  }

  if (textScaleFactor != null) {
    binding.platformDispatcher.textScaleFactorTestValue = textScaleFactor;
    addTearDown(binding.platformDispatcher.clearTextScaleFactorTestValue);
  }

  await tester.pumpWidget(
    MaterialApp(
      theme: createLightTheme(),
      darkTheme: createDarkTheme(),
      themeMode: ThemeMode.system,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const HelloWorldPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('text remains visible at large text scale', (tester) async {
    const surface = Size(360, 720);
    await pumpResponsiveApp(
      tester,
      surfaceSize: surface,
      textScaleFactor: 2.5,
    );

    final rect = tester.getRect(find.text('Hello World'));
    expect(rect.left >= 0, isTrue);
    expect(rect.right <= surface.width, isTrue);
  });

  testWidgets('text remains centered in landscape orientation', (tester) async {
    const surface = Size(812, 375); // landscape
    await pumpResponsiveApp(tester, surfaceSize: surface);

    final center = tester.getCenter(find.text('Hello World'));
    expect(center.dx, closeTo(surface.width / 2, 1.0));
    expect(center.dy, closeTo(surface.height / 2, 1.0));
  });
}
