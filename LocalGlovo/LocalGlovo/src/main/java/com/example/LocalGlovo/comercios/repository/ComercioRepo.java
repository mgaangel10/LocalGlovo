package com.example.LocalGlovo.comercios.repository;

import com.example.LocalGlovo.comercios.Dto.GetListComercios;
import com.example.LocalGlovo.comercios.models.Comercio;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.UUID;

public interface ComercioRepo extends JpaRepository<Comercio, UUID> {


    @Query("""
            select new com.example.LocalGlovo.comercios.Dto.GetListComercios(
            c.id,
            c.name,
            c.rating,
            c.nameDirection,
            c.imagen
            )
            from Comercio c
            """)
    Page<GetListComercios> getListComercios(Pageable pageable);

    Comercio findByName(String name);
}
