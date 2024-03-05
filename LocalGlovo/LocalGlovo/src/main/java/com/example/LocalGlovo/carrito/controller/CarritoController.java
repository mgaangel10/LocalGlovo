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
import org.springframework.web.bind.annotation.*;

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
        return ResponseEntity.status(201).body(carrito);
    }




    @GetMapping("usuario/buscar/carrito/{uuid}")
    public ResponseEntity<Carrito> buscar(@PathVariable UUID uuid){
        Optional<Carrito> carrito = carritoService.buscarCarritoPorId(uuid);
        return  ResponseEntity.ok(carrito.get());
    }
    @GetMapping("usuario/all/carrito")
    public ResponseEntity<List<GetCarritoDto>> allCarrito(){
        List<GetCarritoDto> carritoDtos = carritoService.listarCarrito();
        return ResponseEntity.ok(carritoDtos);
    }

    @DeleteMapping("usuario/eliminar/producto/carrito/{carritoId}/{productoId}")
    public ResponseEntity<?> eliminarProductoDelCarrito(@PathVariable UUID carritoId,@PathVariable UUID productoId){
        carritoService.eliminarProductoDelCarrito(carritoId,productoId);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("usuario/terminar/carrito/{id}")
    public ResponseEntity<Carrito> terminarCarrito(@PathVariable UUID id){
        Carrito carrito = carritoService.TerminarCarrito(id);
        return  ResponseEntity.status(201).body(carrito);
    }

}
