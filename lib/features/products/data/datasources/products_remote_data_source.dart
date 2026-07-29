import 'package:ag_pos/core/error/failure.dart';
import 'package:ag_pos/core/network/network_service.dart';
import 'package:ag_pos/features/products/data/models/product_page_model.dart';
import 'package:dartz/dartz.dart';

abstract interface class ProductsRemoteDataSource {
  Future<Either<Failure, ProductPageModel>> getProducts({
    required int skip,
    required int limit,
  });
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  const ProductsRemoteDataSourceImpl(this._networkService);

  final NetworkService _networkService;

  @override
  Future<Either<Failure, ProductPageModel>> getProducts({
    required int skip,
    required int limit,
  }) {
    return _networkService.get<ProductPageModel>(
      '/products',
      queryParameters: <String, dynamic>{
        'skip': skip,
        'limit': limit,
        'select': 'id,title,description,category,price,rating,thumbnail',
      },
      decoder: (Object? data) {
        return ProductPageModel.fromJson(data! as Map<String, dynamic>);
      },
    );
  }
}
