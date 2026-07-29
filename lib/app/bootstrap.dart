import 'dart:async';

import 'package:ag_pos/app/template_app.dart';
import 'package:ag_pos/core/di/app_providers.dart';
import 'package:flutter/material.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };

  await runZonedGuarded(
    () async {
      runApp(const AppProviders(child: TemplateApp()));
    },
    (Object error, StackTrace stackTrace) {
      FlutterError.reportError(
        FlutterErrorDetails(exception: error, stack: stackTrace),
      );
    },
  );
}
