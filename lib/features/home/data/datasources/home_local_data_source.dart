import 'package:ag_pos/features/home/domain/entities/template_feature.dart';

abstract interface class HomeLocalDataSource {
  Future<List<TemplateFeature>> getTemplateFeatures();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  const HomeLocalDataSourceImpl();

  @override
  Future<List<TemplateFeature>> getTemplateFeatures() async {
    return const <TemplateFeature>[
      TemplateFeature(
        title: 'Clean architecture',
        description: 'Feature-first data, domain, and presentation layers.',
        icon: TemplateFeatureIcon.architecture,
      ),
      TemplateFeature(
        title: 'GoRouter',
        description: 'Centralized, named, and deep-link-ready navigation.',
        icon: TemplateFeatureIcon.routing,
      ),
      TemplateFeature(
        title: 'Provider + DI',
        description: 'Explicit dependency composition and testable state.',
        icon: TemplateFeatureIcon.dependencyInjection,
      ),
      TemplateFeature(
        title: 'Adaptive theme',
        description: 'Light and dark themes follow the device by default.',
        icon: TemplateFeatureIcon.theme,
      ),
    ];
  }
}
