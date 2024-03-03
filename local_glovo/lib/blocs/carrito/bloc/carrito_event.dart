part of 'carrito_bloc.dart';

@immutable
sealed class CarritoEvent {
  late final String carritoId;
  late final String productoId;
}

final class CarritoItem extends CarritoEvent {
  final String productoId;
  CarritoItem({required this.productoId});
}

final class CArritoDeleteItem extends CarritoEvent {
  final String carritoId;
  final String productoId;

  CArritoDeleteItem({required this.carritoId, required this.productoId});
}

final class CarritoTerminadoItem extends CarritoEvent {
  final String carritoId;
  CarritoTerminadoItem({required this.carritoId});
}
