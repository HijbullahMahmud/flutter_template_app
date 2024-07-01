import 'package:clean_arch_with_riverpod/common/data/remote/network_service.dart';
import 'package:clean_arch_with_riverpod/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_arch_with_riverpod/features/auth/data/repositories/authentication_repository_impl.dart';
import 'package:clean_arch_with_riverpod/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/domain/providers/dio_network_service_provider.dart';

final authDataSourceProvider =
    Provider.family<LoginUserDataSource, NetworkService>((_, networkService) =>
        LoginUserRemoteDataSource(networkService: networkService));

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final networkService = ref.read(networkServiceProvider);
  final dataSource = ref.read(authDataSourceProvider(networkService));
  return AuthRepositoryImpl(dataSource: dataSource);
});
