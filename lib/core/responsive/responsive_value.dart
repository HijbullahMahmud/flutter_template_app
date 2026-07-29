import 'package:ag_pos/core/responsive/app_breakpoints.dart';

class ResponsiveValue<T> {
  const ResponsiveValue({
    required this.smallPhone,
    required this.phone,
    required this.tablet,
    required this.expanded,
  });

  final T smallPhone;
  final T phone;
  final T tablet;
  final T expanded;

  T resolve(AppWindowSize windowSize) {
    return switch (windowSize) {
      AppWindowSize.smallPhone => smallPhone,
      AppWindowSize.phone => phone,
      AppWindowSize.tablet => tablet,
      AppWindowSize.expanded => expanded,
    };
  }
}
