import 'package:ag_pos/app/router/app_router.dart';
import 'package:ag_pos/features/home/data/datasources/home_local_data_source.dart';
import 'package:ag_pos/features/home/data/repositories/home_repository_impl.dart';
import 'package:ag_pos/features/home/domain/repositories/home_repository.dart';
import 'package:ag_pos/features/home/domain/usecases/get_template_features.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((Ref ref) {
  final router = AppRouter.create();
  ref.onDispose(router.dispose);
  return router;
});

final homeLocalDataSourceProvider = Provider<HomeLocalDataSource>(
  (Ref ref) => const HomeLocalDataSourceImpl(),
);

final homeRepositoryProvider = Provider<HomeRepository>(
  (Ref ref) => HomeRepositoryImpl(ref.watch(homeLocalDataSourceProvider)),
);

final getTemplateFeaturesProvider = Provider<GetTemplateFeatures>(
  (Ref ref) => GetTemplateFeatures(ref.watch(homeRepositoryProvider)),
);
