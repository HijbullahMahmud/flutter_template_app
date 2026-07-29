import 'package:ag_pos/core/localization/app_locales.dart';
import 'package:ag_pos/core/localization/locale_preferences.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_controller.g.dart';

@Riverpod(keepAlive: true)
Locale initialLocale(Ref ref) => AppLocales.english;

@Riverpod(keepAlive: true)
LocalePreferences localePreferences(Ref ref) {
  return SharedPreferencesLocalePreferences();
}

@Riverpod(keepAlive: true)
class LocaleController extends _$LocaleController {
  @override
  Locale build() => ref.watch(initialLocaleProvider);

  Future<void> setLocale(Locale locale) async {
    if (!AppLocales.isSupported(locale) ||
        state.languageCode == locale.languageCode) {
      return;
    }

    state = locale;

    try {
      await ref.read(localePreferencesProvider).saveLocale(locale);
    } on Object catch (error, stackTrace) {
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: error,
          stack: stackTrace,
          library: 'locale preferences',
          context: ErrorDescription('while saving the selected locale'),
        ),
      );
    }
  }
}
