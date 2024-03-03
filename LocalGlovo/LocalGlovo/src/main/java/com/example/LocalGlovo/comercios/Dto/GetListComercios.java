package com.example.LocalGlovo.comercios.Dto;

import com.example.LocalGlovo.comercios.models.CategoriaComercios;

import java.util.Set;
import java.util.UUID;

public record GetListComercios(UUID id,
                               String name,
                               double rating,
                               String nameDirection,
                               String imagen,
                               double latitud,
                               double longitud,
                               CategoriaComercios categorias) {
}
