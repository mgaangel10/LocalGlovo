package com.example.LocalGlovo.productos.repository;

import com.example.LocalGlovo.productos.model.Ingredientes;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface IngredientesRepo extends JpaRepository<Ingredientes, UUID> {
}
