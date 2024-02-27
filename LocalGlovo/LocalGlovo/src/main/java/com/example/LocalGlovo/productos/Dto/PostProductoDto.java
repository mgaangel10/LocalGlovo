package com.example.LocalGlovo.productos.Dto;

import com.example.LocalGlovo.productos.model.Ingredientes;

import java.util.HashSet;
import java.util.Set;

public record PostProductoDto(String imagen,
                              String name,
                              double precio,
                              boolean disponible,
                              Set<Ingredientes> ingredientes
                              ) {

}
