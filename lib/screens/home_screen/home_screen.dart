import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:login_screen/global/components/animated_button.dart';
import 'package:login_screen/routes/app_routes.dart';
import 'package:login_screen/services/service.dart';
import 'package:login_screen/utils/responsive_sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.su),
              alignment: Alignment.center,
              child: Text(
                "Hello\n${Service.authService.currentUser?.displayName}",
                style: context.displayLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.su),
              child: AnimatedButtonContainer(
                onPressed: () => signOut(context),
                child: Text(
                  "Sign Out",
                  style: context.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future signOut(BuildContext context) async {
    await Service.authService
        .signOut()
        .then((value) => AppRoutes.goToAuthScreen(context));
  }
}
