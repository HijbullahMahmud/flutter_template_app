// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_feature_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TemplateFeatureModel _$TemplateFeatureModelFromJson(
  Map<String, dynamic> json,
) => _TemplateFeatureModel(
  title: json['title'] as String,
  description: json['description'] as String,
  icon: $enumDecode(_$TemplateFeatureIconEnumMap, json['icon']),
);

Map<String, dynamic> _$TemplateFeatureModelToJson(
  _TemplateFeatureModel instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'icon': _$TemplateFeatureIconEnumMap[instance.icon]!,
};

const _$TemplateFeatureIconEnumMap = {
  TemplateFeatureIcon.architecture: 'architecture',
  TemplateFeatureIcon.routing: 'routing',
  TemplateFeatureIcon.dependencyInjection: 'dependencyInjection',
  TemplateFeatureIcon.theme: 'theme',
};
