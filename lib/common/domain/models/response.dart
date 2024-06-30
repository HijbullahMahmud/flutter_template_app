import 'package:clean_arch_with_riverpod/common/domain/models/either.dart';
import 'package:clean_arch_with_riverpod/common/exceptions/http_exception.dart';

class Response {
  final int statusCode;
  final String? statusMessage;
  final dynamic data;

  Response(
      {required this.statusCode, this.statusMessage, this.data = const {}});
  @override
  String toString() {
    return 'statusCode=$statusCode\nstatusMessage=$statusMessage\n data=$data';
  }
}

extension ResponseExtension on Response{
  Right<AppException, Response> get toRight => Right(this);
}