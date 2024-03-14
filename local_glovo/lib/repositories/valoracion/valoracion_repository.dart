import 'package:local_glovo/models/response/valoracion_response/valoracion.dart';
import 'package:local_glovo/models/response/valoracion_response/valoracion_response.dart';

abstract class ValoracionRepository {
  Future<ValoracionResponse> addValoracion(double rating, String comercioId);
}
