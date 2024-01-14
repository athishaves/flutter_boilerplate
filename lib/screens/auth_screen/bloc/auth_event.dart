part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignUpEvent extends AuthEvent {
  final String email, password, name;
  final BuildContext context;
  SignUpEvent({
    required this.email,
    required this.password,
    required this.name,
    required this.context,
  });
}

class LogInEvent extends AuthEvent {
  final String email, password;
  final BuildContext context;
  LogInEvent({
    required this.email,
    required this.password,
    required this.context,
  });
}

class SwitchForm extends AuthEvent {}

class SubmitForm extends AuthEvent {
  final String email, password, name;
  final BuildContext context;
  SubmitForm({
    required this.email,
    required this.password,
    required this.name,
    required this.context,
  });
}

class ResetError extends AuthEvent {}
