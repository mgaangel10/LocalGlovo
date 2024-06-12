part of 'comercio_bloc.dart';

@immutable
sealed class ComercioEvent {
  late final String categorias;
}

final class ComercioFetchEvents extends ComercioEvent {}

class ComercioList extends ComercioEvent {
  final int page;
  ComercioList({required this.page});
}

class ComercioDetalles extends ComercioEvent {
  final String comercioId;
  ComercioDetalles(this.comercioId);
}

class ComercioCategoriasItem extends ComercioEvent {
  final String categorias;
  ComercioCategoriasItem({required this.categorias});
}

class ComercioFetchMore extends ComercioEvent {
  final int page;
  ComercioFetchMore({required this.page});
}
