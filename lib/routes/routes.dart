import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_screen/screens/auth_screen/auth_screen.dart';
import 'package:login_screen/screens/auth_screen/bloc/auth_bloc.dart';
import 'package:login_screen/screens/home_screen/home_screen.dart';

class Routes {
  static const String authScreen = '/authScreen';
  static const String homeScreen = '/homeScreen';

  static Widget getAuthScreen(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const AuthScreen(),
    );
  }

  static Widget getHomeScreen(BuildContext context) {
    return const HomeScreen();
  }
}
