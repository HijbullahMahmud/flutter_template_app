import 'dart:ui';

import 'package:ag_pos/app/template_app.dart';
import 'package:ag_pos/core/di/app_dependencies.dart';
import 'package:ag_pos/core/localization/app_locales.dart';
import 'package:ag_pos/core/localization/locale_cubit.dart';
import 'package:ag_pos/core/localization/locale_preferences.dart';
import 'package:ag_pos/core/theme/theme_cubit.dart';
import 'package:ag_pos/core/theme/theme_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final dependencies = AppDependencies.create();
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
    MultiRepositoryProvider(
      providers: <RepositoryProvider<dynamic>>[
        RepositoryProvider.value(value: dependencies.getTemplateFeatures),
        RepositoryProvider.value(value: dependencies.getProducts),
      ],
      child: MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          BlocProvider<ThemeCubit>(
            create: (_) => ThemeCubit(
              preferences: themePreferences,
              initialMode: initialThemeMode,
            ),
          ),
          BlocProvider<LocaleCubit>(
            create: (_) => LocaleCubit(
              preferences: localePreferences,
              initialLocale: initialLocale,
            ),
          ),
        ],
        child: TemplateApp(router: dependencies.router),
      ),
    ),
  );
}
