import 'dart:convert';

import 'package:http/http.dart';
import 'package:local_glovo/models/response/valoracion_response/valoracion.dart';
import 'package:local_glovo/models/response/valoracion_response/valoracion_response.dart';
import 'package:local_glovo/repositories/valoracion/valoracion_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ValoracioRespositoryImpl extends ValoracionRepository {
  final Client _httpClient = Client();

  @override
  Future<ValoracionResponse> addValoracion(
      double rating, String comercioId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    String? usuarioId = prefs.getString("usuarioId");

    final response = await _httpClient.post(
      Uri.parse(
          'http://10.0.2.2:9000/usuario/add/valoracion/$usuarioId/$comercioId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: rating.toString(),
    );
    print(response.body);
    if (response.statusCode == 201) {
      print(response.statusCode);
      print('Response body: ${response.body}');
      final responseBody =
          ValoracionResponse.fromJson(json.decode(response.body));

      final content = responseBody;

      return content;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Response body: ${response.body}');
      throw Exception(
          'Failed to load detalles comercios. Status code: ${response.statusCode}');
    }
  }
}
