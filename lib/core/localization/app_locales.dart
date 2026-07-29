import 'package:flutter/material.dart';

abstract final class AppLocales {
  static const Locale english = Locale('en');
  static const Locale bangla = Locale('bn');
  static const Locale arabic = Locale('ar');

  static const List<Locale> supported = <Locale>[english, bangla, arabic];

  static Locale fromLanguageCode(String? languageCode) {
    return switch (languageCode) {
      'bn' => bangla,
      'ar' => arabic,
      'en' || _ => english,
    };
  }

  static bool isSupported(Locale locale) {
    return supported.any(
      (Locale supportedLocale) =>
          supportedLocale.languageCode == locale.languageCode,
    );
  }
}
