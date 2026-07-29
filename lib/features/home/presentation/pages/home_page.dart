import 'package:ag_pos/app/router/app_routes.dart';
import 'package:ag_pos/core/config/app_config.dart';
import 'package:ag_pos/core/constants/app_sizes.dart';
import 'package:ag_pos/core/widgets/app_error_view.dart';
import 'package:ag_pos/core/widgets/app_page.dart';
import 'package:ag_pos/features/home/presentation/providers/home_controller.dart';
import 'package:ag_pos/features/home/presentation/widgets/feature_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: AppConfig.appName,
      actions: <Widget>[
        IconButton(
          tooltip: 'Settings',
          onPressed: () => context.goNamed(AppRouteNames.settings),
          icon: const Icon(Icons.settings_outlined),
        ),
        const SizedBox(width: AppSizes.space8),
      ],
      body: Consumer<HomeController>(
        builder:
            (BuildContext context, HomeController controller, Widget? child) {
              return switch (controller.status) {
                HomeStatus.initial || HomeStatus.loading => const Center(
                  child: CircularProgressIndicator(),
                ),
                HomeStatus.failure => AppErrorView(
                  message: controller.errorMessage ?? 'Something went wrong.',
                  onRetry: controller.load,
                ),
                HomeStatus.success => _HomeContent(controller: controller),
              };
            },
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.space24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Ready for your features.',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: AppSizes.space8),
          Text(
            'Replace this starter feature with your product modules. '
            'The app foundation is already wired.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSizes.space32),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final columns = constraints.maxWidth < AppSizes.compactBreakpoint
                  ? 1
                  : 2;
              final itemWidth =
                  (constraints.maxWidth - (AppSizes.space16 * (columns - 1))) /
                  columns;

              return Wrap(
                spacing: AppSizes.space16,
                runSpacing: AppSizes.space16,
                children: controller.features
                    .map(
                      (feature) => SizedBox(
                        width: itemWidth,
                        child: FeatureCard(feature: feature),
                      ),
                    )
                    .toList(growable: false),
              );
            },
          ),
        ],
      ),
    );
  }
}
