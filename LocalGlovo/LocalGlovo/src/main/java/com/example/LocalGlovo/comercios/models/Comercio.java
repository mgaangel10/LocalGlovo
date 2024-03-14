package com.example.LocalGlovo.comercios.models;

import com.example.LocalGlovo.Favoritos.models.Favorito;
import com.example.LocalGlovo.productos.model.Producto;
import com.example.LocalGlovo.valoracion.models.Valoracion;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.util.List;
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
    protected double latitud;

    @Column(name = "longitud")
    protected double longitud;

    @Column(name = "rating")
    protected double rating;

    @Column(name = "name_direction")
    protected String nameDirection;

    @Column(name = "categorias")
    @ElementCollection(fetch = FetchType.EAGER)
    @Enumerated(EnumType.STRING)
    private Set<CategoriaComercios> categorias;

    @Column(name = "producto_id")
    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Producto> productos;

    @OneToMany(mappedBy = "comercio")
    @JsonManagedReference
    protected List<Favorito> favoritoList;

    @OneToMany(mappedBy = "comercioV")
    @JsonManagedReference
    protected List<Valoracion> valoracions;




}
