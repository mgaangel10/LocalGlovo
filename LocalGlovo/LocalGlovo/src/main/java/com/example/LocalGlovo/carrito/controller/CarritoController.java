package com.example.LocalGlovo.carrito.controller;

import com.example.LocalGlovo.carrito.Dto.GetCarritoDto;
import com.example.LocalGlovo.carrito.Dto.LineaCarritoDto;
import com.example.LocalGlovo.carrito.models.Carrito;
import com.example.LocalGlovo.carrito.service.CarritoService;
import com.example.LocalGlovo.productos.model.Producto;
import com.example.LocalGlovo.productos.service.ProductoService;
import com.example.LocalGlovo.users.model.Usuario;
import com.example.LocalGlovo.users.service.UsuarioService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequiredArgsConstructor
public class CarritoController {

    private final CarritoService carritoService;
    private final UsuarioService usuarioService;
    private final ProductoService productoService;

    @PostMapping("usuario/{usuarioId}/agregar/carrito/{productoId}")
    public ResponseEntity<Carrito> agregarAlCarrito(@PathVariable UUID usuarioId, @PathVariable UUID productoId) {
        Optional<Usuario> usuario = usuarioService.findById(usuarioId);
        Producto producto = productoService.buscarPorID(productoId);
        carritoService.agregarProductoAlCarrito(usuario.get(), producto);
        Carrito carrito= carritoService.buscarCarritoActivoDelUsuario(usuario.get());
        return ResponseEntity.ok(carrito);
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
    @GetMapping("usuario/all/carrito")
    public ResponseEntity<List<GetCarritoDto>> allCarrito(){
        List<GetCarritoDto> carritoDtos = carritoService.listarCarrito();
        return ResponseEntity.ok(carritoDtos);
    }

}
