import 'dart:async';

import 'package:ag_pos/core/constants/app_sizes.dart';
import 'package:ag_pos/core/extensions/build_context_extensions.dart';
import 'package:ag_pos/core/localization/app_locales.dart';
import 'package:ag_pos/core/localization/locale_controller.dart';
import 'package:ag_pos/core/responsive/app_breakpoints.dart';
import 'package:ag_pos/core/responsive/responsive_builder.dart';
import 'package:ag_pos/core/theme/theme_controller.dart';
import 'package:ag_pos/core/widgets/app_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedThemeMode = ref.watch(themeControllerProvider);
    final selectedLocale = ref.watch(localeControllerProvider);
    final l10n = context.locale;

    return AppPage(
      title: l10n.settingsTitle,
      maxContentWidth: AppSizes.formMaxWidth,
      body: ResponsiveBuilder(
        builder: (BuildContext context, metrics) {
          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: metrics.horizontalPadding,
              vertical: metrics.verticalPadding,
            ),
            children: <Widget>[
              Text(
                l10n.appearanceTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSizes.space8),
              Text(
                l10n.appearanceDescription,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSizes.space24),
              _ThemeModeSelector(
                selectedThemeMode: selectedThemeMode,
                useCompactLayout:
                    metrics.width < AppBreakpoints.segmentedControl,
                onChanged: (ThemeMode mode) {
                  unawaited(
                    ref
                        .read(themeControllerProvider.notifier)
                        .setThemeMode(mode),
                  );
                },
              ),
              SizedBox(height: metrics.sectionGap),
              Text(
                l10n.languageTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSizes.space8),
              Text(
                l10n.languageDescription,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSizes.space16),
              DropdownButtonFormField<Locale>(
                initialValue: selectedLocale,
                isExpanded: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.language_outlined),
                ),
                items: AppLocales.supported
                    .map((Locale locale) {
                      return DropdownMenuItem<Locale>(
                        value: locale,
                        child: Text(
                          _localeName(context, locale),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    })
                    .toList(growable: false),
                onChanged: (Locale? locale) {
                  if (locale != null) {
                    unawaited(
                      ref
                          .read(localeControllerProvider.notifier)
                          .setLocale(locale),
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }

  String _localeName(BuildContext context, Locale locale) {
    return switch (locale.languageCode) {
      'bn' => context.locale.languageBangla,
      'ar' => context.locale.languageArabic,
      _ => context.locale.languageEnglish,
    };
  }
}

class _ThemeModeSelector extends StatelessWidget {
  const _ThemeModeSelector({
    required this.selectedThemeMode,
    required this.useCompactLayout,
    required this.onChanged,
  });

  final ThemeMode selectedThemeMode;
  final bool useCompactLayout;
  final ValueChanged<ThemeMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final options = <_ThemeModeOption>[
      _ThemeModeOption(
        mode: ThemeMode.system,
        icon: Icons.brightness_auto_outlined,
        label: context.locale.themeSystem,
      ),
      _ThemeModeOption(
        mode: ThemeMode.light,
        icon: Icons.light_mode_outlined,
        label: context.locale.themeLight,
      ),
      _ThemeModeOption(
        mode: ThemeMode.dark,
        icon: Icons.dark_mode_outlined,
        label: context.locale.themeDark,
      ),
    ];

    if (!useCompactLayout) {
      return SegmentedButton<ThemeMode>(
        key: const Key('theme-mode-segmented'),
        showSelectedIcon: false,
        segments: options
            .map(
              (_ThemeModeOption option) => ButtonSegment<ThemeMode>(
                value: option.mode,
                icon: Icon(option.icon),
                label: Text(option.label),
              ),
            )
            .toList(growable: false),
        selected: <ThemeMode>{selectedThemeMode},
        onSelectionChanged: (Set<ThemeMode> selection) {
          onChanged(selection.first);
        },
      );
    }

    return Card(
      key: const Key('theme-mode-vertical'),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: options
            .map((_ThemeModeOption option) {
              final selected = option.mode == selectedThemeMode;
              return Semantics(
                button: true,
                selected: selected,
                child: ListTile(
                  leading: Icon(option.icon),
                  title: Text(option.label),
                  trailing: Icon(
                    selected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                  ),
                  selected: selected,
                  onTap: () => onChanged(option.mode),
                ),
              );
            })
            .toList(growable: false),
      ),
    );
  }
}

class _ThemeModeOption {
  const _ThemeModeOption({
    required this.mode,
    required this.icon,
    required this.label,
  });

  final ThemeMode mode;
  final IconData icon;
  final String label;
}
