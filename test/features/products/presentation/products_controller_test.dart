import 'dart:async';

import 'package:ag_pos/core/di/app_providers.dart';
import 'package:ag_pos/core/error/failure.dart';
import 'package:ag_pos/features/products/domain/entities/product.dart';
import 'package:ag_pos/features/products/domain/entities/product_page_result.dart';
import 'package:ag_pos/features/products/domain/repositories/products_repository.dart';
import 'package:ag_pos/features/products/domain/usecases/get_products.dart';
import 'package:ag_pos/features/products/presentation/providers/products_controller.dart';
import 'package:ag_pos/features/products/presentation/providers/products_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loads the first page and appends the next page', () async {
    final repository = _PagingProductsRepository();
    final container = ProviderContainer(
      overrides: [
        getProductsProvider.overrideWithValue(GetProducts(repository)),
      ],
    );
    addTearDown(container.dispose);

    final firstState = await container.read(productsControllerProvider.future);

    expect(firstState.items.map((Product item) => item.id), <int>[1, 2]);
    expect(firstState.nextSkip, 2);
    expect(firstState.hasMore, isTrue);

    await container.read(productsControllerProvider.notifier).loadNextPage();
    final secondState = container.read(productsControllerProvider).requireValue;

    expect(secondState.items.map((Product item) => item.id), <int>[1, 2, 3, 4]);
    expect(secondState.hasMore, isFalse);
    expect(secondState.isLoadingMore, isFalse);
    expect(repository.requestedSkips, <int>[0, 2]);
  });

  test('keeps existing products when loading another page fails', () async {
    final repository = _FailingNextPageRepository();
    final container = ProviderContainer(
      overrides: [
        getProductsProvider.overrideWithValue(GetProducts(repository)),
      ],
    );
    addTearDown(container.dispose);

    await container.read(productsControllerProvider.future);
    await container.read(productsControllerProvider.notifier).loadNextPage();
    final state = container.read(productsControllerProvider).requireValue;

    expect(state.items, hasLength(2));
    expect(state.loadMoreFailure, isA<NetworkFailure>());
    expect(state.isLoadingMore, isFalse);
  });

  test('initial loading becomes an error when the request stalls', () async {
    final repository = _StalledProductsRepository();
    final container = ProviderContainer(
      overrides: [
        getProductsProvider.overrideWithValue(GetProducts(repository)),
        productsRequestTimeoutProvider.overrideWithValue(Duration.zero),
      ],
    );
    addTearDown(container.dispose);

    await expectLater(
      container.read(productsControllerProvider.future),
      throwsA(isA<ProductsFeatureException>()),
    );

    final state = container.read(productsControllerProvider);
    expect(state, isA<AsyncError<ProductsState>>());
  });

  test('loading another page stops when the request stalls', () async {
    final repository = _StalledNextPageRepository();
    final container = ProviderContainer(
      overrides: [
        getProductsProvider.overrideWithValue(GetProducts(repository)),
        productsRequestTimeoutProvider.overrideWithValue(Duration.zero),
      ],
    );
    addTearDown(container.dispose);

    await container.read(productsControllerProvider.future);
    await container.read(productsControllerProvider.notifier).loadNextPage();

    final state = container.read(productsControllerProvider).requireValue;
    expect(state.items, hasLength(2));
    expect(state.loadMoreFailure?.type, FailureType.receiveTimeout);
    expect(state.isLoadingMore, isFalse);
  });
}

class _PagingProductsRepository implements ProductsRepository {
  final List<int> requestedSkips = <int>[];

  @override
  Future<Either<Failure, ProductPageResult>> getProducts({
    required int skip,
    required int limit,
  }) async {
    requestedSkips.add(skip);
    final items = skip == 0
        ? <Product>[_product(1), _product(2)]
        : <Product>[_product(3), _product(4)];
    return Right<Failure, ProductPageResult>(
      ProductPageResult(items: items, total: 4, skip: skip, limit: limit),
    );
  }
}

class _FailingNextPageRepository implements ProductsRepository {
  @override
  Future<Either<Failure, ProductPageResult>> getProducts({
    required int skip,
    required int limit,
  }) async {
    if (skip > 0) {
      return const Left<Failure, ProductPageResult>(
        NetworkFailure(
          type: FailureType.noConnection,
          message: 'No connection',
        ),
      );
    }

    return Right<Failure, ProductPageResult>(
      ProductPageResult(
        items: <Product>[_product(1), _product(2)],
        total: 4,
        skip: 0,
        limit: limit,
      ),
    );
  }
}

class _StalledProductsRepository implements ProductsRepository {
  @override
  Future<Either<Failure, ProductPageResult>> getProducts({
    required int skip,
    required int limit,
  }) {
    return Completer<Either<Failure, ProductPageResult>>().future;
  }
}

class _StalledNextPageRepository implements ProductsRepository {
  @override
  Future<Either<Failure, ProductPageResult>> getProducts({
    required int skip,
    required int limit,
  }) {
    if (skip > 0) {
      return Completer<Either<Failure, ProductPageResult>>().future;
    }

    return Future<Either<Failure, ProductPageResult>>.value(
      Right<Failure, ProductPageResult>(
        ProductPageResult(
          items: <Product>[_product(1), _product(2)],
          total: 4,
          skip: 0,
          limit: limit,
        ),
      ),
    );
  }
}

Product _product(int id) {
  return Product(
    id: id,
    title: 'Product $id',
    description: 'Description $id',
    category: 'test',
    price: id.toDouble(),
    rating: 4.5,
    thumbnailUrl: 'https://example.com/$id.png',
  );
}
