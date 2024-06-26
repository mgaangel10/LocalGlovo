// Generated by https://quicktype.io

export interface ProductosDetails {
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
