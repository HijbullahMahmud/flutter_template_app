import 'dart:ui';

import 'package:ag_pos/app/template_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void bootstrap() {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = FlutterError.presentError;
  PlatformDispatcher.instance.onError = (Object error, StackTrace stackTrace) {
    FlutterError.reportError(
      FlutterErrorDetails(exception: error, stack: stackTrace),
    );
    return true;
  };

  runApp(const ProviderScope(child: TemplateApp()));
}
