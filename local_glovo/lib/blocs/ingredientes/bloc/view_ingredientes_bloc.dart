import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:local_glovo/models/response/comercio_details_response.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository.dart';
import 'package:meta/meta.dart';

part 'view_ingredientes_event.dart';
part 'view_ingredientes_state.dart';

class ViewIngredientesBloc
    extends Bloc<ViewIngredientesEvent, ViewIngredientesState> {
  final ComercioRepository comercioRepository;
  ViewIngredientesBloc(this.comercioRepository)
      : super(ViewIngredientesInitial()) {
    on<ViewIngredientesEvent>(_onIngredientesFetch);
  }

  void _onIngredientesFetch(
      ViewIngredientesEvent event, Emitter<ViewIngredientesState> emit) async {
    emit(ViewIngredientesLoading());
    try {
      final viewIngredientes =
          await comercioRepository.viewIngredientes(event.id);
      emit(IngredientesSucces(viewIngredientes));
    } catch (e) {
      emit(IngredientesError(e.toString()));
    }
  }
}
