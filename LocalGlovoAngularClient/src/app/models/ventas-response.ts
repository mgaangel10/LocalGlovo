export interface VentasResponse {
    id: string;
    total: number;
    usuarios: Usuario[];
    productos: Producto[];
    fecha: Date;
}

export interface Producto {
    id: string;
    imagen: string;
    name: string;
    precio: number;
    disponible: boolean;
    ingredientes: Ingrediente[];
}

export interface Ingrediente {
    id: string;
    name: string;
    imagen: string;
}

export interface Usuario {
    id: string;
    email: string;
    username: string;
    password: string;
    name: string;
    lastName: string;
    phoneNumber: string;
    birthDate: null;
    fotoUrl: string;
    accountNonExpired: boolean;
    accountNonLocked: boolean;
    credentialsNonExpired: boolean;
    enabled: boolean;
    roles: string[];
    createdAt: null;
    lastPasswordChangeAt: null;
    usuarios: any[];
    inChargeof: any[];
    favoritos: Favorito[];
    authorities: Authority[];
}

export interface Authority {
    authority: string;
}

export interface Favorito {
    id: ID;
}

export interface ID {
    usuarioId: string;
    comercioId: string;
}
