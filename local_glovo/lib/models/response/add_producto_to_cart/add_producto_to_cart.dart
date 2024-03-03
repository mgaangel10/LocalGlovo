import 'dart:convert';
import 'dart:ffi';

import 'lineas_carrito.dart';
import 'usuario.dart';

class AddProductoToCart {
  String? id;
  int? cantidad;
  double? total;
  List<LineasCarrito>? lineasCarrito;
  Usuario? usuario;
  String? estado;

  AddProductoToCart({
    this.id,
    this.cantidad,
    this.total,
    this.lineasCarrito,
    this.usuario,
    this.estado,
  });

  factory AddProductoToCart.fromMap(Map<String, dynamic> data) {
    return AddProductoToCart(
      id: data['id'] as String?,
      cantidad: data['cantidad'] as int?,
      total: data['total'] != null ? data['total'].toDouble() : null,
      lineasCarrito: (data['lineasCarrito'] as List<dynamic>?)
              ?.map((e) => LineasCarrito.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      usuario: data['usuario'] == null
          ? null
          : Usuario.fromMap(data['usuario'] as Map<String, dynamic>),
      estado: data['estado'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'cantidad': cantidad,
        'total': total,
        'lineasCarrito': lineasCarrito?.map((e) => e.toMap()).toList(),
        'usuario': usuario?.toMap(),
        'estado': estado,
      };

  factory AddProductoToCart.fromJson(String data) {
    return AddProductoToCart.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
