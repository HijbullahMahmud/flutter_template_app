import 'package:ag_pos/core/theme/theme_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit({required this.preferences, ThemeMode? initialMode})
    : super(initialMode ?? ThemeMode.system);

  final ThemePreferences preferences;

  Future<void> setThemeMode(ThemeMode mode) async {
    if (state == mode) {
      return;
    }

    emit(mode);

    try {
      await preferences.saveThemeMode(mode);
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
