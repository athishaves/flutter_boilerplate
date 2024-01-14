import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_screen/screens/auth_screen/bloc/auth_bloc.dart';
import 'package:login_screen/screens/auth_screen/components/login_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: context.read<AuthBloc>().authScreenNotifier,
        builder: (context, authType, child) {
          return switch (authType) {
            AuthScreenType.login => LoginScreen(),
            AuthScreenType.signUp => SignUpScreen(),
          };
        });
  }
}
