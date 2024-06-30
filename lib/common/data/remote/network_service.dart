import 'package:clean_arch_with_riverpod/common/domain/models/response.dart';

import '../../domain/models/either.dart';
import '../../exceptions/http_exception.dart';

abstract class NetworkService{
  String get baseUrl;
  Map<String, Object> get headers;

  void updateHeader(Map<String, Object> data);

  Future<Either<AppException, Response>> get(String endPoint, {Map<String, dynamic>? queryParameters});

  Future<Either<AppException, Response>> post(String endPoint, {Map<String, dynamic>? data});
  
}