import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:base_app/bootstrap/bootstrap.dart';
import 'package:base_app/di/container.dart';
import 'package:base_app/env/app_environment.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentation/pages/heroes/heroes_page.dart';
import 'package:base_app/presentation/pages/welcome/welcome_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    getIt.reset();
  });

  testWidgets('launching app shows welcome and tapping CTA navigates to heroes', (tester) async {
    await bootstrap(AppEnvironment.dev);
    await tester.pumpAndSettle();

    final welcomeContext = tester.element(find.byType(WelcomePage));
    final welcomeL10n = AppLocalizations.of(welcomeContext);

    expect(find.text(welcomeL10n.exploreHeroes), findsOneWidget);
    expect(find.text(welcomeL10n.welcomeTagline), findsOneWidget);

    await tester.tap(find.text(welcomeL10n.exploreHeroes));
    await tester.pumpAndSettle();

    final heroesContext = tester.element(find.byType(HeroesPage));
    final heroesL10n = AppLocalizations.of(heroesContext);

    expect(find.text(heroesL10n.heroesTitle), findsOneWidget);
    expect(find.text(heroesL10n.heroesComingSoon), findsOneWidget);
    expect(find.text(welcomeL10n.exploreHeroes), findsNothing);
  });
}
