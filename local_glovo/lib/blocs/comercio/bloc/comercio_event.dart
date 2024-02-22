part of 'comercio_bloc.dart';

@immutable
sealed class ComercioEvent {}

final class ComercioFetchEvents extends ComercioEvent {}

class ComercioList extends ComercioEvent {
  ComercioList();
}
