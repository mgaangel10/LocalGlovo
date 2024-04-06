package com.example.LocalGlovo.carrito.repository;

import com.example.LocalGlovo.carrito.models.Ventas;
import com.example.LocalGlovo.productos.model.Producto;
import com.example.LocalGlovo.users.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

public interface VentasRepo extends JpaRepository<Ventas, UUID> {
    @Query("""
            SELECT v.productos, COUNT(v.productos) as count
             FROM Ventas v
              WHERE v.fecha = :fecha
               GROUP BY v.productos
                ORDER BY count DESC
            """)
    List<Producto> obtenerProductosMasVendidos(@Param("fecha") LocalDate fecha);

    @Query("""
            SELECT v.usuarios, COUNT(v.usuarios) as count 
            FROM Ventas v
             WHERE v.fecha = :fecha
              GROUP BY v.usuarios
               ORDER BY count DESC
            """)
    List<Usuario> obtenerUsuariosQueMasCompran(@Param("fecha") LocalDate fecha);
}
