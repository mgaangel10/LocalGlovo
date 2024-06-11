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
    @Operation(summary = "Crear un producto")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se ha r" +
                            "creado el comercio",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Producto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                               { disponible: true
                                                id: "d153a08a-e1c0-4aeb-98e1-f19c832c8d11"
                                                imagen: "OIP_818702_077602_203009.jpeg"
                                                ingredientes: null
                                                name: "Nuevo producto"
                                                precio: 7}
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "400",
                    description = "Bad Request",
                    content = @Content)
    })

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
    @Operation(summary = "Listar todos los productos")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha listado los productos",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = GetListProducto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                               {
                                                             "content": [
                                                                 {
                                                                     "imagen": "https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                                                                     "name": "Hamburguesa",
                                                                     "precio": 5.0,
                                                                     "disponible": true
                                                                 },
                                                                 {
                                                                     "imagen": "https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                                                                     "name": "Manzana",
                                                                     "precio": 5.0,
                                                                     "disponible": true
                                                                 },
                                                                 {
                                                                     "imagen": "https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                                                                     "name": "CocaCola",
                                                                     "precio": 5.0,
                                                                     "disponible": true
                                                                 },
                                                                 {
                                                                     "imagen": "https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                                                                     "name": "Fanta",
                                                                     "precio": 5.0,
                                                                     "disponible": true
                                                                 },
                                                                 {
                                                                     "imagen": "OIP_818702_077602_203009.jpeg",
                                                                     "name": "Nuevo producto",
                                                                     "precio": 7.0,
                                                                     "disponible": true
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
                                                             "last": true,
                                                             "totalElements": 5,
                                                             "totalPages": 1,
                                                             "first": true,
                                                             "size": 10,
                                                             "number": 0,
                                                             "sort": {
                                                                 "empty": true,
                                                                 "sorted": false,
                                                                 "unsorted": true
                                                             },
                                                             "numberOfElements": 5,
                                                             "empty": false
                                                         }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Not found",
                    content = @Content)
    })
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
   @Operation(summary = "Buscar ingrediente por id")
   @ApiResponses(value = {
           @ApiResponse(responseCode = "200",
                   description = "Se ha encontrado el ingrediente",
                   content = {@Content(mediaType = "application/json",
                           array = @ArraySchema(schema = @Schema(implementation = Ingredientes.class)),
                           examples = {@ExampleObject(
                                   value = """
                                             {
                                                    "id": "241149d3-01e0-4ab6-ab80-d5839d08d2dd",
                                                    "name": "queso",
                                                    "imagen": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-aJrV-c_wMpQuZd9CGVpTmGIxYsBBSD5Y9w&usqp=CAU"
                                                        }
                                           """
                           )}
                   )}),
           @ApiResponse(responseCode = "404",
                   description = "Not found",
                   content = @Content)
   })
    @GetMapping("usuario/ingredientes/{id}")
    public ResponseEntity<?> buscarPorId(@PathVariable UUID id){
        Ingredientes ingredientes = productoService.finByIdIngredientes(id);
        return ResponseEntity.ok(ingredientes);
    }
    @Operation(summary = "Buscar un producto por id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha encontrado el producto",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Producto.class)),
                            examples = {@ExampleObject(
                                    value = """
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
                                                           }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Not found",
                    content = @Content)
    })
    @GetMapping("usuario/productos/{id}")
    public ResponseEntity<?> buscarPorIdProductos(@PathVariable UUID id){
        Producto producto = productoService.buscarPorID(id);
        return ResponseEntity.ok(producto);
    }
    @Operation(summary = "Buscar un producto por id")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha encontrado el producto",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Producto.class)),
                            examples = {@ExampleObject(
                                    value = """
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
                                                           }
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Not found",
                    content = @Content)
    })
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
   @Operation(summary = "Borrar un producto")
   @ApiResponses(value = {
           @ApiResponse(responseCode = "204",
                   description = "Se ha borrado el producto",
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
    @DeleteMapping("administrador/delete/producto/{productoId}")
    public ResponseEntity<?> EliminarProducto (@PathVariable UUID productoId){
        try {
            productoService.eliminarProducto(productoId);
            return  ResponseEntity.noContent().build();
        }catch (Exception e){
            throw new GlobalException(e.getMessage());
        }

    }
    @Operation(summary = "Crear ingredientes")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se ha creado el ingrediente",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Ingredientes.class)),
                            examples = {@ExampleObject(
                                    value = """
                                              id: "0300b1eb-2061-4236-8355-f8149540ad93"
                                              imagen: "fotoPruebaComercio_008187_402744.jpeg"
                                              name: "Nuevo ingrediente"
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "400",
                    description = "Bad Request",
                    content = @Content)
    })
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
    @Operation(summary = "Borra ingredientes")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204",
                    description = "Se ha borrado el ingrediente",
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
    @DeleteMapping("administrador/eliminar/{ingredientesId}")
    public ResponseEntity<?> eliminarIngredientes(@PathVariable UUID ingredientesId){
        try{
            productoService.eliminarIngrediente(ingredientesId);
            return ResponseEntity.noContent().build();
        }catch (Exception e){
            throw new GlobalException(e.getMessage());
        }

    }
    @Operation(summary = "Editar producto")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se ha editado el producto",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Producto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                               { disponible: true
                                                id: "d153a08a-e1c0-4aeb-98e1-f19c832c8d11"
                                                imagen: "OIP_818702_077602_203009.jpeg"
                                                ingredientes: null
                                                name: "Nuevo producto"
                                                precio: 7}
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Not found",
                    content = @Content)
    })
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
