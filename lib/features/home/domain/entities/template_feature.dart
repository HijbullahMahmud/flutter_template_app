enum TemplateFeatureIcon { architecture, routing, dependencyInjection, theme }

class TemplateFeature {
  const TemplateFeature({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;

  final TemplateFeatureIcon icon;
}
