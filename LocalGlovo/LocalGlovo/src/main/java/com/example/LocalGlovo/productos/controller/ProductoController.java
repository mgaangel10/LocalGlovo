package com.example.LocalGlovo.productos.controller;

import com.example.LocalGlovo.comercios.Dto.GetListComercios;
import com.example.LocalGlovo.comercios.models.Comercio;
import com.example.LocalGlovo.productos.Dto.GetListProducto;
import com.example.LocalGlovo.productos.Dto.PostProductoDto;
import com.example.LocalGlovo.productos.model.Ingredientes;
import com.example.LocalGlovo.productos.model.Producto;
import com.example.LocalGlovo.productos.service.ProductoService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class ProductoController {

    private final ProductoService productoService;

    @PostMapping("/administrador/crear/producto")
    public ResponseEntity<?> crearProducto(@RequestBody PostProductoDto postProductoDto){
        Producto producto = productoService.crearProducto(postProductoDto);
        return ResponseEntity.ok(producto);
    }

    @GetMapping("/usuario/listar/productos")
    public ResponseEntity<?> listarProductos(@PageableDefault(page = 0,size = 10) Pageable pageable){
        Page<GetListProducto> getListComerciosPage = productoService.listarProductos(pageable);
        return ResponseEntity.ok(getListComerciosPage);
    }

    @PostMapping("/administrador/añadir/productos/{nombreComercio}")
    public ResponseEntity<?> añadirProductos(@PathVariable String nombreComercio, @RequestBody List<UUID> idsProductos) {
        try {
            Comercio comercio = productoService.añadirProductosAComercio(nombreComercio, idsProductos);
            return new ResponseEntity<>(comercio, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("usuario/ingredientes/{id}")
    public ResponseEntity<?> buscarPorId(@PathVariable UUID id){
        Ingredientes ingredientes = productoService.finByIdIngredientes(id);
        return ResponseEntity.ok(ingredientes);
    }

    @GetMapping("usuario/productos/{id}")
    public ResponseEntity<?> buscarPorIdProductos(@PathVariable UUID id){
        Producto producto = productoService.buscarPorID(id);
        return ResponseEntity.ok(producto);
    }

    @DeleteMapping("usuario/delete/ingredientes/{id}")
    public ResponseEntity<?> eliminarIngredientes(@PathVariable UUID id){
        productoService.EliminarIngredientes(id);
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("administrador/delete/producto/{productoId}")
    public ResponseEntity<?> EliminarProducto (@PathVariable UUID productoId){
        productoService.eliminarProducto(productoId);
        return  ResponseEntity.noContent().build();
    }

}
