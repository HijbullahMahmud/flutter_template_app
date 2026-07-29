enum FailureType {
  connectionTimeout,
  sendTimeout,
  receiveTimeout,
  transformTimeout,
  badCertificate,
  cancelled,
  noConnection,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  conflict,
  validation,
  rateLimited,
  server,
  cache,
  serialization,
  unknown,
}

sealed class Failure {
  const Failure({
    required this.type,
    required this.message,
    this.statusCode,
    this.data,
    this.cause,
    this.stackTrace,
  });

  final FailureType type;
  final String message;
  final int? statusCode;
  final Object? data;
  final Object? cause;
  final StackTrace? stackTrace;
}

final class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.type,
    required super.message,
    super.statusCode,
    super.data,
    super.cause,
    super.stackTrace,
  });
}

final class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.cause, super.stackTrace})
    : super(type: FailureType.cache);
}

final class SerializationFailure extends Failure {
  const SerializationFailure({
    required super.message,
    super.data,
    super.cause,
    super.stackTrace,
  }) : super(type: FailureType.serialization);
}

final class UnknownFailure extends Failure {
  const UnknownFailure({required super.message, super.cause, super.stackTrace})
    : super(type: FailureType.unknown);
}
