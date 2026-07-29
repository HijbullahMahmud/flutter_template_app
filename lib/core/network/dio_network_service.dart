import 'package:ag_pos/core/error/failure.dart';
import 'package:ag_pos/core/network/network_error_mapper.dart';
import 'package:ag_pos/core/network/network_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class DioNetworkService implements NetworkService {
  const DioNetworkService(this._dio, this._cacheOptions);

  final Dio _dio;
  final CacheOptions _cacheOptions;

  @override
  Future<Either<Failure, T>> get<T>(
    String path, {
    required DataDecoder<T> decoder,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    RequestCachePolicy cachePolicy = RequestCachePolicy.useCache,
  }) {
    final policy = switch (cachePolicy) {
      RequestCachePolicy.useCache => CachePolicy.request,
      RequestCachePolicy.refresh => CachePolicy.refresh,
      RequestCachePolicy.noCache => CachePolicy.noCache,
    };
    final cacheExtra = _cacheOptions.copyWith(policy: policy).toExtra();
    final requestOptions = (options ?? Options()).copyWith(
      method: 'GET',
      extra: <String, Object?>{...?options?.extra, ...cacheExtra},
    );

    return _request<T>(
      path,
      decoder: decoder,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Either<Failure, T>> post<T>(
    String path, {
    required DataDecoder<T> decoder,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _request<T>(
      path,
      decoder: decoder,
      data: data,
      queryParameters: queryParameters,
      options: (options ?? Options()).copyWith(method: 'POST'),
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Either<Failure, T>> put<T>(
    String path, {
    required DataDecoder<T> decoder,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _request<T>(
      path,
      decoder: decoder,
      data: data,
      queryParameters: queryParameters,
      options: (options ?? Options()).copyWith(method: 'PUT'),
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Either<Failure, T>> patch<T>(
    String path, {
    required DataDecoder<T> decoder,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _request<T>(
      path,
      decoder: decoder,
      data: data,
      queryParameters: queryParameters,
      options: (options ?? Options()).copyWith(method: 'PATCH'),
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Either<Failure, T>> delete<T>(
    String path, {
    required DataDecoder<T> decoder,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _request<T>(
      path,
      decoder: decoder,
      data: data,
      queryParameters: queryParameters,
      options: (options ?? Options()).copyWith(method: 'DELETE'),
      cancelToken: cancelToken,
    );
  }

  Future<Either<Failure, T>> _request<T>(
    String path, {
    required DataDecoder<T> decoder,
    Object? data,
    Map<String, dynamic>? queryParameters,
    required Options options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.request<Object?>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      try {
        return Right<Failure, T>(decoder(response.data));
      } on Object catch (error, stackTrace) {
        return Left<Failure, T>(
          SerializationFailure(
            message: 'The server response could not be processed.',
            data: response.data,
            cause: error,
            stackTrace: stackTrace,
          ),
        );
      }
    } on DioException catch (error) {
      return Left<Failure, T>(NetworkErrorMapper.fromDioException(error));
    } on Object catch (error, stackTrace) {
      return Left<Failure, T>(
        UnknownFailure(
          message: 'An unexpected request error occurred.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
