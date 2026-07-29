import 'package:ag_pos/core/error/failure.dart';
import 'package:dio/dio.dart';

abstract final class NetworkErrorMapper {
  static Failure fromDioException(DioException exception) {
    return switch (exception.type) {
      DioExceptionType.connectionTimeout => _networkFailure(
        exception,
        FailureType.connectionTimeout,
        'Connection timed out. Please try again.',
      ),
      DioExceptionType.sendTimeout => _networkFailure(
        exception,
        FailureType.sendTimeout,
        'The request took too long to send.',
      ),
      DioExceptionType.receiveTimeout => _networkFailure(
        exception,
        FailureType.receiveTimeout,
        'The server took too long to respond.',
      ),
      DioExceptionType.transformTimeout => _networkFailure(
        exception,
        FailureType.transformTimeout,
        'The response took too long to process.',
      ),
      DioExceptionType.badCertificate => _networkFailure(
        exception,
        FailureType.badCertificate,
        'A secure connection could not be established.',
      ),
      DioExceptionType.cancel => _networkFailure(
        exception,
        FailureType.cancelled,
        'The request was cancelled.',
      ),
      DioExceptionType.connectionError => _networkFailure(
        exception,
        FailureType.noConnection,
        'No internet connection. Check your network and try again.',
      ),
      DioExceptionType.badResponse => _fromResponse(exception),
      DioExceptionType.unknown => _networkFailure(
        exception,
        FailureType.unknown,
        exception.message ?? 'An unexpected network error occurred.',
      ),
    };
  }

  static Failure _fromResponse(DioException exception) {
    final response = exception.response;
    final statusCode = response?.statusCode;
    final data = response?.data;
    final serverMessage = _extractMessage(data);

    final (type, fallbackMessage) = switch (statusCode) {
      400 => (FailureType.badRequest, 'The request is invalid.'),
      401 => (FailureType.unauthorized, 'Your session has expired.'),
      403 => (
        FailureType.forbidden,
        'You do not have permission for this action.',
      ),
      404 => (FailureType.notFound, 'The requested resource was not found.'),
      408 => (FailureType.receiveTimeout, 'The request timed out.'),
      409 => (FailureType.conflict, 'The request conflicts with current data.'),
      413 => (FailureType.badRequest, 'The submitted data is too large.'),
      415 => (
        FailureType.badRequest,
        'The submitted data format is not supported.',
      ),
      422 => (FailureType.validation, 'Some submitted information is invalid.'),
      429 => (
        FailureType.rateLimited,
        'Too many requests. Please try again later.',
      ),
      final code? when code >= 500 => (
        FailureType.server,
        'The server is unavailable. Please try again later.',
      ),
      final code? when code >= 400 => (
        FailureType.badRequest,
        'The request could not be completed.',
      ),
      _ => (FailureType.unknown, 'An unexpected server response occurred.'),
    };

    return NetworkFailure(
      type: type,
      message: serverMessage ?? fallbackMessage,
      statusCode: statusCode,
      data: data,
      cause: exception,
      stackTrace: exception.stackTrace,
    );
  }

  static NetworkFailure _networkFailure(
    DioException exception,
    FailureType type,
    String message,
  ) {
    return NetworkFailure(
      type: type,
      message: message,
      statusCode: exception.response?.statusCode,
      data: exception.response?.data,
      cause: exception,
      stackTrace: exception.stackTrace,
    );
  }

  static String? _extractMessage(Object? data) {
    if (data is String && data.trim().isNotEmpty) {
      return data.trim();
    }

    if (data is! Map<Object?, Object?>) {
      return null;
    }

    for (final key in const <String>['message', 'error', 'detail', 'title']) {
      final value = data[key];
      if (value is String && value.trim().isNotEmpty) {
        return value.trim();
      }
    }

    final errors = data['errors'];
    if (errors is List<Object?>) {
      final messages = errors.whereType<String>().where(
        (String value) => value.trim().isNotEmpty,
      );
      if (messages.isNotEmpty) {
        return messages.join('\n');
      }
    }

    if (errors is Map<Object?, Object?>) {
      final messages = errors.values
          .expand<String>((Object? value) {
            if (value is String) {
              return <String>[value];
            }
            if (value is List<Object?>) {
              return value.whereType<String>();
            }
            return const <String>[];
          })
          .where((String value) => value.trim().isNotEmpty);
      if (messages.isNotEmpty) {
        return messages.join('\n');
      }
    }

    return null;
  }
}
