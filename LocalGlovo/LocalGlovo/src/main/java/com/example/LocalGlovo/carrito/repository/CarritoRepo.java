package com.example.LocalGlovo.carrito.repository;

import com.example.LocalGlovo.carrito.models.Carrito;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;
import java.util.UUID;

public interface CarritoRepo extends JpaRepository<Carrito, UUID> {

    @Query("select c from Carrito c where c.id = ?1")
    Optional<Carrito> comprobarId(UUID id);
}
