part of 'valoracion_bloc.dart';

@immutable
sealed class ValoracionEvent {
  late String comercioId;
  late double valoracion;
}

final class ValoracionItem extends ValoracionEvent {
  final String comercioId;
  final double valoracion;
  ValoracionItem({required this.valoracion, required this.comercioId});
}
