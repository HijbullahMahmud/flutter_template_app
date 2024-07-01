import 'package:clean_arch_with_riverpod/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginButton extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final String userName;
  final String password;
  const LoginButton(
      {required this.formKey,
      required this.userName,
      required this.password,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            ref
                .read(authStateNotifierProvider.notifier)
                .loginUser(userName, password);
          }
        },
        child: const Text("Login"));
  }
}
