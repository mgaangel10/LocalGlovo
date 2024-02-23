import 'package:local_glovo/models/response/comercio_details_response.dart';
import 'package:local_glovo/models/response/comercio_response.dart';

abstract class ComercioRepository {
  Future<List<Content>> listarComercios();
  Future<ComercioDetailsResponse> comercioDetalles(String id);
}
