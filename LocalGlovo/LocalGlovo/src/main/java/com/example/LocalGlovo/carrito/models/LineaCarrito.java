package com.example.LocalGlovo.carrito.models;

import com.example.LocalGlovo.productos.model.Producto;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.GenericGenerator;

import java.util.UUID;
@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class LineaCarrito {
    @Id
    @GeneratedValue(generator = "UUID",strategy = GenerationType.UUID)
    @GenericGenerator(name = "UUID", type = org.hibernate.id.UUIDGenerator.class)
    protected UUID id;

    @ManyToOne
    protected Producto producto;

    @ManyToOne
    @JsonIgnore
    protected Carrito carrito;

    @Column(name = "cantidad")
    protected int cantidad;
    public LineaCarrito(Producto producto, int cantidad) {
        this.producto = producto;
        this.cantidad = cantidad;
    }
    public void aumentarCantidad() {
        cantidad++;
    }

    public void disminuirCantidad() {
        cantidad--;
    }

    public double getTotal() {
        return producto.getPrecio() * cantidad;
    }
}
