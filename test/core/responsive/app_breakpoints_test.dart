import 'package:ag_pos/core/responsive/app_breakpoints.dart';
import 'package:ag_pos/core/responsive/responsive_value.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppBreakpoints', () {
    test('maps logical widths to the expected window size', () {
      expect(AppBreakpoints.windowSizeFor(320), AppWindowSize.smallPhone);
      expect(AppBreakpoints.windowSizeFor(360), AppWindowSize.phone);
      expect(AppBreakpoints.windowSizeFor(599), AppWindowSize.phone);
      expect(AppBreakpoints.windowSizeFor(600), AppWindowSize.tablet);
      expect(AppBreakpoints.windowSizeFor(839), AppWindowSize.tablet);
      expect(AppBreakpoints.windowSizeFor(840), AppWindowSize.expanded);
    });
  });

  test('ResponsiveValue resolves every window size', () {
    const value = ResponsiveValue<int>(
      smallPhone: 1,
      phone: 2,
      tablet: 3,
      expanded: 4,
    );

    expect(value.resolve(AppWindowSize.smallPhone), 1);
    expect(value.resolve(AppWindowSize.phone), 2);
    expect(value.resolve(AppWindowSize.tablet), 3);
    expect(value.resolve(AppWindowSize.expanded), 4);
  });
}
