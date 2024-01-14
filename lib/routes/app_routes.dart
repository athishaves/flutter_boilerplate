import 'package:flutter/material.dart';
import 'package:login_screen/routes/routes.dart';

class AppRoutes {
  static void goToAuthScreen(context) {
    Navigator.pushNamed(context, Routes.authScreen);
  }

  static void goToHomeScreen(context) {
    Navigator.pushNamed(context, Routes.homeScreen);
  }

  static Map<String, Widget Function(BuildContext)> get generateRoutes {
    Map<String, Widget Function(BuildContext)> routes = {};

    routes[Routes.authScreen] = (context) => Routes.getAuthScreen(context);

    routes[Routes.homeScreen] = (context) => Routes.getHomeScreen(context);

    return routes;
  }
}
