// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(initialLocale)
final initialLocaleProvider = InitialLocaleProvider._();

final class InitialLocaleProvider
    extends $FunctionalProvider<Locale, Locale, Locale>
    with $Provider<Locale> {
  InitialLocaleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'initialLocaleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$initialLocaleHash();

  @$internal
  @override
  $ProviderElement<Locale> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Locale create(Ref ref) {
    return initialLocale(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale>(value),
    );
  }
}

String _$initialLocaleHash() => r'242d266e5f4b50f688c54fed930400cefd9c5448';

@ProviderFor(localePreferences)
final localePreferencesProvider = LocalePreferencesProvider._();

final class LocalePreferencesProvider
    extends
        $FunctionalProvider<
          LocalePreferences,
          LocalePreferences,
          LocalePreferences
        >
    with $Provider<LocalePreferences> {
  LocalePreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localePreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localePreferencesHash();

  @$internal
  @override
  $ProviderElement<LocalePreferences> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalePreferences create(Ref ref) {
    return localePreferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalePreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalePreferences>(value),
    );
  }
}

String _$localePreferencesHash() => r'8418780af317eae1a63f6f7fc5314ebd3d35f862';

@ProviderFor(LocaleController)
final localeControllerProvider = LocaleControllerProvider._();

final class LocaleControllerProvider
    extends $NotifierProvider<LocaleController, Locale> {
  LocaleControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localeControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localeControllerHash();

  @$internal
  @override
  LocaleController create() => LocaleController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale>(value),
    );
  }
}

String _$localeControllerHash() => r'368c3a313aa91549008c01c7809789cd6a57b07c';

abstract class _$LocaleController extends $Notifier<Locale> {
  Locale build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Locale, Locale>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Locale, Locale>,
              Locale,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
