import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:base_app/app/theme/app_theme.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentation/pages/hello_world_page.dart';

Future<void> pumpHelloWorldApp(
  WidgetTester tester, {
  ThemeMode themeMode = ThemeMode.system,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: createLightTheme(),
      darkTheme: createDarkTheme(),
      themeMode: themeMode,
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
  testWidgets('renders Hello World text', (tester) async {
    await pumpHelloWorldApp(tester);

    expect(find.text('Hello World'), findsOneWidget);
  });

  testWidgets('has no tappable semantics widgets', (tester) async {
    await pumpHelloWorldApp(tester);

    final handle = tester.ensureSemantics();
    try {
      final semantics = tester.getSemantics(find.text('Hello World'));
      expect(semantics.hasFlag(SemanticsFlag.isButton), isFalse);
      expect(semantics.hasFlag(SemanticsFlag.hasImplicitScrolling), isFalse);
    } finally {
      handle.dispose();
    }
  });

  testWidgets('text remains readable when system theme is dark', (tester) async {
    await pumpHelloWorldApp(tester, themeMode: ThemeMode.dark);

    expect(find.text('Hello World'), findsOneWidget);
  });
}
