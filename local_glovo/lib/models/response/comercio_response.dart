class ComercioResponse {
  List<Content>? content;
  Pageable? pageable;
  bool? last;
  int? totalPages;
  int? totalElements;
  int? size;
  int? number;
  Sort? sort;
  bool? first;
  int? numberOfElements;
  bool? empty;

  ComercioResponse(
      {this.content,
      this.pageable,
      this.last,
      this.totalPages,
      this.totalElements,
      this.size,
      this.number,
      this.sort,
      this.first,
      this.numberOfElements,
      this.empty});

  ComercioResponse.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      if (json['content'] is Map<String, dynamic>) {
        content = (json['content']['your_list_key'] as List)
            .map((item) => Content.fromJson(item))
            .toList();
      } else if (json['content'] is List) {
        content = (json['content'] as List)
            .map((item) => Content.fromJson(item))
            .toList();
      } else {
        content = <Content>[];
      }
    }
    pageable = json['pageable'] != null
        ? new Pageable.fromJson(json['pageable'])
        : null;
    last = json['last'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    size = json['size'];
    number = json['number'];
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    first = json['first'];
    numberOfElements = json['numberOfElements'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    if (this.pageable != null) {
      data['pageable'] = this.pageable!.toJson();
    }
    data['last'] = this.last;
    data['totalPages'] = this.totalPages;
    data['totalElements'] = this.totalElements;
    data['size'] = this.size;
    data['number'] = this.number;
    if (this.sort != null) {
      data['sort'] = this.sort!.toJson();
    }
    data['first'] = this.first;
    data['numberOfElements'] = this.numberOfElements;
    data['empty'] = this.empty;
    return data;
  }
}

class Content {
  String? id;
  String? name;
  double? rating;
  String? nameDirection;
  String? imagen;
  double? latitud;
  double? longitud;
  String? categorias;

  Content(
      {this.id,
      this.name,
      this.rating,
      this.nameDirection,
      this.imagen,
      this.latitud,
      this.longitud,
      this.categorias});

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rating = json['rating'];
    nameDirection = json['nameDirection'];
    imagen = json['imagen'];
    latitud = json['latitud'];
    longitud = json['longitud'];
    categorias = json['categorias'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['rating'] = this.rating;
    data['nameDirection'] = this.nameDirection;
    data['imagen'] = this.imagen;
    data['latitud'] = this.latitud;
    data['longitud'] = this.longitud;
    data['categorias'] = this.categorias;
    return data;
  }
}

class Pageable {
  int? pageNumber;
  int? pageSize;
  Sort? sort;
  int? offset;
  bool? paged;
  bool? unpaged;

  Pageable(
      {this.pageNumber,
      this.pageSize,
      this.sort,
      this.offset,
      this.paged,
      this.unpaged});

  Pageable.fromJson(Map<String, dynamic> json) {
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    sort = json['sort'] != null ? new Sort.fromJson(json['sort']) : null;
    offset = json['offset'];
    paged = json['paged'];
    unpaged = json['unpaged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNumber'] = this.pageNumber;
    data['pageSize'] = this.pageSize;
    if (this.sort != null) {
      data['sort'] = this.sort!.toJson();
    }
    data['offset'] = this.offset;
    data['paged'] = this.paged;
    data['unpaged'] = this.unpaged;
    return data;
  }
}

class Sort {
  bool? empty;
  bool? unsorted;
  bool? sorted;

  Sort({this.empty, this.unsorted, this.sorted});

  Sort.fromJson(Map<String, dynamic> json) {
    empty = json['empty'];
    unsorted = json['unsorted'];
    sorted = json['sorted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['empty'] = this.empty;
    data['unsorted'] = this.unsorted;
    data['sorted'] = this.sorted;
    return data;
  }
}
