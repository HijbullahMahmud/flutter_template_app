import 'package:ag_pos/app/router/app_routes.dart';
import 'package:ag_pos/app/template_app.dart';
import 'package:ag_pos/core/di/app_providers.dart';
import 'package:ag_pos/core/localization/app_locales.dart';
import 'package:ag_pos/core/localization/locale_controller.dart';
import 'package:ag_pos/core/localization/locale_preferences.dart';
import 'package:ag_pos/core/theme/theme_controller.dart';
import 'package:ag_pos/core/theme/theme_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the starter home page', (WidgetTester tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.text('Ready for your features.'), findsOneWidget);
    expect(find.text('Clean architecture'), findsOneWidget);
    expect(find.text('GoRouter'), findsOneWidget);
    expect(find.text('Riverpod + DI'), findsOneWidget);
  });

  testWidgets('navigates to settings and changes theme', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    final appContext = tester.element(find.byType(MaterialApp));
    final container = ProviderScope.containerOf(appContext);
    expect(container.read(themeControllerProvider), ThemeMode.system);

    container.read(routerProvider).goNamed(AppRouteNames.settings);
    await tester.pumpAndSettle();
    expect(find.text('Appearance'), findsOneWidget);

    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();

    expect(container.read(themeControllerProvider), ThemeMode.dark);
  });

  testWidgets('selects, persists, and renders supported languages', (
    WidgetTester tester,
  ) async {
    final localePreferences = _FakeLocalePreferences();
    await tester.pumpWidget(_buildApp(localePreferences: localePreferences));
    await tester.pumpAndSettle();

    final appContext = tester.element(find.byType(MaterialApp));
    final container = ProviderScope.containerOf(appContext);
    expect(container.read(localeControllerProvider), AppLocales.english);

    container.read(routerProvider).goNamed(AppRouteNames.settings);
    await tester.pumpAndSettle();

    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bangla').last);
    await tester.pumpAndSettle();

    expect(container.read(localeControllerProvider), AppLocales.bangla);
    expect(localePreferences.savedLocale, AppLocales.bangla);
    expect(find.text('সেটিংস'), findsOneWidget);

    await container
        .read(localeControllerProvider.notifier)
        .setLocale(AppLocales.arabic);
    await tester.pumpAndSettle();

    expect(find.text('الإعدادات'), findsOneWidget);
    final settingsContext = tester.element(find.text('الإعدادات'));
    expect(Directionality.of(settingsContext), TextDirection.rtl);
  });
}

Widget _buildApp({LocalePreferences? localePreferences}) {
  return ProviderScope(
    overrides: [
      themePreferencesProvider.overrideWithValue(_FakeThemePreferences()),
      localePreferencesProvider.overrideWithValue(
        localePreferences ?? _FakeLocalePreferences(),
      ),
    ],
    child: const TemplateApp(),
  );
}

class _FakeThemePreferences implements ThemePreferences {
  @override
  Future<ThemeMode> loadThemeMode() async => ThemeMode.system;

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {}
}

class _FakeLocalePreferences implements LocalePreferences {
  Locale? savedLocale;

  @override
  Future<Locale> loadLocale() async {
    return savedLocale ?? AppLocales.english;
  }

  @override
  Future<void> saveLocale(Locale locale) async {
    savedLocale = locale;
  }
}
