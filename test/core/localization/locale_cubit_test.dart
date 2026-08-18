import 'package:ag_pos/core/localization/app_locales.dart';
import 'package:ag_pos/core/localization/locale_cubit.dart';
import 'package:ag_pos/core/localization/locale_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('uses English by default', () {
    final cubit = LocaleCubit(preferences: _FakeLocalePreferences());
    addTearDown(cubit.close);

    expect(cubit.state, AppLocales.english);
  });

  test('restores the supplied saved locale', () {
    final cubit = LocaleCubit(
      preferences: _FakeLocalePreferences(),
      initialLocale: AppLocales.arabic,
    );
    addTearDown(cubit.close);

    expect(cubit.state, AppLocales.arabic);
  });

  test('updates and persists a supported locale once', () async {
    final preferences = _FakeLocalePreferences();
    final cubit = LocaleCubit(preferences: preferences);
    addTearDown(cubit.close);

    await cubit.setLocale(AppLocales.bangla);
    await cubit.setLocale(AppLocales.bangla);

    expect(cubit.state, AppLocales.bangla);
    expect(preferences.savedLocale, AppLocales.bangla);
    expect(preferences.writeCount, 1);
  });

  test('ignores unsupported locales', () async {
    final preferences = _FakeLocalePreferences();
    final cubit = LocaleCubit(preferences: preferences);
    addTearDown(cubit.close);

    await cubit.setLocale(const Locale('fr'));

    expect(cubit.state, AppLocales.english);
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
