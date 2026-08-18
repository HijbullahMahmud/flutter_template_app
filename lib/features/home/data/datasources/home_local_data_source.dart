import 'package:ag_pos/features/home/data/models/template_feature_model.dart';
import 'package:ag_pos/features/home/domain/entities/template_feature.dart';

abstract interface class HomeLocalDataSource {
  Future<List<TemplateFeatureModel>> getTemplateFeatures();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  const HomeLocalDataSourceImpl();

  @override
  Future<List<TemplateFeatureModel>> getTemplateFeatures() async {
    return const <TemplateFeatureModel>[
      TemplateFeatureModel(
        title: 'Clean architecture',
        description: 'Feature-first data, domain, and presentation layers.',
        icon: TemplateFeatureIcon.architecture,
      ),
      TemplateFeatureModel(
        title: 'GoRouter',
        description: 'Centralized, named, and deep-link-ready navigation.',
        icon: TemplateFeatureIcon.routing,
      ),
      TemplateFeatureModel(
        title: 'BLoC + DI',
        description: 'Explicit dependencies and testable state.',
        icon: TemplateFeatureIcon.dependencyInjection,
      ),
      TemplateFeatureModel(
        title: 'Dio networking',
        description: 'Typed CRUD, caching, and centralized error handling.',
        icon: TemplateFeatureIcon.theme,
      ),
    ];
  }
}
