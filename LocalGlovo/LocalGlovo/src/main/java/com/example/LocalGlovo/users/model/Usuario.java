package com.example.LocalGlovo.users.model;


import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;
import org.springframework.boot.autoconfigure.security.SecurityProperties;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
public class Usuario extends User {
    @ManyToMany
    @JoinTable(name = "tbl_usuario_usuarios",
            joinColumns = @JoinColumn(name = "responsable_id"),
            inverseJoinColumns = @JoinColumn(name = "usuarios_id"))
    private List<Usuario> usuarios = new ArrayList<>();
    @ManyToMany(mappedBy = "usuarios")
    private List<Usuario> inChargeof;





}
