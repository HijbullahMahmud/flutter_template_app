import 'package:ag_pos/core/constants/app_sizes.dart';
import 'package:ag_pos/core/extensions/build_context_extensions.dart';
import 'package:ag_pos/core/responsive/responsive_builder.dart';
import 'package:ag_pos/features/products/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final price = NumberFormat.simpleCurrency(
      locale: localeName,
      name: 'USD',
    ).format(product.price);

    return ResponsiveBuilder(
      builder: (BuildContext context, metrics) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16 / 10,
                child: ColoredBox(
                  color: colors.surfaceContainerHighest,
                  child: Image.network(
                    product.thumbnailUrl,
                    fit: BoxFit.cover,
                    semanticLabel: context.locale.productImageLabel(
                      product.title,
                    ),
                    loadingBuilder:
                        (
                          BuildContext context,
                          Widget child,
                          ImageChunkEvent? progress,
                        ) {
                          if (progress == null) {
                            return child;
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                    errorBuilder:
                        (
                          BuildContext context,
                          Object error,
                          StackTrace? stackTrace,
                        ) {
                          return Icon(
                            Icons.image_not_supported_outlined,
                            size: 48,
                            color: colors.onSurfaceVariant,
                          );
                        },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(metrics.cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.labelMedium?.copyWith(color: colors.primary),
                    ),
                    const SizedBox(height: AppSizes.space8),
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSizes.space8),
                    Text(
                      product.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSizes.space16),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            price,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(color: colors.primary),
                          ),
                        ),
                        const Icon(Icons.star_rounded, size: 20),
                        const SizedBox(width: AppSizes.space4),
                        Text(
                          product.rating.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
