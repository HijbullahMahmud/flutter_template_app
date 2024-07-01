import 'package:clean_arch_with_riverpod/common/domain/models/either.dart';

import 'package:clean_arch_with_riverpod/common/domain/models/user/user.dart';

import 'package:clean_arch_with_riverpod/common/exceptions/http_exception.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl extends AuthRepository{
  final LoginUserDataSource dataSource;

  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<Either<AppException, User>> login({required User user}) async{
    return dataSource.loginUser(user: user);
  }

}