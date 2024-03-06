import 'dart:convert';

import 'package:local_glovo/models/response/favorito_resonse.dart';
import 'package:local_glovo/models/response/ver_favorito_response.dart';
import 'package:local_glovo/repositories/favorito/favorito_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

class FavoritoRepositoryImpl extends FavoritoRepository {
  final Client _httpClient = Client();

  @override
  Future<FavoritoResponse> addFavorito(String comercioId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    String? usuarioId = prefs.getString("usuarioId");

    final response = await _httpClient.post(
      Uri.parse(
          'http://10.0.2.2:9000/usuario/añadir/favorito/$usuarioId/$comercioId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 201) {
      print(response.statusCode);
      print('Response body: ${response.body}');
      final responseBody =
          FavoritoResponse.fromJson(json.decode(response.body));

      final content = responseBody;

      return content;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Response body: ${response.body}');
      throw Exception(
          'Failed to load detalles comercios. Status code: ${response.statusCode}');
    }
  }

  @override
  Future<VerFavoritoResponse> verFavorito() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    String? usuarioId = prefs.getString("usuarioId");

    final response = await _httpClient.get(
      Uri.parse('http://10.0.2.2:9000/usuario/ver/favorito/$usuarioId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      final responseBody =
          VerFavoritoResponse.fromJson(json.decode(response.body));

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
