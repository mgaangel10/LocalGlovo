part of 'comercio_details_bloc.dart';

@immutable
sealed class ComercioDetailsEvent {
  late final String comercioId;
}

final class ComercioDetailsItem extends ComercioDetailsEvent {
  final String comercioId;
  ComercioDetailsItem({required this.comercioId});
}
