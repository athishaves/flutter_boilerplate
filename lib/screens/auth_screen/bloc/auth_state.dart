part of 'auth_bloc.dart';

class AuthState {
  final String? errorMessage;
  final bool isLoading, authSuccess;
  AuthState({
    required this.errorMessage,
    required this.isLoading,
    this.authSuccess = false,
  });

  factory AuthState.initial() {
    return AuthState(errorMessage: null, isLoading: false);
  }

  factory AuthState.error({required String error}) {
    return AuthState(errorMessage: error, isLoading: false);
  }

  factory AuthState.loading() {
    return AuthState(errorMessage: null, isLoading: true);
  }

  factory AuthState.success() {
    return AuthState(errorMessage: null, isLoading: true, authSuccess: true);
  }
}
