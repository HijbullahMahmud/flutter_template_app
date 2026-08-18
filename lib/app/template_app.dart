import 'package:ag_pos/core/config/app_config.dart';
import 'package:ag_pos/core/extensions/build_context_extensions.dart';
import 'package:ag_pos/core/localization/locale_cubit.dart';
import 'package:ag_pos/core/responsive/app_breakpoints.dart';
import 'package:ag_pos/core/theme/app_theme.dart';
import 'package:ag_pos/core/theme/app_typography.dart';
import 'package:ag_pos/core/theme/theme_cubit.dart';
import 'package:ag_pos/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TemplateApp extends StatelessWidget {
  const TemplateApp({required this.router, super.key});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (BuildContext context, ThemeMode themeMode) {
        return BlocBuilder<LocaleCubit, Locale>(
          builder: (BuildContext context, Locale locale) {
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
          },
        );
      },
    );
  }
}
