enum AppWindowSize { smallPhone, phone, tablet, expanded }

abstract final class AppBreakpoints {
  /// Widths use Flutter logical pixels, not physical device pixels.
  static const double smallPhone = 360;
  static const double tablet = 600;
  static const double expanded = 840;

  /// A segmented control needs more room than the small-phone breakpoint,
  /// especially after localization and accessibility text scaling.
  static const double segmentedControl = 520;

  static AppWindowSize windowSizeFor(double width) {
    if (width < smallPhone) {
      return AppWindowSize.smallPhone;
    }
    if (width < tablet) {
      return AppWindowSize.phone;
    }
    if (width < expanded) {
      return AppWindowSize.tablet;
    }
    return AppWindowSize.expanded;
  }
}
