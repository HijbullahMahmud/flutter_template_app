import 'package:ag_pos/core/error/failure.dart';
import 'package:ag_pos/core/network/network_error_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('transport errors', () {
    const cases = <DioExceptionType, FailureType>{
      DioExceptionType.connectionTimeout: FailureType.connectionTimeout,
      DioExceptionType.sendTimeout: FailureType.sendTimeout,
      DioExceptionType.receiveTimeout: FailureType.receiveTimeout,
      DioExceptionType.transformTimeout: FailureType.transformTimeout,
      DioExceptionType.badCertificate: FailureType.badCertificate,
      DioExceptionType.cancel: FailureType.cancelled,
      DioExceptionType.connectionError: FailureType.noConnection,
      DioExceptionType.unknown: FailureType.unknown,
    };

    for (final entry in cases.entries) {
      test('maps ${entry.key.name}', () {
        final failure = NetworkErrorMapper.fromDioException(
          DioException(
            requestOptions: RequestOptions(path: '/test'),
            type: entry.key,
          ),
        );

        expect(failure.type, entry.value);
      });
    }
  });

  group('HTTP errors', () {
    const cases = <int, FailureType>{
      400: FailureType.badRequest,
      401: FailureType.unauthorized,
      403: FailureType.forbidden,
      404: FailureType.notFound,
      408: FailureType.receiveTimeout,
      409: FailureType.conflict,
      413: FailureType.badRequest,
      415: FailureType.badRequest,
      418: FailureType.badRequest,
      422: FailureType.validation,
      429: FailureType.rateLimited,
      500: FailureType.server,
      503: FailureType.server,
    };

    for (final entry in cases.entries) {
      test('maps status ${entry.key}', () {
        final request = RequestOptions(path: '/test');
        final failure = NetworkErrorMapper.fromDioException(
          DioException.badResponse(
            statusCode: entry.key,
            requestOptions: request,
            response: Response<Object?>(
              requestOptions: request,
              statusCode: entry.key,
            ),
          ),
        );

        expect(failure.type, entry.value);
        expect(failure.statusCode, entry.key);
      });
    }

    test('prefers a server-provided message', () {
      final request = RequestOptions(path: '/test');
      final failure = NetworkErrorMapper.fromDioException(
        DioException.badResponse(
          statusCode: 422,
          requestOptions: request,
          response: Response<Object?>(
            requestOptions: request,
            statusCode: 422,
            data: <String, Object?>{'message': 'Email is invalid.'},
          ),
        ),
      );

      expect(failure.message, 'Email is invalid.');
    });

    test('flattens field validation messages', () {
      final request = RequestOptions(path: '/test');
      final failure = NetworkErrorMapper.fromDioException(
        DioException.badResponse(
          statusCode: 422,
          requestOptions: request,
          response: Response<Object?>(
            requestOptions: request,
            statusCode: 422,
            data: <String, Object?>{
              'errors': <String, Object?>{
                'email': <String>['Email is required.'],
                'name': 'Name is required.',
              },
            },
          ),
        ),
      );

      expect(failure.message, contains('Email is required.'));
      expect(failure.message, contains('Name is required.'));
    });
  });
}
