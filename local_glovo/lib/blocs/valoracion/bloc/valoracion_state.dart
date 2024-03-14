part of 'valoracion_bloc.dart';

@immutable
sealed class ValoracionState {}

final class ValoracionInitial extends ValoracionState {}

final class ValoracionLoading extends ValoracionState {}

final class ValoracionSucess extends ValoracionInitial {
  final ValoracionResponse valoracionResponse;
  ValoracionSucess(this.valoracionResponse);
}

final class ValoracionError extends ValoracionInitial {
  final String error;
  ValoracionError(this.error);
}
