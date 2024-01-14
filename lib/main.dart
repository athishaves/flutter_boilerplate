import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:login_screen/global/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';
import 'package:login_screen/routes/app_routes.dart';
import 'package:login_screen/routes/routes.dart';
import 'package:login_screen/services/service.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  Service.setup();

  LocalJsonLocalization.delegate.directories = ['lib/i18n'];
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersive,
  );

  FlutterNativeSplash.remove();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    String initialRoute = Service.authService.currentUser == null
        ? Routes.authScreen
        : Routes.homeScreen;
    return MaterialApp(
      locale: const Locale('en', 'IN'),
      supportedLocales: const [
        Locale('kn', 'IN'),
        Locale('en', 'US'),
      ],
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocalJsonLocalization.delegate,
      ],
      theme: themeData,
      initialRoute: initialRoute,
      routes: AppRoutes.generateRoutes,
    );
  }
}
