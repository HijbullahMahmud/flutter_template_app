// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductsController)
final productsControllerProvider = ProductsControllerProvider._();

final class ProductsControllerProvider
    extends $AsyncNotifierProvider<ProductsController, ProductsState> {
  ProductsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: _disableRetry,
        name: r'productsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$productsControllerHash();

  @$internal
  @override
  ProductsController create() => ProductsController();
}

String _$productsControllerHash() =>
    r'f35c0312244135f33a0de9ec535106c3a169e5ea';

abstract class _$ProductsController extends $AsyncNotifier<ProductsState> {
  FutureOr<ProductsState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ProductsState>, ProductsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProductsState>, ProductsState>,
              AsyncValue<ProductsState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
