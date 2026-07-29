// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Flutter Starter';

  @override
  String get settingsTooltip => 'Settings';

  @override
  String get homeReadyTitle => 'Ready for your features.';

  @override
  String get homeReadyDescription =>
      'Replace this starter feature with your product modules. The app foundation is already wired.';

  @override
  String get homeLoadError => 'Could not load the starter content.';

  @override
  String get featureArchitectureTitle => 'Clean architecture';

  @override
  String get featureArchitectureDescription =>
      'Feature-first data, domain, and presentation layers.';

  @override
  String get featureRoutingTitle => 'GoRouter';

  @override
  String get featureRoutingDescription =>
      'Centralized, named, and deep-link-ready navigation.';

  @override
  String get featureRiverpodTitle => 'Riverpod + DI';

  @override
  String get featureRiverpodDescription =>
      'Generated providers and testable state.';

  @override
  String get featureNetworkTitle => 'Dio networking';

  @override
  String get featureNetworkDescription =>
      'Typed CRUD, caching, and centralized error handling.';

  @override
  String get productsBrowseAction => 'Browse sample products';

  @override
  String get productsTitle => 'Products';

  @override
  String get productsDescription =>
      'A real paginated API example using Dio, Dartz, Riverpod, Freezed, and the responsive grid.';

  @override
  String productsCount(int count) {
    return 'Showing $count products';
  }

  @override
  String get productsLoadError => 'Could not load products.';

  @override
  String get productsLoadMoreError =>
      'Could not load the next page of products.';

  @override
  String get productsEmpty => 'No products are available.';

  @override
  String get productsEndOfList => 'You have reached the end.';

  @override
  String productImageLabel(String title) {
    return 'Image of $title';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get appearanceTitle => 'Appearance';

  @override
  String get appearanceDescription =>
      'System follows the current light or dark setting of the device.';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get languageTitle => 'Language';

  @override
  String get languageDescription =>
      'Choose the language used throughout the application.';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageBangla => 'Bangla';

  @override
  String get languageArabic => 'Arabic';

  @override
  String get loadingLabel => 'Loading';

  @override
  String get tryAgain => 'Try again';

  @override
  String notFoundMessage(String location) {
    return 'No page exists at $location';
  }

  @override
  String get backToHome => 'Back to home';
}
