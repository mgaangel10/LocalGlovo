package com.example.LocalGlovo.productos.model;

import com.example.LocalGlovo.comercios.models.Comercio;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.GenericGenerator;

import java.util.Set;
import java.util.UUID;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class Producto {
    @Id
    @GeneratedValue(generator = "UUID",strategy = GenerationType.UUID)
    @GenericGenerator(name = "UUID", type = org.hibernate.id.UUIDGenerator.class)
    protected UUID id;

    @Column(name = "imagen")
    protected String imagen;

    @Column(name = "name")
    protected String name;

    @Column(name = "precio")
    protected double precio;

    @Column(name = "disponible")
    protected boolean disponible;
    @ManyToOne(cascade = CascadeType.ALL)
    private Comercio comercio;


    @Column(name = "ingredientes_id")
    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<Ingredientes> ingredientes;





}
