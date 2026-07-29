import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class ThemePreferences {
  Future<ThemeMode> loadThemeMode();
  Future<void> saveThemeMode(ThemeMode mode);
}

class SharedPreferencesThemePreferences implements ThemePreferences {
  SharedPreferencesThemePreferences([SharedPreferencesAsync? preferences])
    : _preferences = preferences ?? SharedPreferencesAsync();

  static const String _themeModeKey = 'settings.theme_mode';

  final SharedPreferencesAsync _preferences;

  @override
  Future<ThemeMode> loadThemeMode() async {
    final value = await _preferences.getString(_themeModeKey);
    return ThemeModeCodec.decode(value);
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) {
    return _preferences.setString(_themeModeKey, ThemeModeCodec.encode(mode));
  }
}

abstract final class ThemeModeCodec {
  static ThemeMode decode(String? value) {
    return switch (value) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      'system' || _ => ThemeMode.system,
    };
  }

  static String encode(ThemeMode mode) => mode.name;
}
