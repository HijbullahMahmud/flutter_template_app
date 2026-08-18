import 'package:ag_pos/core/theme/theme_cubit.dart';
import 'package:ag_pos/core/theme/theme_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('uses the device theme by default', () {
    final cubit = ThemeCubit(preferences: _FakeThemePreferences());
    addTearDown(cubit.close);

    expect(cubit.state, ThemeMode.system);
  });

  test('restores the supplied saved theme', () {
    final cubit = ThemeCubit(
      preferences: _FakeThemePreferences(),
      initialMode: ThemeMode.dark,
    );
    addTearDown(cubit.close);

    expect(cubit.state, ThemeMode.dark);
  });

  test('updates and persists theme mode', () async {
    final preferences = _FakeThemePreferences();
    final cubit = ThemeCubit(preferences: preferences);
    addTearDown(cubit.close);

    await cubit.setThemeMode(ThemeMode.dark);
    await cubit.setThemeMode(ThemeMode.dark);

    expect(cubit.state, ThemeMode.dark);
    expect(preferences.savedMode, ThemeMode.dark);
    expect(preferences.writeCount, 1);
  });
}

class _FakeThemePreferences implements ThemePreferences {
  ThemeMode? savedMode;
  int writeCount = 0;

  @override
  Future<ThemeMode> loadThemeMode() async {
    return savedMode ?? ThemeMode.system;
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {
    savedMode = mode;
    writeCount += 1;
  }
}
