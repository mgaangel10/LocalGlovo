import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:local_glovo/models/response/add_producto_to_cart/add_producto_to_cart.dart';
import 'package:local_glovo/repositories/carrito/carrito_repository.dart';
import 'package:local_glovo/ui/pages/error_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarritoRepositoryImpl extends CarritoRepository {
  final Client _httpClient = Client();

  @override
  Future<AddProductoToCart> addAlCarrito(String productoId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    String? id = prefs.getString("usuarioId");

    final response = await _httpClient.post(
      Uri.parse('http://10.0.2.2:9000/usuario/$id/agregar/carrito/$productoId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    print('usuarioId: $id');
    print('token: $token');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 201) {
      final responseBody = AddProductoToCart.fromJson(response.body);
      final content = responseBody;
      return content;
    } else {
      throw UnimplementedError('Failed to load carrito');
    }
  }

  @override
  Future<void> deleteProducto(String carritoId, String productoId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final response = await _httpClient.delete(
      Uri.parse(
          'http://10.0.2.2:9000/usuario/eliminar/producto/carrito/$carritoId/$productoId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 204) {
      return;
    } else {
      throw UnimplementedError('Failed to load delete');
    }
  }

  @override
  Future<AddProductoToCart> terminarCarrito(String carritoId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    final response = await _httpClient.post(
      Uri.parse('http://10.0.2.2:9000/usuario/terminar/carrito/$carritoId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    print('token: $token');
    print('carritoId:$carritoId');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 201) {
      final responseBody = AddProductoToCart.fromJson(response.body);
      final content = responseBody;
      return content;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Response body: ${response.body}');
      throw UnimplementedError('Failed to load carrito');
    }
  }

  @override
  Future<AddProductoToCart> verCarritoid(
      BuildContext context, CarritoRepository carritoRepository) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      String? carritoId = prefs.getString("carritoId");

      final response = await _httpClient.get(
        Uri.parse('http://10.0.2.2:9000/usuario/buscar/carrito/$carritoId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      print('token: $token');
      print('carritoId:$carritoId');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final responseBody = AddProductoToCart.fromJson(response.body);
        final content = responseBody;
        return content;
      } else {
        print('Request failed with status: ${response.statusCode}.');
        print('Response body: ${response.body}');
        throw Exception('Tu carrito esta vacio');
      }
    } catch (e) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ErrorPage(
              carritoRepository: carritoRepository,
              errorMessage: e.toString(),
            ),
          ));
      throw Exception('Tu carrito esta vacio');
    }
  }
}
