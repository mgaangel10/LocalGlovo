class FavoritoResponse {
  Id? id;

  FavoritoResponse({this.id});

  FavoritoResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? new Id.fromJson(json['id']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data['id'] = this.id!.toJson();
    }
    return data;
  }
}

class Id {
  String? usuarioId;
  String? comercioId;

  Id({this.usuarioId, this.comercioId});

  Id.fromJson(Map<String, dynamic> json) {
    usuarioId = json['usuarioId'];
    comercioId = json['comercioId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usuarioId'] = this.usuarioId;
    data['comercioId'] = this.comercioId;
    return data;
  }
}
