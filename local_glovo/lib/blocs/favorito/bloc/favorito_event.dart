part of 'favorito_bloc.dart';

@immutable
sealed class FavoritoEvent {}

final class AddFavoritoItem extends FavoritoEvent {
  AddFavoritoItem();
}

final class VerFavoritoItem extends FavoritoEvent {
  VerFavoritoItem();
}
