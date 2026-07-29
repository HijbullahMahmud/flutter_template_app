import 'package:dio/dio.dart';

abstract interface class AccessTokenProvider {
  Future<String?> readAccessToken();
}

class EmptyAccessTokenProvider implements AccessTokenProvider {
  const EmptyAccessTokenProvider();

  @override
  Future<String?> readAccessToken() async => null;
}

class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor(this._tokenProvider);

  final AccessTokenProvider _tokenProvider;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenProvider.readAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
