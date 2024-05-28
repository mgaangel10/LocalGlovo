export interface ListadoComercioGoogleMaps {
    id:            string;
    imagen:        string;
    name:          string;
    latitud:       number;
    longitud:      number;
    rating:        number;
    nameDirection: string;
    categorias:    string[];
    productos:     Producto[];
    favoritoList:  FavoritoList[];
}

export interface FavoritoList {
    id: ID;
}

export interface ID {
    usuarioId:  string;
    comercioId: string;
}

export interface Producto {
    id:           string;
    imagen:       string;
    name:         string;
    precio:       number;
    disponible:   boolean;
    ingredientes: Ingrediente[];
    comercio:     null;
}

export interface Ingrediente {
    id:     string;
    name:   string;
    imagen: string;
}
