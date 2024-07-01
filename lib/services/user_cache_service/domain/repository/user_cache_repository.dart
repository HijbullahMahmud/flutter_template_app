import 'package:clean_arch_with_riverpod/common/exceptions/http_exception.dart';

import '../../../../common/domain/models/either.dart';
import '../../../../common/domain/models/user/user.dart';

abstract class UserRepository{
  Future<Either<AppException, User>> fetchUser();
  Future<bool> saveUser({required User user});
  Future<bool> deleteUser();
  Future<bool> hasUser();
}