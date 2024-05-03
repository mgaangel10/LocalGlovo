package com.example.LocalGlovo.users.service;


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
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDateTime;
import java.util.EnumSet;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class AdministradorService {

    private final AdministradorRepo administradorRepo;
    private final PasswordEncoder passwordEncoder;
    private final UsuarioRepo usuarioRepo;
    public Optional<Administrador> findById(UUID id){return administradorRepo.findById(id);}
    public Optional<Administrador> findByEmail(String email) {
        return administradorRepo.findFirstByEmail(email);
    }

    public Administrador crearAdministrador(PostCrearUserDto postCrearUserDto , EnumSet<UserRoles> userRoles){
        if (usuarioRepo.existsByEmailIgnoreCase(postCrearUserDto.email())||administradorRepo.existsByEmailIgnoreCase(postCrearUserDto.email())){
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,"El email ya ha sido registrado");
        }
        Administrador administrador = Administrador.builder()
                .email(postCrearUserDto.email())
                .name(postCrearUserDto.name())
                .lastName(postCrearUserDto.lastName())
                .password(passwordEncoder.encode(postCrearUserDto.password()))
                .createdAt(LocalDateTime.now())
                .fotoUrl(postCrearUserDto.fotoUrl())
                .birthDate(postCrearUserDto.nacimiento())
                .roles(EnumSet.of(UserRoles.ADMINISTRADOR))
                .build();
        return administradorRepo.save(administrador);
    }

    public Administrador createWithRole(PostCrearUserDto postCrearUserDto){
        return crearAdministrador(postCrearUserDto,EnumSet.of(UserRoles.ADMINISTRADOR));
    }
    public List<Usuario> usuariosRegistrados(){
        List<Usuario> usuarios = usuarioRepo.findByEnabledFalse();
        if (usuarios.isEmpty()){
            throw new RuntimeException("No se ha encontrados usuarios que se hayan registrados");
        }else {
            return usuarioRepo.findByEnabledFalse();
        }

    }

    public Usuario setearEneable (UUID usuarioId){
        Optional<Usuario> usuario = usuarioRepo.findById(usuarioId);
        if (usuario.isPresent()){
            Usuario usuario1 = usuario.get();
            usuario1.setEnabled(false);
         return    usuarioRepo.save(usuario1);
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
            administrador.get().setCredentialsNonExpired(false);
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

}