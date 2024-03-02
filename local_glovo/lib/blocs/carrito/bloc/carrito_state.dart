part of 'carrito_bloc.dart';

@immutable
sealed class CarritoState {}

final class CarritoInitial extends CarritoState {}

final class CarritoLoading extends CarritoState {}

final class CarritoSucces extends CarritoInitial {
  final AddProductoToCart carrito;
  CarritoSucces(this.carrito);
}

final class CarritoDeleteSucess extends CarritoInitial {
  CarritoDeleteSucess();
}

final class CarritoError extends CarritoInitial {
  final String error;

  CarritoError(this.error);
}
