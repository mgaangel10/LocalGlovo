part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class DoRegisterEvent extends RegisterEvent {
  final String email;
  final String name;
  final String lastname;
  final String paswsword;
  final String birthDate;
  DoRegisterEvent(
      this.email, this.name, this.lastname, this.paswsword, this.birthDate);
}
