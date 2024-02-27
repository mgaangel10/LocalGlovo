part of 'comercio_bloc.dart';

@immutable
sealed class ComercioState {
  final List<Content> list;
  const ComercioState({
    this.list = const <Content>[],
  });
}

final class ComercioInitial extends ComercioState {}

final class ComercioSuccess extends ComercioState {
  final List<Content> comercioList;
  const ComercioSuccess(this.comercioList);
}

final class ComercioError extends ComercioState {
  final String errorMensaje;
  const ComercioError(this.errorMensaje);
}

final class ComercioDetallesClick extends ComercioState {
  final String coemercioId;
  const ComercioDetallesClick(this.coemercioId);
}
