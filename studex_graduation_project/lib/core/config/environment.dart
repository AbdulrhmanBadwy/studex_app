/// Application runtime environment.
enum Environment {
  development,
  staging,
  production;

  static Environment fromString(String value) {
    return Environment.values.firstWhere(
      (environment) => environment.name == value,
      orElse: () => Environment.development,
    );
  }
}

/// Resolves the active environment from compile-time configuration.
///
/// Override at build time with:
/// `flutter run --dart-define=ENV=staging`
class EnvironmentConfig {
  EnvironmentConfig._();

  static const String _envName = String.fromEnvironment(
    'ENV',
    defaultValue: 'development',
  );

  static Environment get current => Environment.fromString(_envName);

  static bool get isDevelopment => current == Environment.development;

  static bool get isStaging => current == Environment.staging;

  static bool get isProduction => current == Environment.production;
}
