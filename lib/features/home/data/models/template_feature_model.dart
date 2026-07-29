import 'package:ag_pos/features/home/domain/entities/template_feature.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'template_feature_model.freezed.dart';
part 'template_feature_model.g.dart';

@freezed
abstract class TemplateFeatureModel with _$TemplateFeatureModel {
  const factory TemplateFeatureModel({
    required String title,
    required String description,
    required TemplateFeatureIcon icon,
  }) = _TemplateFeatureModel;

  const TemplateFeatureModel._();

  factory TemplateFeatureModel.fromJson(Map<String, dynamic> json) =>
      _$TemplateFeatureModelFromJson(json);

  TemplateFeature toEntity() {
    return TemplateFeature(title: title, description: description, icon: icon);
  }
}
