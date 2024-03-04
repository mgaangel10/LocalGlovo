import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:local_glovo/models/dto/login_dto.dart';
import 'package:local_glovo/models/response/detalles_usuario_response.dart';
import 'package:local_glovo/models/response/login_response.dart';
import 'package:local_glovo/models/response/register_response.dart';
import 'package:local_glovo/repositories/auth/auth_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  LoginBloc(this.authRepository) : super(LoginInitial()) {
    on<DoLoginEvent>(_doLogin);
    on<DetallesUsuarioItem>(_onDetallesFetch);
  }

  void _doLogin(DoLoginEvent event, Emitter<LoginState> emit) async {
    emit(DoLoginLoading());
    final SharedPreferences preferences = await _prefs;

    try {
      final LoginDto loginDto =
          LoginDto(email: event.email, password: event.password);
      final response = await authRepository.login(loginDto);
      preferences.setString('token', response.token!);
      preferences.setString('usuarioId', response.id!);
      emit(DoLoginSucces(response));
      return;
    } on Exception catch (e) {
      emit(DoLoginError(e.toString()));
    }
  }

  void _onDetallesFetch(
      DetallesUsuarioItem event, Emitter<LoginState> emit) async {
    emit(DoLoginLoading());
    final SharedPreferences preferences = await _prefs;
    try {
      final detalles = await authRepository.verPerfil();
      print(detalles);
      emit(DetallesUsuarioSucess(detalles));
    } catch (e) {
      emit(DoLoginError(e.toString()));
    }
  }
}
