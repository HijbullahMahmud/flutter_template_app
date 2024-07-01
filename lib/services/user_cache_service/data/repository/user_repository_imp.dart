import 'package:clean_arch_with_riverpod/common/domain/models/either.dart';
import 'package:clean_arch_with_riverpod/common/domain/models/user/user.dart';
import 'package:clean_arch_with_riverpod/common/exceptions/http_exception.dart';
import 'package:clean_arch_with_riverpod/services/user_cache_service/data/datasource/user_local_datasource.dart';
import 'package:clean_arch_with_riverpod/services/user_cache_service/domain/repository/user_cache_repository.dart';

class UserRepositoryImpl extends UserRepository{
  final UserDataSource dataSource;

  UserRepositoryImpl({required this.dataSource});

  @override
  Future<bool> deleteUser() {
    return dataSource.deleteUser();

  }

  @override
  Future<Either<AppException, User>> fetchUser() {
  return dataSource.fetchUser();
  }

  @override
  Future<bool> hasUser() {
    return dataSource.hasUser();
  }

  @override
  Future<bool> saveUser({required User user}) {
    return dataSource.saveUser(user: user);
  }

}