import 'package:local_glovo/models/response/favorito_resonse.dart';
import 'package:local_glovo/models/response/ver_favorito_response.dart';

abstract class FavoritoRepository {
  Future<FavoritoResponse> addFavorito();
  Future<VerFavoritoResponse> verFavorito();
}
