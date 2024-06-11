package com.example.LocalGlovo.productos.controller;

import com.example.LocalGlovo.Exception.GlobalException;
import com.example.LocalGlovo.comercios.Dto.GetListComercios;
import com.example.LocalGlovo.comercios.Dto.PostCrearComercio;
import com.example.LocalGlovo.comercios.models.Comercio;
import com.example.LocalGlovo.productos.Dto.GetListProducto;
import com.example.LocalGlovo.productos.Dto.PostProductoDto;
import com.example.LocalGlovo.productos.model.Ingredientes;
import com.example.LocalGlovo.productos.model.Producto;
import com.example.LocalGlovo.productos.service.ProductoService;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class ProductoController {

    private final ProductoService productoService;


    @PostMapping("/administrador/crear/producto/{comercioId}")
    public ResponseEntity<?> crearProducto(@RequestPart("producto") String comercioJson, @RequestPart("file") MultipartFile file,@PathVariable UUID comercioId){
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            PostProductoDto postCrearComercio = objectMapper.readValue(comercioJson, PostProductoDto.class);
            Producto producto = productoService.crearProducto(postCrearComercio,comercioId,file);
            return ResponseEntity.ok(producto);
        }catch (Exception e){
            throw new GlobalException(e.getMessage());
        }

    }

    @GetMapping("/usuario/listar/productos")
    public ResponseEntity<?> listarProductos(@PageableDefault(page = 0,size = 10) Pageable pageable){
        Page<GetListProducto> getListComerciosPage = productoService.listarProductos(pageable);
        return ResponseEntity.ok(getListComerciosPage);
    }

   /* @PostMapping("/administrador/añadir/productos/{nombreComercio}")
    public ResponseEntity<?> añadirProductos(@PathVariable String nombreComercio, @RequestBody List<UUID> idsProductos) {
        try {
            Comercio comercio = productoService.añadirProductosAComercio(nombreComercio, idsProductos);
            return new ResponseEntity<>(comercio, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }*/

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
    @GetMapping("administrador/productos/{id}")
    public ResponseEntity<?> buscarPorIdProductosAmdim(@PathVariable UUID id){
        try {
            Producto producto = productoService.buscarPorID(id);
            return ResponseEntity.ok(producto);
        } catch (Exception e) {
            throw new GlobalException(e.getMessage());
        }

    }

   /* @DeleteMapping("usuario/delete/ingredientes/{id}")
    public ResponseEntity<?> eliminarIngredientes(@PathVariable UUID id){
        productoService.EliminarIngredientes(id);
        return ResponseEntity.noContent().build();
    }*/

    @DeleteMapping("administrador/delete/producto/{productoId}")
    public ResponseEntity<?> EliminarProducto (@PathVariable UUID productoId){
        try {
            productoService.eliminarProducto(productoId);
            return  ResponseEntity.noContent().build();
        }catch (Exception e){
            throw new GlobalException(e.getMessage());
        }

    }
    @PostMapping("administrador/add/ingredientes/{productoId}")
    public ResponseEntity<Ingredientes> crearIngredientes(@RequestPart("ingrediente") String ingredientejson, @RequestPart("file") MultipartFile file,@PathVariable UUID productoId){
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            Ingredientes postIngredientes = objectMapper.readValue(ingredientejson, Ingredientes.class);
            Ingredientes ingredientes1 = productoService.crearIngredientes(postIngredientes,productoId,file);
            return ResponseEntity.status(201).body(ingredientes1);
        }catch (Exception e){
            throw new GlobalException(e.getMessage());
        }

    }

    @DeleteMapping("administrador/eliminar/{ingredientesId}")
    public ResponseEntity<?> eliminarIngredientes(@PathVariable UUID ingredientesId){
        try{
            productoService.eliminarIngrediente(ingredientesId);
            return ResponseEntity.noContent().build();
        }catch (Exception e){
            throw new GlobalException(e.getMessage());
        }

    }

    @PutMapping("administrador/editar/producto/{productoId}")
    public ResponseEntity<Producto> editarProducto(@PathVariable UUID productoId,@RequestPart("producto") String comercioJson, @RequestPart("file") MultipartFile file){
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            PostProductoDto postCrearComercio = objectMapper.readValue(comercioJson, PostProductoDto.class);
            Producto producto = productoService.editarProdcuto(productoId,postCrearComercio,file);
            return ResponseEntity.status(201).body(producto);
        }catch (Exception e){
            throw new GlobalException(e.getMessage());
        }

    }



}
