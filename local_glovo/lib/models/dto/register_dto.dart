import 'dart:convert';

class RegisterDto {
	String? email;
	String? name;
	String? lastname;
	String? password;
	String? birthDate;

	RegisterDto({
		this.email, 
		this.name, 
		this.lastname, 
		this.password, 
		this.birthDate, 
	});

	factory RegisterDto.fromMap(Map<String, dynamic> data) => RegisterDto(
				email: data['email'] as String?,
				name: data['name'] as String?,
				lastname: data['lastname'] as String?,
				password: data['password'] as String?,
				birthDate: data['birthDate'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'email': email,
				'name': name,
				'lastname': lastname,
				'password': password,
				'birthDate': birthDate,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RegisterDto].
	factory RegisterDto.fromJson(String data) {
		return RegisterDto.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [RegisterDto] to a JSON string.
	String toJson() => json.encode(toMap());
}
