import 'package:ag_pos/app/router/app_routes.dart';
import 'package:ag_pos/core/constants/app_sizes.dart';
import 'package:ag_pos/core/extensions/build_context_extensions.dart';
import 'package:ag_pos/core/responsive/responsive_builder.dart';
import 'package:ag_pos/core/widgets/app_error_view.dart';
import 'package:ag_pos/core/widgets/app_loading_indicator.dart';
import 'package:ag_pos/core/widgets/app_page.dart';
import 'package:ag_pos/features/home/domain/entities/template_feature.dart';
import 'package:ag_pos/features/home/presentation/bloc/home_bloc.dart';
import 'package:ag_pos/features/home/presentation/widgets/feature_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, HomeState state) {
        return AppPage(
          title: context.locale.appName,
          actions: <Widget>[
            IconButton(
              tooltip: context.locale.settingsTooltip,
              onPressed: () => context.goNamed(AppRouteNames.settings),
              icon: const Icon(Icons.settings_outlined),
            ),
            const SizedBox(width: AppSizes.space8),
          ],
          body: switch (state) {
            HomeLoadSuccess(:final features) => _HomeContent(
              features: features,
            ),
            HomeLoadFailure() => AppErrorView(
              message: context.locale.homeLoadError,
              onRetry: () =>
                  context.read<HomeBloc>().add(const HomeRequested()),
            ),
            HomeLoading() => AppLoadingView(
              semanticLabel: context.locale.loadingLabel,
            ),
          },
        );
      },
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.features});

  final List<TemplateFeature> features;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, metrics) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: metrics.horizontalPadding,
            vertical: metrics.verticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppSizes.readableTextMaxWidth,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      context.locale.homeReadyTitle,
                      style: metrics.isSmallPhone
                          ? Theme.of(context).textTheme.headlineMedium
                          : Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: AppSizes.space8),
                    Text(
                      context.locale.homeReadyDescription,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSizes.space16),
                    FilledButton.icon(
                      onPressed: () => context.goNamed(AppRouteNames.products),
                      icon: const Icon(Icons.shopping_bag_outlined),
                      label: Text(context.locale.productsBrowseAction),
                    ),
                  ],
                ),
              ),
              SizedBox(height: metrics.sectionGap),
              ResponsiveGrid(
                minimumItemWidth: AppSizes.cardMinWidth,
                spacing: metrics.gridGap,
                children: features
                    .map(
                      (TemplateFeature feature) =>
                          FeatureCard(feature: feature),
                    )
                    .toList(growable: false),
              ),
            ],
          ),
        );
      },
    );
  }
}
