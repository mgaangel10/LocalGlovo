package com.example.LocalGlovo.carrito.models;

import com.example.LocalGlovo.comercios.models.Comercio;
import com.example.LocalGlovo.productos.model.Producto;
import com.example.LocalGlovo.users.model.Usuario;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.GenericGenerator;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class Ventas {

    @Id
    @GeneratedValue(generator = "UUID",strategy = GenerationType.UUID)
    @GenericGenerator(name = "UUID", type = org.hibernate.id.UUIDGenerator.class)
    protected UUID id;

    @Column(name = "total")
    private double total;

    @ManyToMany
    private List<Usuario> usuarios;

 @ManyToMany

    private List<Producto> productos;

    @Column(name = "fecha")
    private LocalDate fecha;

    @ManyToMany
    private List<Comercio> comercios;



}
