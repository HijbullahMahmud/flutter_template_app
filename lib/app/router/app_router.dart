import 'package:ag_pos/app/router/app_routes.dart';
import 'package:ag_pos/core/widgets/not_found_page.dart';
import 'package:ag_pos/features/home/presentation/pages/home_page.dart';
import 'package:ag_pos/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRouter {
  static GoRouter create() {
    return GoRouter(
      initialLocation: AppRoutes.home,
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.home,
          name: AppRouteNames.home,
          builder: (BuildContext context, GoRouterState state) {
            return const HomePage();
          },
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.settingsPath,
              name: AppRouteNames.settings,
              builder: (BuildContext context, GoRouterState state) {
                return const SettingsPage();
              },
            ),
          ],
        ),
      ],
      errorBuilder: (BuildContext context, GoRouterState state) {
        return NotFoundPage(location: state.uri.toString());
      },
    );
  }
}
