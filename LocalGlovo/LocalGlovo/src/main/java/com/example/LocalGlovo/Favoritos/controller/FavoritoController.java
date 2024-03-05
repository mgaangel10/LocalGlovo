package com.example.LocalGlovo.Favoritos.controller;

import com.example.LocalGlovo.Favoritos.models.Favorito;
import com.example.LocalGlovo.Favoritos.service.FavoritoService;
import com.example.LocalGlovo.comercios.models.Comercio;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class FavoritoController {

    private final FavoritoService favoritoService;

    @PostMapping("usuario/añadir/favorito/{usuarioId}/{comercioId}")
    public ResponseEntity<Favorito> addFavorito(@PathVariable UUID usuarioId,@PathVariable UUID comercioId ){
      Favorito favorito =  favoritoService.darAFavorito(usuarioId,comercioId);
        return ResponseEntity.status(201).body(favorito);
    }

    @GetMapping("usuario/ver/favorito/{id}")
    public ResponseEntity<List<Comercio>> listarFavorito(@PathVariable UUID id){
        List<Comercio> comercios = favoritoService.verFavoritoDeUsuario(id);
        return ResponseEntity.ok(comercios);
    }

    @DeleteMapping("usuario/quitar/favorito/{usuarioId}/{comercioId}")
    public ResponseEntity<?> quitarComentario (@PathVariable UUID usuarioId,@PathVariable UUID comercioId){
        favoritoService.quitarDeFavorito(usuarioId,comercioId);
        return ResponseEntity.noContent().build();
    }
}
