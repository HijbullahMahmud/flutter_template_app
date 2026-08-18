import 'package:ag_pos/app/router/app_routes.dart';
import 'package:ag_pos/core/widgets/not_found_page.dart';
import 'package:ag_pos/features/home/domain/usecases/get_template_features.dart';
import 'package:ag_pos/features/home/presentation/bloc/home_bloc.dart';
import 'package:ag_pos/features/home/presentation/pages/home_page.dart';
import 'package:ag_pos/features/products/domain/usecases/get_products.dart';
import 'package:ag_pos/features/products/presentation/bloc/products_bloc.dart';
import 'package:ag_pos/features/products/presentation/pages/products_page.dart';
import 'package:ag_pos/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            return BlocProvider<HomeBloc>(
              create: (BuildContext context) =>
                  HomeBloc(context.read<GetTemplateFeatures>())
                    ..add(const HomeRequested()),
              child: const HomePage(),
            );
          },
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.productsPath,
              name: AppRouteNames.products,
              builder: (BuildContext context, GoRouterState state) {
                return BlocProvider<ProductsBloc>(
                  create: (BuildContext context) =>
                      ProductsBloc(context.read<GetProducts>())
                        ..add(const ProductsRequested()),
                  child: const ProductsPage(),
                );
              },
            ),
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
