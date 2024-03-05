part of 'favorito_bloc.dart';

@immutable
sealed class FavoritoState {}

final class FavoritoInitial extends FavoritoState {}

final class FavoritoLoading extends FavoritoState {}

final class AddfavoritoSucess extends FavoritoInitial {
  final FavoritoResponse favoritoResponse;
  AddfavoritoSucess(this.favoritoResponse);
}

final class VerFavoritoSucess extends FavoritoInitial {
  final VerFavoritoResponse verFavoritoResponse;
  VerFavoritoSucess(this.verFavoritoResponse);
}

final class FavoritoError extends FavoritoInitial {
  final String error;
  FavoritoError(this.error);
}
