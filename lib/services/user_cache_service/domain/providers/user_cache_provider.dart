import 'package:clean_arch_with_riverpod/common/data/local/storage_service.dart';
import 'package:clean_arch_with_riverpod/common/domain/providers/shared_preferences_storage_provider.dart';
import 'package:clean_arch_with_riverpod/services/user_cache_service/data/datasource/user_local_datasource.dart';
import 'package:clean_arch_with_riverpod/services/user_cache_service/data/repository/user_repository_imp.dart';
import 'package:clean_arch_with_riverpod/services/user_cache_service/domain/repository/user_cache_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataSourceProvider = Provider.family<UserDataSource, StorageService>((_, networkService){
  return UserLocalDataSource(storageService: networkService);
});

final userLocalRepositoryProvider = Provider<UserRepository>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  final userDataSource = ref.watch(userDataSourceProvider(storageService));
  final repository = UserRepositoryImpl(dataSource: userDataSource);
  return repository;
});