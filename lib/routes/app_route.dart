import 'package:auto_route/auto_route.dart';
import 'package:clean_arch_with_riverpod/features/splash/presentation/screens/splash_screen.dart';
part 'app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
  ];
}
