part of 'image_bloc.dart';

@immutable
sealed class ImageState {}

final class ImageInitial extends ImageState {}

final class ImageLoading extends ImageState {}

final class VerImageSucces extends ImageState {
  final Uint8List uint8list1;
  VerImageSucces(this.uint8list1);

  @override
  List<Object?> get props => [uint8list1];
}

final class VerImageError extends ImageState {
  final String error;
  VerImageError(this.error);

  @override
  List<Object?> get props => [error];
}
