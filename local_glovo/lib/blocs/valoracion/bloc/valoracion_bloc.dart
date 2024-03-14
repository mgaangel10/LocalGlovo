import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:local_glovo/models/response/valoracion_response/valoracion.dart';
import 'package:local_glovo/models/response/valoracion_response/valoracion_response.dart';
import 'package:local_glovo/repositories/valoracion/valoracion_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'valoracion_event.dart';
part 'valoracion_state.dart';

class ValoracionBloc extends Bloc<ValoracionEvent, ValoracionState> {
  final ValoracionRepository valoracionRepository;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  ValoracionBloc(this.valoracionRepository) : super(ValoracionInitial()) {
    on<ValoracionEvent>(_onValoracionFetch);
  }

  void _onValoracionFetch(
      ValoracionEvent event, Emitter<ValoracionState> emit) async {
    emit(ValoracionLoading());
    final SharedPreferences preferences = await _prefs;
    try {
      final valoracionResponse = await valoracionRepository.addValoracion(
          event.valoracion, event.comercioId);
      print(valoracionResponse);
      emit(ValoracionSucess(valoracionResponse));
    } catch (e) {
      emit(ValoracionError(e.toString()));
    }
  }
}
