import 'dart:convert';

import 'package:http/http.dart';
import 'package:local_glovo/models/response/add_producto_to_cart/add_producto_to_cart.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarritoRepositoryImpl extends CarritoRepository {
  final Client _httpClient = Client();

  @override
  Future<AddProductoToCart> addAlCarrito(
      String usuarioId, String productoId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    String? id = prefs.getString("usuarioId");
    usuarioId = id!;

    final response = await _httpClient.post(
      Uri.parse(
          'http://localhost:9000/usuario/$usuarioId/agregar/carrito/$productoId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    print('usuarioId: $usuarioId');
    print('token: $token');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 201) {
      final responseBody =
          AddProductoToCart.fromJson(json.decode(response.body));
      final content = responseBody;
      return content;
    } else {
      throw UnimplementedError('Failed to load comercios');
    }
  }
}
