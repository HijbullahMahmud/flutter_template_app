import 'package:ag_pos/core/network/dio_network_service.dart';
import 'package:ag_pos/features/products/data/datasources/products_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('requests products with limit, skip, and selected fields', () async {
    late RequestOptions capturedRequest;
    final dio = Dio(BaseOptions(baseUrl: 'https://dummyjson.com'));
    addTearDown(() => dio.close(force: true));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          capturedRequest = options;
          handler.resolve(
            Response<Object?>(
              requestOptions: options,
              statusCode: 200,
              data: _responseJson,
            ),
          );
        },
      ),
    );
    final dataSource = ProductsRemoteDataSourceImpl(
      DioNetworkService(dio, CacheOptions(store: MemCacheStore())),
    );

    final result = await dataSource.getProducts(skip: 12, limit: 12);

    expect(result.isRight(), isTrue);
    expect(capturedRequest.path, '/products');
    expect(capturedRequest.queryParameters['skip'], 12);
    expect(capturedRequest.queryParameters['limit'], 12);
    expect(
      capturedRequest.queryParameters['select'],
      'id,title,description,category,price,rating,thumbnail',
    );
  });
}

final Map<String, dynamic> _responseJson = <String, dynamic>{
  'products': <Map<String, dynamic>>[
    <String, dynamic>{
      'id': 1,
      'title': 'Product',
      'description': 'Description',
      'category': 'test',
      'price': 10,
      'rating': 4,
      'thumbnail': 'https://example.com/image.png',
    },
  ],
  'total': 1,
  'skip': 0,
  'limit': 12,
};
