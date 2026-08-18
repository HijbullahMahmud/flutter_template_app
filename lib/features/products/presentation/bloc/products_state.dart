import 'package:ag_pos/core/error/failure.dart';
import 'package:ag_pos/features/products/domain/entities/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_state.freezed.dart';

@freezed
abstract class ProductsState with _$ProductsState {
  const factory ProductsState({
    @Default(<Product>[]) List<Product> items,
    @Default(0) int total,
    @Default(0) int nextSkip,
    @Default(true) bool hasMore,
    @Default(false) bool isLoadingMore,
    Failure? loadMoreFailure,
  }) = _ProductsState;
}
