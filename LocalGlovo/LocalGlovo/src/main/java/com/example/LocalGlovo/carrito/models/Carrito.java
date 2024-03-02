package com.example.LocalGlovo.carrito.models;

import com.example.LocalGlovo.productos.model.Producto;
import com.example.LocalGlovo.users.model.Usuario;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.GenericGenerator;

import java.util.HashSet;
import java.util.Set;
import java.util.UUID;
@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class Carrito {
    @Id
    @GeneratedValue(generator = "UUID",strategy = GenerationType.UUID)
    @GenericGenerator(name = "UUID", type = org.hibernate.id.UUIDGenerator.class)
    protected UUID id;

    @Column(name = "cantidad")
    private Integer cantidad;

    @Column(name = "total")
    private double total;

    @OneToMany(mappedBy = "carrito", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<LineaCarrito> lineasCarrito = new HashSet<>();

    @ManyToOne
    @JoinColumn(name = "usuario_id")
    protected Usuario usuario;

    @Enumerated(EnumType.STRING)
    protected Estado estado;

    public void agregarProducto(Producto producto) {
        LineaCarrito nuevaLinea = new LineaCarrito(producto, 1);
        nuevaLinea.setCarrito(this);
        lineasCarrito.add(nuevaLinea);
    }

    public double calcularTotal() {
        return lineasCarrito.stream()
                .mapToDouble(LineaCarrito::getTotal)
                .sum();
    }

}
