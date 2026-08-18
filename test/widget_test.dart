import 'package:ag_pos/app/router/app_router.dart';
import 'package:ag_pos/app/router/app_routes.dart';
import 'package:ag_pos/app/template_app.dart';
import 'package:ag_pos/core/error/failure.dart';
import 'package:ag_pos/core/localization/app_locales.dart';
import 'package:ag_pos/core/localization/locale_cubit.dart';
import 'package:ag_pos/core/localization/locale_preferences.dart';
import 'package:ag_pos/core/theme/theme_cubit.dart';
import 'package:ag_pos/core/theme/theme_preferences.dart';
import 'package:ag_pos/features/home/data/datasources/home_local_data_source.dart';
import 'package:ag_pos/features/home/data/repositories/home_repository_impl.dart';
import 'package:ag_pos/features/home/domain/usecases/get_template_features.dart';
import 'package:ag_pos/features/home/presentation/widgets/feature_card.dart';
import 'package:ag_pos/features/products/domain/entities/product.dart';
import 'package:ag_pos/features/products/domain/entities/product_page_result.dart';
import 'package:ag_pos/features/products/domain/repositories/products_repository.dart';
import 'package:ag_pos/features/products/domain/usecases/get_products.dart';
import 'package:ag_pos/features/products/presentation/widgets/product_card.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('renders the starter home page', (WidgetTester tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.text('Ready for your features.'), findsOneWidget);
    expect(find.text('Clean architecture'), findsOneWidget);
    expect(find.text('GoRouter'), findsOneWidget);
    expect(find.text('BLoC + DI'), findsOneWidget);
  });

  testWidgets('navigates to settings and changes theme', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    final appContext = tester.element(find.byType(MaterialApp));
    expect(appContext.read<ThemeCubit>().state, ThemeMode.system);

    _router(tester).goNamed(AppRouteNames.settings);
    await tester.pumpAndSettle();
    expect(find.text('Appearance'), findsOneWidget);

    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();

    expect(appContext.read<ThemeCubit>().state, ThemeMode.dark);
  });

  testWidgets('navigates from home to the paginated products feature', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Browse sample products'));
    await tester.pumpAndSettle();

    expect(find.text('Products'), findsOneWidget);
    expect(find.text('Demo product'), findsOneWidget);
    expect(find.byType(ProductCard), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('products use one, two, and three responsive columns', (
    WidgetTester tester,
  ) async {
    _configureView(tester, const Size(320, 700));
    final cases = <(Size, int)>[
      (const Size(320, 700), 1),
      (const Size(390, 700), 2),
      (const Size(600, 900), 3),
    ];

    for (final (size, expectedColumns) in cases) {
      tester.view.physicalSize = size;
      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();

      _router(tester).goNamed(AppRouteNames.products);
      await tester.pumpAndSettle();

      final cards = find.byType(ProductCard);
      expect(cards, findsAtLeastNWidgets(expectedColumns + 1));
      final firstRowY = tester.getTopLeft(cards.at(0)).dy;

      for (var index = 1; index < expectedColumns; index++) {
        expect(tester.getTopLeft(cards.at(index)).dy, firstRowY);
      }
      expect(
        tester.getTopLeft(cards.at(expectedColumns)).dy,
        greaterThan(firstRowY),
      );
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('selects, persists, and renders supported languages', (
    WidgetTester tester,
  ) async {
    final localePreferences = _FakeLocalePreferences();
    await tester.pumpWidget(_buildApp(localePreferences: localePreferences));
    await tester.pumpAndSettle();

    final appContext = tester.element(find.byType(MaterialApp));
    expect(appContext.read<LocaleCubit>().state, AppLocales.english);

    _router(tester).goNamed(AppRouteNames.settings);
    await tester.pumpAndSettle();

    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bangla').last);
    await tester.pumpAndSettle();

    expect(appContext.read<LocaleCubit>().state, AppLocales.bangla);
    expect(localePreferences.savedLocale, AppLocales.bangla);
    expect(find.text('সেটিংস'), findsOneWidget);

    await appContext.read<LocaleCubit>().setLocale(AppLocales.arabic);
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

    _router(tester).goNamed(AppRouteNames.settings);
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

GoRouter _router(WidgetTester tester) {
  final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
  return app.routerConfig! as GoRouter;
}

Widget _buildApp({
  LocalePreferences? localePreferences,
  Locale initialLocale = AppLocales.english,
}) {
  final router = AppRouter.create();
  addTearDown(router.dispose);
  final getTemplateFeatures = GetTemplateFeatures(
    HomeRepositoryImpl(const HomeLocalDataSourceImpl()),
  );

  return MultiRepositoryProvider(
    providers: <RepositoryProvider<dynamic>>[
      RepositoryProvider<GetTemplateFeatures>.value(value: getTemplateFeatures),
      RepositoryProvider<GetProducts>.value(
        value: GetProducts(_FakeProductsRepository()),
      ),
    ],
    child: MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(preferences: _FakeThemePreferences()),
        ),
        BlocProvider<LocaleCubit>(
          create: (_) => LocaleCubit(
            preferences: localePreferences ?? _FakeLocalePreferences(),
            initialLocale: initialLocale,
          ),
        ),
      ],
      child: TemplateApp(router: router),
    ),
  );
}

class _FakeProductsRepository implements ProductsRepository {
  @override
  Future<Either<Failure, ProductPageResult>> getProducts({
    required int skip,
    required int limit,
  }) async {
    return Right<Failure, ProductPageResult>(
      ProductPageResult(
        items: List<Product>.generate(
          6,
          (int index) => Product(
            id: index + 1,
            title: index == 0 ? 'Demo product' : 'Demo product ${index + 1}',
            description: 'A product loaded through the clean architecture.',
            category: 'demo',
            price: 9.99 + index,
            rating: 4.5,
            thumbnailUrl: 'https://example.com/product-${index + 1}.png',
          ),
        ),
        total: 6,
        skip: 0,
        limit: 12,
      ),
    );
  }
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
