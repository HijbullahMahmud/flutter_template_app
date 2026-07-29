import 'package:ag_pos/core/theme/theme_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('encodes all supported theme modes', () {
    expect(ThemeModeCodec.encode(ThemeMode.system), 'system');
    expect(ThemeModeCodec.encode(ThemeMode.light), 'light');
    expect(ThemeModeCodec.encode(ThemeMode.dark), 'dark');
  });

  test('decodes saved theme modes', () {
    expect(ThemeModeCodec.decode('system'), ThemeMode.system);
    expect(ThemeModeCodec.decode('light'), ThemeMode.light);
    expect(ThemeModeCodec.decode('dark'), ThemeMode.dark);
  });

  test('falls back to system for missing or invalid values', () {
    expect(ThemeModeCodec.decode(null), ThemeMode.system);
    expect(ThemeModeCodec.decode('invalid'), ThemeMode.system);
  });
}
