part of 'comercio_details_bloc.dart';

@immutable
sealed class ComercioDetailsState {}

final class ComercioDetailsInitial extends ComercioDetailsState {}

final class ComercioDetailsSucces extends ComercioDetailsInitial {
  final ComercioDetailsResponse comercio;
  ComercioDetailsSucces(this.comercio);
}

final class ComercioDetailsError extends ComercioDetailsInitial {
  final String error;
  ComercioDetailsError(this.error);
}
