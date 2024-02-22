package com.example.LocalGlovo.comercios.models;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.util.Set;
import java.util.UUID;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class Comercio {
    @Id
    @GeneratedValue(generator = "UUID",strategy = GenerationType.UUID)
    @GenericGenerator(name = "UUID", type = org.hibernate.id.UUIDGenerator.class)
    protected UUID id;
    @Column(name = "imagen")
    protected String imagen;

    @Column(name = "name")
    protected String name;

    @Column(name = "latitud")
    protected String latitud;

    @Column(name = "longitud")
    protected String longitud;

    @Column(name = "rating")
    protected double rating;

    @Column(name = "name_direction")
    protected String nameDirection;

    @Column(name = "categorias")
    @ElementCollection(fetch = FetchType.EAGER)
    @Enumerated(EnumType.STRING)
    private Set<CategoriaComercios> categorias;





}
