import 'package:ag_pos/core/error/failure.dart';
import 'package:ag_pos/features/products/domain/entities/product_page_result.dart';
import 'package:ag_pos/features/products/domain/repositories/products_repository.dart';
import 'package:dartz/dartz.dart';

class GetProducts {
  const GetProducts(this._repository);

  final ProductsRepository _repository;

  Future<Either<Failure, ProductPageResult>> call({
    required int skip,
    required int limit,
  }) {
    return _repository.getProducts(skip: skip, limit: limit);
  }
}
