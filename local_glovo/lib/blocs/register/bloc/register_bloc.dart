import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:local_glovo/models/dto/register_dto.dart';
import 'package:local_glovo/models/response/register_response.dart';
import 'package:local_glovo/repositories/auth/auth_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  RegisterBloc(this.authRepository) : super(RegisterInitial()) {
    on<DoRegisterEvent>(_doRegister);
  }

  void _doRegister(DoRegisterEvent event, Emitter<RegisterState> emit) async {
    emit(DoRegisterLoading());
    final SharedPreferences preferences = await _prefs;
    try {
      final RegisterDto registerDto = RegisterDto(
        email: event.email,
        name: event.name,
        lastname: event.lastname,
        password: event.paswsword,
        birthDate: event.birthDate,
      );
      final response = await authRepository.register(registerDto);
      emit(DoRegisterSuccess(response));
      return;
    } on Exception catch (e) {
      emit(DoRegisterError(e.toString()));
    }
  }
}
