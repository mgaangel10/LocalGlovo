package com.example.LocalGlovo.carrito.Dto;

import com.example.LocalGlovo.carrito.models.LineaCarrito;

import java.util.Set;
import java.util.UUID;

public record GetCarritoDto(UUID id,
                            Integer cantidad,
                            double total,
                            Set<LineaCarrito> lineaCarritoDtos) {
}
