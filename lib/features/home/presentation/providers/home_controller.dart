import 'package:ag_pos/core/di/app_providers.dart';
import 'package:ag_pos/core/types/result.dart';
import 'package:ag_pos/features/home/domain/entities/template_feature.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeControllerProvider =
    AsyncNotifierProvider<HomeController, List<TemplateFeature>>(
      HomeController.new,
    );

class HomeController extends AsyncNotifier<List<TemplateFeature>> {
  @override
  Future<List<TemplateFeature>> build() => _load();

  Future<void> reload() async {
    state = const AsyncLoading<List<TemplateFeature>>();
    state = await AsyncValue.guard(_load);
  }

  Future<List<TemplateFeature>> _load() async {
    final useCase = ref.read(getTemplateFeaturesProvider);
    final result = await useCase();

    return switch (result) {
      Success<List<TemplateFeature>>(:final value) => value,
      ResultFailure<List<TemplateFeature>>(:final failure) =>
        throw HomeFeatureException(failure.message),
    };
  }
}

class HomeFeatureException implements Exception {
  const HomeFeatureException(this.message);

  final String message;

  @override
  String toString() => message;
}
