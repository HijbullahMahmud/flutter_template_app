import 'package:ag_pos/app/router/app_router.dart';
import 'package:ag_pos/core/theme/theme_controller.dart';
import 'package:ag_pos/features/home/data/datasources/home_local_data_source.dart';
import 'package:ag_pos/features/home/data/repositories/home_repository_impl.dart';
import 'package:ag_pos/features/home/domain/repositories/home_repository.dart';
import 'package:ag_pos/features/home/domain/usecases/get_template_features.dart';
import 'package:ag_pos/features/home/presentation/providers/home_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeController>(
          create: (_) => ThemeController(),
        ),
        Provider<HomeLocalDataSource>(
          create: (_) => const HomeLocalDataSourceImpl(),
        ),
        Provider<HomeRepository>(
          create: (BuildContext context) =>
              HomeRepositoryImpl(context.read<HomeLocalDataSource>()),
        ),
        Provider<GetTemplateFeatures>(
          create: (BuildContext context) =>
              GetTemplateFeatures(context.read<HomeRepository>()),
        ),
        ChangeNotifierProvider<HomeController>(
          create: (BuildContext context) =>
              HomeController(context.read<GetTemplateFeatures>())..load(),
        ),
        Provider<GoRouter>(
          create: (_) => AppRouter.create(),
          dispose: (_, GoRouter router) => router.dispose(),
        ),
      ],
      child: child,
    );
  }
}
