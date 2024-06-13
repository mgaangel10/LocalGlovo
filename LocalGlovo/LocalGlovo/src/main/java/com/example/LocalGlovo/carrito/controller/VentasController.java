package com.example.LocalGlovo.carrito.controller;

import com.example.LocalGlovo.Exception.GlobalException;
import com.example.LocalGlovo.carrito.models.Ventas;
import com.example.LocalGlovo.carrito.service.VentasService;
import com.example.LocalGlovo.comercios.models.Comercio;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequiredArgsConstructor
public class VentasController {

    private final VentasService ventasService;

    @Operation(summary = "Ver ventas de una fecha")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha encontrado una venta para ese dia",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Comercio.class)),
                            examples = {@ExampleObject(
                                    value = """
                                               {
                                                                                                            "id": "c90f7de8-bf6f-41aa-9838-f5e4464cd3bb",
                                                                                                            "total": 5.0,
                                                                                                            "usuarios": [
                                                                                                                {
                                                                                                                    "id": "5d818565-99f9-4d80-920e-8259c6ecb8e6",
                                                                                                                    "email": "pedro@gmail.com",
                                                                                                                    "username": "pedro@gmail.com",
                                                                                                                    "password": "{bcrypt}$2a$10$05HASeZdtwl8NS/nWbNMJOU07tiGZ9Z/mVE2Z.FKhsyjkCK7yuLqa",
                                                                                                                    "name": "Pedro",
                                                                                                                    "lastName": "pepe",
                                                                                                                    "phoneNumber": "383838",
                                                                                                                    "birthDate": null,
                                                                                                                    "fotoUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQciKN1y59CDYMq-IALg7OUijN7hIiM8hdzKw&usqp=CAU",
                                                                                                                    "accountNonExpired": true,
                                                                                                                    "accountNonLocked": true,
                                                                                                                    "credentialsNonExpired": true,
                                                                                                                    "enabled": true,
                                                                                                                    "roles": [
                                                                                                                        "USER"
                                                                                                                    ],
                                                                                                                    "createdAt": null,
                                                                                                                    "lastPasswordChangeAt": null,
                                                                                                                    "usuarios": [],
                                                                                                                    "inChargeof": [],
                                                                                                                    "favoritos": [
                                                                                                                        {
                                                                                                                            "id": {
                                                                                                                                "usuarioId": "5d818565-99f9-4d80-920e-8259c6ecb8e6",
                                                                                                                                "comercioId": "aee5e900-9dad-11d1-80b4-00c04fd430c9"
                                                                                                                            }
                                                                                                                        }
                                                                                                                    ],
                                                                                                                    "authorities": [
                                                                                                                        {
                                                                                                                            "authority": "ROLE_USER"
                                                                                                                        }
                                                                                                                    ]
                                                                                                                }
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
                                                                                                            "fecha": "2024-06-11",
                                                                                                            "comercios": []
                                                                                                        }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Not found",
                    content = @Content)
    })
    @GetMapping("administrador/ver/ventas/{localDate}")
    public ResponseEntity<Ventas> verVentas(@PathVariable LocalDate localDate){
        try {
            Ventas ventas = ventasService.obtenerventa(localDate);
            return ResponseEntity.ok(ventas);
        }catch (Exception e){
            throw new GlobalException(e.getMessage());
        }

    }
    @Operation(summary = "Ver comercios con mas likes")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha listado los 5 comercios con mas likes",
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
                                                       "likes": false,
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
                                                   },
                                                   {
                                                       "id": "f89f898a-70aa-48d5-8088-3f3c892d7bae",
                                                       "imagen": "fotoPruebaComercio_755114.jpeg",
                                                       "name": "Las Lozas",
                                                       "latitud": 37.2700843067059,
                                                       "longitud": -6.063028856447782,
                                                       "rating": 4.8,
                                                       "nameDirection": "La puebla del rio",
                                                       "likes": false,
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
                                                   {
                                                       "id": "123e4567-e89b-12d3-a456-426614174000",
                                                       "imagen": "fotoPruebaComercio_755114.jpeg",
                                                       "name": "Felipon",
                                                       "latitud": 37.27203372064043,
                                                       "longitud": -6.066180282066359,
                                                       "rating": 4.8,
                                                       "nameDirection": "La puebla del rio",
                                                       "likes": false,
                                                       "categorias": [
                                                           "CARNECERIA"
                                                       ],
                                                       "productos": [],
                                                       "favoritoList": []
                                                   },
                                                   {
                                                       "id": "7bb2e900-9dad-11d1-80b4-00c04fd430c9",
                                                       "imagen": "fotoPruebaComercio_755114.jpeg",
                                                       "name": "Tienda Bendicion",
                                                       "latitud": 37.272149626637564,
                                                       "longitud": -6.06192884623146,
                                                       "rating": 4.5,
                                                       "nameDirection": "La puebla del rio",
                                                       "likes": false,
                                                       "categorias": [
                                                           "TIENDAROPA"
                                                       ],
                                                       "productos": [],
                                                       "favoritoList": []
                                                   },
                                                   {
                                                       "id": "8cc3e900-9dad-11d1-80b4-00c04fd430c9",
                                                       "imagen": "fotoPruebaComercio_755114.jpeg",
                                                       "name": "Bar Osso",
                                                       "latitud": 37.272804495539006,
                                                       "longitud": -6.062129797459527,
                                                       "rating": 4.2,
                                                       "nameDirection": "La puebla del rio",
                                                       "likes": false,
                                                       "categorias": [
                                                           "BAR"
                                                       ],
                                                       "productos": [],
                                                       "favoritoList": []
                                                   }
                                               ]
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Not found",
                    content = @Content)
    })
    @GetMapping("administrador/ver/comercios/mayor/likes")
    public ResponseEntity<List<Comercio>> verComercioMayorLikes(){
        List<Comercio> comercios = ventasService.comercioConMasLikes();
        return ResponseEntity.ok(comercios);
    }



}
