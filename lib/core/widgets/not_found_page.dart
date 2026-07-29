import 'package:ag_pos/app/router/app_routes.dart';
import 'package:ag_pos/core/constants/app_sizes.dart';
import 'package:ag_pos/core/extensions/build_context_extensions.dart';
import 'package:ag_pos/core/responsive/responsive_builder.dart';
import 'package:ag_pos/core/widgets/app_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({required this.location, super.key});

  final String location;

  @override
  Widget build(BuildContext context) {
    return AppPage(
      body: ResponsiveBuilder(
        builder: (BuildContext context, metrics) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(metrics.horizontalPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('404', style: Theme.of(context).textTheme.displayLarge),
                  const SizedBox(height: AppSizes.space8),
                  Text(
                    context.locale.notFoundMessage(location),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSizes.space24),
                  FilledButton(
                    onPressed: () => context.goNamed(AppRouteNames.home),
                    child: Text(context.locale.backToHome),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
