import 'package:clean_arch_with_riverpod/features/auth/presentation/screens/login_screen.dart';
import 'package:clean_arch_with_riverpod/features/dashboard/presentation/widgets/dashboard_screen.dart';
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
    GoRoute(
      name: DashboardScreen.routeName,
      path: DashboardScreen.routeName,
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    )
  ],
);
