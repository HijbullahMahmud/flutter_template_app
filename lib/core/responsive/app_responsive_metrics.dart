import 'package:ag_pos/core/responsive/app_breakpoints.dart';
import 'package:ag_pos/core/responsive/responsive_value.dart';

class AppResponsiveMetrics {
  const AppResponsiveMetrics._({required this.width, required this.windowSize});

  factory AppResponsiveMetrics.fromWidth(double width) {
    return AppResponsiveMetrics._(
      width: width,
      windowSize: AppBreakpoints.windowSizeFor(width),
    );
  }

  static const ResponsiveValue<double> _horizontalPadding =
      ResponsiveValue<double>(
        smallPhone: 12,
        phone: 16,
        tablet: 24,
        expanded: 32,
      );
  static const ResponsiveValue<double> _verticalPadding =
      ResponsiveValue<double>(
        smallPhone: 16,
        phone: 20,
        tablet: 24,
        expanded: 32,
      );
  static const ResponsiveValue<double> _cardPadding = ResponsiveValue<double>(
    smallPhone: 16,
    phone: 20,
    tablet: 24,
    expanded: 24,
  );
  static const ResponsiveValue<double> _gridGap = ResponsiveValue<double>(
    smallPhone: 12,
    phone: 16,
    tablet: 20,
    expanded: 24,
  );
  static const ResponsiveValue<double> _sectionGap = ResponsiveValue<double>(
    smallPhone: 24,
    phone: 28,
    tablet: 32,
    expanded: 36,
  );

  final double width;
  final AppWindowSize windowSize;

  double get horizontalPadding => _horizontalPadding.resolve(windowSize);
  double get verticalPadding => _verticalPadding.resolve(windowSize);
  double get cardPadding => _cardPadding.resolve(windowSize);
  double get gridGap => _gridGap.resolve(windowSize);
  double get sectionGap => _sectionGap.resolve(windowSize);

  bool get isSmallPhone => windowSize == AppWindowSize.smallPhone;
  bool get isPhone =>
      windowSize == AppWindowSize.smallPhone ||
      windowSize == AppWindowSize.phone;
  bool get isTablet =>
      windowSize == AppWindowSize.tablet ||
      windowSize == AppWindowSize.expanded;
}
