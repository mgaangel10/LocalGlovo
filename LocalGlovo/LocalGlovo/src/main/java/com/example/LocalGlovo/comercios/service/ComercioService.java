package com.example.LocalGlovo.comercios.service;

import com.example.LocalGlovo.comercios.Dto.GetListComercios;
import com.example.LocalGlovo.comercios.Dto.PostCrearComercio;
import com.example.LocalGlovo.comercios.models.CategoriaComercios;
import com.example.LocalGlovo.comercios.models.Comercio;
import com.example.LocalGlovo.comercios.repository.ComercioRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.EnumSet;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ComercioService {

    private final ComercioRepo comercioRepo;


    public Comercio crearComercio(PostCrearComercio postCrearComercio){

        CategoriaComercios comercios = CategoriaComercios.valueOf(postCrearComercio.categorias().toUpperCase());
        if (comercios == null){
            throw new RuntimeException("Categoria de comercio no validas");
        }
        Comercio comercio = Comercio.builder()
                .name(postCrearComercio.name())
                .latitud(postCrearComercio.latitud())
                .longitud(postCrearComercio.longitud())
                .nameDirection(postCrearComercio.nameDirection())
                .categorias(EnumSet.of(comercios))
                .imagen(postCrearComercio.imagen())

                .build();
        return comercioRepo.save(comercio);
    }
    public List<GetListComercios> getComerciosPorCategoria(CategoriaComercios categoria) {
        return comercioRepo.findByCategoriasContains(categoria);
    }

    public Page<GetListComercios> listarComercios(Pageable pageable){
        Page<GetListComercios> getListComercios = comercioRepo.getListComercios(pageable);
        if (getListComercios.isEmpty()){
            throw new RuntimeException("No hay comercios");
        }else{
            return comercioRepo.getListComercios(pageable);
        }
    }

    public Comercio finfbyid(UUID uuid){
        Optional<Comercio> comercio = comercioRepo.findById(uuid);

        if (comercio.isEmpty()){
            throw new RuntimeException("ningun comercio por el id: "+uuid);
        }else{
            return comercio.get();
        }
    }
}
