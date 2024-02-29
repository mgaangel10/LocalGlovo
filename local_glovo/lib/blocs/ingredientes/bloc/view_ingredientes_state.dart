part of 'view_ingredientes_bloc.dart';

@immutable
sealed class ViewIngredientesState {}

final class ViewIngredientesInitial extends ViewIngredientesState {}

final class ViewIngredientesLoading extends ViewIngredientesState {}

final class IngredientesSucces extends ViewIngredientesState {
  final Productos ingredientes;
  IngredientesSucces(this.ingredientes);
}

final class IngredientesError extends ViewIngredientesState {
  final String error;
  IngredientesError(this.error);
}
