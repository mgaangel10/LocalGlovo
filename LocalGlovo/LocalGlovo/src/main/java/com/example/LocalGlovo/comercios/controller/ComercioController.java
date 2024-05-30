package com.example.LocalGlovo.comercios.controller;

import com.example.LocalGlovo.Exception.GlobalException;
import com.example.LocalGlovo.comercios.Dto.GetListComercios;
import com.example.LocalGlovo.comercios.Dto.PostCrearComercio;
import com.example.LocalGlovo.comercios.models.CategoriaComercios;
import com.example.LocalGlovo.comercios.models.Comercio;
import com.example.LocalGlovo.comercios.service.ComercioService;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class ComercioController {
    private final ComercioService comercioService;


    @PostMapping("/administrador/crear/comercio")
    public ResponseEntity<?> crearComercio(@RequestPart("comercio") String comercioJson, @RequestPart("file") MultipartFile file) {
        try {
            // Convertir la cadena JSON en un objeto PostCrearComercio
            ObjectMapper objectMapper = new ObjectMapper();
            PostCrearComercio postCrearComercio = objectMapper.readValue(comercioJson, PostCrearComercio.class);

            Comercio comercio = comercioService.crearComercio(postCrearComercio, file);
            return ResponseEntity.ok(comercio);
        } catch (Exception e) {
            throw new GlobalException(e.getMessage());
        }
    }


    @GetMapping("administrador/listado/categorias")
    public ResponseEntity<List<String>> listadoCategorias(){
        List<String> categorias = comercioService.listadoDeCategorias();
        return ResponseEntity.ok(categorias);
    }
    @GetMapping("/administrador/listado/googlemaps")
    public ResponseEntity<List<Comercio>> listadoCoemercioGoogleMaps(){
        List<Comercio> comercios = comercioService.listadoProyectosGoogleMaps();
        return ResponseEntity.ok(comercios);
    }

    @GetMapping("/usuario/listar/comercios")
    public ResponseEntity<Page<GetListComercios>> findAll(@PageableDefault(page = 0,size = 10)Pageable pageable){
        Page<GetListComercios> getListComerciosPage = comercioService.listarComercios(pageable);
        return ResponseEntity.ok(getListComerciosPage);
    }
    @GetMapping("administrador/listar/comercios")
    public ResponseEntity<Page<GetListComercios>> findAllAdministrador(@PageableDefault(page = 0,size = 10)Pageable pageable){
        Page<GetListComercios> getListComerciosPage = comercioService.listarComercios(pageable);
        return ResponseEntity.ok(getListComerciosPage);
    }
    @GetMapping("administrador/buscar/comercio/{nombre}")
    public ResponseEntity<List<Comercio>> buscarPorNombre(@PathVariable String nombre){
       List<Comercio>  comercio = comercioService.findByNombre(nombre);
        return ResponseEntity.ok(comercio);
    }

    @GetMapping("/usuario/buscar/id/{id}")
    public ResponseEntity<?> findById(@PathVariable UUID id){
        Comercio comercio = comercioService.finfbyid(id);
        return ResponseEntity.ok(comercio);

    }
    @GetMapping("/administrador/buscar/id/{id}")
    public ResponseEntity<?> findByIdComercio(@PathVariable UUID id){
        Comercio comercio = comercioService.finfbyid(id);
        return ResponseEntity.ok(comercio);

    }
    @GetMapping("usuario/filtrar/comercios/{categoria}")
    public ResponseEntity<List<GetListComercios>> getComerciosPorCategoria(@PathVariable CategoriaComercios categoria) {
        List<GetListComercios> comercios= comercioService.getComerciosPorCategoria(categoria);
        return ResponseEntity.ok(comercios);
    }
    @GetMapping("administrador/filtrar/comercios/{categoria}")
    public ResponseEntity<List<GetListComercios>> filtrarPorCategoria(@PathVariable CategoriaComercios categoria){
        List<GetListComercios> comercios= comercioService.getComerciosPorCategoria(categoria);
        return ResponseEntity.ok(comercios);
    }

    @DeleteMapping("administrador/eliminar/comercio/{comercioId}")
    public ResponseEntity<?> eliminarComercio(@PathVariable UUID comercioId){
        comercioService.elimarComercio(comercioId);
        return ResponseEntity.noContent().build();
    }

    @PutMapping("administrador/editar/comercio/{comercioId}")
    public ResponseEntity<Comercio> editarComercio(@PathVariable UUID comercioId,@RequestBody PostCrearComercio postCrearComercio){
        Comercio comercio = comercioService.editarComercio(comercioId,postCrearComercio);
        return ResponseEntity.status(201).body(comercio);
    }
}
