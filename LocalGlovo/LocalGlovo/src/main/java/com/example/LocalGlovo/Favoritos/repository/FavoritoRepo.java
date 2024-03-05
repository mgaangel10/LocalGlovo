package com.example.LocalGlovo.Favoritos.repository;

import com.example.LocalGlovo.Favoritos.models.Favorito;
import com.example.LocalGlovo.Favoritos.models.FavoritoId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface FavoritoRepo extends JpaRepository<Favorito, FavoritoId> {



}
