import 'dart:convert';

import 'package:http/http.dart';
import 'package:local_glovo/models/response/comercio_details_response.dart';
import 'package:local_glovo/models/response/comercio_response.dart';
import 'package:local_glovo/repositories/comercio/comercio_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComercioRepositoryImpl extends ComercioRepository {
  final Client _httpClient = Client();

  @override
  Future<List<Content>> listarComercios() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    final response = await _httpClient.get(
      Uri.parse('http://localhost:9000/usuario/listar/comercios'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      final responseBody =
          ComercioResponse.fromJson(json.decode(response.body));
      final content = responseBody.content!;
      return content;
    } else {
      throw UnimplementedError('Failed to load comercios');
    }
  }

  @override
  Future<ComercioDetailsResponse> comercioDetalles(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final response = await _httpClient.get(
      Uri.parse('http://localhost:9000/usuario/buscar/id/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      final responseBody =
          ComercioDetailsResponse.fromJson(json.decode(response.body));

      final content = responseBody;

      return content;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Response body: ${response.body}');
      throw UnimplementedError('Failed to load detalles comercios');
    }
  }

  @override
  Future<Productos> viewIngredientes(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final response = await _httpClient.get(
      Uri.parse('http://localhost:9000/usuario/productos/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      final responseBody = Productos.fromJson(json.decode(response.body));

      final content = responseBody;

      return content;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Response body: ${response.body}');
      throw UnimplementedError('Failed to load detalles comercios');
    }
  }
}
