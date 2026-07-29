import 'package:ag_pos/app/router/app_routes.dart';
import 'package:ag_pos/app/template_app.dart';
import 'package:ag_pos/core/di/app_providers.dart';
import 'package:ag_pos/core/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the starter home page', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: TemplateApp()));
    await tester.pumpAndSettle();

    expect(find.text('Ready for your features.'), findsOneWidget);
    expect(find.text('Clean architecture'), findsOneWidget);
    expect(find.text('GoRouter'), findsOneWidget);
    expect(find.text('Riverpod + DI'), findsOneWidget);
  });

  testWidgets('navigates to settings and changes theme', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: TemplateApp()));
    await tester.pumpAndSettle();

    final appContext = tester.element(find.byType(MaterialApp));
    final container = ProviderScope.containerOf(appContext);
    expect(container.read(themeModeProvider), ThemeMode.system);

    container.read(routerProvider).goNamed(AppRouteNames.settings);
    await tester.pumpAndSettle();
    expect(find.text('Appearance'), findsOneWidget);

    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();

    expect(container.read(themeModeProvider), ThemeMode.dark);
  });
}
