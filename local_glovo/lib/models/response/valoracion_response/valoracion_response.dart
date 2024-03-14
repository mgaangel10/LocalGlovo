import 'dart:convert';

import 'producto.dart';
import 'valoracion.dart';

class ValoracionResponse {
	String? id;
	String? imagen;
	String? name;
	double? latitud;
	double? longitud;
	double? rating;
	String? nameDirection;
	List<String>? categorias;
	List<Producto>? productos;
	List<dynamic>? favoritoList;
	List<Valoracion>? valoracions;

	ValoracionResponse({
		this.id, 
		this.imagen, 
		this.name, 
		this.latitud, 
		this.longitud, 
		this.rating, 
		this.nameDirection, 
		this.categorias, 
		this.productos, 
		this.favoritoList, 
		this.valoracions, 
	});

	factory ValoracionResponse.fromMap(Map<String, dynamic> data) {
		return ValoracionResponse(
			id: data['id'] as String?,
			imagen: data['imagen'] as String?,
			name: data['name'] as String?,
			latitud: (data['latitud'] as num?)?.toDouble(),
			longitud: (data['longitud'] as num?)?.toDouble(),
			rating: (data['rating'] as num?)?.toDouble(),
			nameDirection: data['nameDirection'] as String?,
			categorias: data['categorias'] as List<String>?,
			productos: (data['productos'] as List<dynamic>?)
						?.map((e) => Producto.fromMap(e as Map<String, dynamic>))
						.toList(),
			favoritoList: data['favoritoList'] as List<dynamic>?,
			valoracions: (data['valoracions'] as List<dynamic>?)
						?.map((e) => Valoracion.fromMap(e as Map<String, dynamic>))
						.toList(),
		);
	}



	Map<String, dynamic> toMap() => {
				'id': id,
				'imagen': imagen,
				'name': name,
				'latitud': latitud,
				'longitud': longitud,
				'rating': rating,
				'nameDirection': nameDirection,
				'categorias': categorias,
				'productos': productos?.map((e) => e.toMap()).toList(),
				'favoritoList': favoritoList,
				'valoracions': valoracions?.map((e) => e.toMap()).toList(),
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ValoracionResponse].
	factory ValoracionResponse.fromJson(String data) {
		return ValoracionResponse.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [ValoracionResponse] to a JSON string.
	String toJson() => json.encode(toMap());
}
