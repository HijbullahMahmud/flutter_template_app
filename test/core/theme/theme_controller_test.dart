import 'package:ag_pos/core/theme/theme_controller.dart';
import 'package:ag_pos/core/theme/theme_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('uses the device theme by default', () {
    final container = ProviderContainer(
      overrides: [
        themePreferencesProvider.overrideWithValue(_FakeThemePreferences()),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(themeControllerProvider), ThemeMode.system);
  });

  test('restores the supplied saved theme', () {
    final container = ProviderContainer(
      overrides: [
        initialThemeModeProvider.overrideWithValue(ThemeMode.dark),
        themePreferencesProvider.overrideWithValue(_FakeThemePreferences()),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(themeControllerProvider), ThemeMode.dark);
  });

  test('updates and persists theme mode', () async {
    final preferences = _FakeThemePreferences();
    final container = ProviderContainer(
      overrides: [themePreferencesProvider.overrideWithValue(preferences)],
    );
    addTearDown(container.dispose);

    await container
        .read(themeControllerProvider.notifier)
        .setThemeMode(ThemeMode.dark);
    await container
        .read(themeControllerProvider.notifier)
        .setThemeMode(ThemeMode.dark);

    expect(container.read(themeControllerProvider), ThemeMode.dark);
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
