import 'package:ag_pos/features/home/data/models/template_feature_model.dart';
import 'package:ag_pos/features/home/domain/entities/template_feature.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('serializes and deserializes JSON', () {
    const model = TemplateFeatureModel(
      title: 'Freezed',
      description: 'Generated model',
      icon: TemplateFeatureIcon.architecture,
    );

    final json = model.toJson();
    final restored = TemplateFeatureModel.fromJson(json);

    expect(restored, model);
    expect(json['icon'], 'architecture');
  });

  test('maps to a domain entity', () {
    const model = TemplateFeatureModel(
      title: 'Freezed',
      description: 'Generated model',
      icon: TemplateFeatureIcon.architecture,
    );

    final entity = model.toEntity();

    expect(entity.title, model.title);
    expect(entity.icon, model.icon);
  });
}
