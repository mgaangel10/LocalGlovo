package com.example.LocalGlovo.comercios.repository;

import com.example.LocalGlovo.comercios.Dto.GetListComercios;
import com.example.LocalGlovo.comercios.models.CategoriaComercios;
import com.example.LocalGlovo.comercios.models.Comercio;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ComercioRepo extends JpaRepository<Comercio, UUID> {

    List<GetListComercios> findByCategoriasContains(CategoriaComercios categoria);
    @Query("""
            select new com.example.LocalGlovo.comercios.Dto.GetListComercios(
            c.id,
            c.name,
            c.rating,
            c.nameDirection,
            c.imagen,
            c.latitud,
            c.longitud,
            c.categorias
            )
            from Comercio c
            """)
    Page<GetListComercios> getListComercios(Pageable pageable);
    @Query("""
            select new com.example.LocalGlovo.comercios.Dto.GetListComercios(
            c.id,
            c.name,
            c.rating,
            c.nameDirection,
            c.imagen,
            c.latitud,
            c.longitud,
            c.categorias
            )
            from Comercio c
            where c.name = ?1
            """)
    List<GetListComercios> findByNombreGetListComercio(String nombre);


    Comercio findByName(String name);
}
