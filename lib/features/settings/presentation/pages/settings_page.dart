import 'dart:async';

import 'package:ag_pos/core/constants/app_sizes.dart';
import 'package:ag_pos/core/theme/theme_controller.dart';
import 'package:ag_pos/core/widgets/app_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMode = ref.watch(themeModeProvider);

    return AppPage(
      title: 'Settings',
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.space24),
        children: <Widget>[
          Text('Appearance', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSizes.space8),
          Text(
            'System follows the current light or dark setting of the device.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSizes.space24),
          SegmentedButton<ThemeMode>(
            segments: const <ButtonSegment<ThemeMode>>[
              ButtonSegment<ThemeMode>(
                value: ThemeMode.system,
                icon: Icon(Icons.brightness_auto_outlined),
                label: Text('System'),
              ),
              ButtonSegment<ThemeMode>(
                value: ThemeMode.light,
                icon: Icon(Icons.light_mode_outlined),
                label: Text('Light'),
              ),
              ButtonSegment<ThemeMode>(
                value: ThemeMode.dark,
                icon: Icon(Icons.dark_mode_outlined),
                label: Text('Dark'),
              ),
            ],
            selected: <ThemeMode>{selectedMode},
            onSelectionChanged: (Set<ThemeMode> selection) {
              unawaited(
                ref
                    .read(themeModeProvider.notifier)
                    .setThemeMode(selection.first),
              );
            },
          ),
        ],
      ),
    );
  }
}
