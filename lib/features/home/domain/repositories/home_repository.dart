import 'package:ag_pos/core/types/result.dart';
import 'package:ag_pos/features/home/domain/entities/template_feature.dart';

abstract interface class HomeRepository {
  Future<Result<List<TemplateFeature>>> getTemplateFeatures();
}
