import 'package:ag_pos/core/config/app_config.dart';
import 'package:ag_pos/core/network/auth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';

abstract final class DioFactory {
  static const Duration _timeout = Duration(seconds: 30);

  static Dio create({
    required AccessTokenProvider tokenProvider,
    required CacheOptions cacheOptions,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.apiBaseUrl,
        connectTimeout: _timeout,
        sendTimeout: _timeout,
        receiveTimeout: _timeout,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: const <String, Object>{
          Headers.acceptHeader: Headers.jsonContentType,
        },
        validateStatus: (int? status) {
          return status != null && status >= 200 && status < 300;
        },
      ),
    );

    dio.interceptors.addAll(<Interceptor>[
      AuthInterceptor(tokenProvider),
      DioCacheInterceptor(options: cacheOptions),
      if (kDebugMode)
        LogInterceptor(
          requestBody: true,
          responseBody: false,
          logPrint: (Object value) => debugPrint(value.toString()),
        ),
    ]);

    return dio;
  }

  static CacheOptions createCacheOptions() {
    return CacheOptions(
      store: MemCacheStore(
        maxSize: 10 * 1024 * 1024,
        maxEntrySize: 1024 * 1024,
      ),
      policy: CachePolicy.request,
      hitCacheOnErrorCodes: const <int>[500, 502, 503, 504],
      hitCacheOnNetworkFailure: true,
      maxStale: const Duration(days: 7),
      priority: CachePriority.normal,
      allowPostMethod: false,
    );
  }
}
