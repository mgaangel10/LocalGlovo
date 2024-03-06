part of 'favorito_bloc.dart';

@immutable
sealed class FavoritoEvent {
  late String comercioId;
}

final class AddFavoritoItem extends FavoritoEvent {
  final String comercioId;
  AddFavoritoItem({required this.comercioId});
}

final class VerFavoritoItem extends FavoritoEvent {
  VerFavoritoItem();
}
