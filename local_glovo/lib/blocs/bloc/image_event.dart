part of 'image_bloc.dart';

@immutable
sealed class ImageEvent {}

final class VerImageItem extends ImageEvent {
  final String fileName;
  VerImageItem({required this.fileName});

  @override
  List<Object?> get props => [fileName];
}
