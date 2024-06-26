import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:local_glovo/models/response/add_producto_to_cart/add_producto_to_cart.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'carrito_event.dart';
part 'carrito_state.dart';

class CarritoBloc extends Bloc<CarritoEvent, CarritoState> {
  final CarritoRepository carritoRepository;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  CarritoBloc(this.carritoRepository) : super(CarritoInitial()) {
    on<CarritoItem>(_onCarritoFetch);
    on<CArritoDeleteItem>(_onCarritoDeteleFetch);
    on<CarritoTerminadoItem>(_onCarritoTerminadoFetch);
    on<VerCarritoItem>(_onVerCarritoFetch);
  }

  void _onCarritoFetch(CarritoEvent event, Emitter<CarritoState> emit) async {
    emit(CarritoLoading());
    final SharedPreferences preferences = await _prefs;
    try {
      final carritoResponse =
          await carritoRepository.addAlCarrito(event.productoId);

      print('usuarioId guardado: ${carritoResponse.usuario!.id!}');
      print('carritoID: ${carritoResponse.id!}');
      preferences.setString('carritoId', carritoResponse.id!);
      emit(CarritoSucces(carritoResponse));
    } catch (e) {
      emit(CarritoError(e.toString()));
    }
  }

  void _onCarritoDeteleFetch(
      CarritoEvent event, Emitter<CarritoState> emit) async {
    emit(CarritoLoading());
    final SharedPreferences preferences = await _prefs;
    try {
      final carritoDeleteResponse = await carritoRepository.deleteProducto(
          event.carritoId, event.productoId);
      emit(CarritoDeleteSucess());
    } catch (e) {
      emit(CarritoError(e.toString()));
    }
  }

  void _onCarritoTerminadoFetch(
      CarritoTerminadoItem event, Emitter<CarritoState> emit) async {
    emit(CarritoLoading());
    final SharedPreferences preferences = await _prefs;
    try {
      final carritoTerminadoResponse =
          await carritoRepository.terminarCarrito(event.carritoId);

      emit(CarritoTerminadoSucess(carritoTerminadoResponse));
    } catch (e) {
      emit(CarritoError(e.toString()));
    }
  }

  void _onVerCarritoFetch(
      VerCarritoItem event, Emitter<CarritoState> emit) async {
    emit(CarritoLoading());
    final SharedPreferences preferences = await _prefs;
    try {
      final verCarrito = await carritoRepository.verCarritoid(
          event.context, event.carritoRepository);
      emit(VerCarritoSucess(verCarrito));
    } catch (e) {
      emit(CarritoError(e.toString()));
    }
  }
}
