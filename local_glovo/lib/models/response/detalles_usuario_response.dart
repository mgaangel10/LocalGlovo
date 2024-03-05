class DetallesUsuarioResponse {
  String? id;
  String? username;
  String? name;
  String? lastName;
  String? phoneNumber;
  String? fotoUrl;

  DetallesUsuarioResponse(
      {this.id,
      this.username,
      this.name,
      this.lastName,
      this.phoneNumber,
      this.fotoUrl});

  DetallesUsuarioResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    fotoUrl = json['fotoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['phoneNumber'] = this.phoneNumber;
    data['fotoUrl'] = this.fotoUrl;
    return data;
  }
}
