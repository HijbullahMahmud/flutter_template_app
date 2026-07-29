import 'package:ag_pos/core/error/failure.dart';
import 'package:ag_pos/features/products/domain/entities/product_page_result.dart';
import 'package:dartz/dartz.dart';

abstract interface class ProductsRepository {
  Future<Either<Failure, ProductPageResult>> getProducts({
    required int skip,
    required int limit,
  });
}
