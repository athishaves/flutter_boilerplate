import 'package:get_it/get_it.dart';
import 'package:login_screen/services/auth_service.dart';

class Service {
  static final getIt = GetIt.instance;

  static void setup() {
    getIt.registerSingleton<AuthService>(AuthService());
  }

  static AuthService get authService => getIt<AuthService>();
}
