import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../env/app_environment.dart';
import '../l10n/app_localizations.dart';
import '../presentation/pages/hello_world_page.dart';
import 'theme/app_theme.dart';

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
      home: const HelloWorldPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
