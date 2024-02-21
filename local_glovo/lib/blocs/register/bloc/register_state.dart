part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class DoRegisterLoading extends RegisterState {}

class DoRegisterSuccess extends RegisterState {
  final RegisterResponse registerResponse;
  DoRegisterSuccess(this.registerResponse);
}

class DoRegisterError extends RegisterState {
  final String errorMessage;
  DoRegisterError(this.errorMessage);
}
