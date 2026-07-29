abstract final class AppConfig {
  static const String appName = 'Flutter Starter';
  static const bool showDebugBanner = false;

  static const String environment = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'development',
  );
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://dummyjson.com',
  );

  static bool get isProduction => environment == 'production';
}
