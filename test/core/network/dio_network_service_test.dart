import 'package:ag_pos/core/error/failure.dart';
import 'package:ag_pos/core/network/dio_network_service.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Dio dio;
  late DioNetworkService service;
  late List<String> methods;

  setUp(() {
    methods = <String>[];
    dio = Dio(BaseOptions(baseUrl: 'https://example.com'));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          methods.add(options.method);
          handler.resolve(
            Response<Object?>(
              requestOptions: options,
              statusCode: 200,
              data: <String, Object?>{'value': 42},
            ),
          );
        },
      ),
    );
    service = DioNetworkService(dio, CacheOptions(store: MemCacheStore()));
  });

  tearDown(() {
    dio.close(force: true);
  });

  test('decodes a successful response', () async {
    final result = await service.get<int>('/value', decoder: _valueDecoder);

    expect(result.isRight(), isTrue);
    expect(result.getOrElse(() => -1), 42);
    expect(methods, <String>['GET']);
  });

  test('supports POST, PUT, PATCH, and DELETE', () async {
    await service.post<int>('/value', decoder: _valueDecoder);
    await service.put<int>('/value', decoder: _valueDecoder);
    await service.patch<int>('/value', decoder: _valueDecoder);
    await service.delete<int>('/value', decoder: _valueDecoder);

    expect(methods, <String>['POST', 'PUT', 'PATCH', 'DELETE']);
  });

  test('maps decoder exceptions to serialization failures', () async {
    final result = await service.get<int>(
      '/value',
      decoder: (Object? data) => data as int,
    );

    result.fold((Failure failure) {
      expect(failure.type, FailureType.serialization);
      expect(failure, isA<SerializationFailure>());
    }, (_) => fail('Expected a serialization failure.'));
  });
}

int _valueDecoder(Object? data) {
  final json = data! as Map<String, Object?>;
  return json['value']! as int;
}
