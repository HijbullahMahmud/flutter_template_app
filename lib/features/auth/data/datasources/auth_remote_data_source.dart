import 'package:clean_arch_with_riverpod/common/endpoint.dart';
import 'package:clean_arch_with_riverpod/common/data/remote/network_service.dart';


import '../../../../common/domain/models/either.dart';
import '../../../../common/domain/models/user/user.dart';
import '../../../../common/exceptions/http_exception.dart';

abstract class LoginUserDataSource {
  Future<Either<AppException, User>> loginUser({required User user});
}

class LoginUserRemoteDataSource extends LoginUserDataSource {
  final NetworkService networkService;

  LoginUserRemoteDataSource({required this.networkService});


  @override
  Future<Either<AppException, User>> loginUser({required User user}) async {
    try {
      final response = await networkService.post(EndPoints.login, data: user.toJson());
      return response.fold((l) => Left(l), (r){
        final user = User.fromJson(r.data);
        networkService.updateHeader({'Authentication': user.token});
        return Right(user);
      })
;    } catch (e) {
      return Left(AppException(
        message: "Unknown error occured.",
        statusCode: 1,
        identifier: '${e.toString()}\nLoginUserRemoteDataSource.loginUser',
      ));
    }
  }
}
