import 'package:ag_pos/core/localization/app_locales.dart';
import 'package:ag_pos/core/localization/locale_controller.dart';
import 'package:ag_pos/core/localization/locale_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('uses English by default', () {
    final container = ProviderContainer(
      overrides: [
        localePreferencesProvider.overrideWithValue(_FakeLocalePreferences()),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(localeControllerProvider), AppLocales.english);
  });

  test('restores the supplied saved locale', () {
    final container = ProviderContainer(
      overrides: [
        initialLocaleProvider.overrideWithValue(AppLocales.arabic),
        localePreferencesProvider.overrideWithValue(_FakeLocalePreferences()),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(localeControllerProvider), AppLocales.arabic);
  });

  test('updates and persists a supported locale once', () async {
    final preferences = _FakeLocalePreferences();
    final container = ProviderContainer(
      overrides: [localePreferencesProvider.overrideWithValue(preferences)],
    );
    addTearDown(container.dispose);

    await container
        .read(localeControllerProvider.notifier)
        .setLocale(AppLocales.bangla);
    await container
        .read(localeControllerProvider.notifier)
        .setLocale(AppLocales.bangla);

    expect(container.read(localeControllerProvider), AppLocales.bangla);
    expect(preferences.savedLocale, AppLocales.bangla);
    expect(preferences.writeCount, 1);
  });

  test('ignores unsupported locales', () async {
    final preferences = _FakeLocalePreferences();
    final container = ProviderContainer(
      overrides: [localePreferencesProvider.overrideWithValue(preferences)],
    );
    addTearDown(container.dispose);

    await container
        .read(localeControllerProvider.notifier)
        .setLocale(const Locale('fr'));

    expect(container.read(localeControllerProvider), AppLocales.english);
    expect(preferences.writeCount, 0);
  });
}

class _FakeLocalePreferences implements LocalePreferences {
  Locale? savedLocale;
  int writeCount = 0;

  @override
  Future<Locale> loadLocale() async {
    return savedLocale ?? AppLocales.english;
  }

  @override
  Future<void> saveLocale(Locale locale) async {
    savedLocale = locale;
    writeCount += 1;
  }
}
