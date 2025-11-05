import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalizations {
  const AppLocalizations(this.locale);

  final Locale locale;

  static const supportedLocales = <Locale>[
    Locale('en'),
  ];

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'appTitle': 'Base App',
      'helloWorld': 'Hello World',
      'welcomeTagline': "Heroes aren't Born. They're Built.",
      'exploreHeroes': 'Explore Heroes',
      'heroesTitle': 'Heroes',
      'heroesComingSoon': 'Heroes list coming soon.',
      'welcomeLogoWordmark': 'MARVEL HEROES',
      'welcomeLogoSemantic': 'Marvel Heroes logo',
    },
  };

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  String get appTitle => _localizedValues[locale.languageCode]!['appTitle']!;
  String get helloWorld => _localizedValues[locale.languageCode]!['helloWorld']!;
  String get welcomeTagline => _localizedValues[locale.languageCode]!['welcomeTagline']!;
  String get exploreHeroes => _localizedValues[locale.languageCode]!['exploreHeroes']!;
  String get heroesTitle => _localizedValues[locale.languageCode]!['heroesTitle']!;
  String get heroesComingSoon => _localizedValues[locale.languageCode]!['heroesComingSoon']!;
  String get welcomeLogoWordmark => _localizedValues[locale.languageCode]!['welcomeLogoWordmark']!;
  String get welcomeLogoSemantic => _localizedValues[locale.languageCode]!['welcomeLogoSemantic']!;

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
  static const delegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => AppLocalizations.supportedLocales.contains(Locale(locale.languageCode));

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
