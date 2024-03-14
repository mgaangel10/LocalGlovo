package com.example.LocalGlovo.valoracion.repository;

import com.example.LocalGlovo.comercios.models.Comercio;
import com.example.LocalGlovo.valoracion.models.Valoracion;
import com.example.LocalGlovo.valoracion.models.ValoracionId;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ValoracionRepo extends JpaRepository<Valoracion, ValoracionId> {

    List<Valoracion> findAllByComercioV(Comercio comercio);
}
