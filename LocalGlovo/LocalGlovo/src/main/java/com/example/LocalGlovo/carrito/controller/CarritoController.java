package com.example.LocalGlovo.carrito.controller;

import com.example.LocalGlovo.Exception.GlobalException;
import com.example.LocalGlovo.carrito.Dto.GetCarritoDto;
import com.example.LocalGlovo.carrito.Dto.LineaCarritoDto;
import com.example.LocalGlovo.carrito.models.Carrito;
import com.example.LocalGlovo.carrito.service.CarritoService;
import com.example.LocalGlovo.comercios.models.Comercio;
import com.example.LocalGlovo.productos.model.Producto;
import com.example.LocalGlovo.productos.service.ProductoService;
import com.example.LocalGlovo.users.model.Usuario;
import com.example.LocalGlovo.users.service.UsuarioService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
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


    @Operation(summary = "agregar un producto al carrito")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se ha agregado el producto al carrito",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Comercio.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                                                                          "id": "6719091c-ba8a-46b4-bece-3bac3e1f3a78",
                                                                                                          "cantidad": 1,
                                                                                                          "total": 5.0,
                                                                                                          "lineasCarrito": [
                                                                                                              {
                                                                                                                  "id": "0a4d14aa-15e7-46dc-ac18-31ea793ab999",
                                                                                                                  "producto": {
                                                                                                                      "id": "7b8e6e8d-a202-4927-9bb9-9124a3049c4e",
                                                                                                                      "imagen": "https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                                                                                                                      "name": "Fanta",
                                                                                                                      "precio": 5.0,
                                                                                                                      "disponible": true,
                                                                                                                      "comercio": null,
                                                                                                                      "ingredientes": []
                                                                                                                  },
                                                                                                                  "cantidad": 1,
                                                                                                                  "total": 5.0
                                                                                                              }
                                                                                                          ],
                                                                                                          "usuario": {
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
                                                                                                          },
                                                                                                          "estado": "ACTIVO"
                                                                                                      }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Not found",
                    content = @Content)
    })
    @PostMapping("usuario/{usuarioId}/agregar/carrito/{productoId}")
    public ResponseEntity<Carrito> agregarAlCarrito(@PathVariable UUID usuarioId, @PathVariable UUID productoId) {
        Optional<Usuario> usuario = usuarioService.findById(usuarioId);
        Producto producto = productoService.buscarPorID(productoId);
        carritoService.agregarProductoAlCarrito(usuario.get(), producto);
        Carrito carrito= carritoService.buscarCarritoActivoDelUsuario(usuario.get());
        return ResponseEntity.status(201).body(carrito);
    }

    @Operation(summary = "Buscar un carrito por id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha encontrado el carrito",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Comercio.class)),
                            examples = {@ExampleObject(
                                    value = """
                                               {
                                                                                                           "id": "6719091c-ba8a-46b4-bece-3bac3e1f3a78",
                                                                                                           "cantidad": 1,
                                                                                                           "total": 5.0,
                                                                                                           "lineasCarrito": [
                                                                                                               {
                                                                                                                   "id": "0a4d14aa-15e7-46dc-ac18-31ea793ab999",
                                                                                                                   "producto": {
                                                                                                                       "id": "7b8e6e8d-a202-4927-9bb9-9124a3049c4e",
                                                                                                                       "imagen": "https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                                                                                                                       "name": "Fanta",
                                                                                                                       "precio": 5.0,
                                                                                                                       "disponible": true,
                                                                                                                       "comercio": null,
                                                                                                                       "ingredientes": []
                                                                                                                   },
                                                                                                                   "cantidad": 1,
                                                                                                                   "total": 5.0
                                                                                                               }
                                                                                                           ],
                                                                                                           "usuario": {
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
                                                                                                           },
                                                                                                           "estado": "ACTIVO"
                                                                                                       }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Not found",
                    content = @Content)
    })
    @GetMapping("usuario/buscar/carrito/{uuid}")
    public ResponseEntity<Carrito> buscar(@PathVariable UUID uuid){
        try {
            Optional<Carrito> carrito = carritoService.buscarCarritoPorIdV2(uuid);
            return ResponseEntity.ok(carrito.get());
        }catch (Exception e){
            throw new GlobalException(e.getMessage());
        }
    }


    @Operation(summary = "eliminar Cantidad de producto del carrito")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204",
                    description = "Se ha borrado el productos del carrito",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Comercio.class)),
                            examples = {@ExampleObject(
                                    value = """
                                               {
                                                                                                           "id": "6719091c-ba8a-46b4-bece-3bac3e1f3a78",
                                                                                                           "cantidad": 0,
                                                                                                           "total": 0.0,
                                                                                                           "lineasCarrito": [
                                                                                                              
                                                                                                           ],
                                                                                                           "usuario": {
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
                                                                                                           },
                                                                                                           "estado": "ACTIVO"
                                                                                                       }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Not found",
                    content = @Content)
    })
    @DeleteMapping("usuario/eliminar/producto/carrito/{carritoId}/{productoId}")
    public ResponseEntity<?> eliminarProductoDelCarrito(@PathVariable UUID carritoId,@PathVariable UUID productoId){
        carritoService.eliminarProductoDelCarrito(carritoId,productoId);
        return ResponseEntity.noContent().build();
    }
    @Operation(summary = "Terminar carrito")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se ha termiando el carrito",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Comercio.class)),
                            examples = {@ExampleObject(
                                    value = """
                                               {
                                                                                                           "id": "6719091c-ba8a-46b4-bece-3bac3e1f3a78",
                                                                                                           "cantidad": 1,
                                                                                                           "total": 5.0,
                                                                                                           "lineasCarrito": [
                                                                                                               {
                                                                                                                   "id": "0a4d14aa-15e7-46dc-ac18-31ea793ab999",
                                                                                                                   "producto": {
                                                                                                                       "id": "7b8e6e8d-a202-4927-9bb9-9124a3049c4e",
                                                                                                                       "imagen": "https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                                                                                                                       "name": "Fanta",
                                                                                                                       "precio": 5.0,
                                                                                                                       "disponible": true,
                                                                                                                       "comercio": null,
                                                                                                                       "ingredientes": []
                                                                                                                   },
                                                                                                                   "cantidad": 1,
                                                                                                                   "total": 5.0
                                                                                                               }
                                                                                                           ],
                                                                                                           "usuario": {
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
                                                                                                           },
                                                                                                           "estado": "TERMINADO"
                                                                                                       }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Not found",
                    content = @Content)
    })
    @PostMapping("usuario/terminar/carrito/{id}")
    public ResponseEntity<Carrito> terminarCarrito(@PathVariable UUID id){
        Carrito carrito = carritoService.TerminarCarrito(id);
        return  ResponseEntity.status(201).body(carrito);
    }

}
