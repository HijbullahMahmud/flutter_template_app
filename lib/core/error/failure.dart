sealed class Failure {
  const Failure(this.message, [this.cause]);

  final String message;
  final Object? cause;
}

final class CacheFailure extends Failure {
  const CacheFailure(super.message, [super.cause]);
}

final class NetworkFailure extends Failure {
  const NetworkFailure(super.message, [super.cause]);
}

final class UnknownFailure extends Failure {
  const UnknownFailure(super.message, [super.cause]);
}
