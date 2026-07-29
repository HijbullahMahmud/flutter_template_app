import 'package:ag_pos/core/widgets/app_loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('uses a Material indicator on Android', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      _testApp(TargetPlatform.android, const AppLoadingIndicator()),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(CupertinoActivityIndicator), findsNothing);
  });

  testWidgets('uses a Cupertino indicator on iOS', (WidgetTester tester) async {
    await tester.pumpWidget(
      _testApp(TargetPlatform.iOS, const AppLoadingIndicator()),
    );

    expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('exposes an optional semantic loading label', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      _testApp(
        TargetPlatform.android,
        const AppLoadingIndicator(semanticLabel: 'Loading products'),
      ),
    );

    expect(find.bySemanticsLabel('Loading products'), findsOneWidget);
  });
}

Widget _testApp(TargetPlatform platform, Widget child) {
  return MaterialApp(
    theme: ThemeData(platform: platform),
    home: Scaffold(body: child),
  );
}
