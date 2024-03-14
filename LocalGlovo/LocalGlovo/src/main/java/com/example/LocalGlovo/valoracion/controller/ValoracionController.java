package com.example.LocalGlovo.valoracion.controller;

import com.example.LocalGlovo.comercios.models.Comercio;
import com.example.LocalGlovo.valoracion.service.ValoracionService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class ValoracionController {

    private final ValoracionService valoracionService;



    @PostMapping("usuario/add/valoracion/{usuarioId}/{comercioId}")
    public ResponseEntity<Comercio> addValoracion(@PathVariable UUID usuarioId, @PathVariable UUID comercioId,@RequestBody double rating){
       Comercio comercio = valoracionService.obtenerMediaValoracion(usuarioId, comercioId,rating);

       return ResponseEntity.status(201).body(comercio);
    }
}
