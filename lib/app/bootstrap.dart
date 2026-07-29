import 'dart:ui';

import 'package:ag_pos/app/template_app.dart';
import 'package:ag_pos/core/localization/app_locales.dart';
import 'package:ag_pos/core/localization/locale_controller.dart';
import 'package:ag_pos/core/localization/locale_preferences.dart';
import 'package:ag_pos/core/theme/theme_controller.dart';
import 'package:ag_pos/core/theme/theme_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = FlutterError.presentError;
  PlatformDispatcher.instance.onError = (Object error, StackTrace stackTrace) {
    FlutterError.reportError(
      FlutterErrorDetails(exception: error, stack: stackTrace),
    );
    return true;
  };

  final themePreferences = SharedPreferencesThemePreferences();
  final localePreferences = SharedPreferencesLocalePreferences();
  ThemeMode initialThemeMode;
  Locale initialLocale;

  try {
    initialThemeMode = await themePreferences.loadThemeMode();
  } on Object catch (error, stackTrace) {
    initialThemeMode = ThemeMode.system;
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        stack: stackTrace,
        library: 'theme preferences',
        context: ErrorDescription('while loading the saved theme mode'),
      ),
    );
  }

  try {
    initialLocale = await localePreferences.loadLocale();
  } on Object catch (error, stackTrace) {
    initialLocale = AppLocales.english;
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        stack: stackTrace,
        library: 'locale preferences',
        context: ErrorDescription('while loading the saved locale'),
      ),
    );
  }

  runApp(
    ProviderScope(
      overrides: [
        themePreferencesProvider.overrideWithValue(themePreferences),
        initialThemeModeProvider.overrideWithValue(initialThemeMode),
        localePreferencesProvider.overrideWithValue(localePreferences),
        initialLocaleProvider.overrideWithValue(initialLocale),
      ],
      child: const TemplateApp(),
    ),
  );
}
