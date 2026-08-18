import 'dart:async';

import 'package:ag_pos/core/error/failure.dart';
import 'package:ag_pos/features/products/domain/entities/product.dart';
import 'package:ag_pos/features/products/domain/entities/product_page_result.dart';
import 'package:ag_pos/features/products/domain/usecases/get_products.dart';
import 'package:ag_pos/features/products/presentation/bloc/products_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class ProductsEvent {
  const ProductsEvent();
}

final class ProductsRequested extends ProductsEvent {
  const ProductsRequested();
}

final class ProductsReloaded extends ProductsEvent {
  const ProductsReloaded();
}

final class ProductsNextPageRequested extends ProductsEvent {
  const ProductsNextPageRequested();
}

sealed class ProductsViewState {
  const ProductsViewState();
}

final class ProductsLoading extends ProductsViewState {
  const ProductsLoading();
}

final class ProductsLoadSuccess extends ProductsViewState {
  const ProductsLoadSuccess(this.products);

  final ProductsState products;
}

final class ProductsLoadFailure extends ProductsViewState {
  const ProductsLoadFailure(this.failure);

  final Failure failure;
}

class ProductsBloc extends Bloc<ProductsEvent, ProductsViewState> {
  ProductsBloc(
    this._getProducts, {
    this.requestTimeout = const Duration(seconds: 15),
  }) : super(const ProductsLoading()) {
    on<ProductsRequested>(_onRequested);
    on<ProductsReloaded>(_onReloaded);
    on<ProductsNextPageRequested>(_onNextPageRequested);
  }

  static const int _pageSize = 12;
  final GetProducts _getProducts;
  final Duration requestTimeout;

  Future<void> _onRequested(
    ProductsRequested event,
    Emitter<ProductsViewState> emit,
  ) async {
    await _loadFirstPage(emit);
  }

  Future<void> _onReloaded(
    ProductsReloaded event,
    Emitter<ProductsViewState> emit,
  ) async {
    await _loadFirstPage(emit);
  }

  Future<void> _onNextPageRequested(
    ProductsNextPageRequested event,
    Emitter<ProductsViewState> emit,
  ) async {
    final currentViewState = state;
    if (currentViewState is! ProductsLoadSuccess) {
      return;
    }
    final current = currentViewState.products;
    if (current.isLoadingMore || !current.hasMore) {
      return;
    }

    emit(
      ProductsLoadSuccess(
        current.copyWith(isLoadingMore: true, loadMoreFailure: null),
      ),
    );

    final result = await _requestProducts(
      skip: current.nextSkip,
      limit: _pageSize,
    );

    result.fold(
      (Failure failure) {
        emit(
          ProductsLoadSuccess(
            current.copyWith(isLoadingMore: false, loadMoreFailure: failure),
          ),
        );
      },
      (ProductPageResult page) {
        final productsById = <int, Product>{
          for (final product in current.items) product.id: product,
          for (final product in page.items) product.id: product,
        };
        final nextSkip = page.skip + page.items.length;

        emit(
          ProductsLoadSuccess(
            current.copyWith(
              items: productsById.values.toList(growable: false),
              total: page.total,
              nextSkip: nextSkip,
              hasMore: page.items.isNotEmpty && nextSkip < page.total,
              isLoadingMore: false,
              loadMoreFailure: null,
            ),
          ),
        );
      },
    );
  }

  Future<void> _loadFirstPage(Emitter<ProductsViewState> emit) async {
    emit(const ProductsLoading());
    final result = await _requestProducts(skip: 0, limit: _pageSize);

    result.fold((Failure failure) => emit(ProductsLoadFailure(failure)), (
      ProductPageResult page,
    ) {
      final nextSkip = page.skip + page.items.length;
      emit(
        ProductsLoadSuccess(
          ProductsState(
            items: page.items,
            total: page.total,
            nextSkip: nextSkip,
            hasMore: page.items.isNotEmpty && nextSkip < page.total,
          ),
        ),
      );
    });
  }

  Future<Either<Failure, ProductPageResult>> _requestProducts({
    required int skip,
    required int limit,
  }) {
    return _getProducts(skip: skip, limit: limit).timeout(
      requestTimeout,
      onTimeout: () => const Left<Failure, ProductPageResult>(
        NetworkFailure(
          type: FailureType.receiveTimeout,
          message: 'The products request timed out. Please try again.',
        ),
      ),
    );
  }
}
