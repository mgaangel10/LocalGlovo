package com.example.LocalGlovo.comercios.controller;

import com.example.LocalGlovo.comercios.Dto.GetListComercios;
import com.example.LocalGlovo.comercios.Dto.PostCrearComercio;
import com.example.LocalGlovo.comercios.models.CategoriaComercios;
import com.example.LocalGlovo.comercios.models.Comercio;
import com.example.LocalGlovo.comercios.service.ComercioService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class ComercioController {
    private final ComercioService comercioService;


    @PostMapping("/administrador/crear/comercio")
    public ResponseEntity<?> crearComercio(@RequestBody PostCrearComercio postCrearComercio){
        Comercio comercio = comercioService.crearComercio(postCrearComercio);
        return ResponseEntity.ok(comercio);
    }

    @GetMapping("/usuario/listar/comercios")
    public ResponseEntity<Page<GetListComercios>> findAll(@PageableDefault(page = 0,size = 10)Pageable pageable){
        Page<GetListComercios> getListComerciosPage = comercioService.listarComercios(pageable);
        return ResponseEntity.ok(getListComerciosPage);
    }

    @GetMapping("/usuario/buscar/id/{id}")
    public ResponseEntity<?> findById(@PathVariable UUID id){
        Comercio comercio = comercioService.finfbyid(id);
        return ResponseEntity.ok(comercio);

    }
    @GetMapping("usuario/filtrar/comercios/{categoria}")
    public ResponseEntity<List<Comercio>> getComerciosPorCategoria(@PathVariable CategoriaComercios categoria) {
        List<Comercio> comercios= comercioService.getComerciosPorCategoria(categoria);
        return ResponseEntity.ok(comercios);
    }
}
