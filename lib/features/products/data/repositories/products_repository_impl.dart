import 'package:ag_pos/core/error/failure.dart';
import 'package:ag_pos/features/products/data/datasources/products_remote_data_source.dart';
import 'package:ag_pos/features/products/domain/entities/product_page_result.dart';
import 'package:ag_pos/features/products/domain/repositories/products_repository.dart';
import 'package:dartz/dartz.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  const ProductsRepositoryImpl(this._remoteDataSource);

  final ProductsRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, ProductPageResult>> getProducts({
    required int skip,
    required int limit,
  }) async {
    final result = await _remoteDataSource.getProducts(
      skip: skip,
      limit: limit,
    );
    return result.map((page) => page.toEntity());
  }
}
