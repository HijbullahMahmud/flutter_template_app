import 'package:clean_arch_with_riverpod/common/data/remote/remote.dart';
import 'package:clean_arch_with_riverpod/common/domain/models/either.dart';
import 'package:clean_arch_with_riverpod/common/exceptions/http_exception.dart';
import 'package:clean_arch_with_riverpod/common/mixins/exception_handler_mixin.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:clean_arch_with_riverpod/common/domain/models/response.dart'
    as response;

import '../../globals.dart';

class DioNetworkService extends NetworkService with ExceptionHandlerMixin {
  final Dio dio;
  DioNetworkService(this.dio) {
    if (!kTestMode) {
      dio.options = dioBaseOptions;
      if (kDebugMode) {
        dio.interceptors
            .add(LogInterceptor(requestBody: true, responseBody: true));
      }
    }
  }

  BaseOptions get dioBaseOptions => BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
      );

  @override
  String get baseUrl => dotenv.env['BASE_URL'] ?? '';

  @override
  Future<Either<AppException, response.Response>> get(String endPoint,
      {Map<String, dynamic>? queryParameters}) {
    final res = handleException(
      () => dio.get(endPoint, queryParameters: queryParameters),
      endpoint: endPoint,
    );
    return res;
  }

  @override
  Map<String, Object> get headers => {
        'accept': 'application/json',
        'content-type': 'application/json',
      };

  @override
  Future<Either<AppException, response.Response>> post(String endpoint,
      {Map<String, dynamic>? data}) {
    final res = handleException(
      () => dio.post(
        endpoint,
        data: data,
      ),
      endpoint: endpoint,
    );
    return res;
  }

  @override
  Map<String, dynamic>? updateHeader(Map<String, dynamic> data) {
    final header = {...data, ...headers};
    if (!kTestMode) {
      dio.options.headers = header;
    }
    return header;
  }
}
