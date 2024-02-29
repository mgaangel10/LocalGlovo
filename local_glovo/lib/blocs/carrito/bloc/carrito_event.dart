part of 'carrito_bloc.dart';

@immutable
sealed class CarritoEvent {
  late final String usuarioId;
  late final String productoId;
}

final class CarritoItem extends CarritoEvent {
  final String usuarioId;
  final String productoId;
  CarritoItem({required this.usuarioId, required this.productoId});
}
