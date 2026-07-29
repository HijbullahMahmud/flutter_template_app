import 'package:ag_pos/core/responsive/app_responsive_metrics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  }) : assert(minimumItemWidth > 0),
       assert(maximumColumns > 0),
       assert(spacing >= 0);

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
        final columns = possibleColumns.clamp(1, maximumColumns).toInt();
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

/// A lazy, content-driven grid for use inside a [CustomScrollView].
///
/// Unlike Flutter's fixed-extent [SliverGrid], each row may grow to fit
/// localized or accessibility-scaled content. Only visible rows are built.
class ResponsiveSliverGrid extends StatelessWidget {
  const ResponsiveSliverGrid({
    required this.itemCount,
    required this.itemBuilder,
    this.minimumItemWidth = 280,
    this.maximumColumns = 3,
    this.spacing = 16,
    this.runSpacing,
    super.key,
  }) : assert(itemCount >= 0),
       assert(minimumItemWidth > 0),
       assert(maximumColumns > 0),
       assert(spacing >= 0);

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final double minimumItemWidth;
  final int maximumColumns;
  final double spacing;
  final double? runSpacing;

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (BuildContext context, SliverConstraints constraints) {
        final availableWidth = constraints.crossAxisExtent;
        final possibleColumns =
            ((availableWidth + spacing) / (minimumItemWidth + spacing)).floor();
        final columns = possibleColumns.clamp(1, maximumColumns);
        final rowCount = (itemCount / columns).ceil();

        return SliverList(
          delegate: SliverChildBuilderDelegate((
            BuildContext context,
            int rowIndex,
          ) {
            final firstItemIndex = rowIndex * columns;
            final rowChildren = <Widget>[];

            for (var column = 0; column < columns; column++) {
              if (column > 0) {
                rowChildren.add(SizedBox(width: spacing));
              }

              final itemIndex = firstItemIndex + column;
              rowChildren.add(
                Expanded(
                  child: itemIndex < itemCount
                      ? itemBuilder(context, itemIndex)
                      : const SizedBox.shrink(),
                ),
              );
            }

            return Padding(
              padding: EdgeInsets.only(
                bottom: rowIndex == rowCount - 1 ? 0 : runSpacing ?? spacing,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: rowChildren,
              ),
            );
          }, childCount: rowCount),
        );
      },
    );
  }
}
