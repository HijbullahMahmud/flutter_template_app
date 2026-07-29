import 'package:ag_pos/core/error/failure.dart';
import 'package:ag_pos/core/types/result.dart';
import 'package:ag_pos/features/home/data/datasources/home_local_data_source.dart';
import 'package:ag_pos/features/home/domain/entities/template_feature.dart';
import 'package:ag_pos/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._localDataSource);

  final HomeLocalDataSource _localDataSource;

  @override
  Future<Result<List<TemplateFeature>>> getTemplateFeatures() async {
    try {
      final features = await _localDataSource.getTemplateFeatures();
      return Success<List<TemplateFeature>>(features);
    } on Object catch (error) {
      return ResultFailure<List<TemplateFeature>>(
        UnknownFailure('Unable to load template features.', error),
      );
    }
  }
}
