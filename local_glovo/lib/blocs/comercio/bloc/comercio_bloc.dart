import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:local_glovo/models/response/comercio_response.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository.dart';
import 'package:meta/meta.dart';

part 'comercio_event.dart';
part 'comercio_state.dart';

class ComercioBloc extends Bloc<ComercioEvent, ComercioState> {
  final ComercioRepository comercioRepository;
  ComercioBloc(this.comercioRepository) : super(ComercioInitial()) {
    on<ComercioList>(_onComercioList);
  }

  void _onComercioList(ComercioList event, Emitter<ComercioState> emit) async {
    try {
      final comercioList = await comercioRepository.listarComercios();
      emit(ComercioSuccess(comercioList));
    } catch (e) {
      emit(ComercioError(e.toString()));
    }
  }
}
