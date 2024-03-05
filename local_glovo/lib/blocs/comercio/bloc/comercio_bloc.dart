import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:local_glovo/models/response/comercio_response.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'comercio_event.dart';
part 'comercio_state.dart';

class ComercioBloc extends Bloc<ComercioEvent, ComercioState> {
  final ComercioRepository comercioRepository;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  ComercioBloc(this.comercioRepository) : super(ComercioInitial()) {
    on<ComercioList>(_onComercioList);
    on<ComercioCategoriasItem>(_onComercioCategoriasFetch);
  }

  void _onComercioList(ComercioList event, Emitter<ComercioState> emit) async {
    final SharedPreferences preferences = await _prefs;
    try {
      final comercioList = await comercioRepository.listarComercios();
      preferences.setString('carritoId', comercioList[0].id!);
      emit(ComercioSuccess(comercioList));
    } catch (e) {
      emit(ComercioError(e.toString()));
    }
  }

  void _onComercioCategoriasFetch(
      ComercioCategoriasItem event, Emitter<ComercioState> emit) async {
    emit(ComercioLoading());
    final SharedPreferences preferences = await _prefs;
    try {
      final comercioResponse =
          await comercioRepository.filtrarCategorias(event.categorias);
      print(comercioResponse);
      emit(ComercioCategoriaSucess(comercioResponse));
    } catch (e) {
      emit(ComercioError(e.toString()));
    }
  }
}
