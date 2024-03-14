import 'dart:convert';

class Id {
	String? usuarioId;
	String? comercioId;

	Id({this.usuarioId, this.comercioId});

	factory Id.fromMap(Map<String, dynamic> data) => Id(
				usuarioId: data['usuarioId'] as String?,
				comercioId: data['comercioId'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'usuarioId': usuarioId,
				'comercioId': comercioId,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Id].
	factory Id.fromJson(String data) {
		return Id.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Id] to a JSON string.
	String toJson() => json.encode(toMap());
}
