class FavoritoResponse {
  String? id;
  String? imagen;
  String? name;
  double? latitud;
  double? longitud;
  double? rating;
  String? nameDirection;
  List<String>? categorias;
  List<Productos>? productos;
  List<FavoritoList>? favoritoList;
  bool? likes;

  FavoritoResponse(
      {this.id,
      this.imagen,
      this.name,
      this.latitud,
      this.longitud,
      this.rating,
      this.nameDirection,
      this.categorias,
      this.productos,
      this.favoritoList,
      this.likes});

  FavoritoResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imagen = json['imagen'];
    name = json['name'];
    latitud = json['latitud'];
    longitud = json['longitud'];
    rating = json['rating'];
    nameDirection = json['nameDirection'];
    categorias =
        json['categorias'] != null ? List<String>.from(json['categorias']) : [];
    if (json['productos'] != null) {
      productos = <Productos>[];
      json['productos'].forEach((v) {
        productos!.add(new Productos.fromJson(v));
      });
    }
    if (json['favoritoList'] != null) {
      favoritoList = <FavoritoList>[];
      json['favoritoList'].forEach((v) {
        favoritoList!.add(new FavoritoList.fromJson(v));
      });
    }
    likes = json['likes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imagen'] = this.imagen;
    data['name'] = this.name;
    data['latitud'] = this.latitud;
    data['longitud'] = this.longitud;
    data['rating'] = this.rating;
    data['nameDirection'] = this.nameDirection;
    data['categorias'] = this.categorias;
    if (this.productos != null) {
      data['productos'] = this.productos!.map((v) => v.toJson()).toList();
    }
    if (this.favoritoList != null) {
      data['favoritoList'] = this.favoritoList!.map((v) => v.toJson()).toList();
    }
    data['likes'] = this.likes;
    return data;
  }
}

class Productos {
  String? id;
  String? imagen;
  String? name;
  double? precio;
  bool? disponible;
  List<Ingredientes>? ingredientes;

  Productos(
      {this.id,
      this.imagen,
      this.name,
      this.precio,
      this.disponible,
      this.ingredientes});

  Productos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imagen = json['imagen'];
    name = json['name'];
    precio = json['precio'];
    disponible = json['disponible'];
    if (json['ingredientes'] != null) {
      ingredientes = <Ingredientes>[];
      json['ingredientes'].forEach((v) {
        ingredientes!.add(new Ingredientes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imagen'] = this.imagen;
    data['name'] = this.name;
    data['precio'] = this.precio;
    data['disponible'] = this.disponible;
    if (this.ingredientes != null) {
      data['ingredientes'] = this.ingredientes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ingredientes {
  String? id;
  String? name;
  String? imagen;

  Ingredientes({this.id, this.name, this.imagen});

  Ingredientes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imagen = json['imagen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['imagen'] = this.imagen;
    return data;
  }
}

class FavoritoList {
  Id? id;

  FavoritoList({this.id});

  FavoritoList.fromJson(Map<String, dynamic> json) {
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
