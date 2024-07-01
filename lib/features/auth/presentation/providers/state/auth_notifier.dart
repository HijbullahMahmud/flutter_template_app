import 'package:clean_arch_with_riverpod/common/domain/models/user/user.dart';
import 'package:clean_arch_with_riverpod/common/exceptions/http_exception.dart';
import 'package:clean_arch_with_riverpod/features/auth/presentation/providers/state/auth_state.dart';
import 'package:clean_arch_with_riverpod/services/user_cache_service/domain/repository/user_cache_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/repositories/auth_repository.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  AuthNotifier({required this.authRepository, required this.userRepository})
      : super(const AuthState.initial());

  Future<void> loginUser(String userName, String password) async {
    state = const AuthState.loading();
    final response = await authRepository.login(
        user: User(username: userName, password: password));

    state = await response.fold((l) => AuthState.failure(l), (user) async {
      final hasSavedUser = await userRepository.saveUser(user: user);
      if (hasSavedUser) {
        return const AuthState.success();
      }else{
        return AuthState.failure(CacheFailureException());
      }
    });
  }
}
