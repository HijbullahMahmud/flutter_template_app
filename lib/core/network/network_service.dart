import 'package:ag_pos/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

typedef DataDecoder<T> = T Function(Object? data);

enum RequestCachePolicy { useCache, refresh, noCache }

abstract interface class NetworkService {
  Future<Either<Failure, T>> get<T>(
    String path, {
    required DataDecoder<T> decoder,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    RequestCachePolicy cachePolicy = RequestCachePolicy.useCache,
  });

  Future<Either<Failure, T>> post<T>(
    String path, {
    required DataDecoder<T> decoder,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  Future<Either<Failure, T>> put<T>(
    String path, {
    required DataDecoder<T> decoder,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  Future<Either<Failure, T>> patch<T>(
    String path, {
    required DataDecoder<T> decoder,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  Future<Either<Failure, T>> delete<T>(
    String path, {
    required DataDecoder<T> decoder,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });
}
