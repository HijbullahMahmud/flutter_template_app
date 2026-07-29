import 'package:ag_pos/core/error/failure.dart';
import 'package:ag_pos/features/home/domain/entities/template_feature.dart';
import 'package:ag_pos/features/home/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class GetTemplateFeatures {
  const GetTemplateFeatures(this._repository);

  final HomeRepository _repository;

  Future<Either<Failure, List<TemplateFeature>>> call() {
    return _repository.getTemplateFeatures();
  }
}
