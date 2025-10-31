enum AppEnvironment { dev, staging, production }

extension AppEnvironmentX on AppEnvironment {
  String get name => switch (this) {
        AppEnvironment.dev => 'development',
        AppEnvironment.staging => 'staging',
        AppEnvironment.production => 'production',
      };
}
