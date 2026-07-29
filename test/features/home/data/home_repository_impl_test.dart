import 'package:ag_pos/features/home/data/datasources/home_local_data_source.dart';
import 'package:ag_pos/features/home/data/models/template_feature_model.dart';
import 'package:ag_pos/features/home/data/repositories/home_repository_impl.dart';
import 'package:ag_pos/features/home/domain/entities/template_feature.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps models from the local data source to entities', () async {
    final repository = HomeRepositoryImpl(_SuccessfulDataSource());

    final result = await repository.getTemplateFeatures();

    expect(result.isRight(), isTrue);
    result.fold((failure) => fail(failure.message), (features) {
      expect(features, hasLength(1));
      expect(features.single.title, 'Test');
    });
  });

  test('maps data source exceptions to a typed failure', () async {
    final repository = HomeRepositoryImpl(_FailingDataSource());

    final result = await repository.getTemplateFeatures();

    expect(result.isLeft(), isTrue);
  });
}

class _SuccessfulDataSource implements HomeLocalDataSource {
  @override
  Future<List<TemplateFeatureModel>> getTemplateFeatures() async {
    return const <TemplateFeatureModel>[
      TemplateFeatureModel(
        title: 'Test',
        description: 'Test feature',
        icon: TemplateFeatureIcon.architecture,
      ),
    ];
  }
}

class _FailingDataSource implements HomeLocalDataSource {
  @override
  Future<List<TemplateFeatureModel>> getTemplateFeatures() {
    throw StateError('Test failure');
  }
}
