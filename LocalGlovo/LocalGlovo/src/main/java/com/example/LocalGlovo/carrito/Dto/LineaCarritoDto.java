package com.example.LocalGlovo.carrito.Dto;

import com.example.LocalGlovo.carrito.models.LineaCarrito;
import com.example.LocalGlovo.productos.model.Producto;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class LineaCarritoDto {
    private UUID id;
    private Producto producto;

    private double precio;
    private int cantidad;


    public static LineaCarritoDto of (LineaCarrito lc){
        return new LineaCarritoDto(
                lc.getId(),
                lc.getProducto(),

                lc.getProducto().getPrecio(),
                lc.getCantidad()
        );
    }

}
