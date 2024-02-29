import 'dart:convert';

class Producto {
	String? id;
	String? imagen;
	String? name;
	int? precio;
	bool? disponible;
	List<dynamic>? ingredientes;

	Producto({
		this.id, 
		this.imagen, 
		this.name, 
		this.precio, 
		this.disponible, 
		this.ingredientes, 
	});

	factory Producto.fromMap(Map<String, dynamic> data) => Producto(
				id: data['id'] as String?,
				imagen: data['imagen'] as String?,
				name: data['name'] as String?,
				precio: data['precio'] as int?,
				disponible: data['disponible'] as bool?,
				ingredientes: data['ingredientes'] as List<dynamic>?,
			);

	Map<String, dynamic> toMap() => {
				'id': id,
				'imagen': imagen,
				'name': name,
				'precio': precio,
				'disponible': disponible,
				'ingredientes': ingredientes,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Producto].
	factory Producto.fromJson(String data) {
		return Producto.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Producto] to a JSON string.
	String toJson() => json.encode(toMap());
}
