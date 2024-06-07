package com.example.LocalGlovo.users.controller;


import com.example.LocalGlovo.Exception.GlobalException;
import com.example.LocalGlovo.comercios.Dto.PostCrearComercio;
import com.example.LocalGlovo.security.jwt.JwtProvider;
import com.example.LocalGlovo.users.Dto.JwtUserResponse;
import com.example.LocalGlovo.users.Dto.PostCrearUserDto;
import com.example.LocalGlovo.users.Dto.PostLogin;
import com.example.LocalGlovo.users.Dto.PostRegistroDto;
import com.example.LocalGlovo.users.model.Administrador;
import com.example.LocalGlovo.users.model.Usuario;
import com.example.LocalGlovo.users.service.AdministradorService;
import com.example.LocalGlovo.users.service.UsuarioService;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.core.Authentication;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class AdministradorController {

    private final AdministradorService administradorService;
    private final UsuarioService usuarioService;
    private final AuthenticationManager authenticationManager;
    private final JwtProvider jwtProvider;

    @Operation(summary = "Crear un administrador")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se ha creado un administrador correctamente",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = PostCrearUserDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                       {"id":"e3ccd792-2ceb-44ad-97df-6a660d67e01c",
                                                       "fullname":"aa perez",
                                                       "username":"perez@gmail.cm",
                                                       "email":"perez@gmail.cm",
                                                       "creadoen":"2023-12-29T17:04:20.4570273"}
                                                    },
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "400",
                    description = "Bad request",
                    content = @Content)
    })
    @PostMapping("auth/register/admin")
    public ResponseEntity<?> crearAdministrador(@RequestPart("admin") String adminJson, @RequestPart("file") MultipartFile file) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            PostCrearUserDto postCrearComercio = objectMapper.readValue(adminJson, PostCrearUserDto.class);
            Administrador administrador = administradorService.createWithRole(postCrearComercio,file);
            return ResponseEntity.status(HttpStatus.CREATED).body(PostRegistroDto.Administrador(administrador));
        } catch (Exception e) {

           throw new GlobalException(e.getMessage());
        }
    }

    @Operation(summary = "Login de un administrador")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se ha logeado un administrador correctamente",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = PostCrearUserDto.class)),
                            examples = {@ExampleObject(
                                    value = """
                                                {
                                                           "id": "e3ccd792-2ceb-44ad-97df-6a660d67e01c",
                                                                                                    "fullname": "aa perez",
                                                                                                    "username": "perez@gmail.cm",
                                                                                                    "email": "perez@gmail.cm",
                                                                                                    "creadoen": "2023-12-29T17:04:20.457027",
                                                                                                    "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJlM2NjZDc5Mi0y
                                                                                                    Y2ViLTQ0YWQtOTdkZi02YTY2MGQ2N2UwMWMiLCJpYXQiOjE3MDM5NTI2Mjh9.
                                                                                                    uLRxPcoKmn_bhWdIMe_MoUUElUw57Km3iJtdbKVkuOUeaXJfqBaGrEu2I6Ob1mIBJo8Z7eQYzItUw3Eh7Cq3XQ"
                                                    },
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "401",
                    description = "UNAUTHORIZED",
                    content = @Content)
    })
    @PostMapping("auth/login/admin")
    public ResponseEntity<JwtUserResponse> loginadmin(@RequestBody PostLogin postLogin){
        administradorService.setearEnabled(postLogin);
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        postLogin.email(),
                        postLogin.password()
                )
        );
        SecurityContextHolder.getContext().setAuthentication(authentication);
        String token = jwtProvider.generateToken(authentication);
        Administrador administrador = (Administrador) authentication.getPrincipal();
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(JwtUserResponse.ofAdminsitrador(administrador, token));
    }
    @Operation(summary = "Banear cuentas de usuario")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se ha baneado la cuenta de un usuario",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Usuario.class)),
                            examples = {@ExampleObject(
                                    value = """
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
                                                          "enabled": false,
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
                                            """
                            )}
                    )}),
            @ApiResponse(responseCode = "404",
                    description = "Not found",
                    content = @Content)
    })
    @PostMapping("administrador/quitar/cuenta/usuario/{usuarioId}")
    public ResponseEntity<Usuario> quitarCuentaUsuario(@PathVariable UUID usuarioId){
        Usuario usuario = administradorService.setearEneable(usuarioId);
        return ResponseEntity.status(201).body(usuario);
    }
    @Operation(summary = "Listar todos los usuarios")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha listado los usuarios",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Usuario.class)),
                            examples = {@ExampleObject(
                                    value = """
                                              [
                                                           {
                                                               "id": "6f1b8ae1-d1cb-491d-a73c-abf8c3e829d0",
                                                               "email": "jose@gmail.com",
                                                               "username": "jose@gmail.com",
                                                               "password": "{bcrypt}$2a$10$05HASeZdtwl8NS/nWbNMJOU07tiGZ9Z/mVE2Z.FKhsyjkCK7yuLqa",
                                                               "name": "Jose",
                                                               "lastName": "perez",
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
                                                               "favoritos": [],
                                                               "authorities": [
                                                                   {
                                                                       "authority": "ROLE_USER"
                                                                   }
                                                               ]
                                                           },
                                                           {
                                                               "id": "e9ef3d6f-5e47-4218-bd23-495ce3176dbd",
                                                               "email": "antonio@gmail.com",
                                                               "username": "antonio@gmail.com",
                                                               "password": "{bcrypt}$2a$10$05HASeZdtwl8NS/nWbNMJOU07tiGZ9Z/mVE2Z.FKhsyjkCK7yuLqa",
                                                               "name": "Antonio",
                                                               "lastName": "macias",
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
                                                               "favoritos": [],
                                                               "authorities": [
                                                                   {
                                                                       "authority": "ROLE_USER"
                                                                   }
                                                               ]
                                                           },
                                                           {
                                                               "id": "8e221cbb-7edd-4943-b643-fcb2f34deb19",
                                                               "email": "juan@gmail.com",
                                                               "username": "juan@gmail.com",
                                                               "password": "{bcrypt}$2a$10$05HASeZdtwl8NS/nWbNMJOU07tiGZ9Z/mVE2Z.FKhsyjkCK7yuLqa",
                                                               "name": "Juan",
                                                               "lastName": "pepe",
                                                               "phoneNumber": "383838",
                                                               "birthDate": null,
                                                               "fotoUrl": "https://previews.123rf.com/images/jemastock/jemastock1712/jemastock171209328/91942350-dise%C3%B1o-gr%C3%A1fico-del-ejemplo-del-vector-del-icono-del-avatar-del-perfil-del-hombre-de-negocios.jpg",
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
                                                               "favoritos": [],
                                                               "authorities": [
                                                                   {
                                                                       "authority": "ROLE_USER"
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
    @GetMapping("administrador/ver/usuarios")
    public ResponseEntity<List<Usuario>> listarUsuario(){
        List<Usuario> usuarios = administradorService.listadoUsuarios();
        return ResponseEntity.ok(usuarios);
    }
    @Operation(summary = "Ver administrador logueado")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se ha mostrado el admin logueado",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Usuario.class)),
                            examples = {@ExampleObject(
                                    value = """
                                             {
                                                 "id": "a23c61eb-4a5a-4cdd-beea-44234583ff4c",
                                                 "email": "angel@gmail.com",
                                                 "username": "angel@gmail.com",
                                                 "password": "{bcrypt}$2a$10$05HASeZdtwl8NS/nWbNMJOU07tiGZ9Z/mVE2Z.FKhsyjkCK7yuLqa",
                                                 "name": "Angel",
                                                 "lastName": "perez",
                                                 "phoneNumber": "383838",
                                                 "birthDate": null,
                                                 "fotoUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQciKN1y59CDYMq-IALg7OUijN7hIiM8hdzKw&usqp=CAU",
                                                 "accountNonExpired": true,
                                                 "accountNonLocked": true,
                                                 "credentialsNonExpired": true,
                                                 "enabled": true,
                                                 "roles": [
                                                     "ADMINISTRADOR"
                                                 ],
                                                 "createdAt": null,
                                                 "lastPasswordChangeAt": null,
                                                 "puesto": null,
                                                 "authorities": [
                                                     {
                                                         "authority": "ROLE_ADMINISTRADOR"
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

    @GetMapping("administrador/logueado")
    public ResponseEntity<Administrador> getLoggedAdministrador() {
        Administrador administrador = administradorService.getLoggedAdministrador();
        return ResponseEntity.ok(administrador);
    }
    @Operation(summary = "Cerrar sesion del administrador")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se ha deslogueado el administrador",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Administrador.class)),
                            examples = {@ExampleObject(
                                    value = """
                                             {
                                                 "id": "a23c61eb-4a5a-4cdd-beea-44234583ff4c",
                                                 "email": "angel@gmail.com",
                                                 "username": "angel@gmail.com",
                                                 "password": "{bcrypt}$2a$10$05HASeZdtwl8NS/nWbNMJOU07tiGZ9Z/mVE2Z.FKhsyjkCK7yuLqa",
                                                 "name": "Angel",
                                                 "lastName": "perez",
                                                 "phoneNumber": "383838",
                                                 "birthDate": null,
                                                 "fotoUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQciKN1y59CDYMq-IALg7OUijN7hIiM8hdzKw&usqp=CAU",
                                                 "accountNonExpired": true,
                                                 "accountNonLocked": true,
                                                 "credentialsNonExpired": true,
                                                 "enabled": true,
                                                 "roles": [
                                                     "ADMINISTRADOR"
                                                 ],
                                                 "createdAt": null,
                                                 "lastPasswordChangeAt": null,
                                                 "puesto": null,
                                                 "authorities": [
                                                     {
                                                         "authority": "ROLE_ADMINISTRADOR"
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
    @PostMapping("administrador/logout/{id}")
    public ResponseEntity<Administrador> logOut(@PathVariable UUID id){
        Administrador administrador = administradorService.logOut(id);
        return ResponseEntity.status(201).body(administrador);
    }
    @Operation(summary = "Buscar usuario por email")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201",
                    description = "Se ha encontrado al usuario",
                    content = {@Content(mediaType = "application/json",
                            array = @ArraySchema(schema = @Schema(implementation = Usuario.class)),
                            examples = {@ExampleObject(
                                    value = """
                                            [
                                                {
                                                    "id": "8e221cbb-7edd-4943-b643-fcb2f34deb19",
                                                    "email": "juan@gmail.com",
                                                    "username": "juan@gmail.com",
                                                    "password": "{bcrypt}$2a$10$05HASeZdtwl8NS/nWbNMJOU07tiGZ9Z/mVE2Z.FKhsyjkCK7yuLqa",
                                                    "name": "Juan",
                                                    "lastName": "pepe",
                                                    "phoneNumber": "383838",
                                                    "birthDate": null,
                                                    "fotoUrl": "https://previews.123rf.com/images/jemastock/jemastock1712/jemastock171209328/91942350-dise%C3%B1o-gr%C3%A1fico-del-ejemplo-del-vector-del-icono-del-avatar-del-perfil-del-hombre-de-negocios.jpg",
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
                                                    "favoritos": [],
                                                    "authorities": [
                                                        {
                                                            "authority": "ROLE_USER"
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
    @GetMapping("administrador/buscar/usuario/{buscar}")
    public ResponseEntity<List<Usuario>> buscarUsuario(@PathVariable String buscar){
        List<Usuario> usuarios = administradorService.buscarUsuario(buscar);
        return ResponseEntity.ok(usuarios);
    }



}
