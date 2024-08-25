import 'package:clean_arch_with_riverpod/features/auth/domain/providers/login_provider.dart';
import 'package:clean_arch_with_riverpod/features/auth/domain/repositories/auth_repository.dart';
import 'package:clean_arch_with_riverpod/features/auth/presentation/providers/state/auth_notifier.dart';
import 'package:clean_arch_with_riverpod/features/auth/presentation/providers/state/auth_state.dart';
import 'package:clean_arch_with_riverpod/services/user_cache_service/domain/providers/user_cache_provider.dart';
import 'package:clean_arch_with_riverpod/services/user_cache_service/domain/repository/user_cache_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
      
  final AuthRepository authRepository = ref.read(authRepositoryProvider);
  final UserRepository userRepository = ref.read(userLocalRepositoryProvider);

  return AuthNotifier(
      authRepository: authRepository, userRepository: userRepository);
});
