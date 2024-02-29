package com.example.LocalGlovo.carrito.controller;

import com.example.LocalGlovo.carrito.Dto.LineaCarritoDto;
import com.example.LocalGlovo.carrito.models.Carrito;
import com.example.LocalGlovo.carrito.service.CarritoService;
import com.example.LocalGlovo.productos.model.Producto;
import com.example.LocalGlovo.productos.service.ProductoService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

@RestController
@RequiredArgsConstructor
public class CarritoController {

    private final CarritoService carritoService;

    private final ProductoService productoService;

    @PostMapping("usuario/agregar/carrito/{productoId}")
    public void agregarAlCarrito(@PathVariable UUID productoId, UUID carritoId) {
        Producto producto = productoService.buscarPorID(productoId);
        Carrito carrito = carritoService.crearUnCarrito();
        carritoService.agregarProductoAlCarrito(carrito, producto);
    }

    @GetMapping("usuario/buscar/carrito/{id}")
    public Map<String, Object> verCarrito(@PathVariable UUID id) {
        Carrito carrito = carritoService.buscarCarritoPorId(id).orElseThrow(() -> new RuntimeException("Carrito no encontrado"));
        List<LineaCarritoDto> lineasCarritoDto = carrito.getLineasCarrito().stream()
                .map(LineaCarritoDto::of)
                .collect(Collectors.toList());


        double totalCarrito = carritoService.calcularTotalCarrito(carrito);


        Map<String, Object> resultado = new HashMap<>();
        resultado.put("lineasCarrito", lineasCarritoDto);
        resultado.put("total", totalCarrito);

        return resultado;
    }
}
