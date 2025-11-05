import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:base_app/app/theme/app_theme.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentation/pages/welcome/welcome_page.dart';

void main() {
  testWidgets('renders welcome content', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: createLightTheme(),
        darkTheme: createDarkTheme(),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const WelcomePage(),
      ),
    );

    await tester.pumpAndSettle();

    final context = tester.element(find.byType(WelcomePage));
    final l10n = AppLocalizations.of(context);

    expect(find.text(l10n.welcomeLogoWordmark), findsOneWidget);
    expect(find.text(l10n.welcomeTagline), findsOneWidget);
    expect(find.text(l10n.exploreHeroes), findsOneWidget);
  });
}
