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

final class DeleteFavoritoItem extends FavoritoEvent {
  final String comercioId;
  DeleteFavoritoItem({required this.comercioId});
}
