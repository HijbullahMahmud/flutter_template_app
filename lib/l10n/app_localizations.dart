import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('bn'),
    Locale('en'),
  ];

  /// Application name
  ///
  /// In en, this message translates to:
  /// **'Flutter Starter'**
  String get appName;

  /// No description provided for @settingsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTooltip;

  /// No description provided for @homeReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Ready for your features.'**
  String get homeReadyTitle;

  /// No description provided for @homeReadyDescription.
  ///
  /// In en, this message translates to:
  /// **'Replace this starter feature with your product modules. The app foundation is already wired.'**
  String get homeReadyDescription;

  /// No description provided for @homeLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load the starter content.'**
  String get homeLoadError;

  /// No description provided for @featureArchitectureTitle.
  ///
  /// In en, this message translates to:
  /// **'Clean architecture'**
  String get featureArchitectureTitle;

  /// No description provided for @featureArchitectureDescription.
  ///
  /// In en, this message translates to:
  /// **'Feature-first data, domain, and presentation layers.'**
  String get featureArchitectureDescription;

  /// No description provided for @featureRoutingTitle.
  ///
  /// In en, this message translates to:
  /// **'GoRouter'**
  String get featureRoutingTitle;

  /// No description provided for @featureRoutingDescription.
  ///
  /// In en, this message translates to:
  /// **'Centralized, named, and deep-link-ready navigation.'**
  String get featureRoutingDescription;

  /// No description provided for @featureRiverpodTitle.
  ///
  /// In en, this message translates to:
  /// **'Riverpod + DI'**
  String get featureRiverpodTitle;

  /// No description provided for @featureRiverpodDescription.
  ///
  /// In en, this message translates to:
  /// **'Generated providers and testable state.'**
  String get featureRiverpodDescription;

  /// No description provided for @featureNetworkTitle.
  ///
  /// In en, this message translates to:
  /// **'Dio networking'**
  String get featureNetworkTitle;

  /// No description provided for @featureNetworkDescription.
  ///
  /// In en, this message translates to:
  /// **'Typed CRUD, caching, and centralized error handling.'**
  String get featureNetworkDescription;

  /// No description provided for @productsBrowseAction.
  ///
  /// In en, this message translates to:
  /// **'Browse sample products'**
  String get productsBrowseAction;

  /// No description provided for @productsTitle.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get productsTitle;

  /// No description provided for @productsDescription.
  ///
  /// In en, this message translates to:
  /// **'A real paginated API example using Dio, Dartz, Riverpod, Freezed, and the responsive grid.'**
  String get productsDescription;

  /// No description provided for @productsCount.
  ///
  /// In en, this message translates to:
  /// **'Showing {count} products'**
  String productsCount(int count);

  /// No description provided for @productsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load products.'**
  String get productsLoadError;

  /// No description provided for @productsLoadMoreError.
  ///
  /// In en, this message translates to:
  /// **'Could not load the next page of products.'**
  String get productsLoadMoreError;

  /// No description provided for @productsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No products are available.'**
  String get productsEmpty;

  /// No description provided for @productsEndOfList.
  ///
  /// In en, this message translates to:
  /// **'You have reached the end.'**
  String get productsEndOfList;

  /// No description provided for @productImageLabel.
  ///
  /// In en, this message translates to:
  /// **'Image of {title}'**
  String productImageLabel(String title);

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @appearanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearanceTitle;

  /// No description provided for @appearanceDescription.
  ///
  /// In en, this message translates to:
  /// **'System follows the current light or dark setting of the device.'**
  String get appearanceDescription;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @languageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTitle;

  /// No description provided for @languageDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose the language used throughout the application.'**
  String get languageDescription;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageBangla.
  ///
  /// In en, this message translates to:
  /// **'Bangla'**
  String get languageBangla;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get languageArabic;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @notFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'No page exists at {location}'**
  String notFoundMessage(String location);

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get backToHome;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
