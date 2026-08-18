import 'package:ag_pos/core/constants/app_sizes.dart';
import 'package:ag_pos/core/extensions/build_context_extensions.dart';
import 'package:ag_pos/core/responsive/responsive_builder.dart';
import 'package:ag_pos/features/home/domain/entities/template_feature.dart';
import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({required this.feature, super.key});

  final TemplateFeature feature;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final (title, description) = _localizedContent(context, feature.icon);

    return ResponsiveBuilder(
      builder: (BuildContext context, metrics) {
        return Card(
          child: Padding(
            padding: EdgeInsets.all(metrics.cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: colors.primaryContainer,
                    borderRadius: BorderRadius.circular(AppSizes.radius12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSizes.space12),
                    child: Icon(
                      _iconFor(feature.icon),
                      color: colors.onPrimaryContainer,
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.space16),
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: AppSizes.space8),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  (String, String) _localizedContent(
    BuildContext context,
    TemplateFeatureIcon icon,
  ) {
    final l10n = context.locale;

    return switch (icon) {
      TemplateFeatureIcon.architecture => (
        l10n.featureArchitectureTitle,
        l10n.featureArchitectureDescription,
      ),
      TemplateFeatureIcon.routing => (
        l10n.featureRoutingTitle,
        l10n.featureRoutingDescription,
      ),
      TemplateFeatureIcon.dependencyInjection => (
        l10n.featureBlocTitle,
        l10n.featureBlocDescription,
      ),
      TemplateFeatureIcon.theme => (
        l10n.featureNetworkTitle,
        l10n.featureNetworkDescription,
      ),
    };
  }

  IconData _iconFor(TemplateFeatureIcon icon) {
    return switch (icon) {
      TemplateFeatureIcon.architecture => Icons.account_tree_outlined,
      TemplateFeatureIcon.routing => Icons.route_outlined,
      TemplateFeatureIcon.dependencyInjection => Icons.hub_outlined,
      TemplateFeatureIcon.theme => Icons.brightness_6_outlined,
    };
  }
}
