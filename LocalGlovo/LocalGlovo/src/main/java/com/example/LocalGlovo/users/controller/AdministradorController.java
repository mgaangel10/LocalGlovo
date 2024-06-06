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

    @PostMapping("administrador/quitar/cuenta/usuario/{usuarioId}")
    public ResponseEntity<Usuario> quitarCuentaUsuario(@PathVariable UUID usuarioId){
        Usuario usuario = administradorService.setearEneable(usuarioId);
        return ResponseEntity.status(201).body(usuario);
    }

    @GetMapping("administrador/ver/usuarios")
    public ResponseEntity<List<Usuario>> listarUsuario(){
        List<Usuario> usuarios = administradorService.listadoUsuarios();
        return ResponseEntity.ok(usuarios);
    }
    @GetMapping("administrador/logueado")
    public ResponseEntity<Administrador> getLoggedAdministrador() {
        Administrador administrador = administradorService.getLoggedAdministrador();
        return ResponseEntity.ok(administrador);
    }

    @PostMapping("administrador/logout/{id}")
    public ResponseEntity<Administrador> logOut(@PathVariable UUID id){
        Administrador administrador = administradorService.logOut(id);
        return ResponseEntity.status(201).body(administrador);
    }

    @GetMapping("administrador/buscar/usuario/{buscar}")
    public ResponseEntity<List<Usuario>> buscarUsuario(@PathVariable String buscar){
        List<Usuario> usuarios = administradorService.buscarUsuario(buscar);
        return ResponseEntity.ok(usuarios);
    }



}
