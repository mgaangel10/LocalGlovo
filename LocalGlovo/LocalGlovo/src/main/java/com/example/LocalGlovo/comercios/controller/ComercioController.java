package com.example.LocalGlovo.comercios.controller;

import com.example.LocalGlovo.Exception.GlobalException;
import com.example.LocalGlovo.comercios.Dto.GetListComercios;
import com.example.LocalGlovo.comercios.Dto.PostCrearComercio;
import com.example.LocalGlovo.comercios.models.CategoriaComercios;
import com.example.LocalGlovo.comercios.models.Comercio;
import com.example.LocalGlovo.comercios.service.ComercioService;
import com.example.LocalGlovo.users.Dto.PostCrearUserDto;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
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


    @Operation(summary = "Crear un comercio")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se ha creado un comercio",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = PostCrearComercio.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {       
                                                      "categorias":"BAR",
                                                      "favoritoList": null,
                                                      "id": "ec011e7d-0a51-41ef-8448-717a37767d77",
                                                      "imagen": "OIP_246488_156042.jpeg",
                                                      "latitud": 37.26452441509684,
                                                      "longitud": -6.060504913330078,
                                                      "name": "BaseDeDatos",
                                                      "nameDirection": "dhdasdsd",
                                                      "productos": null,
                                                      "rating": 0
                                                    },
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "400",
                    description = "Bad request",
                    content = @Content)
    })
    @PostMapping("/administrador/crear/comercio")
    public ResponseEntity<?> crearComercio(@RequestPart("comercio") String comercioJson, @RequestPart("file") MultipartFile file) {
        try {

            ObjectMapper objectMapper = new ObjectMapper();
            PostCrearComercio postCrearComercio = objectMapper.readValue(comercioJson, PostCrearComercio.class);

            Comercio comercio = comercioService.crearComercio(postCrearComercio, file);
            return ResponseEntity.ok(comercio);
        } catch (Exception e) {
            throw new GlobalException(e.getMessage());
        }
    }

    @Operation(summary = "Listar categorias de un comercio")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha listado las categorias",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = CategoriaComercios.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                      
                                                     [
                                                                     "FARMACIA",
                                                                     "BAR",
                                                                     "RESTAURANTE",
                                                                     "TIENDAROPA",
                                                                     "TIENDACOMESTIBLES",
                                                                     "CARNECERIA"
                                                                 ]
                                                    
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Not found",
                    content = @Content)
    })
    @GetMapping("administrador/listado/categorias")
    public ResponseEntity<List<String>> listadoCategorias(){
        List<String> categorias = comercioService.listadoDeCategorias();
        return ResponseEntity.ok(categorias);
    }

    @Operation(summary = "Listar categorias de un comercio")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha listado las categorias",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Comercio.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                      
                                                     [{
                                                            "id": "f89f898a-70aa-48d5-8088-3f3c892d7bae",
                                                            "imagen": "fotoPruebaComercio_755114.jpeg",
                                                            "name": "Las Lozas",
                                                            "latitud": 37.2700843067059,
                                                            "longitud": -6.063028856447782,
                                                            "rating": 4.8,
                                                            "nameDirection": "La puebla del rio",
                                                            "categorias": [
                                                                "FARMACIA"
                                                            ],
                                                            "productos": [
                                                                {
                                                                    "id": "550e8400-e29b-41d4-a716-446655440000",
                                                                    "imagen": "https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                                                                    "name": "Manzana",
                                                                    "precio": 5.0,
                                                                    "disponible": true,
                                                                    "comercio": null,
                                                                    "ingredientes": []
                                                                }
                                                            ],
                                                            "favoritoList": []
                                                                     },
                                                                 ]
                                                    
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Not found",
                    content = @Content)
    })
    @GetMapping("/administrador/listado/googlemaps")
    public ResponseEntity<List<Comercio>> listadoCoemercioGoogleMaps(){
        List<Comercio> comercios = comercioService.listadoProyectosGoogleMaps();
        return ResponseEntity.ok(comercios);
    }

    @Operation(summary = "Listado de comercios")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha listado los comercios",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GetListComercios.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                      
                                                    {
                                                                      "content": [
                                                                          {
                                                                              "id": "f89f898a-70aa-48d5-8088-3f3c892d7bae",
                                                                              "name": "Las Lozas",
                                                                              "rating": 4.8,
                                                                              "nameDirection": "La puebla del rio",
                                                                              "imagen": "fotoPruebaComercio_755114.jpeg",
                                                                              "latitud": 37.2700843067059,
                                                                              "longitud": -6.063028856447782,
                                                                              "categorias": "FARMACIA"
                                                                          },
                                                                          {
                                                                              "id": "123e4567-e89b-12d3-a456-426614174000",
                                                                              "name": "Felipon",
                                                                              "rating": 4.8,
                                                                              "nameDirection": "La puebla del rio",
                                                                              "imagen": "fotoPruebaComercio_755114.jpeg",
                                                                              "latitud": 37.27203372064043,
                                                                              "longitud": -6.066180282066359,
                                                                              "categorias": "CARNECERIA"
                                                                          },
                                                                          {
                                                                              "id": "7bb2e900-9dad-11d1-80b4-00c04fd430c9",
                                                                              "name": "Tienda Bendicion",
                                                                              "rating": 4.5,
                                                                              "nameDirection": "La puebla del rio",
                                                                              "imagen": "fotoPruebaComercio_755114.jpeg",
                                                                              "latitud": 37.272149626637564,
                                                                              "longitud": -6.06192884623146,
                                                                              "categorias": "TIENDAROPA"
                                                                          },
                                                                          {
                                                                              "id": "8cc3e900-9dad-11d1-80b4-00c04fd430c9",
                                                                              "name": "Bar Osso",
                                                                              "rating": 4.2,
                                                                              "nameDirection": "La puebla del rio",
                                                                              "imagen": "fotoPruebaComercio_755114.jpeg",
                                                                              "latitud": 37.272804495539006,
                                                                              "longitud": -6.062129797459527,
                                                                              "categorias": "BAR"
                                                                          },
                                                                          {
                                                                              "id": "9dd4e900-9dad-11d1-80b4-00c04fd430c9",
                                                                              "name": "Tienda G Fashion",
                                                                              "rating": 4.1,
                                                                              "nameDirection": "Sevilla",
                                                                              "imagen": "fotoPruebaComercio_755114.jpeg",
                                                                              "latitud": 37.2708028410246,
                                                                              "longitud": -6.06328770833118,
                                                                              "categorias": "TIENDAROPA"
                                                                          },
                                                                          {
                                                                              "id": "aee5e900-9dad-11d1-80b4-00c04fd430c9",
                                                                              "name": "Supermercado",
                                                                              "rating": 4.6,
                                                                              "nameDirection": "Coria del Rio",
                                                                              "imagen": "fotoPruebaComercio_755114.jpeg",
                                                                              "latitud": 37.268698190432744,
                                                                              "longitud": -6.065863976966079,
                                                                              "categorias": "TIENDACOMESTIBLES"
                                                                          },
                                                                          {
                                                                              "id": "bee6e900-9dad-11d1-80b4-00c04fd430c9",
                                                                              "name": "CarnicerÃ­a",
                                                                              "rating": 4.7,
                                                                              "nameDirection": "Palomares del rio",
                                                                              "imagen": "fotoPruebaComercio_755114.jpeg",
                                                                              "latitud": 37.26693788942789,
                                                                              "longitud": -6.063505949827319,
                                                                              "categorias": "CARNECERIA"
                                                                          },
                                                                          {
                                                                              "id": "cee7e900-9dad-11d1-80b4-00c04fd430c9",
                                                                              "name": "Pet shop",
                                                                              "rating": 4.9,
                                                                              "nameDirection": "La puebla del rio",
                                                                              "imagen": "fotoPruebaComercio_755114.jpeg",
                                                                              "latitud": 37.2662548259502,
                                                                              "longitud": -6.064503731577847,
                                                                              "categorias": "FARMACIA"
                                                                          },
                                                                          {
                                                                              "id": "dee8e900-9dad-11d1-80b4-00c04fd430c9",
                                                                              "name": "Restaurante",
                                                                              "rating": 4.3,
                                                                              "nameDirection": "La puebla del rio",
                                                                              "imagen": "fotoPruebaComercio_755114.jpeg",
                                                                              "latitud": 37.26473838920224,
                                                                              "longitud": -6.066084591003926,
                                                                              "categorias": "RESTAURANTE"
                                                                          },
                                                                          {
                                                                              "id": "efe9e900-9dad-11d1-80b4-00c04fd430c9",
                                                                              "name": "Tienda SportMax",
                                                                              "rating": 4.2,
                                                                              "nameDirection": "La puebla del rio",
                                                                              "imagen": "fotoPruebaComercio_755114.jpeg",
                                                                              "latitud": 37.26461146346672,
                                                                              "longitud": -6.0604388183971745,
                                                                              "categorias": "BAR"
                                                                          }
                                                                      ],
                                                                      "pageable": {
                                                                          "pageNumber": 0,
                                                                          "pageSize": 10,
                                                                          "sort": {
                                                                              "empty": true,
                                                                              "sorted": false,
                                                                              "unsorted": true
                                                                          },
                                                                          "offset": 0,
                                                                          "paged": true,
                                                                          "unpaged": false
                                                                      },
                                                                      "last": false,
                                                                      "totalPages": 2,
                                                                      "totalElements": 13,
                                                                      "first": true,
                                                                      "size": 10,
                                                                      "number": 0,
                                                                      "sort": {
                                                                          "empty": true,
                                                                          "sorted": false,
                                                                          "unsorted": true
                                                                      },
                                                                      "numberOfElements": 10,
                                                                      "empty": false
                                                                  }
                                                    
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Not found",
                    content = @Content)
    })
    @GetMapping("/usuario/listar/comercios")
    public ResponseEntity<Page<GetListComercios>> findAll(@PageableDefault(page = 0,size = 10)Pageable pageable){
        Page<GetListComercios> getListComerciosPage = comercioService.listarComercios(pageable);
        return ResponseEntity.ok(getListComerciosPage);
    }
    @Operation(summary = "Listado de comercios")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha listado los comercios",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GetListComercios.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                      
                                                    {
                                                                      "content": [
                                                                          {
                                                                              "id": "f89f898a-70aa-48d5-8088-3f3c892d7bae",
                                                                              "name": "Las Lozas",
                                                                              "rating": 4.8,
                                                                              "nameDirection": "La puebla del rio",
                                                                              "imagen": "fotoPruebaComercio_755114.jpeg",
                                                                              "latitud": 37.2700843067059,
                                                                              "longitud": -6.063028856447782,
                                                                              "categorias": "FARMACIA"
                                                                          },
                                                                          {
                                                                              "id": "123e4567-e89b-12d3-a456-426614174000",
                                                                              "name": "Felipon",
                                                                              "rating": 4.8,
                                                                              "nameDirection": "La puebla del rio",
                                                                              "imagen": "fotoPruebaComercio_755114.jpeg",
                                                                              "latitud": 37.27203372064043,
                                                                              "longitud": -6.066180282066359,
                                                                              "categorias": "CARNECERIA"
                                                                          },
                                                                          {
                                                                              "id": "7bb2e900-9dad-11d1-80b4-00c04fd430c9",
                                                                              "name": "Tienda Bendicion",
                                                                              "rating": 4.5,
                                                                              "nameDirection": "La puebla del rio",
                                                                              "imagen": "fotoPruebaComercio_755114.jpeg",
                                                                              "latitud": 37.272149626637564,
                                                                              "longitud": -6.06192884623146,
                                                                              "categorias": "TIENDAROPA"
                                                                          },
                                                                          {
                                                                              "id": "8cc3e900-9dad-11d1-80b4-00c04fd430c9",
                                                                              "name": "Bar Osso",
                                                                              "rating": 4.2,
                                                                              "nameDirection": "La puebla del rio",
                                                                              "imagen": "fotoPruebaComercio_755114.jpeg",
                                                                              "latitud": 37.272804495539006,
                                                                              "longitud": -6.062129797459527,
                                                                              "categorias": "BAR"
                                                                          },
                                                                          {
                                                                              "id": "9dd4e900-9dad-11d1-80b4-00c04fd430c9",
                                                                              "name": "Tienda G Fashion",
                                                                              "rating": 4.1,
                                                                              "nameDirection": "Sevilla",
                                                                              "imagen": "fotoPruebaComercio_755114.jpeg",
                                                                              "latitud": 37.2708028410246,
                                                                              "longitud": -6.06328770833118,
                                                                              "categorias": "TIENDAROPA"
                                                                          },
                                                                          {
                                                                              "id": "aee5e900-9dad-11d1-80b4-00c04fd430c9",
                                                                              "name": "Supermercado",
                                                                              "rating": 4.6,
                                                                              "nameDirection": "Coria del Rio",
                                                                              "imagen": "fotoPruebaComercio_755114.jpeg",
                                                                              "latitud": 37.268698190432744,
                                                                              "longitud": -6.065863976966079,
                                                                              "categorias": "TIENDACOMESTIBLES"
                                                                          },
                                                                          {
                                                                              "id": "bee6e900-9dad-11d1-80b4-00c04fd430c9",
                                                                              "name": "CarnicerÃ­a",
                                                                              "rating": 4.7,
                                                                              "nameDirection": "Palomares del rio",
                                                                              "imagen": "fotoPruebaComercio_755114.jpeg",
                                                                              "latitud": 37.26693788942789,
                                                                              "longitud": -6.063505949827319,
                                                                              "categorias": "CARNECERIA"
                                                                          },
                                                                          {
                                                                              "id": "cee7e900-9dad-11d1-80b4-00c04fd430c9",
                                                                              "name": "Pet shop",
                                                                              "rating": 4.9,
                                                                              "nameDirection": "La puebla del rio",
                                                                              "imagen": "fotoPruebaComercio_755114.jpeg",
                                                                              "latitud": 37.2662548259502,
                                                                              "longitud": -6.064503731577847,
                                                                              "categorias": "FARMACIA"
                                                                          },
                                                                          {
                                                                              "id": "dee8e900-9dad-11d1-80b4-00c04fd430c9",
                                                                              "name": "Restaurante",
                                                                              "rating": 4.3,
                                                                              "nameDirection": "La puebla del rio",
                                                                              "imagen": "fotoPruebaComercio_755114.jpeg",
                                                                              "latitud": 37.26473838920224,
                                                                              "longitud": -6.066084591003926,
                                                                              "categorias": "RESTAURANTE"
                                                                          },
                                                                          {
                                                                              "id": "efe9e900-9dad-11d1-80b4-00c04fd430c9",
                                                                              "name": "Tienda SportMax",
                                                                              "rating": 4.2,
                                                                              "nameDirection": "La puebla del rio",
                                                                              "imagen": "fotoPruebaComercio_755114.jpeg",
                                                                              "latitud": 37.26461146346672,
                                                                              "longitud": -6.0604388183971745,
                                                                              "categorias": "BAR"
                                                                          }
                                                                      ],
                                                                      "pageable": {
                                                                          "pageNumber": 0,
                                                                          "pageSize": 10,
                                                                          "sort": {
                                                                              "empty": true,
                                                                              "sorted": false,
                                                                              "unsorted": true
                                                                          },
                                                                          "offset": 0,
                                                                          "paged": true,
                                                                          "unpaged": false
                                                                      },
                                                                      "last": false,
                                                                      "totalPages": 2,
                                                                      "totalElements": 13,
                                                                      "first": true,
                                                                      "size": 10,
                                                                      "number": 0,
                                                                      "sort": {
                                                                          "empty": true,
                                                                          "sorted": false,
                                                                          "unsorted": true
                                                                      },
                                                                      "numberOfElements": 10,
                                                                      "empty": false
                                                                  }
                                                    
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Not found",
                    content = @Content)
    })
    @GetMapping("administrador/listar/comercios")
    public ResponseEntity<Page<GetListComercios>> findAllAdministrador(@PageableDefault(page = 0,size = 10)Pageable pageable){
        Page<GetListComercios> getListComerciosPage = comercioService.listarComercios(pageable);
        return ResponseEntity.ok(getListComerciosPage);
    }

    @Operation(summary = "Buscar comercio por nombre")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha encontrado el/los comercios",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Comercio.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                      
                                                   [
                                                       {
                                                           "id": "aee5e900-9dad-11d1-80b4-00c04fd430c9",
                                                           "imagen": "fotoPruebaComercio_755114.jpeg",
                                                           "name": "Supermercado",
                                                           "latitud": 37.268698190432744,
                                                           "longitud": -6.065863976966079,
                                                           "rating": 4.6,
                                                           "nameDirection": "Coria del Rio",
                                                           "categorias": [
                                                               "TIENDACOMESTIBLES"
                                                           ],
                                                           "productos": [
                                                               {
                                                                   "id": "7b8e6e8d-a202-4927-9bb9-9124a3049c4e",
                                                                   "imagen": "https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                                                                   "name": "Fanta",
                                                                   "precio": 5.0,
                                                                   "disponible": true,
                                                                   "comercio": null,
                                                                   "ingredientes": []
                                                               },
                                                               {
                                                                   "id": "b714eea5-9b28-4e8c-b189-83d8fc14a834",
                                                                   "imagen": "https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                                                                   "name": "Hamburguesa",
                                                                   "precio": 5.0,
                                                                   "disponible": true,
                                                                   "comercio": null,
                                                                   "ingredientes": [
                                                                       {
                                                                           "id": "9dcc75d8-4b5d-4d1f-a4c8-fcae5b85b0ff",
                                                                           "name": "bacon",
                                                                           "imagen": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToq2hM1WG_DfqtcNXFQitF0uYK7QlH22b7wg&usqp=CAU"
                                                                       },
                                                                       {
                                                                           "id": "241149d3-01e0-4ab6-ab80-d5839d08d2dd",
                                                                           "name": "queso",
                                                                           "imagen": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-aJrV-c_wMpQuZd9CGVpTmGIxYsBBSD5Y9w&usqp=CAU"
                                                                       }
                                                                   ]
                                                               },
                                                               {
                                                                   "id": "3f33b5a5-bc9a-4b4c-9d6f-0935379d7e61",
                                                                   "imagen": "https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                                                                   "name": "CocaCola",
                                                                   "precio": 5.0,
                                                                   "disponible": true,
                                                                   "comercio": null,
                                                                   "ingredientes": []
                                                               }
                                                           ],
                                                           "favoritoList": [
                                                               {
                                                                   "id": {
                                                                       "usuarioId": "5d818565-99f9-4d80-920e-8259c6ecb8e6",
                                                                       "comercioId": "aee5e900-9dad-11d1-80b4-00c04fd430c9"
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
    @GetMapping("administrador/buscar/comercio/{nombre}")
    public ResponseEntity<List<Comercio>> buscarPorNombre(@PathVariable String nombre){
       List<Comercio>  comercio = comercioService.findByNombre(nombre);
        return ResponseEntity.ok(comercio);
    }
    @Operation(summary = "Buscar comercio por id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha encontrado el comercio",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Comercio.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                      
                                                  {
                                                      "id": "aee5e900-9dad-11d1-80b4-00c04fd430c9",
                                                      "imagen": "fotoPruebaComercio_755114.jpeg",
                                                      "name": "Supermercado",
                                                      "latitud": 37.268698190432744,
                                                      "longitud": -6.065863976966079,
                                                      "rating": 4.6,
                                                      "nameDirection": "Coria del Rio",
                                                      "categorias": [
                                                          "TIENDACOMESTIBLES"
                                                      ],
                                                      "productos": [
                                                          {
                                                              "id": "b714eea5-9b28-4e8c-b189-83d8fc14a834",
                                                              "imagen": "https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                                                              "name": "Hamburguesa",
                                                              "precio": 5.0,
                                                              "disponible": true,
                                                              "comercio": null,
                                                              "ingredientes": [
                                                                  {
                                                                      "id": "241149d3-01e0-4ab6-ab80-d5839d08d2dd",
                                                                      "name": "queso",
                                                                      "imagen": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-aJrV-c_wMpQuZd9CGVpTmGIxYsBBSD5Y9w&usqp=CAU"
                                                                  },
                                                                  {
                                                                      "id": "9dcc75d8-4b5d-4d1f-a4c8-fcae5b85b0ff",
                                                                      "name": "bacon",
                                                                      "imagen": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToq2hM1WG_DfqtcNXFQitF0uYK7QlH22b7wg&usqp=CAU"
                                                                  }
                                                              ]
                                                          },
                                                          {
                                                              "id": "7b8e6e8d-a202-4927-9bb9-9124a3049c4e",
                                                              "imagen": "https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                                                              "name": "Fanta",
                                                              "precio": 5.0,
                                                              "disponible": true,
                                                              "comercio": null,
                                                              "ingredientes": []
                                                          },
                                                          {
                                                              "id": "3f33b5a5-bc9a-4b4c-9d6f-0935379d7e61",
                                                              "imagen": "https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                                                              "name": "CocaCola",
                                                              "precio": 5.0,
                                                              "disponible": true,
                                                              "comercio": null,
                                                              "ingredientes": []
                                                          }
                                                      ],
                                                      "favoritoList": [
                                                          {
                                                              "id": {
                                                                  "usuarioId": "5d818565-99f9-4d80-920e-8259c6ecb8e6",
                                                                  "comercioId": "aee5e900-9dad-11d1-80b4-00c04fd430c9"
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
    @GetMapping("/usuario/buscar/id/{id}")
    public ResponseEntity<?> findById(@PathVariable UUID id){
        Comercio comercio = comercioService.finfbyid(id);
        return ResponseEntity.ok(comercio);

    }
    @Operation(summary = "Buscar comercio por id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha encontrado el comercio",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Comercio.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                      
                                                  {
                                                      "id": "aee5e900-9dad-11d1-80b4-00c04fd430c9",
                                                      "imagen": "fotoPruebaComercio_755114.jpeg",
                                                      "name": "Supermercado",
                                                      "latitud": 37.268698190432744,
                                                      "longitud": -6.065863976966079,
                                                      "rating": 4.6,
                                                      "nameDirection": "Coria del Rio",
                                                      "categorias": [
                                                          "TIENDACOMESTIBLES"
                                                      ],
                                                      "productos": [
                                                          {
                                                              "id": "b714eea5-9b28-4e8c-b189-83d8fc14a834",
                                                              "imagen": "https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                                                              "name": "Hamburguesa",
                                                              "precio": 5.0,
                                                              "disponible": true,
                                                              "comercio": null,
                                                              "ingredientes": [
                                                                  {
                                                                      "id": "241149d3-01e0-4ab6-ab80-d5839d08d2dd",
                                                                      "name": "queso",
                                                                      "imagen": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-aJrV-c_wMpQuZd9CGVpTmGIxYsBBSD5Y9w&usqp=CAU"
                                                                  },
                                                                  {
                                                                      "id": "9dcc75d8-4b5d-4d1f-a4c8-fcae5b85b0ff",
                                                                      "name": "bacon",
                                                                      "imagen": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToq2hM1WG_DfqtcNXFQitF0uYK7QlH22b7wg&usqp=CAU"
                                                                  }
                                                              ]
                                                          },
                                                          {
                                                              "id": "7b8e6e8d-a202-4927-9bb9-9124a3049c4e",
                                                              "imagen": "https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                                                              "name": "Fanta",
                                                              "precio": 5.0,
                                                              "disponible": true,
                                                              "comercio": null,
                                                              "ingredientes": []
                                                          },
                                                          {
                                                              "id": "3f33b5a5-bc9a-4b4c-9d6f-0935379d7e61",
                                                              "imagen": "https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                                                              "name": "CocaCola",
                                                              "precio": 5.0,
                                                              "disponible": true,
                                                              "comercio": null,
                                                              "ingredientes": []
                                                          }
                                                      ],
                                                      "favoritoList": [
                                                          {
                                                              "id": {
                                                                  "usuarioId": "5d818565-99f9-4d80-920e-8259c6ecb8e6",
                                                                  "comercioId": "aee5e900-9dad-11d1-80b4-00c04fd430c9"
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
    @GetMapping("/administrador/buscar/id/{id}")
    public ResponseEntity<?> findByIdComercio(@PathVariable UUID id){
        Comercio comercio = comercioService.finfbyid(id);
        return ResponseEntity.ok(comercio);

    }
    @Operation(summary = "Buscar comercio por id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha encontrado el comercio",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GetListComercios.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                      
                                                 [
                                                     {
                                                         "id": "8cc3e900-9dad-11d1-80b4-00c04fd430c9",
                                                         "name": "Bar Osso",
                                                         "rating": 4.2,
                                                         "nameDirection": "La puebla del rio",
                                                         "imagen": "fotoPruebaComercio_755114.jpeg",
                                                         "latitud": 37.272804495539006,
                                                         "longitud": -6.062129797459527,
                                                         "categorias": "BAR"
                                                     },
                                                     {
                                                         "id": "efe9e900-9dad-11d1-80b4-00c04fd430c9",
                                                         "name": "Tienda SportMax",
                                                         "rating": 4.2,
                                                         "nameDirection": "La puebla del rio",
                                                         "imagen": "fotoPruebaComercio_755114.jpeg",
                                                         "latitud": 37.26461146346672,
                                                         "longitud": -6.0604388183971745,
                                                         "categorias": "BAR"
                                                     },
                                                     {
                                                         "id": "ffeae900-9dad-11d1-80b4-00c04fd430c9",
                                                         "name": "CafeterÃ­a ",
                                                         "rating": 4.6,
                                                         "nameDirection": "La puebla del rio",
                                                         "imagen": "fotoPruebaComercio_755114.jpeg",
                                                         "latitud": 37.26320511204529,
                                                         "longitud": -6.063870937788194,
                                                         "categorias": "BAR"
                                                     },
                                                     {
                                                         "id": "84c5311a-0251-4808-9989-ac5ada8cf517",
                                                         "name": "Nuevo comercio",
                                                         "rating": 0.0,
                                                         "nameDirection": "La puebla del rio",
                                                         "imagen": "OIP_818702_077602.jpeg",
                                                         "latitud": 37.26452441509684,
                                                         "longitud": -6.060504913330078,
                                                         "categorias": "BAR"
                                                     },
                                                     {
                                                         "id": "ec011e7d-0a51-41ef-8448-717a37767d77",
                                                         "name": "BaseDeDatos",
                                                         "rating": 0.0,
                                                         "nameDirection": "dhdasdsd",
                                                         "imagen": "OIP_246488_156042.jpeg",
                                                         "latitud": 37.26452441509684,
                                                         "longitud": -6.060504913330078,
                                                         "categorias": "BAR"
                                                     }
                                                 ]
                                                    
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Not found",
                    content = @Content)
    })
    @GetMapping("usuario/filtrar/comercios/{categoria}")
    public ResponseEntity<List<GetListComercios>> getComerciosPorCategoria(@PathVariable CategoriaComercios categoria) {
        List<GetListComercios> comercios= comercioService.getComerciosPorCategoria(categoria);
        return ResponseEntity.ok(comercios);
    }
    @Operation(summary = "Buscar comercio por id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha encontrado el comercio",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GetListComercios.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                      
                                                 [
                                                     {
                                                         "id": "8cc3e900-9dad-11d1-80b4-00c04fd430c9",
                                                         "name": "Bar Osso",
                                                         "rating": 4.2,
                                                         "nameDirection": "La puebla del rio",
                                                         "imagen": "fotoPruebaComercio_755114.jpeg",
                                                         "latitud": 37.272804495539006,
                                                         "longitud": -6.062129797459527,
                                                         "categorias": "BAR"
                                                     },
                                                     {
                                                         "id": "efe9e900-9dad-11d1-80b4-00c04fd430c9",
                                                         "name": "Tienda SportMax",
                                                         "rating": 4.2,
                                                         "nameDirection": "La puebla del rio",
                                                         "imagen": "fotoPruebaComercio_755114.jpeg",
                                                         "latitud": 37.26461146346672,
                                                         "longitud": -6.0604388183971745,
                                                         "categorias": "BAR"
                                                     },
                                                     {
                                                         "id": "ffeae900-9dad-11d1-80b4-00c04fd430c9",
                                                         "name": "CafeterÃ­a ",
                                                         "rating": 4.6,
                                                         "nameDirection": "La puebla del rio",
                                                         "imagen": "fotoPruebaComercio_755114.jpeg",
                                                         "latitud": 37.26320511204529,
                                                         "longitud": -6.063870937788194,
                                                         "categorias": "BAR"
                                                     },
                                                     {
                                                         "id": "84c5311a-0251-4808-9989-ac5ada8cf517",
                                                         "name": "Nuevo comercio",
                                                         "rating": 0.0,
                                                         "nameDirection": "La puebla del rio",
                                                         "imagen": "OIP_818702_077602.jpeg",
                                                         "latitud": 37.26452441509684,
                                                         "longitud": -6.060504913330078,
                                                         "categorias": "BAR"
                                                     },
                                                     {
                                                         "id": "ec011e7d-0a51-41ef-8448-717a37767d77",
                                                         "name": "BaseDeDatos",
                                                         "rating": 0.0,
                                                         "nameDirection": "dhdasdsd",
                                                         "imagen": "OIP_246488_156042.jpeg",
                                                         "latitud": 37.26452441509684,
                                                         "longitud": -6.060504913330078,
                                                         "categorias": "BAR"
                                                     }
                                                 ]
                                                    
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Not found",
                    content = @Content)
    })
    @GetMapping("administrador/filtrar/comercios/{categoria}")
    public ResponseEntity<List<GetListComercios>> filtrarPorCategoria(@PathVariable CategoriaComercios categoria){
        List<GetListComercios> comercios= comercioService.getComerciosPorCategoria(categoria);
        return ResponseEntity.ok(comercios);
    }
    @Operation(summary = "Eliminar comercio por id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204",
                    description = "Se ha borrado el comercio",
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
    @DeleteMapping("administrador/eliminar/comercio/{comercioId}")
    public ResponseEntity<?> eliminarComercio(@PathVariable UUID comercioId){
        comercioService.elimarComercio(comercioId);
        return ResponseEntity.noContent().build();
    }
    @Operation(summary = "Eliminar comercio por id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se ha borrado el comercio",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Comercio.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {     
                                                          "categorias":"BAR",
                                                          "favoritoList": null,
                                                          "id": "ec011e7d-0a51-41ef-8448-717a37767d77",
                                                          "imagen": "OIP_246488_156042.jpeg",
                                                          "latitud": 37.26452441509684,
                                                          "longitud": -6.060504913330078,
                                                          "name": "BaseDeDatos",
                                                          "nameDirection": "dhdasdsd",
                                                          "productos": null,
                                                          "rating": 0
                                                                                                    },
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Not found",
                    content = @Content)
    })
    @PutMapping("administrador/editar/comercio/{comercioId}")
    public ResponseEntity<Comercio> editarComercio(@PathVariable UUID comercioId,@RequestPart("comercio") String comercioJson, @RequestPart("file") MultipartFile file){
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            PostCrearComercio postCrearComercio = objectMapper.readValue(comercioJson, PostCrearComercio.class);
            Comercio comercio = comercioService.editarComercio(comercioId, postCrearComercio, file);
            return ResponseEntity.status(201).body(comercio);
        }catch (Exception e){
            throw new GlobalException(e.getMessage());
        }
    }
}
