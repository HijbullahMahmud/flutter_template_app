import 'package:ag_pos/core/constants/app_sizes.dart';
import 'package:ag_pos/core/extensions/build_context_extensions.dart';
import 'package:ag_pos/core/responsive/responsive_builder.dart';
import 'package:flutter/material.dart';

class AppErrorView extends StatelessWidget {
  const AppErrorView({required this.message, this.onRetry, super.key});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, metrics) {
        return Center(
          child: Padding(
            padding: EdgeInsets.all(metrics.horizontalPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: AppSizes.space16),
                Text(message, textAlign: TextAlign.center),
                if (onRetry != null) ...<Widget>[
                  const SizedBox(height: AppSizes.space16),
                  FilledButton.tonal(
                    onPressed: onRetry,
                    child: Text(context.locale.tryAgain),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
