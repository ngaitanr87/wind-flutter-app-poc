import 'package:flutter/material.dart';

import 'package:base_app/l10n/app_localizations.dart';

class HeroesPage extends StatelessWidget {
  const HeroesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.heroesTitle),
      ),
      body: Center(
        child: Text(
          l10n.heroesComingSoon,
          style: theme.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
