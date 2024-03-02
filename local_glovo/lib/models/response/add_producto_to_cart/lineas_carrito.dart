import 'dart:convert';

import 'producto.dart';

class LineasCarrito {
	String? id;
	Producto? producto;
	int? cantidad;
	int? total;

	LineasCarrito({this.id, this.producto, this.cantidad, this.total});

	factory LineasCarrito.fromMap(Map<String, dynamic> data) => LineasCarrito(
				id: data['id'] as String?,
				producto: data['producto'] == null
						? null
						: Producto.fromMap(data['producto'] as Map<String, dynamic>),
				cantidad: data['cantidad'] as int?,
				total: data['total'] as int?,
			);

	Map<String, dynamic> toMap() => {
				'id': id,
				'producto': producto?.toMap(),
				'cantidad': cantidad,
				'total': total,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LineasCarrito].
	factory LineasCarrito.fromJson(String data) {
		return LineasCarrito.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [LineasCarrito] to a JSON string.
	String toJson() => json.encode(toMap());
}
