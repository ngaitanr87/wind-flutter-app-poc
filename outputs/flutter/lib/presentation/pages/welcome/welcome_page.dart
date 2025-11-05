import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:base_app/app/app_routes.dart';
import 'package:base_app/app/assets.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentation/pages/welcome/cubit/welcome_cubit.dart';

int _opacity(double value) => (value * 255).round().clamp(0, 255);

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WelcomeCubit(),
      child: const _WelcomeView(),
    );
  }
}

class _WelcomeView extends StatelessWidget {
  const _WelcomeView();

  void _handleNavigation(BuildContext context, WelcomeState state) {
    if (state.navigateToHeroes) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.heroes);
      context.read<WelcomeCubit>().navigationHandled();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final l10n = AppLocalizations.of(context);

    return BlocListener<WelcomeCubit, WelcomeState>(
      listenWhen: (previous, current) => previous.navigateToHeroes != current.navigateToHeroes,
      listener: _handleNavigation,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                Assets.welcomeBg,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colorScheme.scrim.withAlpha(_opacity(0.45)),
                      colorScheme.surface.withAlpha(_opacity(0.25)),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: constraints.maxHeight - 48),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Semantics(
                              header: true,
                              label: l10n.welcomeLogoSemantic,
                              image: true,
                              child: Text(
                                l10n.welcomeLogoWordmark,
                                textAlign: TextAlign.center,
                                style: textTheme.headlineMedium?.copyWith(
                                  color: colorScheme.onPrimary,
                                  letterSpacing: 6,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                            Text(
                              l10n.welcomeTagline,
                              textAlign: TextAlign.center,
                              style: textTheme.titleLarge?.copyWith(
                                color: colorScheme.onPrimary.withAlpha(_opacity(0.92)),
                              ),
                            ),
                            const SizedBox(height: 120),
                            Semantics(
                              button: true,
                              label: l10n.exploreHeroes,
                              child: FilledButton(
                                style: FilledButton.styleFrom(
                                  minimumSize: const Size.fromHeight(60),
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                                ),
                                onPressed: () => context.read<WelcomeCubit>().exploreHeroes(),
                                child: Text(
                                  l10n.exploreHeroes,
                                  style: textTheme.titleMedium?.copyWith(
                                    color: colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
