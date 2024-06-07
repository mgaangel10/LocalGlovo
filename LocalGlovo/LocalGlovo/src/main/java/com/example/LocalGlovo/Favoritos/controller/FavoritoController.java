package com.example.LocalGlovo.Favoritos.controller;

import com.example.LocalGlovo.Favoritos.models.Favorito;
import com.example.LocalGlovo.Favoritos.service.FavoritoService;
import com.example.LocalGlovo.comercios.models.Comercio;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
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
    @Operation(summary = "Añadir a favorito un comercio")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se ha añadidio a favorito",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Comercio.class)),
                            examples = {@ExampleObject(
                                    value = """
                                               {
                                                          "id": "dee8e900-9dad-11d1-80b4-00c04fd430c9",
                                                          "imagen": "fotoPruebaComercio_755114.jpeg",
                                                          "name": "Restaurante",
                                                          "latitud": 37.26473838920224,
                                                          "longitud": -6.066084591003926,
                                                          "rating": 4.3,
                                                          "nameDirection": "La puebla del rio",
                                                          "categorias": [
                                                              "RESTAURANTE"
                                                          ],
                                                          "productos": [],
                                                          "favoritoList": [
                                                              {
                                                                  "id": {
                                                                      "usuarioId": "5d818565-99f9-4d80-920e-8259c6ecb8e6",
                                                                      "comercioId": "dee8e900-9dad-11d1-80b4-00c04fd430c9"
                                                                  }
                                                              }
                                                          ]
                                                      }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Not found",
                    content = @Content)
    })
    @PostMapping("usuario/añadir/favorito/{usuarioId}/{comercioId}")
    public ResponseEntity<Comercio> addFavorito(@PathVariable UUID usuarioId,@PathVariable UUID comercioId ){
      Comercio favorito =  favoritoService.darAFavorito(usuarioId,comercioId);
        return ResponseEntity.status(201).body(favorito);
    }
    @Operation(summary = "Ver favoritos de un usuario")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha listado los favoritos",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Comercio.class)),
                            examples = {@ExampleObject(
                                    value = """
                                               [
                                                           {
                                                               "id": "dee8e900-9dad-11d1-80b4-00c04fd430c9",
                                                               "imagen": "fotoPruebaComercio_755114.jpeg",
                                                               "name": "Restaurante",
                                                               "latitud": 37.26473838920224,
                                                               "longitud": -6.066084591003926,
                                                               "rating": 4.3,
                                                               "nameDirection": "La puebla del rio",
                                                               "categorias": [
                                                                   "RESTAURANTE"
                                                               ],
                                                               "productos": [],
                                                               "favoritoList": [
                                                                   {
                                                                       "id": {
                                                                           "usuarioId": "5d818565-99f9-4d80-920e-8259c6ecb8e6",
                                                                           "comercioId": "dee8e900-9dad-11d1-80b4-00c04fd430c9"
                                                                       }
                                                                   }
                                                               ]
                                                           }
                                                       ]
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Not found",
                    content = @Content)
    })
    @GetMapping("usuario/ver/favorito/{id}")
    public ResponseEntity<List<Comercio>> listarFavorito(@PathVariable UUID id){
        List<Comercio> comercios = favoritoService.verFavoritoDeUsuario(id);
        return ResponseEntity.ok(comercios);
    }
    @Operation(summary = "Quitar favorito un comercio")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204",
                    description = "Se ha quitado el favorito",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema()),
                            examples = {@ExampleObject(
                                    value = """
                                             
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Not found",
                    content = @Content)
    })
    @DeleteMapping("usuario/quitar/favorito/{usuarioId}/{comercioId}")
    public ResponseEntity<?> quitarComentario (@PathVariable UUID usuarioId,@PathVariable UUID comercioId){
        favoritoService.quitarDeFavorito(usuarioId,comercioId);
        return ResponseEntity.noContent().build();
    }
}
