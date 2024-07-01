import 'package:clean_arch_with_riverpod/common/domain/models/either.dart';
import 'package:clean_arch_with_riverpod/common/domain/models/user/user.dart';
import 'package:clean_arch_with_riverpod/common/exceptions/http_exception.dart';

abstract class AuthRepository{
  Future<Either<AppException, User>> login({required User user});
}