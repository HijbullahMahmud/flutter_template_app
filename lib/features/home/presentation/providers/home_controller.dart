import 'package:ag_pos/core/di/app_providers.dart';
import 'package:ag_pos/features/home/domain/entities/template_feature.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_controller.g.dart';

@Riverpod(keepAlive: true)
class HomeController extends _$HomeController {
  @override
  Future<List<TemplateFeature>> build() => _load();

  Future<void> reload() async {
    state = const AsyncLoading<List<TemplateFeature>>();
    state = await AsyncValue.guard(_load);
  }

  Future<List<TemplateFeature>> _load() async {
    final result = await ref.read(getTemplateFeaturesProvider)();
    return result.fold(
      (failure) => throw HomeFeatureException(failure.message),
      (features) => features,
    );
  }
}

class HomeFeatureException implements Exception {
  const HomeFeatureException(this.message);

  final String message;

  @override
  String toString() => message;
}
