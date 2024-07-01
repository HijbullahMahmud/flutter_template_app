import 'package:clean_arch_with_riverpod/features/auth/presentation/presentation.dart';
import 'package:clean_arch_with_riverpod/features/dashboard/presentation/widgets/dashboard_screen.dart';
import 'package:clean_arch_with_riverpod/features/splash/presentation/providers/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static const String routeName = "/SplashScreen";
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      final isUserLoggedIn = await ref.read(userLogingCheckProvider.future);
      final route =
          isUserLoggedIn ? DashboardScreen.routeName : LoginScreen.routeName;

      GoRouter.of(context).pushReplacementNamed(route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Text(
          "Splash Screen",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
