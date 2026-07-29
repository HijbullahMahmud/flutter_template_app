import 'package:ag_pos/app/router/app_routes.dart';
import 'package:ag_pos/app/template_app.dart';
import 'package:ag_pos/core/di/app_providers.dart';
import 'package:ag_pos/core/localization/app_locales.dart';
import 'package:ag_pos/core/localization/locale_controller.dart';
import 'package:ag_pos/core/localization/locale_preferences.dart';
import 'package:ag_pos/core/theme/theme_controller.dart';
import 'package:ag_pos/core/theme/theme_preferences.dart';
import 'package:ag_pos/features/home/presentation/widgets/feature_card.dart';
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

  testWidgets('small phone with large text renders without overflow', (
    WidgetTester tester,
  ) async {
    _configureView(tester, const Size(320, 568), textScaleFactor: 2);

    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.text('Ready for your features.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('small phone uses compact theme controls in Bangla', (
    WidgetTester tester,
  ) async {
    _configureView(tester, const Size(320, 568));

    await tester.pumpWidget(
      _buildApp(
        localePreferences: _FakeLocalePreferences(
          initialLocale: AppLocales.bangla,
        ),
        initialLocale: AppLocales.bangla,
      ),
    );
    await tester.pumpAndSettle();

    final appContext = tester.element(find.byType(MaterialApp));
    final container = ProviderScope.containerOf(appContext);
    container.read(routerProvider).goNamed(AppRouteNames.settings);
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('theme-mode-vertical')), findsOneWidget);
    expect(find.byKey(const Key('theme-mode-segmented')), findsNothing);
    expect(find.text('সেটিংস'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('tablet uses three columns and Arabic RTL without overflow', (
    WidgetTester tester,
  ) async {
    _configureView(tester, const Size(1024, 768));

    await tester.pumpWidget(
      _buildApp(
        localePreferences: _FakeLocalePreferences(
          initialLocale: AppLocales.arabic,
        ),
        initialLocale: AppLocales.arabic,
      ),
    );
    await tester.pumpAndSettle();

    final cards = find.byType(FeatureCard);
    expect(cards, findsNWidgets(4));
    expect(
      tester.getTopLeft(cards.at(0)).dy,
      tester.getTopLeft(cards.at(1)).dy,
    );
    expect(
      tester.getTopLeft(cards.at(1)).dy,
      tester.getTopLeft(cards.at(2)).dy,
    );

    final cardContext = tester.element(cards.first);
    expect(Directionality.of(cardContext), TextDirection.rtl);
    expect(tester.takeException(), isNull);
  });
}

void _configureView(
  WidgetTester tester,
  Size size, {
  double textScaleFactor = 1,
}) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  tester.platformDispatcher.textScaleFactorTestValue = textScaleFactor;

  addTearDown(() {
    tester.view.resetDevicePixelRatio();
    tester.view.resetPhysicalSize();
    tester.platformDispatcher.clearTextScaleFactorTestValue();
  });
}

Widget _buildApp({
  LocalePreferences? localePreferences,
  Locale initialLocale = AppLocales.english,
}) {
  return ProviderScope(
    overrides: [
      themePreferencesProvider.overrideWithValue(_FakeThemePreferences()),
      initialLocaleProvider.overrideWithValue(initialLocale),
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
  _FakeLocalePreferences({Locale? initialLocale}) : savedLocale = initialLocale;

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
