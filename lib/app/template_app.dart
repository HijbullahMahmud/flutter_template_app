import 'package:ag_pos/core/config/app_config.dart';
import 'package:ag_pos/core/theme/app_theme.dart';
import 'package:ag_pos/core/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TemplateApp extends StatelessWidget {
  const TemplateApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = context.read<GoRouter>();
    final themeMode = context.select<ThemeController, ThemeMode>(
      (ThemeController controller) => controller.themeMode,
    );

    return MaterialApp.router(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: AppConfig.showDebugBanner,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
