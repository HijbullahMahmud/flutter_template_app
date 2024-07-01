import 'package:clean_arch_with_riverpod/features/auth/auth.dart';
import 'package:clean_arch_with_riverpod/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../dashboard/presentation/widgets/dashboard_screen.dart';
import '../providers/state/auth_state.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String routeName = "/authscreen";

  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController(text: "emilys");
  final passwordController = TextEditingController(text: 'emilyspass');

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authStateNotifierProvider);
    ref.listen(authStateNotifierProvider.select((value) => value),
        ((previous, next) {
      //show snackbar on failure
      if (next is Failure) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(next.exception.message.toString())));
      } else if (next is Success) {
        context.pushReplacementNamed(DashboardScreen.routeName);
      }
    }));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AuthField(
                hintText: "UserName",
                controller: userNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your user name";
                  }
                  return null;
                },
              ),
              AuthField(
                hintText: "Password",
                controller: passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null && value!.isEmpty || value.length < 6) {
                    return "Enter your 6 digits password";
                  }
                  return null;
                },
              ),
              state.maybeMap(
                loading: (_) => const Center(
                  child: CircularProgressIndicator(),
                ),
                orElse: () => LoginButton(
                  formKey: _formKey,
                  userName: userNameController.text,
                  password: passwordController.text,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
