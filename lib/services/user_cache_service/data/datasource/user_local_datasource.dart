import 'dart:convert';

import 'package:clean_arch_with_riverpod/common/data/local/storage_service.dart';
import 'package:clean_arch_with_riverpod/common/domain/models/user/user.dart';
import 'package:clean_arch_with_riverpod/common/exceptions/http_exception.dart';
import 'package:clean_arch_with_riverpod/common/globals.dart';

import '../../../../common/domain/models/either.dart';

abstract class UserDataSource {
  String get storageKey;

  Future<Either<AppException, User>> fetchUser();
  Future<bool> saveUser({required User user});
  Future<bool> deleteUser();
  Future<bool> hasUser();
}

class UserLocalDataSource extends UserDataSource {
  final StorageService storageService;

  UserLocalDataSource({required this.storageService});

  @override
  Future<bool> deleteUser() async{
   return await storageService.remove(storageKey);
  }

  @override
  Future<Either<AppException, User>> fetchUser() async {
    final user = await storageService.get(storageKey);
    if (user == null) {
      return Left(AppException(
          identifier: "UserLocalDataSource",
          statusCode: 404,
          message: "User Not Found"));
    }
    final userJson = jsonDecode(user.toString());
    return Right(User.fromJson(userJson));
  }

  @override
  Future<bool> hasUser() async {
    return await storageService.has(storageKey);
  }

  @override
  Future<bool> saveUser({required User user}) async {
    return await storageService.set(storageKey, jsonEncode(user.toJson()));
  }

  @override
  String get storageKey => USER_LOCAL_STORAGE_KEY;
}
