import 'package:clean_arch_with_riverpod/features/splash/presentation/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: SplashScreen.routeName,
  routes: [
    GoRoute(
      name: SplashScreen.routeName,
      path: SplashScreen.routeName,
      builder: (context, state) => const SplashScreen(),
    ),
  ],
);
