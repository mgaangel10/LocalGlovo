part of 'view_ingredientes_bloc.dart';

@immutable
sealed class ViewIngredientesEvent {
  late final String id;
}

final class IngredientesItem extends ViewIngredientesEvent {
  final String id;
  IngredientesItem({required this.id});
}
