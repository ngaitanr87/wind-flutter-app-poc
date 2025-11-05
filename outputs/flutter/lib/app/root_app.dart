import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:base_app/app/app_routes.dart';
import 'package:base_app/app/theme/app_theme.dart';
import 'package:base_app/env/app_environment.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentation/pages/heroes/heroes_page.dart';
import 'package:base_app/presentation/pages/welcome/welcome_page.dart';

class RootApp extends StatelessWidget {
  const RootApp({
    super.key,
    required this.environment,
  });

  final AppEnvironment environment;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
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
      initialRoute: AppRoutes.welcome,
      routes: {
        AppRoutes.welcome: (context) => const WelcomePage(),
        AppRoutes.heroes: (context) => const HeroesPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<AppEnvironment>('environment', environment));
  }
}
