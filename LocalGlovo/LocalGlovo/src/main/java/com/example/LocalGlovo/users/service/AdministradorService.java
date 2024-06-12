package com.example.LocalGlovo.users.service;


import com.example.LocalGlovo.Exception.GlobalException;
import com.example.LocalGlovo.Favoritos.models.Favorito;
import com.example.LocalGlovo.Favoritos.repository.FavoritoRepo;
import com.example.LocalGlovo.carrito.models.Carrito;
import com.example.LocalGlovo.carrito.models.Ventas;
import com.example.LocalGlovo.carrito.repository.CarritoRepo;
import com.example.LocalGlovo.carrito.repository.VentasRepo;
import com.example.LocalGlovo.files.service.FicheroService;
import com.example.LocalGlovo.users.Dto.JwtUserResponse;
import com.example.LocalGlovo.users.Dto.PostCrearUserDto;
import com.example.LocalGlovo.users.Dto.PostLogin;
import com.example.LocalGlovo.users.model.Administrador;
import com.example.LocalGlovo.users.model.UserRoles;
import com.example.LocalGlovo.users.model.Usuario;
import com.example.LocalGlovo.users.repositorio.AdministradorRepo;
import com.example.LocalGlovo.users.repositorio.UsuarioRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;




@Service
@RequiredArgsConstructor
public class AdministradorService {

    private final AdministradorRepo administradorRepo;
    private final PasswordEncoder passwordEncoder;
    private final UsuarioRepo usuarioRepo;
    private final FicheroService ficheroService;
    private final EmailService emailService;
    private final FavoritoRepo favoritoRepo;
    private final VentasRepo ventasRepo;
    private final CarritoRepo carritoRepo;
    public Optional<Administrador> findById(UUID id){return administradorRepo.findById(id);}
    public Optional<Administrador> findByEmail(String email) {
        return administradorRepo.findFirstByEmail(email);
    }
    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    public  String generateRandomString(int length) {
        Random random = new Random();
        StringBuilder builder = new StringBuilder(length);

        for (int i = 0; i < length; i++) {
            int randomIndex = random.nextInt(CHARACTERS.length());
            builder.append(CHARACTERS.charAt(randomIndex));
        }

        return builder.toString();
    }
    public Administrador crearAdministrador(PostCrearUserDto postCrearUserDto , EnumSet<UserRoles> userRoles, MultipartFile file){
        String newPassword = generateRandomString(8);
        String filename = ficheroService.storeAndReturnFilename(file);
        if (usuarioRepo.existsByEmailIgnoreCase(postCrearUserDto.email())||administradorRepo.existsByEmailIgnoreCase(postCrearUserDto.email())){
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,"El email ya ha sido registrado");
        }
        if (postCrearUserDto.email().isEmpty()){
            throw new GlobalException("El campo email no puede estar vacio");
        }
        if (postCrearUserDto.name().isEmpty()){
            throw new GlobalException("El campo nombre no puede estar vacio");
        }
        if (postCrearUserDto.lastName().isEmpty()){
            throw new GlobalException("El campo apellidos no puede estar vacio");
        }

        Administrador administrador = Administrador.builder()
                .email(postCrearUserDto.email())
                .name(postCrearUserDto.name())
                .lastName(postCrearUserDto.lastName())
                .password(passwordEncoder.encode(newPassword))
                .createdAt(LocalDateTime.now())
                .fotoUrl(filename)
                .birthDate(postCrearUserDto.nacimiento())
                .roles(EnumSet.of(UserRoles.ADMINISTRADOR))
                .build();
        emailService.registroAdmin(administrador,newPassword);
        return administradorRepo.save(administrador);
    }

    public Administrador createWithRole(PostCrearUserDto postCrearUserDto,MultipartFile file){
        return crearAdministrador(postCrearUserDto,EnumSet.of(UserRoles.ADMINISTRADOR),file);
    }
    public List<Usuario> usuariosRegistrados(){
        List<Usuario> usuarios = usuarioRepo.findByEnabledFalse();
        if (usuarios.isEmpty()){
            throw new RuntimeException("No se ha encontrados usuarios que se hayan registrados");
        }else {
            return usuarioRepo.findByEnabledFalse();
        }

    }

    public void setearEneable (UUID usuarioId){
        Optional<Usuario> usuario = usuarioRepo.findById(usuarioId);
        if (usuario.isPresent()){
            List<Carrito> carritos = carritoRepo.findByUsuario(usuario.get());
            for (Carrito c:carritos) {
                c.setUsuario(null); // Desvincula el usuario del carrito
                carritoRepo.save(c); // Guarda el carrito actualizado
            }

            List<Favorito> favoritoList = usuario.get().getFavoritos();
            favoritoList.forEach(favorito -> favoritoRepo.delete(favorito));
            List<Ventas> ventas = ventasRepo.findByUsuariosContaining(usuario.get());

            for (Ventas venta : ventas) {
                venta.getUsuarios().remove(usuario.get());
                ventasRepo.save(venta); // Guarda la venta actualizada
            }

            usuarioRepo.delete(usuario.get()); // Guarda el usuario actualizado en lugar de eliminarlo
        }else {
            throw new RuntimeException("Usuario con email: '"+usuarioId+"' no encontrado");
        }
    }


    public Administrador getLoggedAdministrador() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (principal instanceof UserDetails) {
            String nombre= ((UserDetails)principal).getUsername();
            Optional<Administrador> administrador = administradorRepo.findByEmailIgnoreCase(nombre);
            return administrador.get();

        }

        return null;
    }

    public List<Usuario> listadoUsuarios(){
        return usuarioRepo.findByEnabledTrue();
    }

    public Administrador logOut(UUID uuid){
        Optional<Administrador> administrador = administradorRepo.findById(uuid);
        if (administrador.isPresent()){
            administrador.get().setEnabled(false);

            return administradorRepo.save(administrador.get());
        }else{
            throw new RuntimeException("No se encuentra el administrador por ese id");
        }
    }

    public Administrador setearEnabled(PostLogin postCrearUserDto){
        Optional<Administrador> administrador = administradorRepo.findByEmailIgnoreCase(postCrearUserDto.email());

        if (administrador.isPresent() || administrador.get().isEnabled()){
            administrador.get().setEnabled(true);
            return administradorRepo.save(administrador.get());
        }else {
            throw new RuntimeException("No se encuentra el administrador");
        }
    }

    public List<Usuario> buscarUsuario(String buscar){
        List<Usuario> usuarios = usuarioRepo.findAll();
        List<Usuario> usuarios1 = usuarios.stream().filter(usuario -> usuario.getName().toLowerCase().contains(buscar)||
                usuario.getEmail().toLowerCase().contains(buscar)||
                usuario.getLastName().toLowerCase().contains(buscar)||
                usuario.getPhoneNumber().contains(buscar)).collect(Collectors.toList());
        return usuarios1;
    }

}