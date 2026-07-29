import 'package:ag_pos/core/config/app_config.dart';
import 'package:ag_pos/core/di/app_providers.dart';
import 'package:ag_pos/core/extensions/build_context_extensions.dart';
import 'package:ag_pos/core/localization/locale_controller.dart';
import 'package:ag_pos/core/responsive/app_breakpoints.dart';
import 'package:ag_pos/core/theme/app_theme.dart';
import 'package:ag_pos/core/theme/app_typography.dart';
import 'package:ag_pos/core/theme/theme_controller.dart';
import 'package:ag_pos/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TemplateApp extends ConsumerWidget {
  const TemplateApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeControllerProvider);
    final locale = ref.watch(localeControllerProvider);

    return MaterialApp.router(
      onGenerateTitle: (BuildContext context) => context.locale.appName,
      debugShowCheckedModeBanner: AppConfig.showDebugBanner,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: router,
      builder: (BuildContext context, Widget? child) {
        final windowSize = AppBreakpoints.windowSizeFor(
          MediaQuery.sizeOf(context).width,
        );
        final theme = Theme.of(context);
        final textTheme = AppTypography.forWindowSize(windowSize).apply(
          bodyColor: theme.colorScheme.onSurface,
          displayColor: theme.colorScheme.onSurface,
        );

        return Theme(
          data: theme.copyWith(textTheme: textTheme),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
