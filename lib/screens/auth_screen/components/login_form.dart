import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_screen/global/components/animated_button.dart';
import 'package:login_screen/screens/auth_screen/bloc/auth_bloc.dart';
import 'package:login_screen/screens/auth_screen/components/auth_button.dart';
import 'package:login_screen/utils/responsive_sizer.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class AuthForm extends StatelessWidget {
  final AuthScreenType authScreenType;
  AuthForm({
    super.key,
    required this.authScreenType,
  });

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool signUp = false;
    String mainButtonText = "", switchButtonText = "";

    if (authScreenType == AuthScreenType.signUp) {
      signUp = true;
      mainButtonText = 'signup'.i18n();
      switchButtonText = 'login'.i18n();
    } else {
      mainButtonText = 'login'.i18n();
      switchButtonText = 'signup'.i18n();
    }

    AuthBloc bloc = context.read<AuthBloc>();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.su,
          vertical: 30.su,
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (signUp) ...[
                  TextField(
                    controller: _nameController,
                    obscureText: false,
                    cursorColor: context.focusColor,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => resetError(context),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'name'.i18n(),
                      labelStyle: context.bodyMedium,
                    ),
                  ),
                  16.su.heightBox
                ],
                TextField(
                  controller: _emailController,
                  obscureText: false,
                  cursorColor: context.focusColor,
                  textInputAction: TextInputAction.next,
                  onChanged: (_) => resetError(context),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'email'.i18n(),
                    labelStyle: context.bodyMedium,
                  ),
                ),
                16.su.heightBox,
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  cursorColor: context.focusColor,
                  textInputAction: TextInputAction.done,
                  onChanged: (_) => resetError(context),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'password'.i18n(),
                    labelStyle: context.bodyMedium,
                  ),
                ),
                16.su.heightBox,
                BlocBuilder<AuthBloc, AuthState>(
                    bloc: bloc,
                    builder: (context, state) {
                      String text =
                          state.errorMessage ?? mainButtonText.toUpperCase();
                      bool disabled = state.errorMessage != null;

                      AuthButtonState authState;
                      if (state.authSuccess) {
                        authState = AuthButtonState.downloadingData;
                      } else if (state.errorMessage != null) {
                        authState = AuthButtonState.error;
                      } else if (state.isLoading) {
                        authState = AuthButtonState.authenticating;
                      } else {
                        authState = AuthButtonState.normal;
                      }
                      return AuthButton(
                        buttonText: text,
                        disabled: disabled,
                        authState: authState,
                        authDelay: bloc.authDelay,
                        onPressed: () {
                          bloc.add(
                            SubmitForm(
                              context: context,
                              name: _nameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );
                        },
                      );
                    }),
              ],
            ),
            SafeArea(
              top: true,
              child: BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (prev, cur) => prev.isLoading != cur.isLoading,
                builder: (context, state) {
                  return state.isLoading
                      ? const SizedBox.shrink()
                      : AnimatedButtonContainer(
                          onPressed: () {
                            context.read<AuthBloc>().add(SwitchForm());
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: 10.su),
                            child: Text(
                              switchButtonText,
                              style: context.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void resetError(context) {
    BlocProvider.of<AuthBloc>(context).add(ResetError());
  }
}

class LoginScreen extends AuthForm {
  LoginScreen({super.key}) : super(authScreenType: AuthScreenType.login);
}

class SignUpScreen extends AuthForm {
  SignUpScreen({super.key}) : super(authScreenType: AuthScreenType.signUp);
}
