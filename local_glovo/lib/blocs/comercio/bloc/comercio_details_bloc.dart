import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:local_glovo/models/response/comercio_details_response.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository.dart';
import 'package:meta/meta.dart';

part 'comercio_details_event.dart';
part 'comercio_details_state.dart';

class ComercioDetailsBloc
    extends Bloc<ComercioDetailsEvent, ComercioDetailsState> {
  final ComercioRepository comercioRepository;
  ComercioDetailsBloc(this.comercioRepository)
      : super(ComercioDetailsInitial()) {
    on<ComercioDetailsEvent>(_onComercioDetailsFecth);
  }

  void _onComercioDetailsFecth(
      ComercioDetailsEvent event, Emitter<ComercioDetailsState> emit) async {
    emit(ComercioDetailsLoading());
    try {
      final comercioDetailsResponse =
          await comercioRepository.comercioDetalles(event.comercioId);
      emit(ComercioDetailsSucces(comercioDetailsResponse));
    } catch (e) {
      print('Error: $e');
      emit(ComercioDetailsError(e.toString()));
    }
  }
}
