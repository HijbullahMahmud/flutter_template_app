// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appName => 'ফ্লাটার স্টার্টার';

  @override
  String get settingsTooltip => 'সেটিংস';

  @override
  String get homeReadyTitle => 'আপনার ফিচার তৈরির জন্য প্রস্তুত।';

  @override
  String get homeReadyDescription =>
      'এই স্টার্টার ফিচারটি আপনার প্রোডাক্ট মডিউল দিয়ে প্রতিস্থাপন করুন। অ্যাপের ভিত্তি ইতিমধ্যে প্রস্তুত।';

  @override
  String get homeLoadError => 'স্টার্টার কনটেন্ট লোড করা যায়নি।';

  @override
  String get featureArchitectureTitle => 'ক্লিন আর্কিটেকচার';

  @override
  String get featureArchitectureDescription =>
      'ফিচার-ফার্স্ট ডেটা, ডোমেইন এবং প্রেজেন্টেশন লেয়ার।';

  @override
  String get featureRoutingTitle => 'GoRouter';

  @override
  String get featureRoutingDescription =>
      'কেন্দ্রীভূত, নামযুক্ত এবং ডিপ-লিংক উপযোগী নেভিগেশন।';

  @override
  String get featureBlocTitle => 'BLoC + DI';

  @override
  String get featureBlocDescription =>
      'স্পষ্ট ডিপেন্ডেন্সি এবং পরীক্ষাযোগ্য স্টেট।';

  @override
  String get featureNetworkTitle => 'Dio নেটওয়ার্কিং';

  @override
  String get featureNetworkDescription =>
      'টাইপড CRUD, ক্যাশিং এবং কেন্দ্রীভূত ত্রুটি ব্যবস্থাপনা।';

  @override
  String get productsBrowseAction => 'নমুনা পণ্য দেখুন';

  @override
  String get productsTitle => 'পণ্য';

  @override
  String get productsDescription =>
      'Dio, Dartz, BLoC, Freezed এবং রেসপনসিভ গ্রিড ব্যবহার করে একটি বাস্তব পেজিনেটেড API উদাহরণ।';

  @override
  String productsCount(int count) {
    return '$countটি পণ্য দেখানো হচ্ছে';
  }

  @override
  String get productsLoadError => 'পণ্য লোড করা যায়নি।';

  @override
  String get productsLoadMoreError => 'পণ্যের পরবর্তী পৃষ্ঠা লোড করা যায়নি।';

  @override
  String get productsEmpty => 'কোনো পণ্য পাওয়া যায়নি।';

  @override
  String get productsEndOfList => 'আপনি তালিকার শেষে পৌঁছেছেন।';

  @override
  String productImageLabel(String title) {
    return '$title-এর ছবি';
  }

  @override
  String get settingsTitle => 'সেটিংস';

  @override
  String get appearanceTitle => 'অ্যাপিয়ারেন্স';

  @override
  String get appearanceDescription =>
      'সিস্টেম মোড ডিভাইসের বর্তমান লাইট বা ডার্ক সেটিং অনুসরণ করে।';

  @override
  String get themeSystem => 'সিস্টেম';

  @override
  String get themeLight => 'লাইট';

  @override
  String get themeDark => 'ডার্ক';

  @override
  String get languageTitle => 'ভাষা';

  @override
  String get languageDescription =>
      'অ্যাপ্লিকেশনে ব্যবহারের জন্য ভাষা নির্বাচন করুন।';

  @override
  String get languageEnglish => 'ইংরেজি';

  @override
  String get languageBangla => 'বাংলা';

  @override
  String get languageArabic => 'আরবি';

  @override
  String get loadingLabel => 'লোড হচ্ছে';

  @override
  String get tryAgain => 'আবার চেষ্টা করুন';

  @override
  String notFoundMessage(String location) {
    return '$location ঠিকানায় কোনো পৃষ্ঠা নেই';
  }

  @override
  String get backToHome => 'হোমে ফিরে যান';
}
