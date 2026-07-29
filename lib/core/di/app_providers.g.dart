// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(router)
final routerProvider = RouterProvider._();

final class RouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  RouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routerHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return router(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$routerHash() => r'5b9dd6ff4fc93063b3ff11135a029bcbb69200f0';

@ProviderFor(authTokenSource)
final authTokenSourceProvider = AuthTokenSourceProvider._();

final class AuthTokenSourceProvider
    extends
        $FunctionalProvider<
          AccessTokenProvider,
          AccessTokenProvider,
          AccessTokenProvider
        >
    with $Provider<AccessTokenProvider> {
  AuthTokenSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authTokenSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authTokenSourceHash();

  @$internal
  @override
  $ProviderElement<AccessTokenProvider> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AccessTokenProvider create(Ref ref) {
    return authTokenSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AccessTokenProvider value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AccessTokenProvider>(value),
    );
  }
}

String _$authTokenSourceHash() => r'358301918963dfbd28e18645571a1742397f0cc3';

@ProviderFor(cacheOptions)
final cacheOptionsProvider = CacheOptionsProvider._();

final class CacheOptionsProvider
    extends $FunctionalProvider<CacheOptions, CacheOptions, CacheOptions>
    with $Provider<CacheOptions> {
  CacheOptionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cacheOptionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cacheOptionsHash();

  @$internal
  @override
  $ProviderElement<CacheOptions> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CacheOptions create(Ref ref) {
    return cacheOptions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CacheOptions value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CacheOptions>(value),
    );
  }
}

String _$cacheOptionsHash() => r'e129ae8ab007f3c92bba1e3d505b1d27838b58a7';

@ProviderFor(dio)
final dioProvider = DioProvider._();

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'24aa0bad220190c0e6488e88854075040f5e4d72';

@ProviderFor(networkService)
final networkServiceProvider = NetworkServiceProvider._();

final class NetworkServiceProvider
    extends $FunctionalProvider<NetworkService, NetworkService, NetworkService>
    with $Provider<NetworkService> {
  NetworkServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'networkServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$networkServiceHash();

  @$internal
  @override
  $ProviderElement<NetworkService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NetworkService create(Ref ref) {
    return networkService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NetworkService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NetworkService>(value),
    );
  }
}

String _$networkServiceHash() => r'a69733c7105d224ad1e9604af1934cf507e8f338';

@ProviderFor(homeLocalDataSource)
final homeLocalDataSourceProvider = HomeLocalDataSourceProvider._();

final class HomeLocalDataSourceProvider
    extends
        $FunctionalProvider<
          HomeLocalDataSource,
          HomeLocalDataSource,
          HomeLocalDataSource
        >
    with $Provider<HomeLocalDataSource> {
  HomeLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<HomeLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HomeLocalDataSource create(Ref ref) {
    return homeLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeLocalDataSource>(value),
    );
  }
}

String _$homeLocalDataSourceHash() =>
    r'bb980b8e907994911a4b3b977950a38706b2d7c2';

@ProviderFor(homeRepository)
final homeRepositoryProvider = HomeRepositoryProvider._();

final class HomeRepositoryProvider
    extends $FunctionalProvider<HomeRepository, HomeRepository, HomeRepository>
    with $Provider<HomeRepository> {
  HomeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeRepositoryHash();

  @$internal
  @override
  $ProviderElement<HomeRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HomeRepository create(Ref ref) {
    return homeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeRepository>(value),
    );
  }
}

String _$homeRepositoryHash() => r'6cd1d484300d27262788fd8af7c74fe4d01fc15b';

@ProviderFor(getTemplateFeatures)
final getTemplateFeaturesProvider = GetTemplateFeaturesProvider._();

final class GetTemplateFeaturesProvider
    extends
        $FunctionalProvider<
          GetTemplateFeatures,
          GetTemplateFeatures,
          GetTemplateFeatures
        >
    with $Provider<GetTemplateFeatures> {
  GetTemplateFeaturesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTemplateFeaturesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getTemplateFeaturesHash();

  @$internal
  @override
  $ProviderElement<GetTemplateFeatures> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetTemplateFeatures create(Ref ref) {
    return getTemplateFeatures(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetTemplateFeatures value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetTemplateFeatures>(value),
    );
  }
}

String _$getTemplateFeaturesHash() =>
    r'f9769954d3447bf0862c0a4d192941caa9e6bbd5';
