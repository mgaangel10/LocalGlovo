import 'dart:async';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ComercioRepository comercioRepository;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  ImageBloc(this.comercioRepository) : super(ImageInitial()) {
    on<VerImageItem>(_onVerImageFetch);
  }

  void _onVerImageFetch(VerImageItem event, Emitter<ImageState> emit) async {
    emit(ImageLoading());
    try {
      final imageResponse =
          await comercioRepository.downloadFile(event.fileName);
      emit(VerImageSucces(imageResponse));
    } catch (e) {
      emit(VerImageError(e.toString()));
    }
  }
}
