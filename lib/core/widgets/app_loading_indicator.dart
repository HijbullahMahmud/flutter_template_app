import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({
    this.size = 24,
    this.color,
    this.strokeWidth = 2.5,
    this.semanticLabel,
    super.key,
  }) : assert(size > 0),
       assert(strokeWidth > 0);

  final double size;
  final Color? color;
  final double strokeWidth;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    final indicator =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS
        ? CupertinoActivityIndicator(radius: size / 2, color: color)
        : SizedBox.square(
            dimension: size,
            child: CircularProgressIndicator(
              color: color,
              strokeWidth: strokeWidth,
            ),
          );

    if (semanticLabel == null) {
      return indicator;
    }

    return Semantics(
      label: semanticLabel,
      child: ExcludeSemantics(child: indicator),
    );
  }
}

class AppLoadingView extends StatelessWidget {
  const AppLoadingView({
    this.size = 32,
    this.color,
    this.semanticLabel,
    super.key,
  });

  final double size;
  final Color? color;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppLoadingIndicator(
        size: size,
        color: color,
        semanticLabel: semanticLabel,
      ),
    );
  }
}
