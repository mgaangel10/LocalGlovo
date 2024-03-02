package com.example.LocalGlovo.comercios.Dto;

import java.util.UUID;

public record GetListComercios(UUID id,
                               String name,
                               double rating,
                               String nameDirection,
                               String imagen,
                               double latitud,
                               double longitud) {
}
