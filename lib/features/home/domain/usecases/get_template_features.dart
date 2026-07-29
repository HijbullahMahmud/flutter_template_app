import 'package:ag_pos/core/types/result.dart';
import 'package:ag_pos/features/home/domain/entities/template_feature.dart';
import 'package:ag_pos/features/home/domain/repositories/home_repository.dart';

class GetTemplateFeatures {
  const GetTemplateFeatures(this._repository);

  final HomeRepository _repository;

  Future<Result<List<TemplateFeature>>> call() {
    return _repository.getTemplateFeatures();
  }
}
