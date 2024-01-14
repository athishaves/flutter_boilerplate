import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:localization/localization.dart';
import 'package:login_screen/routes/app_routes.dart';
import 'package:login_screen/services/service.dart';
import 'package:login_screen/utils/extensions.dart';

part 'auth_event.dart';
part 'auth_state.dart';

enum AuthScreenType { login, signUp }

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  ValueNotifier<AuthScreenType> authScreenNotifier =
      ValueNotifier(AuthScreenType.login);

  bool get isSignUp => authScreenNotifier.value == AuthScreenType.signUp;
  bool get isLogin => authScreenNotifier.value == AuthScreenType.login;

  Duration authDelay = 1000.ms;

  AuthBloc() : super(AuthState.initial()) {
    on<SignUpEvent>((event, emit) async {
      try {
        String name = event.name;
        String email = event.email;
        String password = event.password;
        await Future.wait([
          Service.authService.createUserWithEmailAndPassword(
            displayName: name,
            email: email,
            password: password,
          ),
          authDelay.delay
        ]).then((values) => _handleAuth(values[0], event.context, emit));
      } on FirebaseAuthException catch (e) {
        emit(AuthState.error(error: e.message ?? ""));
      }
    });

    on<LogInEvent>((event, emit) async {
      try {
        String email = event.email;
        String password = event.password;
        await Future.wait([
          Service.authService.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
          authDelay.delay
        ]).then((values) => _handleAuth(values[0], event.context, emit));
      } on FirebaseAuthException catch (e) {
        emit(AuthState.error(error: e.message ?? ""));
      }
    });

    on<SubmitForm>((event, emit) async {
      String name = event.name;
      String email = event.email;
      String password = event.password;

      if (authScreenNotifier.value == AuthScreenType.signUp && name.isEmpty) {
        emit(AuthState.error(error: 'name-empty'.i18n()));
        return;
      }
      if (email.isEmpty) {
        emit(AuthState.error(error: 'email-empty'.i18n()));
        return;
      }
      if (password.isEmpty) {
        emit(AuthState.error(error: 'password-empty'.i18n()));
        return;
      }

      emit(AuthState.loading());
      add(isSignUp
          ? SignUpEvent(
              context: event.context,
              email: email,
              password: password,
              name: name,
            )
          : LogInEvent(
              context: event.context,
              email: email,
              password: password,
            ));
    });

    on<SwitchForm>((event, emit) {
      emit(AuthState.initial());
      if (isSignUp) {
        authScreenNotifier.value = AuthScreenType.login;
      } else if (isLogin) {
        authScreenNotifier.value = AuthScreenType.signUp;
      }
    });

    on<ResetError>((event, emit) {
      emit(AuthState.initial());
    });
  }

  Future _handleAuth(UserCredential credential, BuildContext context,
      Emitter<AuthState> emit) async {
    if (credential.user != null) {
      emit(AuthState.success());
      await _loadData();
      if (context.mounted) {
        AppRoutes.goToHomeScreen(context);
      }
    }
  }

  Future _loadData() async => 5.delay();
}
