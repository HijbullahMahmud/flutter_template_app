import 'package:ag_pos/core/theme/theme_preferences.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_controller.g.dart';

@Riverpod(keepAlive: true)
ThemeMode initialThemeMode(Ref ref) => ThemeMode.system;

@Riverpod(keepAlive: true)
ThemePreferences themePreferences(Ref ref) {
  return SharedPreferencesThemePreferences();
}

@Riverpod(keepAlive: true)
class ThemeController extends _$ThemeController {
  @override
  ThemeMode build() => ref.watch(initialThemeModeProvider);

  Future<void> setThemeMode(ThemeMode mode) async {
    if (state == mode) {
      return;
    }

    state = mode;

    try {
      await ref.read(themePreferencesProvider).saveThemeMode(mode);
    } on Object catch (error, stackTrace) {
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
          library: 'theme preferences',
          context: ErrorDescription('while saving the selected theme mode'),
        ),
      );
    }
  }
}
