import 'package:ag_pos/core/localization/app_locales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('contains English, Bangla, and Arabic', () {
    expect(
      AppLocales.supported.map((Locale locale) => locale.languageCode),
      <String>['en', 'bn', 'ar'],
    );
  });

  test('decodes saved language codes', () {
    expect(AppLocales.fromLanguageCode('en'), AppLocales.english);
    expect(AppLocales.fromLanguageCode('bn'), AppLocales.bangla);
    expect(AppLocales.fromLanguageCode('ar'), AppLocales.arabic);
  });

  test('falls back to English for missing or invalid values', () {
    expect(AppLocales.fromLanguageCode(null), AppLocales.english);
    expect(AppLocales.fromLanguageCode('fr'), AppLocales.english);
  });
}
