import 'dart:convert';

import 'id.dart';

class Valoracion {
	Id? id;
	double? rating;

	Valoracion({this.id, this.rating});

	factory Valoracion.fromMap(Map<String, dynamic> data) => Valoracion(
				id: data['id'] == null
						? null
						: Id.fromMap(data['id'] as Map<String, dynamic>),
				rating: (data['rating'] as num?)?.toDouble(),
			);

	Map<String, dynamic> toMap() => {
				'id': id?.toMap(),
				'rating': rating,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Valoracion].
	factory Valoracion.fromJson(String data) {
		return Valoracion.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Valoracion] to a JSON string.
	String toJson() => json.encode(toMap());
}
