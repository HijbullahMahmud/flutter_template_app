import 'package:ag_pos/core/error/failure.dart';
import 'package:ag_pos/features/home/domain/entities/template_feature.dart';
import 'package:dartz/dartz.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, List<TemplateFeature>>> getTemplateFeatures();
}
