import 'package:ag_pos/core/responsive/app_responsive_metrics.dart';
import 'package:flutter/material.dart';

typedef ResponsiveWidgetBuilder =
    Widget Function(BuildContext context, AppResponsiveMetrics metrics);

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({required this.builder, super.key});

  final ResponsiveWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;
        return builder(context, AppResponsiveMetrics.fromWidth(width));
      },
    );
  }
}

class ResponsiveConstrainedBox extends StatelessWidget {
  const ResponsiveConstrainedBox({
    required this.child,
    required this.maxWidth,
    this.alignment = Alignment.topCenter,
    super.key,
  });

  final Widget child;
  final double maxWidth;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}

class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({
    required this.children,
    this.minimumItemWidth = 280,
    this.maximumColumns = 3,
    this.spacing = 16,
    this.runSpacing,
    super.key,
  });

  final List<Widget> children;
  final double minimumItemWidth;
  final int maximumColumns;
  final double spacing;
  final double? runSpacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final availableWidth = constraints.maxWidth;
        final possibleColumns =
            ((availableWidth + spacing) / (minimumItemWidth + spacing)).floor();
        final columns = possibleColumns.clamp(1, maximumColumns);
        final itemWidth =
            (availableWidth - (spacing * (columns - 1))) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing ?? spacing,
          children: children
              .map((Widget child) => SizedBox(width: itemWidth, child: child))
              .toList(growable: false),
        );
      },
    );
  }
}
