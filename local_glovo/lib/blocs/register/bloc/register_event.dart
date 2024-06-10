part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class DoRegisterEvent extends RegisterEvent {
  final String email;
  final String name;
  final String lastName;
  final String paswsword;
  final String phoneNumber;
  DoRegisterEvent(
      this.email, this.name, this.lastName, this.paswsword, this.phoneNumber);
}
