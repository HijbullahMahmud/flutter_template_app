import 'package:ag_pos/core/theme/theme_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialThemeModeProvider = Provider<ThemeMode>(
  (Ref ref) => ThemeMode.system,
);

final themePreferencesProvider = Provider<ThemePreferences>(
  (Ref ref) => SharedPreferencesThemePreferences(),
);

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

class ThemeModeNotifier extends Notifier<ThemeMode> {
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
