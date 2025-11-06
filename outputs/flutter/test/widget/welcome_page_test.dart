import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:base_app/app/app_routes.dart';
import 'package:base_app/app/assets.dart';
import 'package:base_app/app/theme/app_theme.dart';
import 'package:base_app/di/container.dart';
import 'package:base_app/env/app_environment.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentation/pages/heroes/heroes_page.dart';
import 'package:base_app/presentation/pages/welcome/welcome_page.dart';

Future<void> pumpWelcomePage(
  WidgetTester tester, {
  ThemeMode themeMode = ThemeMode.light,
  double textScaleFactor = 1.0,
  List<NavigatorObserver> observers = const <NavigatorObserver>[],
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
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(textScaler: TextScaler.linear(textScaleFactor)),
          child: child!,
        );
      },
      initialRoute: AppRoutes.welcome,
      routes: <String, WidgetBuilder>{
        AppRoutes.welcome: (context) => const WelcomePage(),
        AppRoutes.heroes: (context) => const HeroesPage(),
      },
      navigatorObservers: observers,
      debugShowCheckedModeBanner: false,
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  setUp(() async {
    await getIt.reset();
    await configureDependencies(AppEnvironment.dev);
  });

  tearDown(() async {
    await getIt.reset();
  });

  testWidgets('renders background, tagline, and CTA with correct assets', (tester) async {
    await pumpWelcomePage(tester);

    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);

    final image = tester.widget<Image>(imageFinder);
    final background = image.image;
    expect(background, isA<AssetImage>());
    expect((background as AssetImage).assetName, Assets.welcomeBg);

    final context = tester.element(find.byType(WelcomePage));
    final l10n = AppLocalizations.of(context);

    expect(find.text(l10n.welcomeLogoWordmark), findsOneWidget);
    expect(find.text(l10n.welcomeTagline), findsOneWidget);
    expect(find.text(l10n.exploreHeroes), findsOneWidget);
  });

  testWidgets('button maintains semantics and responds in dark theme', (tester) async {
    await pumpWelcomePage(tester, themeMode: ThemeMode.dark);

    final context = tester.element(find.byType(WelcomePage));
    final l10n = AppLocalizations.of(context);

    final handle = tester.ensureSemantics();
    try {
      final node = tester.getSemantics(find.text(l10n.exploreHeroes));
      final semantics = node.getSemanticsData();
      expect(semantics.hasAction(SemanticsAction.tap), isTrue);
      expect(semantics.label, l10n.exploreHeroes);
    } finally {
      handle.dispose();
    }

    await tester.tap(find.text(l10n.exploreHeroes));
    await tester.pumpAndSettle();

    expect(find.text(l10n.heroesComingSoon), findsOneWidget);
  });

  testWidgets('supports large text without layout overflow', (tester) async {
    await pumpWelcomePage(tester, textScaleFactor: 2.0);

    expect(tester.takeException(), isNull);
    final context = tester.element(find.byType(WelcomePage));
    final l10n = AppLocalizations.of(context);
    expect(find.text(l10n.exploreHeroes), findsOneWidget);
  });
}
