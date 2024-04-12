package com.example.LocalGlovo.users.Dto;


import com.example.LocalGlovo.users.model.Administrador;
import com.example.LocalGlovo.users.model.Usuario;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class PostRegistroDto  {
    String id;
    String fullname;
    String username;
    LocalDate birthdate;
    String email;
    String fotoUrl;

    LocalDateTime creadoen;

    public static PostRegistroDto Usuario(Usuario usuario){
        return PostRegistroDto.builder()
                .id(usuario.getId().toString())
                .fullname(usuario.getName().concat(" "+usuario.getLastName()))
                .username(usuario.getUsername())
                .birthdate(usuario.getBirthDate())
                .email(usuario.getEmail())
                .fotoUrl(usuario.getFotoUrl())
                .creadoen(usuario.getCreatedAt())
                .build();
    }
    public static PostRegistroDto Administrador(Administrador administrador){
        return PostRegistroDto.builder()
                .id(administrador.getId().toString())
                .fullname(administrador.getName().concat(" "+administrador.getLastName()))
                .username(administrador.getUsername())
                .birthdate(administrador.getBirthDate())
                .email(administrador.getEmail())
                .fotoUrl(administrador.getFotoUrl())
                .creadoen(administrador.getCreatedAt())
                .build();
    }
}