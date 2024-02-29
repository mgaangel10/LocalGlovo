package com.example.LocalGlovo.carrito.repository;

import com.example.LocalGlovo.carrito.Dto.GetCarritoDto;
import com.example.LocalGlovo.carrito.models.Carrito;
import com.example.LocalGlovo.carrito.models.Estado;
import com.example.LocalGlovo.users.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface CarritoRepo extends JpaRepository<Carrito, UUID> {

    @Query("select c from Carrito c where c.id = ?1")
    Optional<Carrito> comprobarId(UUID id);

    @Query("select c from Carrito c where c.usuario = ?1 and c.estado = ?2")
    Optional<Carrito> buscarCarritoActivoDelUsuario(Usuario usuario, Estado estado);

    @Query("""
            select new com.example.LocalGlovo.carrito.Dto.GetCarritoDto(
            c.id,
            c.cantidad,
            c.total,
             c.lineasCarrito
            )
            from Carrito c
            """)
    List<GetCarritoDto> getListCarrito();
}
