part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class DoLoginLoading extends LoginState {}

final class DoLoginSucces extends LoginState {
  final LoginResponse email;
  DoLoginSucces(this.email);
}

final class DoLoginError extends LoginState {
  final String errorMensaje;
  DoLoginError(this.errorMensaje);
}
