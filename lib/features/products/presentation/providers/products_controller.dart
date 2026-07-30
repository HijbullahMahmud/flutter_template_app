import 'dart:async';

import 'package:ag_pos/core/di/app_providers.dart';
import 'package:ag_pos/core/error/failure.dart';
import 'package:ag_pos/features/products/domain/entities/product.dart';
import 'package:ag_pos/features/products/domain/entities/product_page_result.dart';
import 'package:ag_pos/features/products/presentation/providers/products_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_controller.g.dart';

final productsRequestTimeoutProvider = Provider<Duration>(
  (Ref ref) => const Duration(seconds: 15),
);

Duration? _disableRetry(int retryCount, Object error) => null;

@Riverpod(keepAlive: true, retry: _disableRetry)
class ProductsController extends _$ProductsController {
  static const int _pageSize = 12;

  @override
  Future<ProductsState> build() => _loadFirstPage();

  Future<void> reload() async {
    state = const AsyncLoading<ProductsState>();
    state = await AsyncValue.guard(_loadFirstPage);
  }

  Future<void> loadNextPage() async {
    final current = state.value;
    if (current == null || current.isLoadingMore || !current.hasMore) {
      return;
    }

    state = AsyncData<ProductsState>(
      current.copyWith(isLoadingMore: true, loadMoreFailure: null),
    );

    final result = await _getProducts(skip: current.nextSkip, limit: _pageSize);

    result.fold(
      (Failure failure) {
        state = AsyncData<ProductsState>(
          current.copyWith(isLoadingMore: false, loadMoreFailure: failure),
        );
      },
      (ProductPageResult page) {
        final productsById = <int, Product>{
          for (final product in current.items) product.id: product,
          for (final product in page.items) product.id: product,
        };
        final nextSkip = page.skip + page.items.length;

        state = AsyncData<ProductsState>(
          current.copyWith(
            items: productsById.values.toList(growable: false),
            total: page.total,
            nextSkip: nextSkip,
            hasMore: page.items.isNotEmpty && nextSkip < page.total,
            isLoadingMore: false,
            loadMoreFailure: null,
          ),
        );
      },
    );
  }

  Future<ProductsState> _loadFirstPage() async {
    final result = await _getProducts(skip: 0, limit: _pageSize);

    return result.fold(
      (Failure failure) => throw ProductsFeatureException(failure),
      (ProductPageResult page) {
        final nextSkip = page.skip + page.items.length;
        return ProductsState(
          items: page.items,
          total: page.total,
          nextSkip: nextSkip,
          hasMore: page.items.isNotEmpty && nextSkip < page.total,
        );
      },
    );
  }

  Future<Either<Failure, ProductPageResult>> _getProducts({
    required int skip,
    required int limit,
  }) {
    return ref
        .read(getProductsProvider)(skip: skip, limit: limit)
        .timeout(
          ref.read(productsRequestTimeoutProvider),
          onTimeout: () => const Left<Failure, ProductPageResult>(
            NetworkFailure(
              type: FailureType.receiveTimeout,
              message: 'The products request timed out. Please try again.',
            ),
          ),
        );
  }
}

class ProductsFeatureException implements Exception {
  const ProductsFeatureException(this.failure);

  final Failure failure;

  @override
  String toString() => failure.message;
}
