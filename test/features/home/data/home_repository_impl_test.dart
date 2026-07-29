import 'package:ag_pos/core/types/result.dart';
import 'package:ag_pos/features/home/data/datasources/home_local_data_source.dart';
import 'package:ag_pos/features/home/data/repositories/home_repository_impl.dart';
import 'package:ag_pos/features/home/domain/entities/template_feature.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('returns features from the local data source', () async {
    final repository = HomeRepositoryImpl(_SuccessfulDataSource());

    final result = await repository.getTemplateFeatures();

    expect(result, isA<Success<List<TemplateFeature>>>());
  });

  test('maps data source exceptions to a typed failure', () async {
    final repository = HomeRepositoryImpl(_FailingDataSource());

    final result = await repository.getTemplateFeatures();

    expect(result, isA<ResultFailure<List<TemplateFeature>>>());
  });
}

class _SuccessfulDataSource implements HomeLocalDataSource {
  @override
  Future<List<TemplateFeature>> getTemplateFeatures() async {
    return const <TemplateFeature>[
      TemplateFeature(
        title: 'Test',
        description: 'Test feature',
        icon: TemplateFeatureIcon.architecture,
      ),
    ];
  }
}

class _FailingDataSource implements HomeLocalDataSource {
  @override
  Future<List<TemplateFeature>> getTemplateFeatures() {
    throw StateError('Test failure');
  }
}
