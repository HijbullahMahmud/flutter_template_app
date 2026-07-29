import 'package:ag_pos/core/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('uses the device theme by default', () {
    final controller = ThemeController();

    expect(controller.themeMode, ThemeMode.system);
  });

  test('notifies listeners when theme mode changes', () {
    final controller = ThemeController();
    var notificationCount = 0;
    controller.addListener(() => notificationCount += 1);

    controller.setThemeMode(ThemeMode.dark);
    controller.setThemeMode(ThemeMode.dark);

    expect(controller.themeMode, ThemeMode.dark);
    expect(notificationCount, 1);
  });
}
