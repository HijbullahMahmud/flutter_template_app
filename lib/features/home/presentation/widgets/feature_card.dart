import 'package:ag_pos/core/constants/app_sizes.dart';
import 'package:ag_pos/features/home/domain/entities/template_feature.dart';
import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({required this.feature, super.key});

  final TemplateFeature feature;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.space24),
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
            Text(feature.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppSizes.space8),
            Text(
              feature.description,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
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
