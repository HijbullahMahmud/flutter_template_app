import 'dart:async';

import 'package:ag_pos/core/constants/app_sizes.dart';
import 'package:ag_pos/core/extensions/build_context_extensions.dart';
import 'package:ag_pos/core/localization/app_locales.dart';
import 'package:ag_pos/core/localization/locale_controller.dart';
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
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.space24),
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
          SegmentedButton<ThemeMode>(
            segments: <ButtonSegment<ThemeMode>>[
              ButtonSegment<ThemeMode>(
                value: ThemeMode.system,
                icon: const Icon(Icons.brightness_auto_outlined),
                label: Text(l10n.themeSystem),
              ),
              ButtonSegment<ThemeMode>(
                value: ThemeMode.light,
                icon: const Icon(Icons.light_mode_outlined),
                label: Text(l10n.themeLight),
              ),
              ButtonSegment<ThemeMode>(
                value: ThemeMode.dark,
                icon: const Icon(Icons.dark_mode_outlined),
                label: Text(l10n.themeDark),
              ),
            ],
            selected: <ThemeMode>{selectedThemeMode},
            onSelectionChanged: (Set<ThemeMode> selection) {
              unawaited(
                ref
                    .read(themeControllerProvider.notifier)
                    .setThemeMode(selection.first),
              );
            },
          ),
          const SizedBox(height: AppSizes.space32),
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
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.language_outlined),
            ),
            items: AppLocales.supported
                .map((Locale locale) {
                  return DropdownMenuItem<Locale>(
                    value: locale,
                    child: Text(_localeName(context, locale)),
                  );
                })
                .toList(growable: false),
            onChanged: (Locale? locale) {
              if (locale != null) {
                unawaited(
                  ref.read(localeControllerProvider.notifier).setLocale(locale),
                );
              }
            },
          ),
        ],
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
