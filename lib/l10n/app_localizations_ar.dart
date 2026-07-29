// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'قالب فلاتر';

  @override
  String get settingsTooltip => 'الإعدادات';

  @override
  String get homeReadyTitle => 'جاهز لبناء ميزاتك.';

  @override
  String get homeReadyDescription =>
      'استبدل هذه الميزة التجريبية بوحدات منتجك. البنية الأساسية للتطبيق جاهزة.';

  @override
  String get homeLoadError => 'تعذر تحميل محتوى البداية.';

  @override
  String get featureArchitectureTitle => 'البنية النظيفة';

  @override
  String get featureArchitectureDescription =>
      'طبقات البيانات والمجال والعرض منظمة حسب الميزة.';

  @override
  String get featureRoutingTitle => 'GoRouter';

  @override
  String get featureRoutingDescription =>
      'تنقل مركزي ومسمى وجاهز للروابط العميقة.';

  @override
  String get featureRiverpodTitle => 'Riverpod + DI';

  @override
  String get featureRiverpodDescription => 'مزودات مولدة وحالة قابلة للاختبار.';

  @override
  String get featureNetworkTitle => 'شبكات Dio';

  @override
  String get featureNetworkDescription =>
      'عمليات CRUD محددة النوع وتخزين مؤقت ومعالجة مركزية للأخطاء.';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get appearanceTitle => 'المظهر';

  @override
  String get appearanceDescription =>
      'يتبع وضع النظام إعداد الجهاز الحالي للوضع الفاتح أو الداكن.';

  @override
  String get themeSystem => 'النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get languageTitle => 'اللغة';

  @override
  String get languageDescription =>
      'اختر اللغة المستخدمة في جميع أنحاء التطبيق.';

  @override
  String get languageEnglish => 'الإنجليزية';

  @override
  String get languageBangla => 'البنغالية';

  @override
  String get languageArabic => 'العربية';

  @override
  String get tryAgain => 'حاول مرة أخرى';

  @override
  String notFoundMessage(String location) {
    return 'لا توجد صفحة في $location';
  }

  @override
  String get backToHome => 'العودة إلى الرئيسية';
}
