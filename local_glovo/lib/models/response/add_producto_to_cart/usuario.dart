import 'dart:convert';

import 'authority.dart';

class Usuario {
	String? id;
	String? email;
	String? username;
	String? password;
	String? name;
	String? lastName;
	String? phoneNumber;
	dynamic birthDate;
	dynamic fotoUrl;
	bool? accountNonExpired;
	bool? accountNonLocked;
	bool? credentialsNonExpired;
	bool? enabled;
	List<String>? roles;
	dynamic createdAt;
	dynamic lastPasswordChangeAt;
	List<dynamic>? usuarios;
	List<dynamic>? inChargeof;
	List<Authority>? authorities;

	Usuario({
		this.id, 
		this.email, 
		this.username, 
		this.password, 
		this.name, 
		this.lastName, 
		this.phoneNumber, 
		this.birthDate, 
		this.fotoUrl, 
		this.accountNonExpired, 
		this.accountNonLocked, 
		this.credentialsNonExpired, 
		this.enabled, 
		this.roles, 
		this.createdAt, 
		this.lastPasswordChangeAt, 
		this.usuarios, 
		this.inChargeof, 
		this.authorities, 
	});

	factory Usuario.fromMap(Map<String, dynamic> data) => Usuario(
				id: data['id'] as String?,
				email: data['email'] as String?,
				username: data['username'] as String?,
				password: data['password'] as String?,
				name: data['name'] as String?,
				lastName: data['lastName'] as String?,
				phoneNumber: data['phoneNumber'] as String?,
				birthDate: data['birthDate'] as dynamic,
				fotoUrl: data['fotoUrl'] as dynamic,
				accountNonExpired: data['accountNonExpired'] as bool?,
				accountNonLocked: data['accountNonLocked'] as bool?,
				credentialsNonExpired: data['credentialsNonExpired'] as bool?,
				enabled: data['enabled'] as bool?,
				roles: data['roles'] as List<String>?,
				createdAt: data['createdAt'] as dynamic,
				lastPasswordChangeAt: data['lastPasswordChangeAt'] as dynamic,
				usuarios: data['usuarios'] as List<dynamic>?,
				inChargeof: data['inChargeof'] as List<dynamic>?,
				authorities: (data['authorities'] as List<dynamic>?)
						?.map((e) => Authority.fromMap(e as Map<String, dynamic>))
						.toList(),
			);

	Map<String, dynamic> toMap() => {
				'id': id,
				'email': email,
				'username': username,
				'password': password,
				'name': name,
				'lastName': lastName,
				'phoneNumber': phoneNumber,
				'birthDate': birthDate,
				'fotoUrl': fotoUrl,
				'accountNonExpired': accountNonExpired,
				'accountNonLocked': accountNonLocked,
				'credentialsNonExpired': credentialsNonExpired,
				'enabled': enabled,
				'roles': roles,
				'createdAt': createdAt,
				'lastPasswordChangeAt': lastPasswordChangeAt,
				'usuarios': usuarios,
				'inChargeof': inChargeof,
				'authorities': authorities?.map((e) => e.toMap()).toList(),
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Usuario].
	factory Usuario.fromJson(String data) {
		return Usuario.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Usuario] to a JSON string.
	String toJson() => json.encode(toMap());
}
