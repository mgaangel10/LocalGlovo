import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:local_glovo/models/response/favorito_resonse.dart';
import 'package:local_glovo/models/response/ver_favorito_response.dart';
import 'package:local_glovo/repositories/favorito/favorito_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favorito_event.dart';
part 'favorito_state.dart';

class FavoritoBloc extends Bloc<FavoritoEvent, FavoritoState> {
  final FavoritoRepository favoritoRepository;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  FavoritoBloc(this.favoritoRepository) : super(FavoritoInitial()) {
    on<AddFavoritoItem>(_onAddFavoritoFetch);
    on<VerFavoritoItem>(_onVerFavoritoFetch);
    on<DeleteFavoritoItem>(_onDeleteFavoirtoFetch);
  }

  void _onAddFavoritoFetch(
      AddFavoritoItem event, Emitter<FavoritoState> emit) async {
    emit(FavoritoLoading());
    final SharedPreferences preferences = await _prefs;
    try {
      final favoritoResponse =
          await favoritoRepository.addFavorito(event.comercioId);
      print(favoritoResponse);
      emit(AddfavoritoSucess(favoritoResponse));
    } catch (e) {
      emit(FavoritoError(e.toString()));
    }
  }

  void _onVerFavoritoFetch(
      VerFavoritoItem event, Emitter<FavoritoState> emit) async {
    emit(FavoritoLoading());
    final SharedPreferences preferences = await _prefs;
    try {
      final favoritoResponse = await favoritoRepository.verFavorito();
      emit(VerFavoritoSucess(favoritoResponse));
    } catch (e) {
      emit(FavoritoError(e.toString()));
    }
  }

  void _onDeleteFavoirtoFetch(
      DeleteFavoritoItem event, Emitter<FavoritoState> emit) async {
    emit(FavoritoLoading());
    final SharedPreferences preferences = await _prefs;
    try {
      final favoritoResponse =
          await favoritoRepository.quitarFavorito(event.comercioId);
      emit(DeleteFavoirtoSucess());
    } catch (e) {
      emit(FavoritoError(e.toString()));
    }
  }
}
