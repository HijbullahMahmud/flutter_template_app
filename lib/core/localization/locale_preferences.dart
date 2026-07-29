import 'package:ag_pos/core/localization/app_locales.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class LocalePreferences {
  Future<Locale> loadLocale();
  Future<void> saveLocale(Locale locale);
}

class SharedPreferencesLocalePreferences implements LocalePreferences {
  SharedPreferencesLocalePreferences([SharedPreferencesAsync? preferences])
    : _preferences = preferences ?? SharedPreferencesAsync();

  static const String _localeKey = 'settings.locale';

  final SharedPreferencesAsync _preferences;

  @override
  Future<Locale> loadLocale() async {
    final languageCode = await _preferences.getString(_localeKey);
    return AppLocales.fromLanguageCode(languageCode);
  }

  @override
  Future<void> saveLocale(Locale locale) {
    return _preferences.setString(_localeKey, locale.languageCode);
  }
}
