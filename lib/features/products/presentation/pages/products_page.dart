import 'dart:async';

import 'package:ag_pos/core/constants/app_sizes.dart';
import 'package:ag_pos/core/extensions/build_context_extensions.dart';
import 'package:ag_pos/core/responsive/paginated_responsive_grid_view.dart';
import 'package:ag_pos/core/responsive/responsive_builder.dart';
import 'package:ag_pos/core/responsive/responsive_value.dart';
import 'package:ag_pos/core/widgets/app_error_view.dart';
import 'package:ag_pos/core/widgets/app_page.dart';
import 'package:ag_pos/features/products/presentation/providers/products_controller.dart';
import 'package:ag_pos/features/products/presentation/providers/products_state.dart';
import 'package:ag_pos/features/products/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _productCardMinimumWidth = ResponsiveValue<double>(
  smallPhone: AppSizes.cardMinWidth,
  phone: 148,
  tablet: 148,
  expanded: 148,
);

class ProductsPage extends ConsumerWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsControllerProvider);

    return AppPage(
      title: context.locale.productsTitle,
      body: switch (products) {
        AsyncData<ProductsState>(:final value) => _ProductsContent(
          state: value,
          onLoadMore: () =>
              ref.read(productsControllerProvider.notifier).loadNextPage(),
          onRefresh: () =>
              ref.read(productsControllerProvider.notifier).reload(),
          onRetryLoadMore: () {
            unawaited(
              ref.read(productsControllerProvider.notifier).loadNextPage(),
            );
          },
        ),
        AsyncError<ProductsState>() => AppErrorView(
          message: context.locale.productsLoadError,
          onRetry: () {
            unawaited(ref.read(productsControllerProvider.notifier).reload());
          },
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _ProductsContent extends StatelessWidget {
  const _ProductsContent({
    required this.state,
    required this.onLoadMore,
    required this.onRefresh,
    required this.onRetryLoadMore,
  });

  final ProductsState state;
  final Future<void> Function() onLoadMore;
  final Future<void> Function() onRefresh;
  final VoidCallback onRetryLoadMore;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, metrics) {
        final pagePadding = EdgeInsets.symmetric(
          horizontal: metrics.horizontalPadding,
          vertical: metrics.verticalPadding,
        );

        return RefreshIndicator(
          onRefresh: onRefresh,
          child: PaginatedResponsiveGridView(
            itemCount: state.items.length,
            itemBuilder: (BuildContext context, int index) {
              final product = state.items[index];
              return ProductCard(
                key: ValueKey<int>(product.id),
                product: product,
              );
            },
            hasMore: state.hasMore,
            isLoadingMore: state.isLoadingMore,
            onLoadMore: onLoadMore,
            minimumItemWidth: _productCardMinimumWidth.resolve(
              metrics.windowSize,
            ),
            maximumColumns: 3,
            spacing: metrics.gridGap,
            padding: pagePadding,
            physics: const AlwaysScrollableScrollPhysics(),
            sliversBefore: <Widget>[
              SliverPadding(
                padding: EdgeInsetsDirectional.only(
                  start: metrics.horizontalPadding,
                  top: metrics.verticalPadding,
                  end: metrics.horizontalPadding,
                ),
                sliver: SliverToBoxAdapter(
                  child: _ProductsHeader(total: state.total),
                ),
              ),
            ],
            emptyState: Center(
              child: Padding(
                padding: pagePadding,
                child: Text(
                  context.locale.productsEmpty,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            loadMoreError: state.loadMoreFailure == null
                ? null
                : _LoadMoreError(onRetry: onRetryLoadMore),
            endOfListIndicator: Padding(
              padding: const EdgeInsets.all(AppSizes.space16),
              child: Center(child: Text(context.locale.productsEndOfList)),
            ),
          ),
        );
      },
    );
  }
}

class _ProductsHeader extends StatelessWidget {
  const _ProductsHeader({required this.total});

  final int total;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: AppSizes.readableTextMaxWidth,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            context.locale.productsDescription,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSizes.space8),
          Text(
            context.locale.productsCount(total),
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}

class _LoadMoreError extends StatelessWidget {
  const _LoadMoreError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.space16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            context.locale.productsLoadMoreError,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.space8),
          FilledButton.tonal(
            onPressed: onRetry,
            child: Text(context.locale.tryAgain),
          ),
        ],
      ),
    );
  }
}
