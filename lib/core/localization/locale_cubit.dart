import 'package:ag_pos/core/localization/app_locales.dart';
import 'package:ag_pos/core/localization/locale_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit({required this.preferences, Locale? initialLocale})
    : super(initialLocale ?? AppLocales.english);

  final LocalePreferences preferences;

  Future<void> setLocale(Locale locale) async {
    if (!AppLocales.isSupported(locale) ||
        state.languageCode == locale.languageCode) {
      return;
    }

    emit(locale);

    try {
      await preferences.saveLocale(locale);
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
