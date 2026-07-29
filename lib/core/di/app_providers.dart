import 'package:ag_pos/app/router/app_router.dart';
import 'package:ag_pos/core/network/auth_interceptor.dart';
import 'package:ag_pos/core/network/dio_factory.dart';
import 'package:ag_pos/core/network/dio_network_service.dart';
import 'package:ag_pos/core/network/network_service.dart';
import 'package:ag_pos/features/home/data/datasources/home_local_data_source.dart';
import 'package:ag_pos/features/home/data/repositories/home_repository_impl.dart';
import 'package:ag_pos/features/home/domain/repositories/home_repository.dart';
import 'package:ag_pos/features/home/domain/usecases/get_template_features.dart';
import 'package:ag_pos/features/products/data/datasources/products_remote_data_source.dart';
import 'package:ag_pos/features/products/data/repositories/products_repository_impl.dart';
import 'package:ag_pos/features/products/domain/repositories/products_repository.dart';
import 'package:ag_pos/features/products/domain/usecases/get_products.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_providers.g.dart';

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final router = AppRouter.create();
  ref.onDispose(router.dispose);
  return router;
}

@Riverpod(keepAlive: true)
AccessTokenProvider authTokenSource(Ref ref) {
  // Override this provider with the app's secure token storage implementation.
  return const EmptyAccessTokenProvider();
}

@Riverpod(keepAlive: true)
CacheOptions cacheOptions(Ref ref) => DioFactory.createCacheOptions();

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final client = DioFactory.create(
    tokenProvider: ref.watch(authTokenSourceProvider),
    cacheOptions: ref.watch(cacheOptionsProvider),
  );
  ref.onDispose(() => client.close(force: true));
  return client;
}

@Riverpod(keepAlive: true)
NetworkService networkService(Ref ref) {
  return DioNetworkService(
    ref.watch(dioProvider),
    ref.watch(cacheOptionsProvider),
  );
}

@Riverpod(keepAlive: true)
HomeLocalDataSource homeLocalDataSource(Ref ref) {
  return const HomeLocalDataSourceImpl();
}

@Riverpod(keepAlive: true)
HomeRepository homeRepository(Ref ref) {
  return HomeRepositoryImpl(ref.watch(homeLocalDataSourceProvider));
}

@Riverpod(keepAlive: true)
GetTemplateFeatures getTemplateFeatures(Ref ref) {
  return GetTemplateFeatures(ref.watch(homeRepositoryProvider));
}

@Riverpod(keepAlive: true)
ProductsRemoteDataSource productsRemoteDataSource(Ref ref) {
  return ProductsRemoteDataSourceImpl(ref.watch(networkServiceProvider));
}

@Riverpod(keepAlive: true)
ProductsRepository productsRepository(Ref ref) {
  return ProductsRepositoryImpl(ref.watch(productsRemoteDataSourceProvider));
}

@Riverpod(keepAlive: true)
GetProducts getProducts(Ref ref) {
  return GetProducts(ref.watch(productsRepositoryProvider));
}
