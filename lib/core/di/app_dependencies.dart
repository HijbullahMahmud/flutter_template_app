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

/// Owns the long-lived objects that were previously generated providers.
///
/// Constructor injection keeps dependencies explicit and makes tests replace
/// only the objects they need without a global service locator.
class AppDependencies {
  AppDependencies._({
    required this.router,
    required this.dio,
    required this.cacheOptions,
    required this.networkService,
    required this.homeLocalDataSource,
    required this.homeRepository,
    required this.getTemplateFeatures,
    required this.productsRemoteDataSource,
    required this.productsRepository,
    required this.getProducts,
  });

  factory AppDependencies.create({
    AccessTokenProvider tokenProvider = const EmptyAccessTokenProvider(),
  }) {
    final router = AppRouter.create();
    final cacheOptions = DioFactory.createCacheOptions();
    final dio = DioFactory.create(
      tokenProvider: tokenProvider,
      cacheOptions: cacheOptions,
    );
    final networkService = DioNetworkService(dio, cacheOptions);
    const homeLocalDataSource = HomeLocalDataSourceImpl();
    final homeRepository = HomeRepositoryImpl(homeLocalDataSource);
    final getTemplateFeatures = GetTemplateFeatures(homeRepository);
    final productsRemoteDataSource = ProductsRemoteDataSourceImpl(
      networkService,
    );
    final productsRepository = ProductsRepositoryImpl(productsRemoteDataSource);

    return AppDependencies._(
      router: router,
      dio: dio,
      cacheOptions: cacheOptions,
      networkService: networkService,
      homeLocalDataSource: homeLocalDataSource,
      homeRepository: homeRepository,
      getTemplateFeatures: getTemplateFeatures,
      productsRemoteDataSource: productsRemoteDataSource,
      productsRepository: productsRepository,
      getProducts: GetProducts(productsRepository),
    );
  }

  final GoRouter router;
  final Dio dio;
  final CacheOptions cacheOptions;
  final NetworkService networkService;
  final HomeLocalDataSource homeLocalDataSource;
  final HomeRepository homeRepository;
  final GetTemplateFeatures getTemplateFeatures;
  final ProductsRemoteDataSource productsRemoteDataSource;
  final ProductsRepository productsRepository;
  final GetProducts getProducts;

  void dispose() {
    router.dispose();
    dio.close(force: true);
  }
}
