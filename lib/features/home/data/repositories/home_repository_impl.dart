import 'package:ag_pos/core/error/failure.dart';
import 'package:ag_pos/features/home/data/datasources/home_local_data_source.dart';
import 'package:ag_pos/features/home/domain/entities/template_feature.dart';
import 'package:ag_pos/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._localDataSource);

  final HomeLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<TemplateFeature>>> getTemplateFeatures() async {
    try {
      final models = await _localDataSource.getTemplateFeatures();
      final features = models
          .map((model) => model.toEntity())
          .toList(growable: false);
      return Right<Failure, List<TemplateFeature>>(features);
    } on Object catch (error, stackTrace) {
      return Left<Failure, List<TemplateFeature>>(
        CacheFailure(
          message: 'Unable to load template features.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
